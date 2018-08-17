Received: from eggs.gnu.org ([2001:4830:134:3::10]:36708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqk96-0001Jh-V6
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqjyZ-0002Vj-57
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:00:00 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<20180817180440.49687-2-vsementsov@virtuozzo.com>
	<20180817182543.GK15372@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20662248-c334-6479-36a8-937f622151ab@virtuozzo.com>
Date: Fri, 17 Aug 2018 21:59:41 +0300
MIME-Version: 1.0
In-Reply-To: <20180817182543.GK15372@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, crosa@redhat.com, eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

17.08.2018 21:25, Eduardo Habkost wrote:
> On Fri, Aug 17, 2018 at 09:04:39PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Render block nodes graph with help of graphviz. This new function is
>> for debugging, so there is no sense to put it into qemu.py as a method
>> of QEMUMachine. Let's instead put it separately.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   scripts/render_block_graph.py | 78 +++++++++++++++++++++++++++++++++++=
++++++++
>>   1 file changed, 78 insertions(+)
>>   create mode 100644 scripts/render_block_graph.py
>>
>> diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.=
py
>> new file mode 100644
>> index 0000000000..7048a0bac8
>> --- /dev/null
>> +++ b/scripts/render_block_graph.py
>> @@ -0,0 +1,78 @@
>> +# Render Qemu Block Graph
> [...]
>
> What about making the script work from the command-line?
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.p=
y
> old mode 100644
> new mode 100755
> index 7048a0bac8..e29fe0fc41
> --- a/scripts/render_block_graph.py
> +++ b/scripts/render_block_graph.py
> @@ -1,3 +1,4 @@
> +#!/usr/bin/env python
>   # Render Qemu Block Graph
>   #
>   # Copyright (c) 2017 Parallels International GmbH
> @@ -16,8 +17,9 @@
>   # along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   #
>  =20
> -import os
> +import os, sys
>   from graphviz import Digraph
> +from qmp.qmp import QEMUMonitorProtocol
>  =20
>   def perm(arr):
>       s =3D 'w' if 'write' in arr else '_'
> @@ -27,16 +29,16 @@ def perm(arr):
>       s +=3D 's' if 'resize' in arr else '_'
>       return s
>  =20
> -def render_block_graph(vm, filename, pointers=3DFalse, format=3D'png'):
> +def render_block_graph(qmp, filename, pointers=3DFalse, format=3D'png'):
>       '''
>       Render graph in text (dot) representation into "@filename" and
>       representation in @format into "@filename.@format"
>       '''
>  =20
> -    nodes =3D vm.command('query-named-block-nodes')
> +    nodes =3D qmp.command('query-named-block-nodes')
>       nodes_info =3D {n['node-name']: n for n in nodes}
>  =20
> -    block_graph =3D vm.command('x-query-block-graph')
> +    block_graph =3D qmp.command('x-query-block-graph')
>  =20
>       graph =3D Digraph(comment=3D'Block Nodes Graph')
>       graph.format =3D format
> @@ -76,3 +78,9 @@ def render_block_graph(vm, filename, pointers=3DFalse, =
format=3D'png'):
>           graph.edge(str(e['parent']), str(e['child']), label=3Dlabel)
>  =20
>       graph.render(filename)
> +
> +if __name__ =3D=3D '__main__':
> +    #TODO: use argparse for command-line arguments
> +    qmp =3D QEMUMonitorProtocol(sys.argv[1])
> +    qmp.connect()
> +    render_block_graph(qmp, sys.argv[2])
>
>

Cool, thanks.

so, how to use it then?

for python iotest a proper parameter would be vm._qmp, yes?

is there a way to dump running libvirt vm graph?

I've started libvirt guest, qemu process has cmdline parameters
-chardev=20
socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-3-tmp/monitor.s=
ock,server,nowait
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol

command
virsh qemu-monitor-command tmp '{"execute": "x-query-block-graph"}'
works fine,

but script hangs on connection:
# python ./scripts/render_block_graph.py=20
/var/lib/libvirt/qemu/domain-3-tmp/monitor.sock
^CTraceback (most recent call last):
 =C2=A0 File "./scripts/render_block_graph.py", line 85, in <module>
 =C2=A0=C2=A0=C2=A0 qmp.connect()
 =C2=A0 File "/work/src/qemu/up-new-fleecing/scripts/qmp/qmp.py", line 140,=
=20
in connect
 =C2=A0=C2=A0=C2=A0 self.__sock.connect(self.__address)
 =C2=A0 File "/usr/lib64/python2.7/socket.py", line 224, in meth
 =C2=A0=C2=A0=C2=A0 return getattr(self._sock,name)(*args)
KeyboardInterrupt

./scripts/qmp/qmp-shell /var/lib/libvirt/qemu/domain-3-tmp/monitor.sock
outputs nothing...


--=20
Best regards,
Vladimir
