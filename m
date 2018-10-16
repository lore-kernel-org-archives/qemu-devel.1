Received: from eggs.gnu.org ([2001:4830:134:3::10]:43168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCW-0000yh-T6
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCW-0000A4-4P
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:04 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRCV-0007xg-Re
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCH-0003qj-0Q
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:49 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:25 +0100
Message-Id: <20181016152325.31367-20-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/19] coccinelle: new inplace-byteswaps.cocci
 to remove inplace-byteswapping calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a new Coccinelle script which replaces uses of the inplace
byteswapping functions *_to_cpus() and cpu_to_*s() with their
not-in-place equivalents. This is useful for where the swapping
is done on members of a packed struct -- taking the address
of the member to pass it to an inplace function is undefined
behaviour in C.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181009181612.10633-1-peter.maydell@linaro.org
---
 scripts/coccinelle/inplace-byteswaps.cocci | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 scripts/coccinelle/inplace-byteswaps.cocci

diff --git a/scripts/coccinelle/inplace-byteswaps.cocci b/scripts/coccinelle/inplace-byteswaps.cocci
new file mode 100644
index 00000000000..a869a90cbfd
--- /dev/null
+++ b/scripts/coccinelle/inplace-byteswaps.cocci
@@ -0,0 +1,65 @@
+// Replace uses of in-place byteswapping functions with calls to the
+// equivalent not-in-place functions.  This is necessary to avoid
+// undefined behaviour if the expression being swapped is a field in a
+// packed struct.
+
+@@
+expression E;
+@@
+-be16_to_cpus(&E);
++E = be16_to_cpu(E);
+@@
+expression E;
+@@
+-be32_to_cpus(&E);
++E = be32_to_cpu(E);
+@@
+expression E;
+@@
+-be64_to_cpus(&E);
++E = be64_to_cpu(E);
+@@
+expression E;
+@@
+-cpu_to_be16s(&E);
++E = cpu_to_be16(E);
+@@
+expression E;
+@@
+-cpu_to_be32s(&E);
++E = cpu_to_be32(E);
+@@
+expression E;
+@@
+-cpu_to_be64s(&E);
++E = cpu_to_be64(E);
+@@
+expression E;
+@@
+-le16_to_cpus(&E);
++E = le16_to_cpu(E);
+@@
+expression E;
+@@
+-le32_to_cpus(&E);
++E = le32_to_cpu(E);
+@@
+expression E;
+@@
+-le64_to_cpus(&E);
++E = le64_to_cpu(E);
+@@
+expression E;
+@@
+-cpu_to_le16s(&E);
++E = cpu_to_le16(E);
+@@
+expression E;
+@@
+-cpu_to_le32s(&E);
++E = cpu_to_le32(E);
+@@
+expression E;
+@@
+-cpu_to_le64s(&E);
++E = cpu_to_le64(E);
-- 
2.19.0
