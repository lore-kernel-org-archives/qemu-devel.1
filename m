Received: from eggs.gnu.org ([2001:4830:134:3::10]:36455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqk8L-0000x6-Aq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqk7y-0001gT-8l
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 15:09:43 -0400
Date: Fri, 17 Aug 2018 16:09:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180817190920.GL15372@localhost.localdomain>
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<20180817180440.49687-2-vsementsov@virtuozzo.com>
	<20180817182543.GK15372@localhost.localdomain>
	<20662248-c334-6479-36a8-937f622151ab@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20662248-c334-6479-36a8-937f622151ab@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
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

On Fri, Aug 17, 2018 at 09:59:41PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
> 17.08.2018 21:25, Eduardo Habkost wrote:
> > On Fri, Aug 17, 2018 at 09:04:39PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> > > Render block nodes graph with help of graphviz. This new function i=
s
> > > for debugging, so there is no sense to put it into qemu.py as a met=
hod
> > > of QEMUMachine. Let's instead put it separately.
> > >=20
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
> > > ---
> > >   scripts/render_block_graph.py | 78 ++++++++++++++++++++++++++++++=
+++++++++++++
> > >   1 file changed, 78 insertions(+)
> > >   create mode 100644 scripts/render_block_graph.py
> > >=20
> > > diff --git a/scripts/render_block_graph.py b/scripts/render_block_g=
raph.py
> > > new file mode 100644
> > > index 0000000000..7048a0bac8
> > > --- /dev/null
> > > +++ b/scripts/render_block_graph.py
> > > @@ -0,0 +1,78 @@
> > > +# Render Qemu Block Graph
> > [...]
> >=20
> > What about making the script work from the command-line?
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > diff --git a/scripts/render_block_graph.py b/scripts/render_block_gra=
ph.py
> > old mode 100644
> > new mode 100755
> > index 7048a0bac8..e29fe0fc41
> > --- a/scripts/render_block_graph.py
> > +++ b/scripts/render_block_graph.py
> > @@ -1,3 +1,4 @@
> > +#!/usr/bin/env python
> >   # Render Qemu Block Graph
> >   #
> >   # Copyright (c) 2017 Parallels International GmbH
> > @@ -16,8 +17,9 @@
> >   # along with this program.  If not, see <http://www.gnu.org/license=
s/>.
> >   #
> > -import os
> > +import os, sys
> >   from graphviz import Digraph
> > +from qmp.qmp import QEMUMonitorProtocol
> >   def perm(arr):
> >       s =3D 'w' if 'write' in arr else '_'
> > @@ -27,16 +29,16 @@ def perm(arr):
> >       s +=3D 's' if 'resize' in arr else '_'
> >       return s
> > -def render_block_graph(vm, filename, pointers=3DFalse, format=3D'png=
'):
> > +def render_block_graph(qmp, filename, pointers=3DFalse, format=3D'pn=
g'):
> >       '''
> >       Render graph in text (dot) representation into "@filename" and
> >       representation in @format into "@filename.@format"
> >       '''
> > -    nodes =3D vm.command('query-named-block-nodes')
> > +    nodes =3D qmp.command('query-named-block-nodes')
> >       nodes_info =3D {n['node-name']: n for n in nodes}
> > -    block_graph =3D vm.command('x-query-block-graph')
> > +    block_graph =3D qmp.command('x-query-block-graph')
> >       graph =3D Digraph(comment=3D'Block Nodes Graph')
> >       graph.format =3D format
> > @@ -76,3 +78,9 @@ def render_block_graph(vm, filename, pointers=3DFal=
se, format=3D'png'):
> >           graph.edge(str(e['parent']), str(e['child']), label=3Dlabel=
)
> >       graph.render(filename)
> > +
> > +if __name__ =3D=3D '__main__':
> > +    #TODO: use argparse for command-line arguments
> > +    qmp =3D QEMUMonitorProtocol(sys.argv[1])
> > +    qmp.connect()
> > +    render_block_graph(qmp, sys.argv[2])
> >=20
> >=20
>=20
> Cool, thanks.
>=20
> so, how to use it then?
>=20
> for python iotest a proper parameter would be vm._qmp, yes?

Yes, assuming you just want to do it locally just for debugging.

One thing we could do later: refactor QEMUMachine and
QEMUMonitorProtocol so their method names are the same and both
'vm' and 'vm._qmp' work here.

>=20
> is there a way to dump running libvirt vm graph?
>=20
> I've started libvirt guest, qemu process has cmdline parameters
> -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-3-=
tmp/monitor.sock,server,nowait
> -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol
>=20
> command
> virsh qemu-monitor-command tmp '{"execute": "x-query-block-graph"}'
> works fine,
>=20
> but script hangs on connection:
> # python ./scripts/render_block_graph.py
> /var/lib/libvirt/qemu/domain-3-tmp/monitor.sock
> ^CTraceback (most recent call last):
> =A0 File "./scripts/render_block_graph.py", line 85, in <module>
> =A0=A0=A0 qmp.connect()
> =A0 File "/work/src/qemu/up-new-fleecing/scripts/qmp/qmp.py", line 140,=
 in
> connect
> =A0=A0=A0 self.__sock.connect(self.__address)
> =A0 File "/usr/lib64/python2.7/socket.py", line 224, in meth
> =A0=A0=A0 return getattr(self._sock,name)(*args)
> KeyboardInterrupt
>=20
> ./scripts/qmp/qmp-shell /var/lib/libvirt/qemu/domain-3-tmp/monitor.sock
> outputs nothing...

I don't know why it doesn't work with a running instance started
by libvirt, but it works if I run QEMU manually using "-qmp
unix:/tmp/qmp,server".

--=20
Eduardo
