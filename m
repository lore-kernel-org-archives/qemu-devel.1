Received: from eggs.gnu.org ([209.51.188.92]:57398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvv-0001wE-Ej
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvr-0002Dc-W8
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:55 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvr-000254-JE
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:51 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so762498wrt.13
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:56:46 +0100
Message-Id: <1549562254-41157-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/51] minikconfig: add semantic analysis
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
 scripts/minikconf.py | 138 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 130 insertions(+), 8 deletions(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index d74b9df..2df14ca 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -20,6 +20,10 @@ def debug_print(*args):
     print('#' + (' '.join(str(x) for x in args)))
     pass
 
+def debug_print(*args):
+    #print ' '.join(str(x) for x in args)
+    pass
+
 # -------------------------------------------
 # KconfigData implements the Kconfig semantics.  For now it can only
 # detect undefined symbols, i.e. symbols that were referenced in
@@ -39,6 +43,12 @@ class KconfigData:
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
@@ -46,6 +56,12 @@ class KconfigData:
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
@@ -53,35 +69,85 @@ class KconfigData:
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
+                raise KconfigParserError('contradiction between clauses when setting %s' % self)
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
+                raise KconfigParserError('cycle found including %s' % self)
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
@@ -89,20 +155,38 @@ class KconfigData:
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
@@ -120,11 +204,54 @@ class KconfigData:
                 undef = True
         return undef
 
+    def compute_config(self):
+        if self.check_undefined():
+            raise KconfigParserError(parser, "there were undefined symbols")
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
+        for name, v in self.referenced_vars.items():
+            self.do_default(v, False)
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
+        for name, v in self.referenced_vars.items():
+            debug_print("Evaluating", name)
+            values[name] = v.evaluate()
+
+        return values
+
     # semantic actions -------------
 
     def do_declaration(self, var):
         if (var in self.defined_vars):
-            raise Exception('variable "' + var + '" defined twice')
+            raise KconfigParserError('variable "' + var + '" defined twice')
 
         self.defined_vars.add(var.name)
 
@@ -201,9 +328,6 @@ class KconfigParser:
         data = KconfigData()
         parser = KconfigParser(data)
         parser.parse_file(fp)
-        if data.check_undefined():
-            raise KconfigParserError(parser, "there were undefined symbols")
-
         return data
 
     def __init__(self, data):
@@ -392,7 +516,6 @@ class KconfigParser:
               self.tok == TOK_SELECT or self.tok == TOK_BOOL or \
               self.tok == TOK_IMPLY:
             self.parse_property(var)
-        self.data.do_default(var, False)
 
         # for nicer error message
         if self.tok != TOK_SOURCE and self.tok != TOK_CONFIG and \
@@ -520,5 +643,4 @@ class KconfigParser:
 if __name__ == '__main__':
     fname = len(sys.argv) > 1 and sys.argv[1] or 'Kconfig.test'
     data = KconfigParser.parse(open(fname, 'r'))
-    for i in data.clauses:
-        print i
+    print data.compute_config()
-- 
1.8.3.1
