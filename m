Received: from eggs.gnu.org ([2001:4830:134:3::10]:40822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fsrp9-0002jn-SX
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fsrp6-0007SU-Tf
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:47:03 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 23 Aug 2018 18:46:54 +0300
Message-Id: <20180823154655.40188-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180823154655.40188-1-vsementsov@virtuozzo.com>
References: <20180823154655.40188-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 2/3] scripts: add render_block_graph
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
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

Render block nodes graph with help of graphviz. This new function is
for debugging, so there is no sense to put it into qemu.py as a method
of QEMUMachine. Let's instead put it separately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/render_block_graph.py | 120 ++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100755 scripts/render_block_graph.py

diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
new file mode 100755
index 0000000000..382cc769ef
--- /dev/null
+++ b/scripts/render_block_graph.py
@@ -0,0 +1,120 @@
+#!/usr/bin/env python
+#
+# Render Qemu Block Graph
+#
+# Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved.
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
+import sys
+import subprocess
+import json
+from graphviz import Digraph
+from qemu import MonitorResponseError
+
+
+def perm(arr):
+    s = 'w' if 'write' in arr else '_'
+    s += 'r' if 'consistent-read' in arr else '_'
+    s += 'u' if 'write-unchanged' in arr else '_'
+    s += 'g' if 'graph-mod' in arr else '_'
+    s += 's' if 'resize' in arr else '_'
+    return s
+
+
+def render_block_graph(qmp, filename, format='png'):
+    '''
+    Render graph in text (dot) representation into "@filename" and
+    representation in @format into "@filename.@format"
+    '''
+
+    bds_nodes = qmp.command('query-named-block-nodes')
+    bds_nodes = {n['node-name']: n for n in bds_nodes}
+
+    job_nodes = qmp.command('query-block-jobs')
+    job_nodes = {n['device']: n for n in job_nodes}
+
+    block_graph = qmp.command('x-debug-query-block-graph')
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
+    for n in block_graph['nodes']:
+        if n['type'] == 'bds':
+            info = bds_nodes[n['name']]
+            label = n['name'] + ' [' + info['drv'] + ']'
+            if info['drv'] == 'file':
+                label += '\n' + os.path.basename(info['file'])
+            shape = 'ellipse'
+        elif n['type'] == 'job':
+            info = job_nodes[n['name']]
+            label = info['type'] + ' job (' + n['name'] + ')'
+            shape = 'box'
+        else:
+            assert n['type'] == 'blk'
+            label = n['name'] if n['name'] else 'unnamed blk'
+            shape = 'box'
+
+        graph.node(str(n['id']), label, shape=shape)
+
+    for e in block_graph['edges']:
+        label = '%s\l%s\l%s\l' % (e['name'], perm(e['perm']),
+                                  perm(e['shared-perm']))
+        graph.edge(str(e['parent']), str(e['child']), label=label)
+
+    graph.render(filename)
+
+
+class LibvirtGuest():
+    def __init__(self, name):
+        self.name = name
+
+    def command(self, cmd):
+        # only supports qmp commands without parameters
+        m = {'execute': cmd}
+        ar = ['virsh', 'qemu-monitor-command', self.name, json.dumps(m)]
+
+        reply = json.loads(subprocess.check_output(ar))
+
+        if 'error' in reply:
+            raise MonitorResponseError(reply)
+
+        return reply['return']
+
+
+if __name__ == '__main__':
+    obj = sys.argv[1]
+    out = sys.argv[2]
+
+    if os.path.exists(obj):
+        # assume unix socket
+        qmp = QEMUMonitorProtocol(obj)
+        qmp.connect()
+    else:
+        # assume libvirt guest name
+        qmp = LibvirtGuest(obj)
+
+    render_block_graph(qmp, out)
-- 
2.18.0
