Received: from eggs.gnu.org ([2001:4830:134:3::10]:44743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqLx2-0007JX-IO
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqLx1-0001bb-Ps
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:20:48 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 16 Aug 2018 20:20:26 +0300
Message-Id: <1534440027-10528-4-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
References: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/4] scripts/qemu: add render_block_graph
 method for QEMUMachine
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

Render block nodes graph with help of graphviz

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/qemu.py | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index f099ce7278..cff562c713 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -460,3 +460,56 @@ class QEMUMachine(object):
                                                  socket.SOCK_STREAM)
             self._console_socket.connect(self._console_address)
         return self._console_socket
+
+    def render_block_graph(self, filename):
+        '''
+        Render graph in text (dot) representation into "filename" and graphical
+        representation into pdf file "filename".pdf
+        '''
+
+        try:
+            from graphviz import Digraph
+        except ImportError:
+            print "Can't import graphviz. Please run 'pip install graphviz'"
+            return
+
+        nodes = self.qmp('query-named-block-nodes')['return']
+        edges = self.qmp('x-query-block-nodes-relations')['return']
+        node_names = []
+
+        graph = Digraph(comment='Block Nodes Graph')
+        graph.node('permission symbols:\l'
+                   ' w - Write\l'
+                   ' r - consistent-Read\l'
+                   ' u - write - Unchanged\l'
+                   ' g - Graph-mod\l'
+                   ' s - reSize\l'
+                   'edge label scheme:\l'
+                   ' <child type>\l'
+                   ' <perm>\l'
+                   ' <shared_perm>\l', shape='none')
+
+        def perm(arr):
+            s = 'w' if 'write' in arr else '_'
+            s += 'r' if 'consistent-read' in arr else '_'
+            s += 'u' if 'write-unchanged' in arr else '_'
+            s += 'g' if 'graph-mod' in arr else '_'
+            s += 's' if 'resize' in arr else '_'
+            return s
+
+        for n in nodes:
+            node_names.append(n['node-name'])
+            label = n['node-name'] + ' [' + n['drv'] + ']'
+            if n['drv'] == 'file':
+                label = '<%s<br/>%s>' % (label, os.path.basename(n['file']))
+            graph.node(n['node-name'], label)
+
+        for r in edges:
+            if r['parent'] not in node_names:
+                graph.node(r['parent'], shape='box')
+
+            label = '%s\l%s\l%s\l' % (r['name'], perm(r['perm']),
+                                      perm(r['shared-perm']))
+            graph.edge(r['parent'], r['child'], label=label)
+
+        graph.render(filename)
-- 
2.11.1
