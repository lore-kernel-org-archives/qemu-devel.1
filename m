Received: from eggs.gnu.org ([2001:4830:134:3::10]:46667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWt-0004mO-Hr
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWr-0007jy-Dk
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:19 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWr-0007ji-6L
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:17 -0400
Received: by mail-wm0-x244.google.com with SMTP id u23so30503515wma.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:17 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.15.14 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:15:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:25 +0200
Message-Id: <1499238885-26161-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/42] configure: factor out list of supported
 Xen/KVM/HAX targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This will be useful when the functions are called, early in the configure
process, to filter out targets that do not support hardware acceleration.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 90 ++++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 55 insertions(+), 35 deletions(-)

diff --git a/configure b/configure
index c571ad1..0f14e79 100755
--- a/configure
+++ b/configure
@@ -163,6 +163,50 @@ have_backend () {
     echo "$trace_backends" | grep "$1" >/dev/null
 }
 
+glob() {
+    eval test -z '"${1#'"$2"'}"'
+}
+
+supported_hax_target() {
+    test "$hax" = "yes" || return 1
+    glob "$1" "*-softmmu" || return 1
+    case "${1%-softmmu}" in
+        i386|x86_64)
+            return 0
+        ;;
+    esac
+    return 1
+}
+
+supported_kvm_target() {
+    test "$kvm" = "yes" || return 1
+    glob "$1" "*-softmmu" || return 1
+    case "${1%-softmmu}:$cpu" in
+        arm:arm | aarch64:aarch64 | \
+        i386:i386 | i386:x86_64 | i386:x32 | \
+        x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
+        mips:mips | mipsel:mips | \
+        ppc:ppc | ppcemb:ppc | ppc64:ppc | \
+        ppc:ppc64 | ppcemb:ppc64 | ppc64:ppc64 | \
+        s390x:s390x)
+            return 0
+        ;;
+    esac
+    return 1
+}
+
+supported_xen_target() {
+    test "$xen" = "yes" || return 1
+    glob "$1" "*-softmmu" || return 1
+    case "${1%-softmmu}:$cpu" in
+        arm:arm | aarch64:aarch64 | \
+        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
+            return 0
+        ;;
+    esac
+    return 1
+}
+
 # default parameters
 source_path=$(dirname "$0")
 cpu=""
@@ -6178,46 +6222,22 @@ echo "TARGET_ABI_DIR=$TARGET_ABI_DIR" >> $config_target_mak
 if [ "$HOST_VARIANT_DIR" != "" ]; then
     echo "HOST_VARIANT_DIR=$HOST_VARIANT_DIR" >> $config_target_mak
 fi
-case "$target_name" in
-  i386|x86_64)
-    if test "$xen" = "yes" -a "$target_softmmu" = "yes" ; then
-      echo "CONFIG_XEN=y" >> $config_target_mak
-      if test "$xen_pci_passthrough" = yes; then
+
+if supported_xen_target $target; then
+    echo "CONFIG_XEN=y" >> $config_target_mak
+    if test "$xen_pci_passthrough" = yes; then
         echo "CONFIG_XEN_PCI_PASSTHROUGH=y" >> "$config_target_mak"
-      fi
     fi
-    ;;
-  *)
-esac
-case "$target_name" in
-  aarch64|arm|i386|x86_64|ppcemb|ppc|ppc64|s390x|mipsel|mips)
-    # Make sure the target and host cpus are compatible
-    if test "$kvm" = "yes" -a "$target_softmmu" = "yes" -a \
-      \( "$target_name" = "$cpu" -o \
-      \( "$target_name" = "ppcemb" -a "$cpu" = "ppc" \) -o \
-      \( "$target_name" = "ppc64"  -a "$cpu" = "ppc" \) -o \
-      \( "$target_name" = "ppc"    -a "$cpu" = "ppc64" \) -o \
-      \( "$target_name" = "ppcemb" -a "$cpu" = "ppc64" \) -o \
-      \( "$target_name" = "mipsel" -a "$cpu" = "mips" \) -o \
-      \( "$target_name" = "x86_64" -a "$cpu" = "i386"   \) -o \
-      \( "$target_name" = "i386"   -a "$cpu" = "x86_64" \) -o \
-      \( "$target_name" = "x86_64" -a "$cpu" = "x32"   \) -o \
-      \( "$target_name" = "i386"   -a "$cpu" = "x32" \) \) ; then
-      echo "CONFIG_KVM=y" >> $config_target_mak
-      if test "$vhost_net" = "yes" ; then
+fi
+if supported_kvm_target $target; then
+    echo "CONFIG_KVM=y" >> $config_target_mak
+    if test "$vhost_net" = "yes" ; then
         echo "CONFIG_VHOST_NET=y" >> $config_target_mak
         echo "CONFIG_VHOST_NET_TEST_$target_name=y" >> $config_host_mak
-      fi
     fi
-esac
-if test "$hax" = "yes" ; then
-  if test "$target_softmmu" = "yes" ; then
-    case "$target_name" in
-    i386|x86_64)
-      echo "CONFIG_HAX=y" >> $config_target_mak
-    ;;
-    esac
-  fi
+fi
+if supported_hax_target $target; then
+    echo "CONFIG_HAX=y" >> $config_target_mak
 fi
 if test "$target_bigendian" = "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
-- 
1.8.3.1
