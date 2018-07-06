Received: from eggs.gnu.org ([2001:4830:134:3::10]:51047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK4-0001D4-66
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUJz-0000kr-UN
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fbUJz-0000kN-G3
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id r16-v6so4873020wrt.11
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:15:03 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	h40-v6sm13784683wrf.40.2018.07.06.10.15.01
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Jul 2018 10:15:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Jul 2018 19:14:21 +0200
Message-Id: <1530897268-22932-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
References: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] pr-helper: avoid error on PR IN command
 with zero request size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

After reading a PR IN command with zero request size in prh_read_request,
the resp->result field will be uninitialized and the resp.sz field will
be also uninitialized when returning to prh_co_entry.

If resp->result == GOOD (from a previous successful reply or just luck),
then the assert in prh_write_response might not be triggered and
uninitialized response will be sent.

The fix is to remove the whole handling of sz == 0 in prh_co_entry.
Those errors apply only to PR OUT commands and it's perfectly okay to
catch them later in do_pr_out and multipath_pr_out; the check for
too-short parameters in fact doesn't apply in the easy SG_IO case, as
it can be left to the target firmware even.

The result is that prh_read_request does not fail requests anymore and
prh_co_entry becomes simpler.

Reported-by: Dima Stepanov <dimastep@yandex-team.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/qemu-pr-helper.c | 63 ++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 0218d65..c89a446 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -455,6 +455,14 @@ static int multipath_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
     char transportids[PR_HELPER_DATA_SIZE];
     int r;
 
+    if (sz < PR_OUT_FIXED_PARAM_SIZE) {
+        /* Illegal request, Parameter list length error.  This isn't fatal;
+         * we have read the data, send an error without closing the socket.
+         */
+        scsi_build_sense(sense, SENSE_CODE(INVALID_PARAM_LEN));
+        return CHECK_CONDITION;
+    }
+
     switch (rq_servact) {
     case MPATH_PROUT_REG_SA:
     case MPATH_PROUT_RES_SA:
@@ -574,6 +582,12 @@ static int do_pr_out(int fd, const uint8_t *cdb, uint8_t *sense,
                      const uint8_t *param, int sz)
 {
     int resp_sz;
+
+    if ((fcntl(fd, F_GETFL) & O_ACCMODE) == O_RDONLY) {
+        scsi_build_sense(sense, SENSE_CODE(INVALID_OPCODE));
+        return CHECK_CONDITION;
+    }
+
 #ifdef CONFIG_MPATH
     if (is_mpath(fd)) {
         return multipath_pr_out(fd, cdb, sense, param, sz);
@@ -690,21 +704,6 @@ static int coroutine_fn prh_read_request(PRHelperClient *client,
                                  errp) < 0) {
             goto out_close;
         }
-        if ((fcntl(client->fd, F_GETFL) & O_ACCMODE) == O_RDONLY) {
-            scsi_build_sense(resp->sense, SENSE_CODE(INVALID_OPCODE));
-            sz = 0;
-        } else if (sz < PR_OUT_FIXED_PARAM_SIZE) {
-            /* Illegal request, Parameter list length error.  This isn't fatal;
-             * we have read the data, send an error without closing the socket.
-             */
-            scsi_build_sense(resp->sense, SENSE_CODE(INVALID_PARAM_LEN));
-            sz = 0;
-        }
-        if (sz == 0) {
-            resp->result = CHECK_CONDITION;
-            close(client->fd);
-            client->fd = -1;
-        }
     }
 
     req->fd = client->fd;
@@ -785,25 +784,23 @@ static void coroutine_fn prh_co_entry(void *opaque)
             break;
         }
 
-        if (sz > 0) {
-            num_active_sockets++;
-            if (req.cdb[0] == PERSISTENT_RESERVE_OUT) {
-                r = do_pr_out(req.fd, req.cdb, resp.sense,
-                              client->data, sz);
-                resp.sz = 0;
-            } else {
-                resp.sz = sizeof(client->data);
-                r = do_pr_in(req.fd, req.cdb, resp.sense,
-                             client->data, &resp.sz);
-                resp.sz = MIN(resp.sz, sz);
-            }
-            num_active_sockets--;
-            close(req.fd);
-            if (r == -1) {
-                break;
-            }
-            resp.result = r;
+        num_active_sockets++;
+        if (req.cdb[0] == PERSISTENT_RESERVE_OUT) {
+            r = do_pr_out(req.fd, req.cdb, resp.sense,
+                          client->data, sz);
+            resp.sz = 0;
+        } else {
+            resp.sz = sizeof(client->data);
+            r = do_pr_in(req.fd, req.cdb, resp.sense,
+                         client->data, &resp.sz);
+            resp.sz = MIN(resp.sz, sz);
+        }
+        num_active_sockets--;
+        close(req.fd);
+        if (r == -1) {
+            break;
         }
+        resp.result = r;
 
         if (prh_write_response(client, &req, &resp, &local_err) < 0) {
             break;
-- 
1.8.3.1
