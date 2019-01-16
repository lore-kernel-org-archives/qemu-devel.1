Received: from eggs.gnu.org ([209.51.188.92]:44300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjceT-000534-Pa
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gjceS-0002lM-8b
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:18:05 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 16 Jan 2019 15:17:11 +1100
Message-Id: <20190116041712.130183-2-aik@ozlabs.ru>
In-Reply-To: <20190116041712.130183-1-aik@ozlabs.ru>
References: <20190116041712.130183-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu 1/2] update-linux-headers.sh: Copy new
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org

Since Linux'es ab66dcc76d "powerpc: generate uapi header and system call
table files" there are 2 new files: unistd_32.h and unistd_64.h. These
files content is moved from unistd.h so now we have to copy new files
as well, just like we already do for other architectures; this does it
for MIPS as well.

Also, v5.0-rc2 moved vhost bits around in 4b86713236e4bd
"vhost: split structs into a separate header file", add those too.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 scripts/update-linux-headers.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0a964fe..1cd8bd5 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -121,11 +121,20 @@ for arch in $ARCHLIST; do
         cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
         cp_portable "$tmpdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
     fi
+    if [ $arch = powerpc ]; then
+        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-powerpc/"
+        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"
+    fi
+    if [ $arch = mips ]; then
+        cp "$tmpdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-mips/"
+        cp "$tmpdir/include/asm/unistd_n32.h" "$output/linux-headers/asm-mips/"
+        cp "$tmpdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-mips/"
+    fi
 done
 
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
-for header in kvm.h vfio.h vfio_ccw.h vhost.h \
+for header in kvm.h vfio.h vfio_ccw.h vhost.h vhost_types.h \
               psci.h psp-sev.h userfaultfd.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
-- 
2.17.1
