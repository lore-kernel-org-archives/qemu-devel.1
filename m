Received: from eggs.gnu.org ([2001:4830:134:3::10]:56127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjRg-0006fw-J7
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqjRf-0002jb-NQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 14:26:00 -0400
Date: Fri, 17 Aug 2018 15:25:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180817182543.GK15372@localhost.localdomain>
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<20180817180440.49687-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817180440.49687-2-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] scripts: add render_block_graph
 function for QEMUMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, crosa@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

On Fri, Aug 17, 2018 at 09:04:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Render block nodes graph with help of graphviz. This new function is
> for debugging, so there is no sense to put it into qemu.py as a method
> of QEMUMachine. Let's instead put it separately.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/render_block_graph.py | 78 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 scripts/render_block_graph.py
> 
> diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
> new file mode 100644
> index 0000000000..7048a0bac8
> --- /dev/null
> +++ b/scripts/render_block_graph.py
> @@ -0,0 +1,78 @@
> +# Render Qemu Block Graph
[...]

What about making the script work from the command-line?

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
old mode 100644
new mode 100755
index 7048a0bac8..e29fe0fc41
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -1,3 +1,4 @@
+#!/usr/bin/env python
 # Render Qemu Block Graph
 #
 # Copyright (c) 2017 Parallels International GmbH
@@ -16,8 +17,9 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
-import os
+import os, sys
 from graphviz import Digraph
+from qmp.qmp import QEMUMonitorProtocol
 
 def perm(arr):
     s = 'w' if 'write' in arr else '_'
@@ -27,16 +29,16 @@ def perm(arr):
     s += 's' if 'resize' in arr else '_'
     return s
 
-def render_block_graph(vm, filename, pointers=False, format='png'):
+def render_block_graph(qmp, filename, pointers=False, format='png'):
     '''
     Render graph in text (dot) representation into "@filename" and
     representation in @format into "@filename.@format"
     '''
 
-    nodes = vm.command('query-named-block-nodes')
+    nodes = qmp.command('query-named-block-nodes')
     nodes_info = {n['node-name']: n for n in nodes}
 
-    block_graph = vm.command('x-query-block-graph')
+    block_graph = qmp.command('x-query-block-graph')
 
     graph = Digraph(comment='Block Nodes Graph')
     graph.format = format
@@ -76,3 +78,9 @@ def render_block_graph(vm, filename, pointers=False, format='png'):
         graph.edge(str(e['parent']), str(e['child']), label=label)
 
     graph.render(filename)
+
+if __name__ == '__main__':
+    #TODO: use argparse for command-line arguments
+    qmp = QEMUMonitorProtocol(sys.argv[1])
+    qmp.connect()
+    render_block_graph(qmp, sys.argv[2])


-- 
Eduardo
