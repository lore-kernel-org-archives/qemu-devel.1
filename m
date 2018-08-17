Received: from eggs.gnu.org ([2001:4830:134:3::10]:55644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTyR-0003i9-WB
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTyR-0007zP-4R
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:54:47 -0400
Date: Thu, 16 Aug 2018 22:54:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180817015429.GW15372@localhost.localdomain>
References: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
	<1534440027-10528-4-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534440027-10528-4-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] scripts/qemu: add render_block_graph
 method for QEMUMachine
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

On Thu, Aug 16, 2018 at 08:20:26PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Render block nodes graph with help of graphviz
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks for your patch.  Comments below:

> ---
>  scripts/qemu.py | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index f099ce7278..cff562c713 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -460,3 +460,56 @@ class QEMUMachine(object):
>                                                   socket.SOCK_STREAM)
>              self._console_socket.connect(self._console_address)
>          return self._console_socket
> +
> +    def render_block_graph(self, filename):
> +        '''
> +        Render graph in text (dot) representation into "filename" and graphical
> +        representation into pdf file "filename".pdf
> +        '''
> +
> +        try:
> +            from graphviz import Digraph

I'm not convinced that this belongs to qemu.py, if most code
using the qemu.py module will never use it.  Do you see any
problem in moving this code to a scripts/render_block_graph.py
script?

> +        except ImportError:
> +            print "Can't import graphviz. Please run 'pip install graphviz'"

If you really want to make this part of qemu.py, I suggest
raising an appropriate exception instead of printing to stdout
directly.

(But just moving this code to a separate script would probably be
simpler)

Also, keep in mind that this module needs to work with both
Python 3 and Python 2, so you need to use print("message ...")
with parenthesis.


> +            return
> +
> +        nodes = self.qmp('query-named-block-nodes')['return']
> +        edges = self.qmp('x-query-block-nodes-relations')['return']

I suggest you use .command() instead of .qmp().  It handles
['return'] and ['error'] for you.


> +        node_names = []
> +
> +        graph = Digraph(comment='Block Nodes Graph')
> +        graph.node('permission symbols:\l'
> +                   ' w - Write\l'
> +                   ' r - consistent-Read\l'
> +                   ' u - write - Unchanged\l'
> +                   ' g - Graph-mod\l'
> +                   ' s - reSize\l'
> +                   'edge label scheme:\l'
> +                   ' <child type>\l'
> +                   ' <perm>\l'
> +                   ' <shared_perm>\l', shape='none')
> +
> +        def perm(arr):
> +            s = 'w' if 'write' in arr else '_'
> +            s += 'r' if 'consistent-read' in arr else '_'
> +            s += 'u' if 'write-unchanged' in arr else '_'
> +            s += 'g' if 'graph-mod' in arr else '_'
> +            s += 's' if 'resize' in arr else '_'
> +            return s
> +
> +        for n in nodes:
> +            node_names.append(n['node-name'])
> +            label = n['node-name'] + ' [' + n['drv'] + ']'
> +            if n['drv'] == 'file':
> +                label = '<%s<br/>%s>' % (label, os.path.basename(n['file']))
> +            graph.node(n['node-name'], label)
> +
> +        for r in edges:
> +            if r['parent'] not in node_names:
> +                graph.node(r['parent'], shape='box')
> +
> +            label = '%s\l%s\l%s\l' % (r['name'], perm(r['perm']),
> +                                      perm(r['shared-perm']))
> +            graph.edge(r['parent'], r['child'], label=label)
> +
> +        graph.render(filename)

The rest of the code looks OK to me.

-- 
Eduardo
