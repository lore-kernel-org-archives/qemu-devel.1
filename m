Received: from eggs.gnu.org ([2001:4830:134:3::10]:33383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r4Z-0006vh-4V
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2r4V-0006fU-5Z
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:23:27 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d2r4V-0006fI-0L
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:23:23 -0400
Received: by mail-it0-x243.google.com with SMTP id z67so20116477itb.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:23:22 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <67AB1E7B-31C0-4BB7-BE7A-93932916023E@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 24 Apr 2017 23:23:19 -0400
Subject: [Qemu-devel] [PATCH 7/9] Add verbose option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Add an option that prints each instruction that is currently being  
tested.
To use this option, just add "--v" to risu's command-line.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
  risu.c | 11 ++++++++++-
  1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/risu.c b/risu.c
index 7e42160..ed5b605 100644
--- a/risu.c
+++ b/risu.c
@@ -37,6 +37,8 @@ sigjmp_buf jmpbuf;
  /* Should we test for FP exception status bits? */
  int test_fp_exc = 0;

+int verbose_mode = 0;
+
  void master_sigill(int sig, siginfo_t *si, void *uc)
  {
     switch (recv_and_compare_register_info(master_socket, uc))
@@ -125,7 +127,8 @@ int master(int sock)
  {
     if (sigsetjmp(jmpbuf, 1))
     {
-      return report_match_status();
+        int return_status = report_match_status();
+        exit(return_status);
     }
     master_socket = sock;
     set_sigill_handler(&master_sigill);
@@ -177,6 +180,7 @@ int main(int argc, char **argv)
              { "host", required_argument, 0, 'h' },
              { "port", required_argument, 0, 'p' },
              { "test-fp-exc", no_argument, &test_fp_exc, 1 },
+            { "verbose testing", no_argument, 0, 'v'},
              { 0,0,0,0 }
           };
        int optidx = 0;
@@ -209,6 +213,11 @@ int main(int argc, char **argv)
              usage();
              exit(1);
           }
+         case 'v':  /* Prints each instruction being tested */
+         {
+            verbose_mode = 1;
+            break;
+         }
           default:
              abort();
        }
-- 
2.10.2
