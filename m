Received: from eggs.gnu.org ([209.51.188.92]:59952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVq-0004YL-Sc
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVp-0003X2-Ns
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:36924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCVp-0002Nr-F4
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:49 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:55:57 +0800
Message-Id: <20190123065618.3520-24-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 23/44] minikconfig: add AST
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

Add Python classes that represent the Kconfig abstract syntax tree.
The abstract syntax tree is stored as a list of clauses.  For example:

    config FOO
        depends on BAR
        select BAZ

is represented as three clauses:

    FOO depends on BAR
    FOO default n
    select BAZ if FOO

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 116 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 98 insertions(+), 18 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index fb39e35d6a..a6a28c9c47 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -26,11 +26,84 @@ __all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser' ]
 # -------------------------------------------
 
 class KconfigData:
+    class Expr:
+        def __and__(self, rhs):
+            return KconfigData.AND(self, rhs)
+        def __or__(self, rhs):
+            return KconfigData.OR(self, rhs)
+        def __invert__(self):
+            return KconfigData.NOT(self)
+
+    class AND(Expr):
+        def __init__(self, lhs, rhs):
+            self.lhs = lhs
+            self.rhs = rhs
+        def __str__(self):
+            return "(%s && %s)" % (self.lhs, self.rhs)
+
+    class OR(Expr):
+        def __init__(self, lhs, rhs):
+            self.lhs = lhs
+            self.rhs = rhs
+        def __str__(self):
+            return "(%s || %s)" % (self.lhs, self.rhs)
+
+    class NOT(Expr):
+        def __init__(self, lhs):
+            self.lhs = lhs
+        def __str__(self):
+            return "!%s" % (self.lhs)
+
+    class Var(Expr):
+        def __init__(self, name):
+            self.name = name
+            self.value = None
+        def __str__(self):
+            return self.name
+
+    class Clause:
+        def __init__(self, dest):
+            self.dest = dest
+
+    class AssignmentClause(Clause):
+        def __init__(self, dest, value):
+            KconfigData.Clause.__init__(self, dest)
+            self.value = value
+        def __str__(self):
+            return "%s=%s" % (self.dest, 'y' if self.value else 'n')
+
+    class DefaultClause(Clause):
+        def __init__(self, dest, value, cond=None):
+            KconfigData.Clause.__init__(self, dest)
+            self.value = value
+            self.cond = cond
+        def __str__(self):
+            value = 'y' if self.value else 'n'
+            if self.cond is None:
+                return "config %s default %s" % (self.dest, value)
+            else:
+                return "config %s default %s if %s" % (self.dest, value, self.cond)
+
+    class DependsOnClause(Clause):
+        def __init__(self, dest, expr):
+            KconfigData.Clause.__init__(self, dest)
+            self.expr = expr
+        def __str__(self):
+            return "config %s depends on %s" % (self.dest, self.expr)
+
+    class SelectClause(Clause):
+        def __init__(self, dest, cond):
+            KconfigData.Clause.__init__(self, dest)
+            self.cond = cond
+        def __str__(self):
+            return "select %s if %s" % (self.dest, self.cond)
+
     def __init__(self):
         self.previously_included = []
         self.incl_info = None
         self.defined_vars = set()
-        self.referenced_vars = set()
+        self.referenced_vars = dict()
+        self.clauses = list()
 
     # semantic analysis -------------
 
@@ -48,26 +121,28 @@ class KconfigData:
         if (var in self.defined_vars):
             raise Exception('variable "' + var + '" defined twice')
 
-        self.defined_vars.add(var)
+        self.defined_vars.add(var.name)
 
     # var is a string with the variable's name.
-    #
-    # For now this just returns the variable's name itself.
     def do_var(self, var):
-        self.referenced_vars.add(var)
-        return var
+        if (var in self.referenced_vars):
+            return self.referenced_vars[var]
+
+        var_obj = self.referenced_vars[var] = KconfigData.Var(var)
+        return var_obj
 
     def do_assignment(self, var, val):
-        pass
+        self.clauses.append(KconfigData.AssignmentClause(var, val))
 
     def do_default(self, var, val, cond=None):
-        pass
+        self.clauses.append(KconfigData.DefaultClause(var, val, cond))
 
     def do_depends_on(self, var, expr):
-        pass
+        self.clauses.append(KconfigData.DependsOnClause(var, expr))
 
     def do_select(self, var, symbol, cond=None):
-        pass
+        cond = (cond & var) if cond is not None else var
+        self.clauses.append(KconfigData.SelectClause(symbol, cond))
 
 # -------------------------------------------
 # KconfigParser implements a recursive descent parser for (simplified)
@@ -227,31 +302,34 @@ class KconfigParser:
     def parse_primary(self):
         if self.tok == TOK_NOT:
             self.get_token()
-            self.parse_primary()
+            val = ~self.parse_primary()
         elif self.tok == TOK_LPAREN:
             self.get_token()
-            self.parse_expr()
+            val = self.parse_expr()
             if self.tok != TOK_RPAREN:
                 raise KconfigParserError(self, 'Expected ")"')
             self.get_token()
         elif self.tok == TOK_ID:
-            self.parse_var()
+            val = self.parse_var()
         else:
             raise KconfigParserError(self, 'Expected "!" or "(" or identifier')
+        return val
 
     # disj: primary (OR primary)*
     def parse_disj(self):
-        self.parse_primary()
+        lhs = self.parse_primary()
         while self.tok == TOK_OR:
             self.get_token()
-            self.parse_primary()
+            lhs = lhs | self.parse_primary()
+        return lhs
 
     # expr: disj (AND disj)*
     def parse_expr(self):
-        self.parse_disj()
+        lhs = self.parse_disj()
         while self.tok == TOK_AND:
             self.get_token()
-            self.parse_disj()
+            lhs = lhs & self.parse_disj()
+        return lhs
 
     # condition: IF expr
     #       | empty
@@ -420,4 +498,6 @@ class KconfigParser:
 
 if __name__ == '__main__':
     fname = len(sys.argv) > 1 and sys.argv[1] or 'Kconfig.test'
-    KconfigParser.parse(open(fname, 'r'))
+    data = KconfigParser.parse(open(fname, 'r'))
+    for i in data.clauses:
+        print i
-- 
2.17.1
