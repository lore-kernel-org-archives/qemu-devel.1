Received: from eggs.gnu.org ([2001:4830:134:3::10]:52705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7391b064d=Alistair.Francis@wdc.com>)
	id 1fjCUj-0001oY-3c
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 19:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7391b064d=Alistair.Francis@wdc.com>)
	id 1fjCUf-00032n-6s
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 19:50:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7391b064d=Alistair.Francis@wdc.com>)
	id 1fjCUe-000302-MV
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 19:49:57 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Fri, 27 Jul 2018 16:49:42 -0700
Message-Id: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 1/1] configure: Add RISC-V host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

Allow QEMU to be built to run on a RISC-V host.

QEMU does not yet have a RISC-V TCG or user mode target port, but
running other architectures on RISC-V using TCI does work.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 configure | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 2a7796ea80..c3ff3ae146 100755
--- a/configure
+++ b/configure
@@ -606,6 +606,16 @@ EOF
   compile_object
 }
 
+check_define_value() {
+cat > $TMPC <<EOF
+#if (($1) != ($2))
+#error $1 != ($2)
+#endif
+int main(void) { return 0; }
+EOF
+  compile_object
+}
+
 check_include() {
 cat > $TMPC <<EOF
 #include <$1>
@@ -704,6 +714,12 @@ elif check_define __arm__ ; then
   cpu="arm"
 elif check_define __aarch64__ ; then
   cpu="aarch64"
+elif check_define __riscv ; then
+  if check_define_value __riscv_xlen 64 ; then
+    cpu="riscv64"
+  else
+    cpu="riscv32"
+  fi
 else
   cpu=$(uname -m)
 fi
@@ -712,7 +728,7 @@ ARCH=
 # Normalise host CPU name and set ARCH.
 # Note that this case should only have supported host CPUs, not guests.
 case "$cpu" in
-  ppc|ppc64|s390|s390x|sparc64|x32)
+  ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
     cpu="$cpu"
     supported_cpu="yes"
     eval "cross_cc_${cpu}=\$host_cc"
-- 
2.17.1
