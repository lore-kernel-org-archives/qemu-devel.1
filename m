Received: from eggs.gnu.org ([2001:4830:134:3::10]:46390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyKtJ-0003PK-IM
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyKtG-0002RM-Ed
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:17:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyKtG-0002Qv-AP
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:17:38 -0400
Date: Tue, 20 Mar 2018 19:17:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521566230-111929-2-git-send-email-mst@redhat.com>
References: <1521566230-111929-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521566230-111929-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] update-linux-headers.sh: add unistd.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Add the header and its dependencies.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/update-linux-headers.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index d18e2f1..e528bda 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -80,11 +80,6 @@ for arch in $ARCHLIST; do
         continue
     fi
 
-    # Blacklist architectures which have KVM headers but are actually dead
-    if [ "$arch" = "ia64" -o "$arch" = "mips" ]; then
-        continue
-    fi
-
     if [ "$arch" = x86 ]; then
         arch_var=SRCARCH
     else
@@ -95,9 +90,17 @@ for arch in $ARCHLIST; do
 
     rm -rf "$output/linux-headers/asm-$arch"
     mkdir -p "$output/linux-headers/asm-$arch"
-    for header in kvm.h kvm_para.h unistd.h; do
+    for header in unistd.h bitsperlong.h; do
         cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
     done
+
+    # Blacklist architectures which have KVM headers but are actually dead
+    if [ "$arch" != "ia64" -a "$arch" != "mips" ]; then
+        for header in kvm.h kvm_para.h; do
+            cp "$tmpdir/include/asm/$header" "$output/linux-headers/asm-$arch"
+        done
+    fi
+
     if [ $arch = powerpc ]; then
         cp "$tmpdir/include/asm/epapr_hcalls.h" "$output/linux-headers/asm-powerpc/"
     fi
@@ -130,7 +133,7 @@ for header in kvm.h kvm_para.h vfio.h vfio_ccw.h vhost.h \
 done
 rm -rf "$output/linux-headers/asm-generic"
 mkdir -p "$output/linux-headers/asm-generic"
-for header in kvm_para.h; do
+for header in kvm_para.h bitsperlong.h unistd.h; do
     cp "$tmpdir/include/asm-generic/$header" "$output/linux-headers/asm-generic"
 done
 if [ -L "$linux/source" ]; then
-- 
MST
