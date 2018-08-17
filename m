Received: from eggs.gnu.org ([2001:4830:134:3::10]:50064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqj7A-0004mg-Nw
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqj76-0006cM-0s
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:04:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 21:04:39 +0300
Message-Id: <20180817180440.49687-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180817180440.49687-1-vsementsov@virtuozzo.com>
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/3] scripts: add render_block_graph
 function for QEMUMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com

Render block nodes graph with help of graphviz. This new function is
for debugging, so there is no sense to put it into qemu.py as a method
of QEMUMachine. Let's instead put it separately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/render_block_graph.py | 78 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 scripts/render_block_graph.py

diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
new file mode 100644
index 0000000000..7048a0bac8
--- /dev/null
+++ b/scripts/render_block_graph.py
@@ -0,0 +1,78 @@
+# Render Qemu Block Graph
+#
+# Copyright (c) 2017 Parallels International GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+from graphviz import Digraph
+
+def perm(arr):
+    s = 'w' if 'write' in arr else '_'
+    s += 'r' if 'consistent-read' in arr else '_'
+    s += 'u' if 'write-unchanged' in arr else '_'
+    s += 'g' if 'graph-mod' in arr else '_'
+    s += 's' if 'resize' in arr else '_'
+    return s
+
+def render_block_graph(vm, filename, pointers=False, format='png'):
+    '''
+    Render graph in text (dot) representation into "@filename" and
+    representation in @format into "@filename.@format"
+    '''
+
+    nodes = vm.command('query-named-block-nodes')
+    nodes_info = {n['node-name']: n for n in nodes}
+
+    block_graph = vm.command('x-query-block-graph')
+
+    graph = Digraph(comment='Block Nodes Graph')
+    graph.format = format
+    graph.node('permission symbols:\l'
+               '  w - Write\l'
+               '  r - consistent-Read\l'
+               '  u - write - Unchanged\l'
+               '  g - Graph-mod\l'
+               '  s - reSize\l'
+               'edge label scheme:\l'
+               '  <child type>\l'
+               '  <perm>\l'
+               '  <shared_perm>\l', shape='none')
+
+
+    for n in block_graph['nodes']:
+        if n['type'] == 'block':
+            info = nodes_info[n['node-name']]
+            label = n['node-name'] + ' [' + info['drv'] + ']'
+            shape = 'ellipse'
+        else:
+            assert n['type'] == 'other'
+            label = n['description']
+            shape = 'box'
+
+        if pointers:
+            label += '\n0x%x' % n['id']
+
+        if n['type'] == 'block' and info['drv'] == 'file':
+            label += '\n' + os.path.basename(info['file'])
+
+        graph.node(str(n['id']), label, shape=shape)
+
+    for e in block_graph['edges']:
+        label = '%s\l%s\l%s\l' % (e['name'], perm(e['perm']),
+                                  perm(e['shared-perm']))
+        graph.edge(str(e['parent']), str(e['child']), label=label)
+
+    graph.render(filename)
-- 
2.11.1
