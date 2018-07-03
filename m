Received: from eggs.gnu.org ([2001:4830:134:3::10]:41107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faI8k-00021y-NT
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faI8g-0002wH-0J
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:02:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1faI8f-0002w3-Pl
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:02:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50BF14071181
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 10:02:25 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-239.ams2.redhat.com
	[10.36.117.239])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBF8B1C5AA
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 10:02:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Jul 2018 12:02:24 +0200
Message-Id: <20180703100224.6203-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] pr-helper: avoid error on PR IN command with
 zero request size
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
 scsi/qemu-pr-helper.c | 63 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 0218d65bbf..c89a446a45 100644
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
2.17.1
