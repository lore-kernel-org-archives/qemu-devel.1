Received: from eggs.gnu.org ([2001:4830:134:3::10]:56642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZxq1-0002sB-Mi
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fZxpw-0001Sk-MB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:21:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fZxpw-0001ST-Hv
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:21:44 -0400
References: <1529053904-12607-1-git-send-email-dimastep@yandex-team.ru>
	<20180702085207.GA6032@dimastep-nix>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5149995f-2bb2-cbe8-1a2c-e16ed0ee3cd6@redhat.com>
Date: Mon, 2 Jul 2018 14:21:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180702085207.GA6032@dimastep-nix>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] qemu-pr-helper: garbage response
 structure can be used to write data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>, qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru

On 02/07/2018 10:52, Dima Stepanov wrote:
> Ping.
>=20
> On Fri, Jun 15, 2018 at 12:11:44PM +0300, Dima Stepanov wrote:
>> The prh_co_entry() routine handles requests. The first part is to read=
 a
>> request by calling the prh_read_request() routine, if:
>>   1. scsi_cdb_xfer(req->cdb) call returns 0, and
>>   2. req->cdb[0] =3D=3D PERSISTENT_RESERVE_IN, then
>> The resp->result field will be uninitialized. As a result the resp.sz
>> field will be also uninitialized in the prh_co_entry() function.
>> The second part is to send the response by calling the
>> prh_write_response() routine:
>>   1. For the PERSISTENT_RESERVE_IN command, and
>>   2. resp->result =3D=3D GOOD (previous successful reply or just luck)=
, then
>> There is a probability that the following assert will not be trigered:
>>   assert(resp->sz <=3D req->sz && resp->sz <=3D sizeof(client->data));
>> As a result some uninitialized response will be sent.
>>
>> The fix is to initialize the response structure to CHECK_CONDITION and=
 0
>> values before calling the prh_read_request() routine.

The actual bug is that the "if (sz > 0)" should apply only to=20
PERSISTENT_RESERVE_OUT, and in fact it can be done in do_pr_out. =20
PERSISTENT_RESERVE_IN with sz =3D=3D 0 is weird but okay.

This simplifies the code a bit too, because we can handle closing the=20
file descriptor in prh_co_entry.

Does something like this work for you?

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 0218d65bbf..c89a446a45 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -455,6 +455,14 @@ static int multipath_pr_out(int fd, const uint8_t *c=
db, uint8_t *sense,
     char transportids[PR_HELPER_DATA_SIZE];
     int r;
=20
+    if (sz < PR_OUT_FIXED_PARAM_SIZE) {
+        /* Illegal request, Parameter list length error.  This isn't fat=
al;
+         * we have read the data, send an error without closing the sock=
et.
+         */
+        scsi_build_sense(sense, SENSE_CODE(INVALID_PARAM_LEN));
+        return CHECK_CONDITION;
+    }
+
     switch (rq_servact) {
     case MPATH_PROUT_REG_SA:
     case MPATH_PROUT_RES_SA:
@@ -574,6 +582,12 @@ static int do_pr_out(int fd, const uint8_t *cdb, uin=
t8_t *sense,
                      const uint8_t *param, int sz)
 {
     int resp_sz;
+
+    if ((fcntl(fd, F_GETFL) & O_ACCMODE) =3D=3D O_RDONLY) {
+        scsi_build_sense(sense, SENSE_CODE(INVALID_OPCODE));
+        return CHECK_CONDITION;
+    }
+
 #ifdef CONFIG_MPATH
     if (is_mpath(fd)) {
         return multipath_pr_out(fd, cdb, sense, param, sz);
@@ -690,21 +704,6 @@ static int coroutine_fn prh_read_request(PRHelperCli=
ent *client,
                                  errp) < 0) {
             goto out_close;
         }
-        if ((fcntl(client->fd, F_GETFL) & O_ACCMODE) =3D=3D O_RDONLY) {
-            scsi_build_sense(resp->sense, SENSE_CODE(INVALID_OPCODE));
-            sz =3D 0;
-        } else if (sz < PR_OUT_FIXED_PARAM_SIZE) {
-            /* Illegal request, Parameter list length error.  This isn't=
 fatal;
-             * we have read the data, send an error without closing the =
socket.
-             */
-            scsi_build_sense(resp->sense, SENSE_CODE(INVALID_PARAM_LEN))=
;
-            sz =3D 0;
-        }
-        if (sz =3D=3D 0) {
-            resp->result =3D CHECK_CONDITION;
-            close(client->fd);
-            client->fd =3D -1;
-        }
     }
=20
     req->fd =3D client->fd;
@@ -785,25 +784,23 @@ static void coroutine_fn prh_co_entry(void *opaque)
             break;
         }
=20
-        if (sz > 0) {
-            num_active_sockets++;
-            if (req.cdb[0] =3D=3D PERSISTENT_RESERVE_OUT) {
-                r =3D do_pr_out(req.fd, req.cdb, resp.sense,
-                              client->data, sz);
-                resp.sz =3D 0;
-            } else {
-                resp.sz =3D sizeof(client->data);
-                r =3D do_pr_in(req.fd, req.cdb, resp.sense,
-                             client->data, &resp.sz);
-                resp.sz =3D MIN(resp.sz, sz);
-            }
-            num_active_sockets--;
-            close(req.fd);
-            if (r =3D=3D -1) {
-                break;
-            }
-            resp.result =3D r;
+        num_active_sockets++;
+        if (req.cdb[0] =3D=3D PERSISTENT_RESERVE_OUT) {
+            r =3D do_pr_out(req.fd, req.cdb, resp.sense,
+                          client->data, sz);
+            resp.sz =3D 0;
+        } else {
+            resp.sz =3D sizeof(client->data);
+            r =3D do_pr_in(req.fd, req.cdb, resp.sense,
+                         client->data, &resp.sz);
+            resp.sz =3D MIN(resp.sz, sz);
+        }
+        num_active_sockets--;
+        close(req.fd);
+        if (r =3D=3D -1) {
+            break;
         }
+        resp.result =3D r;
=20
         if (prh_write_response(client, &req, &resp, &local_err) < 0) {
             break;
