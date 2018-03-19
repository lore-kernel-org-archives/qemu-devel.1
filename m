Received: from eggs.gnu.org ([2001:4830:134:3::10]:49687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbx-0002JX-Ou
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbw-0007dp-TV
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1exzbw-0007bM-LP
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:20 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbu-0002zP-Sz
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:34:18 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 18:34:04 +0000
Message-Id: <20180319183415.1976-3-peter.maydell@linaro.org>
In-Reply-To: <20180319183415.1976-1-peter.maydell@linaro.org>
References: <20180319183415.1976-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/13] dump: Update correct kdump phys_base
 field for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Wei Huang <wei@redhat.com>

For guest kernel that supports KASLR, the load address can change every
time when guest VM runs. To find the physical base address correctly,
current QEMU dump searches VMCOREINFO for the string "NUMBER(phys_base)=".
However this string pattern is only available on x86_64. AArch64 uses a
different field, called "NUMBER(PHYS_OFFSET)=". This patch makes sure
QEMU dump uses the correct string on AArch64.

Signed-off-by: Wei Huang <wei@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 1520615003-20869-1-git-send-email-wei@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 dump.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/dump.c b/dump.c
index 097e60b2b3..6bdb0dbe23 100644
--- a/dump.c
+++ b/dump.c
@@ -1609,10 +1609,18 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
 
     lines = g_strsplit((char *)vmci, "\n", -1);
     for (i = 0; lines[i]; i++) {
-        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=")) {
-            if (qemu_strtou64(lines[i] + 18, NULL, 16,
+        const char *prefix = NULL;
+
+        if (s->dump_info.d_machine == EM_X86_64) {
+            prefix = "NUMBER(phys_base)=";
+        } else if (s->dump_info.d_machine == EM_AARCH64) {
+            prefix = "NUMBER(PHYS_OFFSET)=";
+        }
+
+        if (prefix && g_str_has_prefix(lines[i], prefix)) {
+            if (qemu_strtou64(lines[i] + strlen(prefix), NULL, 16,
                               &phys_base) < 0) {
-                warn_report("Failed to read NUMBER(phys_base)=");
+                warn_report("Failed to read %s", prefix);
             } else {
                 s->dump_info.phys_base = phys_base;
             }
-- 
2.16.2
