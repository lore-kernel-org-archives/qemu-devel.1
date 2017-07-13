Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3T-00012w-Ka
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3S-0002WC-JQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:23 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3S-0002Va-Ca
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:22 -0400
Received: by mail-wm0-x244.google.com with SMTP id u23so5457948wma.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:20 +0200
Message-Id: <1499955874-10954-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/41] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

The thread-id of 0 means any CPU but we then ignore the fact we find
the first_cpu in this case who can have an index of 0. Instead of
bailing out just test if we have managed to match up thread-id to a
CPU.

Otherwise you get:
  gdb_handle_packet: command='vCont;C04:0;c'
  put_packet: reply='E22'

The actual reason for gdb sending vCont;C04:0;c was fixed in a
previous commit where we ensure the first_cpu's tid is correctly
reported to gdb however we should still behave correctly next time it
does send 0.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Message-Id: <20170712105216.747-5-alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 gdbstub.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 378fdd8..f936ddd 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -938,23 +938,16 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
             if (res) {
                 goto out;
             }
-            idx = tmp;
+
             /* 0 means any thread, so we pick the first valid CPU */
-            if (!idx) {
-                idx = cpu_gdb_index(first_cpu);
-            }
+            cpu = tmp ? find_cpu(tmp) : first_cpu;
 
-            /*
-             * If we are in user mode, the thread specified is actually a
-             * thread id, and not an index. We need to find the actual
-             * CPU first, and only then we can use its index.
-             */
-            cpu = find_cpu(idx);
             /* invalid CPU/thread specified */
-            if (!idx || !cpu) {
+            if (!cpu) {
                 res = -EINVAL;
                 goto out;
             }
+
             /* only use if no previous match occourred */
             if (newstates[cpu->cpu_index] == 1) {
                 newstates[cpu->cpu_index] = cur_action;
-- 
1.8.3.1
