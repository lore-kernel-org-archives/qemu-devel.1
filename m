Received: from eggs.gnu.org ([2001:4830:134:3::10]:51236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4JU-0008OZ-3p
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4JS-0007JG-40
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:04 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4JR-0007Hh-TY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:02 -0400
Received: by mail-wm0-x244.google.com with SMTP id y5so21469462wmh.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:35:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:33 +0200
Message-Id: <1499099693-22903-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/22] configure: early test for supported
 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Check for unsupported targets in target_list, and print an
error early in the configuration process.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 65 ++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/configure b/configure
index 0f14e79..6d1a6a9 100755
--- a/configure
+++ b/configure
@@ -40,14 +40,18 @@ printf " '%s'" "$0" "$@" >> config.log
 echo >> config.log
 echo "#" >> config.log
 
-error_exit() {
-    echo
+print_error() {
+    (echo
     echo "ERROR: $1"
     while test -n "$2"; do
         echo "       $2"
         shift
     done
-    echo
+    echo) >&2
+}
+
+error_exit() {
+    print_error "$@"
     exit 1
 }
 
@@ -207,6 +211,25 @@ supported_xen_target() {
     return 1
 }
 
+supported_target() {
+    case "$1" in
+        ${target_name}-softmmu) ;;
+        ${target_name}-linux-user)
+            if test "$linux" != "yes"; then
+                print_error "Target '$target' is only available on a Linux host"
+                return 1
+            fi
+            ;;
+        ${target_name}-bsd-user)
+            if test "$bsd" != "yes"; then
+                print_error "Target '$target' is only available on a BSD host"
+                return 1
+            fi
+            ;;
+    esac
+    return 0
+}
+
 # default parameters
 source_path=$(dirname "$0")
 cpu=""
@@ -1734,23 +1757,27 @@ if test "$solaris" = "yes" ; then
 fi
 
 if test -z "${target_list+xxx}" ; then
-    target_list="$default_target_list"
+    for target in $default_target_list; do
+        supported_target $target 2>/dev/null && \
+            target_list="$target_list $target"
+    done
+    target_list="${target_list# }"
 else
     target_list=$(echo "$target_list" | sed -e 's/,/ /g')
+    for target in $target_list; do
+        # Check that we recognised the target name; this allows a more
+        # friendly error message than if we let it fall through.
+        case " $default_target_list " in
+            *" $target "*)
+                ;;
+            *)
+                error_exit "Unknown target name '$target'"
+                ;;
+        esac
+        supported_target $target || exit 1
+    done
 fi
 
-# Check that we recognised the target name; this allows a more
-# friendly error message than if we let it fall through.
-for target in $target_list; do
-    case " $default_target_list " in
-        *" $target "*)
-            ;;
-        *)
-            error_exit "Unknown target name '$target'"
-            ;;
-    esac
-done
-
 # see if system emulation was really requested
 case " $target_list " in
   *"-softmmu "*) softmmu=yes
@@ -6050,16 +6077,10 @@ case "$target" in
     target_softmmu="yes"
     ;;
   ${target_name}-linux-user)
-    if test "$linux" != "yes" ; then
-      error_exit "Target '$target' is only available on a Linux host"
-    fi
     target_user_only="yes"
     target_linux_user="yes"
     ;;
   ${target_name}-bsd-user)
-    if test "$bsd" != "yes" ; then
-      error_exit "Target '$target' is only available on a BSD host"
-    fi
     target_user_only="yes"
     target_bsd_user="yes"
     ;;
-- 
1.8.3.1
