Received: from eggs.gnu.org ([209.51.188.92]:60417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWv-0005W7-Qx
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWu-00048E-LP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:36921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCWu-0002NF-D0
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:56 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:17 +0800
Message-Id: <20190123065618.3520-44-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 43/44] minikconf: implement allyesconfig,
 allnoconfig, randconfig, defconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Apart from defconfig (which is a no-op), the others are implemented
implemented simply by ignoring the RHS of assignments and "default"
statements.  The RHS is replaced respectively by "true", "false" or
a random value.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile             |  5 +++++
 scripts/minikconf.py | 43 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index c4b5c35ff5..97c6453415 100644
--- a/Makefile
+++ b/Makefile
@@ -336,6 +336,11 @@ MINIKCONF_ARGS = \
 
 MINIKCONF = $(SHELL) $(SRC_PATH)/scripts/minikconf.sh
 
+.PHONY: allyesconfig allnoconfig defconfig randconfig
+allyesconfig allnoconfig defconfig randconfig:
+	rm */config-devices.mak config-all-devices.mak
+	$(MAKE) MINIKCONF="$(MINIKCONF) --$<" config-all-devices.mak
+
 %/config-devices.mak: default-configs/%-softmmu.mak Kconfig.host hw/Kconfig
 	$(call quiet-command, \
             $(MINIKCONF) $@ $*-config-devices.mak.d $^ $(MINIKCONF_ARGS) > $@.tmp, "  GEN   $@.tmp")
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index b0b4f76733..a6c2f0c759 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -13,8 +13,10 @@
 import os
 import sys
 import re
+import random
 
-__all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser' ]
+__all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser',
+        'defconfig', 'allyesconfig', 'allnoconfig', 'randconfig' ]
 
 def debug_print(*args):
     #print ' '.join(str(x) for x in args)
@@ -30,6 +32,11 @@ def debug_print(*args):
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
@@ -178,7 +185,8 @@ class KconfigData:
             if self.cond.evaluate():
                 self.dest.set_value(True)
 
-    def __init__(self):
+    def __init__(self, value_mangler=defconfig):
+        self.value_mangler = value_mangler
         self.previously_included = []
         self.incl_info = None
         self.defined_vars = set()
@@ -256,10 +264,12 @@ class KconfigData:
         return var_obj
 
     def do_assignment(self, var, val):
-        self.clauses.append(KconfigData.AssignmentClause(var, val))
+        f = self.value_mangler
+        self.clauses.append(KconfigData.AssignmentClause(var, f(val)))
 
     def do_default(self, var, val, cond=None):
-        self.clauses.append(KconfigData.DefaultClause(var, val, cond))
+        f = self.value_mangler
+        self.clauses.append(KconfigData.DefaultClause(var, f(val), cond))
 
     def do_depends_on(self, var, expr):
         self.clauses.append(KconfigData.DependsOnClause(var, expr))
@@ -307,9 +317,10 @@ class KconfigParserError(Exception):
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
@@ -625,11 +636,29 @@ class KconfigParser:
 
 if __name__ == '__main__':
     argv = sys.argv
+    mode = defconfig
+    if len(sys.argv) > 1:
+        if argv[1] == '--defconfig':
+            del argv[1]
+        elif argv[1] == '--randconfig':
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
         print >>sys.stderr, "%s: at least one argument is required" % argv[0]
         os.exit(1)
 
-    data = KconfigData()
+    if argv[1].startswith('-'):
+        print >>sys.stderr, "%s: invalid option %s" % (argv[0], argv[1])
+        os.exit(1)
+
+    data = KconfigData(mode)
     parser = KconfigParser(data)
     for arg in argv[3:]:
         m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
-- 
2.17.1
