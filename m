Received: from eggs.gnu.org ([209.51.188.92]:58279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOt-0007jN-7k
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOq-0001yP-Kk
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOq-0001xf-9s
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id d15so6163583wmb.3
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:53 +0100
Message-Id: <1548410831-19553-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 34/52] minikconf: implement allnoconfig and
 defconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

Apart from defconfig (which is a no-op),
allyesconfig/allnoconfig/randcondfig can be implemented simply by ignoring
the RHS of assignments and "default" statements.  The RHS is replaced
respectively by "true", "false" or a random value.

However, allyesconfig and randconfig do not quite work, because all
the files for hw/ARCH/Kconfig are sourced and therefore you could
end up enabling some ARM boards in x86 or things like that.  This is
left for future work.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile             |  8 +++++---
 scripts/minikconf.py | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 70b9aec..f3b0dc8 100644
--- a/Makefile
+++ b/Makefile
@@ -340,6 +340,11 @@ MINIKCONF_ARGS = \
 MINIKCONF_INPUTS = $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig
 MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
 
+.PHONY: allnoconfig defconfig
+allnoconfig defconfig:
+	rm */config-devices.mak config-all-devices.mak
+	$(MAKE) MINIKCONF="$(MINIKCONF) --$<" config-all-devices.mak
+
 %/config-devices.mak: default-configs/%.mak $(MINIKCONF_INPUTS)
 	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) > $@.tmp, "GEN", "$@.tmp")
 	$(call quiet-command, if test -f $@; then \
@@ -360,9 +365,6 @@ MINIKCONF = $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \
 	  cp -p $@ $@.old; \
 	 fi,"GEN","$@");
 
-defconfig:
-	rm -f config-all-devices.mak $(SUBDIR_DEVICES_MAK)
-
 ifneq ($(wildcard config-host.mak),)
 include $(SRC_PATH)/Makefile.objs
 endif
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index e26a0e4..dde22ef 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -14,8 +14,10 @@ from __future__ import print_function
 import os
 import sys
 import re
+import random
 
-__all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser' ]
+__all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser',
+        'defconfig', 'allyesconfig', 'allnoconfig', 'randconfig' ]
 
 def debug_print(*args):
     #print ' '.join(str(x) for x in args)
@@ -31,6 +33,11 @@ def debug_print(*args):
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
@@ -184,7 +191,8 @@ class KconfigData:
             if self.cond.evaluate():
                 self.dest.set_value(True, self)
 
-    def __init__(self):
+    def __init__(self, value_mangler=defconfig):
+        self.value_mangler = value_mangler
         self.previously_included = []
         self.incl_info = None
         self.defined_vars = set()
@@ -265,6 +273,7 @@ class KconfigData:
         self.clauses.append(KconfigData.AssignmentClause(var, val))
 
     def do_default(self, var, val, cond=None):
+        val = self.value_mangler(val)
         self.clauses.append(KconfigData.DefaultClause(var, val, cond))
 
     def do_depends_on(self, var, expr):
@@ -314,9 +323,10 @@ class KconfigParserError(Exception):
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
@@ -632,11 +642,30 @@ class KconfigParser:
 
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
