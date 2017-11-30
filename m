Received: from eggs.gnu.org ([2001:4830:134:3::10]:48968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKKat-0005AC-Co
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKKas-0006fy-MS
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:53:19 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 30 Nov 2017 09:53:02 +0100
Message-Id: <1512031988-32490-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1512031988-32490-1-git-send-email-thuth@redhat.com>
References: <1512031988-32490-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 1/7] tests/boot-serial-test: Make sure
 that we check the timeout regularly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Edgar Iglesias <edgar.iglesias@gmail.com>, Anthony Green <green@moxielogic.com>

If the guest continuesly writes characters to the UART, we never leave
the inner while loop and thus never check whether we've reached the
timeout value. So if we fail to find the expected string in the UART
output, the test just hangs and never finishs. Use a counter to regularly
break out of the while loop to check the timeout.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-serial-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index c935d69..fa4183d 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -43,12 +43,13 @@ static testdef_t tests[] = {
 static void check_guest_output(const testdef_t *test, int fd)
 {
     bool output_ok = false;
-    int i, nbr, pos = 0;
+    int i, nbr, pos = 0, ccnt;
     char ch;
 
     /* Poll serial output... Wait at most 60 seconds */
     for (i = 0; i < 6000; ++i) {
-        while ((nbr = read(fd, &ch, 1)) == 1) {
+        ccnt = 0;
+        while ((nbr = read(fd, &ch, 1)) == 1 && ccnt++ < 512) {
             if (ch == test->expect[pos]) {
                 pos += 1;
                 if (test->expect[pos] == '\0') {
-- 
1.8.3.1
