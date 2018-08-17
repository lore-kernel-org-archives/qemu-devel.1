Received: from eggs.gnu.org ([2001:4830:134:3::10]:34447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqbhS-0000lk-Gt
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqbhP-0006rj-52
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:09:46 -0400
References: <1534440027-10528-1-git-send-email-vsementsov@virtuozzo.com>
	<1534440027-10528-4-git-send-email-vsementsov@virtuozzo.com>
	<20180817015429.GW15372@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <deec540b-aaf7-4f8d-5c9f-0684fb2b9b34@virtuozzo.com>
Date: Fri, 17 Aug 2018 13:08:42 +0300
MIME-Version: 1.0
In-Reply-To: <20180817015429.GW15372@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, crosa@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

17.08.2018 04:54, Eduardo Habkost wrote:
> On Thu, Aug 16, 2018 at 08:20:26PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Render block nodes graph with help of graphviz
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Thanks for your patch.  Comments below:
>
>> ---
>>   scripts/qemu.py | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index f099ce7278..cff562c713 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -460,3 +460,56 @@ class QEMUMachine(object):
>>                                                    socket.SOCK_STREAM)
>>               self._console_socket.connect(self._console_address)
>>           return self._console_socket
>> +
>> +    def render_block_graph(self, filename):
>> +        '''
>> +        Render graph in text (dot) representation into "filename" and graphical
>> +        representation into pdf file "filename".pdf
>> +        '''
>> +
>> +        try:
>> +            from graphviz import Digraph
> I'm not convinced that this belongs to qemu.py, if most code
> using the qemu.py module will never use it.  Do you see any
> problem in moving this code to a scripts/render_block_graph.py
> script?

Not a problem, I can do it.. Just one thought:
Isn't it better to keep all function doing something with one vm as 
methods, not separate functions?

>
>> +        except ImportError:
>> +            print "Can't import graphviz. Please run 'pip install graphviz'"
> If you really want to make this part of qemu.py, I suggest
> raising an appropriate exception instead of printing to stdout
> directly.

Ok

> (But just moving this code to a separate script would probably be
> simpler)
>
> Also, keep in mind that this module needs to work with both
> Python 3 and Python 2, so you need to use print("message ...")
> with parenthesis.
>
>
>> +            return
>> +
>> +        nodes = self.qmp('query-named-block-nodes')['return']
>> +        edges = self.qmp('x-query-block-nodes-relations')['return']
> I suggest you use .command() instead of .qmp().  It handles
> ['return'] and ['error'] for you.

Cool, thanks

>
>
>> +        node_names = []
>> +
>> +        graph = Digraph(comment='Block Nodes Graph')
>> +        graph.node('permission symbols:\l'
>> +                   ' w - Write\l'
>> +                   ' r - consistent-Read\l'
>> +                   ' u - write - Unchanged\l'
>> +                   ' g - Graph-mod\l'
>> +                   ' s - reSize\l'
>> +                   'edge label scheme:\l'
>> +                   ' <child type>\l'
>> +                   ' <perm>\l'
>> +                   ' <shared_perm>\l', shape='none')
>> +
>> +        def perm(arr):
>> +            s = 'w' if 'write' in arr else '_'
>> +            s += 'r' if 'consistent-read' in arr else '_'
>> +            s += 'u' if 'write-unchanged' in arr else '_'
>> +            s += 'g' if 'graph-mod' in arr else '_'
>> +            s += 's' if 'resize' in arr else '_'
>> +            return s
>> +
>> +        for n in nodes:
>> +            node_names.append(n['node-name'])
>> +            label = n['node-name'] + ' [' + n['drv'] + ']'
>> +            if n['drv'] == 'file':
>> +                label = '<%s<br/>%s>' % (label, os.path.basename(n['file']))
>> +            graph.node(n['node-name'], label)
>> +
>> +        for r in edges:
>> +            if r['parent'] not in node_names:
>> +                graph.node(r['parent'], shape='box')
>> +
>> +            label = '%s\l%s\l%s\l' % (r['name'], perm(r['perm']),
>> +                                      perm(r['shared-perm']))
>> +            graph.edge(r['parent'], r['child'], label=label)
>> +
>> +        graph.render(filename)
> The rest of the code looks OK to me.
>


-- 
Best regards,
Vladimir
