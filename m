Received: from eggs.gnu.org ([2001:4830:134:3::10]:48777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4MHP-0002E9-LA
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4MHL-0004iu-Py
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:27:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4MHL-0004hv-HO
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:27:07 -0400
Date: Tue, 17 Oct 2017 09:27:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171017092702.5b82103b@nial.brq.redhat.com>
In-Reply-To: <20171016163636.GI11975@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, 16 Oct 2017 17:36:36 +0100
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Mon, Oct 16, 2017 at 06:22:50PM +0200, Igor Mammedov wrote:
> > Series allows to configure NUMA mapping at runtime using QMP/HMP
> > interface. For that to happen it introduces a new '-paused' CLI option
> > which allows to pause QEMU before machine_init() is run and
> > adds new set-numa-node HMP/QMP commands which in conjuction with
> > info hotpluggable-cpus/query-hotpluggable-cpus allow to configure
> > NUMA mapping for cpus. =20
>=20
> What's the problem we're seeking solve here compared to what we currently
> do for NUMA configuration ?
=46rom RHBZ1382425
"
Current -numa CLI interface is quite limited in terms that allow map CPUs t=
o NUMA nodes as it requires to provide cpu_index values which are non obvio=
us and depend on machine/arch. As result libvirt has to assume/re-implement=
 cpu_index allocation logic to provide valid values for -numa cpus=3D... QE=
MU CLI option.

Now QEMU has in place generic CPU hotplug interface and ability to query po=
ssible CPUs layout (with QMP command query-hotpluggable-cpus),
however it requires to run QEMU once per each machine type and topology con=
figuration (-M & -smp combination) which would be too taxing for mgmt layer=
 to do.
Currently proposed idea to solve the issue is to do NUMA mapping at runtime:
 1. start QEMU in stopped mode with needed -M & -smp configuration
    but leave out "-numa cpus" options
 2. query possible cpus layout (query-hotpluggable-cpus)
 3. use new QMP command to map CPUs to NUMA node in terms of generic CPU
    hotplug interface (socket/core/thread)

    commit (419fcde numa: add '-numa cpu,...' option for property based nod=
e mapping)
    added CLI option for topology based

...
 4. continue VM exection
"

> >=20
> > HMP configuration session for CLI '-smp 1,maxcpus=3D2' would look like:
> >=20
> > (qemu) info hotpluggable-cpus=20
> > Hotpluggable CPUs:
> >   type: "qemu64-x86_64-cpu"
> >   vcpus_count: "1"
> >   CPUInstance Properties:
> >     socket-id: "1"
> >     core-id: "0"
> >     thread-id: "0"
> >   type: "qemu64-x86_64-cpu"
> >   vcpus_count: "1"
> >   qom_path: "/machine/unattached/device[0]"
> >   CPUInstance Properties:
> >     socket-id: "0"
> >     core-id: "0"
> >     thread-id: "0"
> > (qemu) set-numa-node node,nodeid=3D0
> > (qemu) set-numa-node node,nodeid=3D1
> > (qemu) set-numa-node cpu,socket-id=3D0,node-id=3D0
> > (qemu) set-numa-node cpu,socket-id=3D1,node-id=3D1
> > (qemu) info hotpluggable-cpus=20
> > Hotpluggable CPUs:
> >   type: "qemu64-x86_64-cpu"
> >   vcpus_count: "1"
> >   CPUInstance Properties:
> >     node-id: "1"
> >     socket-id: "1"
> >     core-id: "0"
> >     thread-id: "0"
> >   type: "qemu64-x86_64-cpu"
> >   vcpus_count: "1"
> >   CPUInstance Properties:
> >     node-id: "0"
> >     socket-id: "0"
> >     core-id: "0"
> >     thread-id: "0"
> > (qemu) cont
> >=20
> > git tree for testing:
> >   https://github.com/imammedo/qemu qmp_preconfig_rfc
> >=20
> >=20
> > CC: eblake@redhat.com
> > CC: armbru@redhat.com
> > CC: ehabkost@redhat.com
> > CC: pkrempa@redhat.com
> > CC: david@gibson.dropbear.id.au
> > CC: peter.maydell@linaro.org
> > CC: pbonzini@redhat.com
> > CC: cohuck@redhat.com
> >=20
> > Igor Mammedov (6):
> >   numa: postpone options post-processing till machine_run_board_init()
> >   numa: split out NumaOptions parsing into parse_NumaOptions()
> >   possible_cpus: add CPUArchId::type field
> >   CLI: add -paused option
> >   HMP: add set-numa-node command
> >   QMP: add set-numa-node command
> >=20
> >  hmp.h                      |  1 +
> >  include/hw/boards.h        |  2 ++
> >  include/sysemu/numa.h      |  2 ++
> >  include/sysemu/sysemu.h    |  1 +
> >  hmp-commands.hx            | 13 ++++++++
> >  hmp.c                      | 23 ++++++++++++++
> >  hw/arm/virt.c              |  3 +-
> >  hw/core/machine.c          | 18 ++++++-----
> >  hw/i386/pc.c               |  4 ++-
> >  hw/ppc/spapr.c             | 13 +++++---
> >  hw/s390x/s390-virtio-ccw.c |  1 +
> >  numa.c                     | 79 ++++++++++++++++++++++++++++++++++----=
--------
> >  qapi-schema.json           | 13 ++++++++
> >  qemu-options.hx            | 15 +++++++++
> >  qmp.c                      |  5 +++
> >  vl.c                       | 54 ++++++++++++++++++++++++++++++-
> >  16 files changed, 210 insertions(+), 37 deletions(-)
> >=20
> > --=20
> > 2.7.4
> >=20
> >  =20
>=20
> Regards,
> Daniel
