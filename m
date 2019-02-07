Received: from eggs.gnu.org ([209.51.188.92]:57319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvs-0001uX-RQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvr-0002Cq-Is
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:52 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvr-00026j-AB
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:51 -0500
Received: by mail-wr1-x443.google.com with SMTP id z18so855410wrh.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:45 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:56:50 +0100
Message-Id: <1549562254-41157-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/51] minikconfig: implement allnoconfig and
 defconfig modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

Apart from defconfig (which is a no-op),
allyesconfig/allnoconfig/randcondfig can be implemented simply by ignoring
the RHS of assignments and "default" statements.  The RHS is replaced
respectively by "true", "false" or a random value.

However, allyesconfig and randconfig do not quite work, because all the
files for hw/ARCH/Kconfig are sourced and therefore you could end up
enabling some ARM boards in x86 or things like that.  This is left for
future work, but I am leaving it in to help debugging minikconf itself.

allnoconfig mode is tied to a new configure option, --without-default-devices.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile             |  1 +
 configure            | 12 +++++++++++-
 scripts/minikconf.py | 43 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 959ab9e..e444f91 100644
--- a/Makefile
+++ b/Makefile
@@ -331,6 +331,7 @@ endif
 
 # This has to be kept in sync with Kconfig.host.
 MINIKCONF_ARGS = \
+    $(CONFIG_MINIKCONF_MODE) \
     $@ $*-config.devices.mak.d $< $(MINIKCONF_INPUTS) \
     CONFIG_KVM=$(CONFIG_KVM) \
     CONFIG_SPICE=$(CONFIG_SPICE) \
diff --git a/configure b/configure
index 64f843f..39e80c7 100755
--- a/configure
+++ b/configure
@@ -486,7 +486,7 @@ libxml2=""
 docker="no"
 debug_mutex="no"
 libpmem=""
-libudev="no"
+default_devices="yes"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -997,6 +997,10 @@ for opt do
   ;;
   --with-trace-file=*) trace_file="$optarg"
   ;;
+  --with-default-devices) default_devices="yes"
+  ;;
+  --without-default-devices) default_devices="no"
+  ;;
   --enable-gprof) gprof="yes"
   ;;
   --enable-gcov) gcov="yes"
@@ -6183,6 +6187,7 @@ echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
+echo "default devices   $default_devices"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -6244,6 +6249,11 @@ echo "GIT_UPDATE=$git_update" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
 
+if test "$default_devices" = "yes" ; then
+  echo "CONFIG_MINIKCONF_MODE=--defconfig" >> $config_host_mak
+else
+  echo "CONFIG_MINIKCONF_MODE=--allnoconfig" >> $config_host_mak
+fi
 if test "$debug_tcg" = "yes" ; then
   echo "CONFIG_DEBUG_TCG=y" >> $config_host_mak
 fi
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index dd96ab9..dc1b612 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -14,17 +14,15 @@ from __future__ import print_function
 import os
 import sys
 import re
+import random
 
- __all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser' ]
+__all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser',
+        'defconfig', 'allyesconfig', 'allnoconfig', 'randconfig' ]
 
 def debug_print(*args):
     print('#' + (' '.join(str(x) for x in args)))
     pass
 
-def debug_print(*args):
-    #print ' '.join(str(x) for x in args)
-    pass
-
 # -------------------------------------------
 # KconfigData implements the Kconfig semantics.  For now it can only
 # detect undefined symbols, i.e. symbols that were referenced in
@@ -35,6 +33,11 @@ def debug_print(*args):
 # just its name).
 # -------------------------------------------
 
+allyesconfig = lambda x: True
+allnoconfig = lambda x: False
+defconfig = lambda x: x
+randconfig = lambda x: random.randint(0, 1) == 1
+
 class KconfigData:
     class Expr:
         def __and__(self, rhs):
@@ -188,7 +191,8 @@ class KconfigData:
             if self.cond.evaluate():
                 self.dest.set_value(True, self)
 
-    def __init__(self):
+    def __init__(self, value_mangler=defconfig):
+        self.value_mangler = value_mangler
         self.previously_included = []
         self.incl_info = None
         self.defined_vars = set()
@@ -268,6 +272,7 @@ class KconfigData:
         self.clauses.append(KconfigData.AssignmentClause(var, val))
 
     def do_default(self, var, val, cond=None):
+        val = self.value_mangler(val)
         self.clauses.append(KconfigData.DefaultClause(var, val, cond))
 
     def do_depends_on(self, var, expr):
@@ -324,9 +329,10 @@ class KconfigParserError(Exception):
         return "%s: %s" % (self.loc, self.msg)
 
 class KconfigParser:
+
     @classmethod
-    def parse(self, fp):
-        data = KconfigData()
+    def parse(self, fp, mode=None):
+        data = KconfigData(mode or KconfigParser.defconfig)
         parser = KconfigParser(data)
         parser.parse_file(fp)
         return data
@@ -649,11 +655,30 @@ class KconfigParser:
 
 if __name__ == '__main__':
     argv = sys.argv
+    mode = defconfig
+    if len(sys.argv) > 1:
+        if argv[1] == '--defconfig':
+            del argv[1]
+        elif argv[1] == '--randconfig':
+            random.seed()
+            mode = randconfig
+            del argv[1]
+        elif argv[1] == '--allyesconfig':
+            mode = allyesconfig
+            del argv[1]
+        elif argv[1] == '--allnoconfig':
+            mode = allnoconfig
+            del argv[1]
+
     if len(argv) == 1:
         print ("%s: at least one argument is required" % argv[0], file=sys.stderr)
         sys.exit(1)
 
-    data = KconfigData()
+    if argv[1].startswith('-'):
+        print ("%s: invalid option %s" % (argv[0], argv[1]), file=sys.stderr)
+        sys.exit(1)
+
+    data = KconfigData(mode)
     parser = KconfigParser(data)
     for arg in argv[3:]:
         m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
-- 
1.8.3.1
