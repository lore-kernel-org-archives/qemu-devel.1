Received: from eggs.gnu.org ([2001:4830:134:3::10]:33962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGmGJ-0006H1-HK
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGmGE-0002fI-PQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:05:07 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGmGE-0002es-Id
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:05:02 -0400
Received: by mail-wr0-x22c.google.com with SMTP id g76so6683697wrd.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:05:02 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  2 Jun 2017 14:05:18 +0100
Message-Id: <20170602130518.22943-5-alex.bennee@linaro.org>
In-Reply-To: <20170602130518.22943-1-alex.bennee@linaro.org>
References: <20170602130518.22943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/4] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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

---
v2
  - used Greg's less convoluted suggestion
  - expand commit message
---
 gdbstub.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 45a3a0b16b..6b1e72e9f7 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -937,23 +937,16 @@ static int gdb_handle_vcont(GDBState *s, const char *p)
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
2.13.0
