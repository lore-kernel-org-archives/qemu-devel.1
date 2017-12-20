Received: from eggs.gnu.org ([2001:4830:134:3::10]:56326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyG-0004Yp-B6
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyF-0007C9-39
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:56 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:42349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyE-0007Bt-SH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:55 -0500
Received: by mail-wm0-x244.google.com with SMTP id b199so11343496wme.1
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:30 +0100
Message-Id: <1513790098-9815-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/46] tests/boot-serial-test: Make sure that we
 check the timeout regularly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

If the guest continuesly writes characters to the UART, we never leave
the inner while loop and thus never check whether we've reached the
timeout value. So if we fail to find the expected string in the UART
output, the test just hangs and never finishs. Use a counter to regularly
break out of the while loop to check the timeout.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512031988-32490-2-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
