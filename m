Received: from eggs.gnu.org ([209.51.188.92]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCS-0001oS-FS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h0sCR-0003pM-CU
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:28 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h0sCR-0003nw-5Q
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:20:27 -0500
Received: by mail-wm1-x333.google.com with SMTP id x10so126551wmg.2
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:20:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Mar 2019 19:19:30 +0100
Message-Id: <1551723614-1823-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/54] minikconfig: implement allnoconfig and
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
Cc: thuth@redhat.com, Yang Zhong <yang.zhong@intel.com>

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
 scripts/minikconf.py | 39 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 0c9cc3e..b0293aa 100644
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
index 3cc6a94..0fdbab4 100755
--- a/configure
+++ b/configure
@@ -487,7 +487,7 @@ libxml2=""
 docker="no"
 debug_mutex="no"
 libpmem=""
-libudev="no"
+default_devices="yes"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -996,6 +996,10 @@ for opt do
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
@@ -6250,6 +6254,7 @@ echo "capstone          $capstone"
 echo "docker            $docker"
 echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
+echo "default devices   $default_devices"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -6311,6 +6316,11 @@ echo "GIT_UPDATE=$git_update" >> $config_host_mak
 
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
index 6bedc57..5421db0 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -14,9 +14,11 @@ from __future__ import print_function
 import os
 import sys
 import re
+import random
 
 __all__ = [ 'KconfigDataError', 'KconfigParserError',
-            'KconfigData', 'KconfigParser' ]
+            'KconfigData', 'KconfigParser' ,
+            'defconfig', 'allyesconfig', 'allnoconfig', 'randconfig' ]
 
 def debug_print(*args):
     #print('# ' + (' '.join(str(x) for x in args)))
@@ -39,6 +41,11 @@ class KconfigDataError(Exception):
     def __str__(self):
         return self.msg
 
+allyesconfig = lambda x: True
+allnoconfig = lambda x: False
+defconfig = lambda x: x
+randconfig = lambda x: random.randint(0, 1) == 1
+
 class KconfigData:
     class Expr:
         def __and__(self, rhs):
@@ -192,7 +199,8 @@ class KconfigData:
             if self.cond.evaluate():
                 self.dest.set_value(True, self)
 
-    def __init__(self):
+    def __init__(self, value_mangler=defconfig):
+        self.value_mangler = value_mangler
         self.previously_included = []
         self.incl_info = None
         self.defined_vars = set()
@@ -272,6 +280,7 @@ class KconfigData:
         self.clauses.append(KconfigData.AssignmentClause(var, val))
 
     def do_default(self, var, val, cond=None):
+        val = self.value_mangler(val)
         self.clauses.append(KconfigData.DefaultClause(var, val, cond))
 
     def do_depends_on(self, var, expr):
@@ -328,9 +337,10 @@ class KconfigParserError(Exception):
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
@@ -653,11 +663,30 @@ class KconfigParser:
 
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
