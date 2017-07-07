Received: from eggs.gnu.org ([2001:4830:134:3::10]:45607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTVT6-0002WI-0H
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTVT2-0001i0-TA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:46:56 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  7 Jul 2017 17:46:46 +0200
Message-Id: <20170707154646.22230-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] hxtool: remove dead -q option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-trivial@nongnu.org

This was used to extract .txt documentation for QMP.  This was
changed to use the QAPI schema instead, so zap it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/hxtool | 46 +---------------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/scripts/hxtool b/scripts/hxtool
index 5468cd7782..1e2c97c5e6 100644
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -7,7 +7,7 @@ hxtoh()
         case $str in
             HXCOMM*)
             ;;
-            STEXI*|ETEXI*|SQMP*|EQMP*) flag=$(($flag^1))
+            STEXI*|ETEXI*) flag=$(($flag^1))
             ;;
             *)
             test $flag -eq 1 && printf "%s\n" "$str"
@@ -45,12 +45,6 @@ hxtotexi()
             fi
             flag=0
             ;;
-            SQMP*|EQMP*)
-            if test $flag -eq 1 ; then
-                printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            ;;
             DEFHEADING*)
             print_texi_heading "$(expr "$str" : "DEFHEADING(\(.*\))")"
             ;;
@@ -65,47 +59,9 @@ hxtotexi()
     done
 }
 
-hxtoqmp()
-{
-    IFS=
-    flag=0
-    line=1
-    while read -r str; do
-        case "$str" in
-            HXCOMM*)
-            ;;
-            SQMP*)
-            if test $flag -eq 1 ; then
-                printf "line %d: syntax error: expected EQMP, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            flag=1
-            ;;
-            EQMP*)
-            if test $flag -ne 1 ; then
-                printf "line %d: syntax error: expected SQMP, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            flag=0
-            ;;
-            STEXI*|ETEXI*)
-            if test $flag -eq 1 ; then
-                printf "line %d: syntax error: expected EQMP, found '%s'\n" "$line" "$str" >&2
-                exit 1
-            fi
-            ;;
-            *)
-            test $flag -eq 1 && printf '%s\n' "$str"
-            ;;
-        esac
-        line=$((line+1))
-    done
-}
-
 case "$1" in
 "-h") hxtoh ;;
 "-t") hxtotexi ;;
-"-q") hxtoqmp ;;
 *) exit 1 ;;
 esac
 
-- 
2.13.0
