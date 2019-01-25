Received: from eggs.gnu.org ([209.51.188.92]:58240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOr-0007hc-P7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOn-0001u7-64
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOm-0001sc-Rv
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:45 -0500
Received: by mail-wm1-x32d.google.com with SMTP id p6so6035689wmc.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:49 +0100
Message-Id: <1548410831-19553-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 30/52] minikconfig: add semantic analysis
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
Message-Id: <20190123065618.3520-25-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 136 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 130 insertions(+), 6 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index eeecac1..7fd1438 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -16,6 +16,10 @@ import sys
 
 __all__ = [ 'KconfigParserError', 'KconfigData', 'KconfigParser' ]
 
+def debug_print(*args):
+    #print ' '.join(str(x) for x in args)
+    pass
+
 # -------------------------------------------
 # KconfigData implements the Kconfig semantics.  For now it can only
 # detect undefined symbols, i.e. symbols that were referenced in
@@ -35,6 +39,12 @@ class KconfigData:
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
@@ -42,6 +52,12 @@ class KconfigData:
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
@@ -49,35 +65,85 @@ class KconfigData:
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
+            self.clauses_for_var = list()
         def __str__(self):
             return self.name
 
+        def has_value(self):
+            return not (self.value is None)
+        def set_value(self, val, clause):
+            self.clauses_for_var.append(clause)
+            if self.has_value() and self.value != val:
+                print("The following clauses were found for " + self.name)
+                for i in self.clauses_for_var:
+                    print("    " + str(i), file=sys.stderr)
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
             KconfigData.Clause.__init__(self, dest)
             self.value = value
         def __str__(self):
-            return "%s=%s" % (self.dest, 'y' if self.value else 'n')
+            return "CONFIG_%s=%s" % (self.dest, 'y' if self.value else 'n')
+
+        def process(self):
+            self.dest.set_value(self.value, self)
 
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
@@ -85,20 +151,38 @@ class KconfigData:
             else:
                 return "config %s default %s if %s" % (self.dest, value, self.cond)
 
+        def priority(self):
+            # Defaults are processed just before leaving the variable
+            return -1
+        def process(self):
+            if not self.dest.has_value() and \
+                    (self.cond is None or self.cond.evaluate()):
+                self.dest.set_value(self.value, self)
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
+                self.dest.set_value(False, self)
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
+                self.dest.set_value(True, self)
+
     def __init__(self):
         self.previously_included = []
         self.incl_info = None
@@ -116,6 +200,50 @@ class KconfigData:
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
@@ -190,9 +318,6 @@ class KconfigParser:
         data = KconfigData()
         parser = KconfigParser(data)
         parser.parse_file(fp)
-        if data.check_undefined():
-            raise KconfigParserError(parser, "there were undefined symbols")
-
         return data
 
     def __init__(self, data):
@@ -501,5 +626,4 @@ class KconfigParser:
 if __name__ == '__main__':
     fname = len(sys.argv) > 1 and sys.argv[1] or 'Kconfig.test'
     data = KconfigParser.parse(open(fname, 'r'))
-    for i in data.clauses:
-        print i
+    print data.compute_config()
-- 
1.8.3.1
