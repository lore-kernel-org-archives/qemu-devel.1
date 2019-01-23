Received: from eggs.gnu.org ([209.51.188.92]:59971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVr-0004ZC-My
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCVq-0003XK-ER
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:36921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCVq-0002NF-5a
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 01:59:50 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:55:58 +0800
Message-Id: <20190123065618.3520-25-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 24/44] minikconfig: add semantic analysis
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

There are three parts in the semantic analysis:

1) evaluating expressions.  This is done as a simple visit
of the Expr nodes.

2) ordering clauses.  This is done by constructing a graph of variables.
There is an edge from X to Y if Y depends on X, if X selects Y, or if
X appears in a conditional selection of Y; in other words, if the value
of X can affect the value of Y.  Each clause has a "destination" variable
whose value can be affected by the clause, and clauses will be processed
according to a topological sorting of their destination variables.
Defaults are processed after all other clauses with the same destination.

3) deriving the value of the variables.  This is done by processing
the clauses in the topological order provided by the previous step.
A "depends on" clause will force a variable to False, a "select" clause
will force a variable to True, an assignment will force a variable
to its RHS.  A default will set a variable to its RHS if it has not
been set before.  Because all variables have a default, after visiting
all clauses all variables will have been set.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 129 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 5 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index a6a28c9c47..48800591e2 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -15,6 +15,10 @@ import sys
 
 __all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser' ]
 
+def debug_print(*args):
+    #print ' '.join(str(x) for x in args)
+    pass
+
 # -------------------------------------------
 # KconfigData implements the Kconfig semantics.  For now it can only
 # detect undefined symbols, i.e. symbols that were referenced in
@@ -34,6 +38,12 @@ class KconfigData:
         def __invert__(self):
             return KconfigData.NOT(self)
 
+        # Abstract methods
+        def add_edges_to(self, var):
+            pass
+        def evaluate(self):
+            assert False
+
     class AND(Expr):
         def __init__(self, lhs, rhs):
             self.lhs = lhs
@@ -41,6 +51,12 @@ class KconfigData:
         def __str__(self):
             return "(%s && %s)" % (self.lhs, self.rhs)
 
+        def add_edges_to(self, var):
+            self.lhs.add_edges_to(var)
+            self.rhs.add_edges_to(var)
+        def evaluate(self):
+            return self.lhs.evaluate() and self.rhs.evaluate()
+
     class OR(Expr):
         def __init__(self, lhs, rhs):
             self.lhs = lhs
@@ -48,22 +64,62 @@ class KconfigData:
         def __str__(self):
             return "(%s || %s)" % (self.lhs, self.rhs)
 
+        def add_edges_to(self, var):
+            self.lhs.add_edges_to(var)
+            self.rhs.add_edges_to(var)
+        def evaluate(self):
+            return self.lhs.evaluate() or self.rhs.evaluate()
+
     class NOT(Expr):
         def __init__(self, lhs):
             self.lhs = lhs
         def __str__(self):
             return "!%s" % (self.lhs)
 
+        def add_edges_to(self, var):
+            self.lhs.add_edges_to(var)
+        def evaluate(self):
+            return not self.lhs.evaluate()
+
     class Var(Expr):
         def __init__(self, name):
             self.name = name
             self.value = None
+            self.outgoing = set()
         def __str__(self):
             return self.name
 
+        def has_value(self):
+            return not (self.value is None)
+        def set_value(self, val):
+            if self.has_value() and self.value != val:
+                raise Exception('contradiction between clauses when setting %s' % self)
+            debug_print("=> %s is now %s" % (self.name, val))
+            self.value = val
+
+        # depth first search of the dependency graph
+        def dfs(self, visited, f):
+            if self in visited:
+                return
+            visited.add(self)
+            for v in self.outgoing:
+                v.dfs(visited, f)
+            f(self)
+
+        def add_edges_to(self, var):
+            self.outgoing.add(var)
+        def evaluate(self):
+            if not self.has_value():
+                raise Exception('cycle found including %s' % self)
+            return self.value
+
     class Clause:
         def __init__(self, dest):
             self.dest = dest
+        def priority(self):
+            return 0
+        def process(self):
+            pass
 
     class AssignmentClause(Clause):
         def __init__(self, dest, value):
@@ -72,11 +128,16 @@ class KconfigData:
         def __str__(self):
             return "%s=%s" % (self.dest, 'y' if self.value else 'n')
 
+        def process(self):
+            self.dest.set_value(self.value)
+
     class DefaultClause(Clause):
         def __init__(self, dest, value, cond=None):
             KconfigData.Clause.__init__(self, dest)
             self.value = value
             self.cond = cond
+            if not (self.cond is None):
+                self.cond.add_edges_to(self.dest)
         def __str__(self):
             value = 'y' if self.value else 'n'
             if self.cond is None:
@@ -84,20 +145,38 @@ class KconfigData:
             else:
                 return "config %s default %s if %s" % (self.dest, value, self.cond)
 
+        def priority(self):
+            # Defaults are processed just before leaving the variable
+            return -1
+        def process(self):
+            if not self.dest.has_value() and \
+                    (self.cond is None or self.cond.evaluate()):
+                self.dest.set_value(self.value)
+
     class DependsOnClause(Clause):
         def __init__(self, dest, expr):
             KconfigData.Clause.__init__(self, dest)
             self.expr = expr
+            self.expr.add_edges_to(self.dest)
         def __str__(self):
             return "config %s depends on %s" % (self.dest, self.expr)
 
+        def process(self):
+            if not self.expr.evaluate():
+                self.dest.set_value(False)
+
     class SelectClause(Clause):
         def __init__(self, dest, cond):
             KconfigData.Clause.__init__(self, dest)
             self.cond = cond
+            self.cond.add_edges_to(self.dest)
         def __str__(self):
             return "select %s if %s" % (self.dest, self.cond)
 
+        def process(self):
+            if self.cond.evaluate():
+                self.dest.set_value(True)
+
     def __init__(self):
         self.previously_included = []
         self.incl_info = None
@@ -115,6 +194,50 @@ class KconfigData:
                 undef = True
         return undef
 
+    def compute_config(self):
+        if self.check_undefined():
+            raise Exception(parser, "there were undefined symbols")
+            return None
+
+        debug_print("Input:")
+        for clause in self.clauses:
+            debug_print(clause)
+
+        debug_print("\nDependency graph:")
+        for i in self.referenced_vars:
+            debug_print(i, "->", [str(x) for x in self.referenced_vars[i].outgoing])
+
+        # The reverse of the depth-first order is the topological sort
+        dfo = dict()
+        visited = set()
+        debug_print("\n")
+        def visit_fn(var):
+            debug_print(var, "has DFS number", len(dfo))
+            dfo[var] = len(dfo)
+
+        for name in self.referenced_vars:
+            v = self.referenced_vars[name]
+            v.dfs(visited, visit_fn)
+
+        # Put higher DFS numbers and higher priorities first.  This
+        # places the clauses in topological order and places defaults
+        # after assignments and dependencies.
+        self.clauses.sort(key=lambda x: (-dfo[x.dest], -x.priority()))
+
+        debug_print("\nSorted clauses:")
+        for clause in self.clauses:
+            debug_print(clause)
+            clause.process()
+
+        debug_print("")
+        values = dict()
+        for name in self.referenced_vars:
+            debug_print("Evaluating", name)
+            v = self.referenced_vars[name]
+            values[name] = v.evaluate()
+
+        return values
+
     # semantic actions -------------
 
     def do_declaration(self, var):
@@ -188,9 +311,6 @@ class KconfigParser:
         data = KconfigData()
         parser = KconfigParser(data)
         parser.parse_file(fp)
-        if data.check_undefined():
-            raise KconfigParserError(parser, "there were undefined symbols")
-
         return data
 
     def __init__(self, data):
@@ -499,5 +619,4 @@ class KconfigParser:
 if __name__ == '__main__':
     fname = len(sys.argv) > 1 and sys.argv[1] or 'Kconfig.test'
     data = KconfigParser.parse(open(fname, 'r'))
-    for i in data.clauses:
-        print i
+    print data.compute_config()
-- 
2.17.1
