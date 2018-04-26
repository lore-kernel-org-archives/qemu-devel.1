Received: from eggs.gnu.org ([2001:4830:134:3::10]:53850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAC-0006jS-Hr
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAB-0001T7-4W
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAA-0001Rn-PB
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:31 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 17:53:29 +0100
Message-ID: <1524761612-5307-5-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 4/7] error reporting: Fix some error
 messages to use ":" rather than ", "
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

This patch is the result of

  git-grep -l 'error_report.*strerror' | xargs perl -p -i~ ../t

with ../t containing

  s{error_report\("(.*), \%s"(, .*)?, strerror\(errno\)\)\;}{error_report_errno\("$1"$2)\;}

Note the comma here    ^
which is a one-character difference from the previous patch.

The effect is that a lot of messages which used to say

  something went wrong, <errno string>

now say

  something went wrong: <errno string>

And of course we remove a lot of open-coded calls.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 block/sheepdog.c      | 16 ++++++++--------
 scsi/qemu-pr-helper.c |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 387f59c..70e4bba 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -603,13 +603,13 @@ static coroutine_fn int send_co_req(int sockfd, SheepdogReq *hdr, void *data,
 
     ret = qemu_co_send(sockfd, hdr, sizeof(*hdr));
     if (ret != sizeof(*hdr)) {
-        error_report("failed to send a req, %s", strerror(errno));
+        error_report_errno("failed to send a req");
         return -errno;
     }
 
     ret = qemu_co_send(sockfd, data, *wlen);
     if (ret != *wlen) {
-        error_report("failed to send a req, %s", strerror(errno));
+        error_report_errno("failed to send a req");
         return -errno;
     }
 
@@ -660,7 +660,7 @@ static coroutine_fn void do_co_req(void *opaque)
 
     ret = qemu_co_recv(sockfd, hdr, sizeof(*hdr));
     if (ret != sizeof(*hdr)) {
-        error_report("failed to get a rsp, %s", strerror(errno));
+        error_report_errno("failed to get a rsp");
         ret = -errno;
         goto out;
     }
@@ -672,7 +672,7 @@ static coroutine_fn void do_co_req(void *opaque)
     if (*rlen) {
         ret = qemu_co_recv(sockfd, data, *rlen);
         if (ret != *rlen) {
-            error_report("failed to get the data, %s", strerror(errno));
+            error_report_errno("failed to get the data");
             ret = -errno;
             goto out;
         }
@@ -809,7 +809,7 @@ static void coroutine_fn aio_read_response(void *opaque)
     /* read a header */
     ret = qemu_co_recv(fd, &rsp, sizeof(rsp));
     if (ret != sizeof(rsp)) {
-        error_report("failed to get the header, %s", strerror(errno));
+        error_report_errno("failed to get the header");
         goto err;
     }
 
@@ -851,7 +851,7 @@ static void coroutine_fn aio_read_response(void *opaque)
         ret = qemu_co_recvv(fd, acb->qiov->iov, acb->qiov->niov,
                             aio_req->iov_offset, rsp.data_length);
         if (ret != rsp.data_length) {
-            error_report("failed to get the data, %s", strerror(errno));
+            error_report_errno("failed to get the data");
             goto err;
         }
         break;
@@ -1362,14 +1362,14 @@ static void coroutine_fn add_aio_request(BDRVSheepdogState *s, AIOReq *aio_req,
     /* send a header */
     ret = qemu_co_send(s->fd, &hdr, sizeof(hdr));
     if (ret != sizeof(hdr)) {
-        error_report("failed to send a req, %s", strerror(errno));
+        error_report_errno("failed to send a req");
         goto out;
     }
 
     if (wlen) {
         ret = qemu_co_sendv(s->fd, iov, niov, aio_req->iov_offset, wlen);
         if (ret != wlen) {
-            error_report("failed to send a data, %s", strerror(errno));
+            error_report_errno("failed to send a data");
         }
     }
 out:
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 663a8a8..ff56313 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -118,12 +118,12 @@ static void write_pidfile(void)
 
     pidfd = qemu_open(pidfile, O_CREAT|O_WRONLY, S_IRUSR|S_IWUSR);
     if (pidfd == -1) {
-        error_report("Cannot open pid file, %s", strerror(errno));
+        error_report_errno("Cannot open pid file");
         exit(EXIT_FAILURE);
     }
 
     if (lockf(pidfd, F_TLOCK, 0)) {
-        error_report("Cannot lock pid file, %s", strerror(errno));
+        error_report_errno("Cannot lock pid file");
         goto fail;
     }
     if (ftruncate(pidfd, 0)) {
-- 
2.1.4
