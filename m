Received: from eggs.gnu.org ([209.51.188.92]:37489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0hy-0007uQ-N3
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0hx-0007ca-E9
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 19:59:58 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 31 Jan 2019 01:59:34 +0100
Message-Id: <20190131005945.20149-3-mreitz@redhat.com>
In-Reply-To: <20190131005945.20149-1-mreitz@redhat.com>
References: <20190131005945.20149-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/13] scripts: add render_block_graph function
 for QEMUMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Render block nodes graph with help of graphviz. This new function is
for debugging, so there is no sense to put it into qemu.py as a method
of QEMUMachine. Let's instead put it separately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20181221170909.25584-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 scripts/render_block_graph.py | 120 ++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100755 scripts/render_block_graph.py

diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.p=
y
new file mode 100755
index 0000000000..ed7e581b4f
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
+    s =3D 'w' if 'write' in arr else '_'
+    s +=3D 'r' if 'consistent-read' in arr else '_'
+    s +=3D 'u' if 'write-unchanged' in arr else '_'
+    s +=3D 'g' if 'graph-mod' in arr else '_'
+    s +=3D 's' if 'resize' in arr else '_'
+    return s
+
+
+def render_block_graph(qmp, filename, format=3D'png'):
+    '''
+    Render graph in text (dot) representation into "@filename" and
+    representation in @format into "@filename.@format"
+    '''
+
+    bds_nodes =3D qmp.command('query-named-block-nodes')
+    bds_nodes =3D {n['node-name']: n for n in bds_nodes}
+
+    job_nodes =3D qmp.command('query-block-jobs')
+    job_nodes =3D {n['device']: n for n in job_nodes}
+
+    block_graph =3D qmp.command('x-debug-query-block-graph')
+
+    graph =3D Digraph(comment=3D'Block Nodes Graph')
+    graph.format =3D format
+    graph.node('permission symbols:\l'
+               '  w - Write\l'
+               '  r - consistent-Read\l'
+               '  u - write - Unchanged\l'
+               '  g - Graph-mod\l'
+               '  s - reSize\l'
+               'edge label scheme:\l'
+               '  <child type>\l'
+               '  <perm>\l'
+               '  <shared_perm>\l', shape=3D'none')
+
+    for n in block_graph['nodes']:
+        if n['type'] =3D=3D 'block-driver':
+            info =3D bds_nodes[n['name']]
+            label =3D n['name'] + ' [' + info['drv'] + ']'
+            if info['drv'] =3D=3D 'file':
+                label +=3D '\n' + os.path.basename(info['file'])
+            shape =3D 'ellipse'
+        elif n['type'] =3D=3D 'block-job':
+            info =3D job_nodes[n['name']]
+            label =3D info['type'] + ' job (' + n['name'] + ')'
+            shape =3D 'box'
+        else:
+            assert n['type'] =3D=3D 'block-backend'
+            label =3D n['name'] if n['name'] else 'unnamed blk'
+            shape =3D 'box'
+
+        graph.node(str(n['id']), label, shape=3Dshape)
+
+    for e in block_graph['edges']:
+        label =3D '%s\l%s\l%s\l' % (e['name'], perm(e['perm']),
+                                  perm(e['shared-perm']))
+        graph.edge(str(e['parent']), str(e['child']), label=3Dlabel)
+
+    graph.render(filename)
+
+
+class LibvirtGuest():
+    def __init__(self, name):
+        self.name =3D name
+
+    def command(self, cmd):
+        # only supports qmp commands without parameters
+        m =3D {'execute': cmd}
+        ar =3D ['virsh', 'qemu-monitor-command', self.name, json.dumps(m=
)]
+
+        reply =3D json.loads(subprocess.check_output(ar))
+
+        if 'error' in reply:
+            raise MonitorResponseError(reply)
+
+        return reply['return']
+
+
+if __name__ =3D=3D '__main__':
+    obj =3D sys.argv[1]
+    out =3D sys.argv[2]
+
+    if os.path.exists(obj):
+        # assume unix socket
+        qmp =3D QEMUMonitorProtocol(obj)
+        qmp.connect()
+    else:
+        # assume libvirt guest name
+        qmp =3D LibvirtGuest(obj)
+
+    render_block_graph(qmp, out)
--=20
2.20.1
