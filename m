Received: from eggs.gnu.org ([209.51.188.92]:47529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ggh4q-0003ck-5A
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 21:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ggh4p-0006P9-0P
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 21:25:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ggh4o-0006OG-OM
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 21:25:10 -0500
Date: Mon, 7 Jan 2019 21:25:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190107212122-mutt-send-email-mst@kernel.org>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<20190107182604-mutt-send-email-mst@kernel.org>
	<7f230258-0950-9155-ec9c-6c6102ed2c2b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7f230258-0950-9155-ec9c-6c6102ed2c2b@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 0/5] Support for
 datapath switching during live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: si-wei liu <si-wei.liu@oracle.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Mon, Jan 07, 2019 at 05:45:22PM -0800, si-wei liu wrote:
>=20
>=20
> On 01/07/2019 03:32 PM, Michael S. Tsirkin wrote:
> > On Mon, Jan 07, 2019 at 05:29:39PM -0500, Venu Busireddy wrote:
> > > Implement the infrastructure to support datapath switching during l=
ive
> > > migration involving SR-IOV devices.
> > >=20
> > > 1. This patch is based off on the current VIRTIO_NET_F_STANDBY feat=
ure
> > >     bit and MAC address device pairing.
> > >=20
> > > 2. This set of events will be consumed by userspace management soft=
ware
> > >     to orchestrate all the hot plug and datapath switching activiti=
es.
> > >     This scheme has the least QEMU modifications while allowing use=
rspace
> > >     software to build its own intelligence to control the whole pro=
cess
> > >     of SR-IOV live migration.
> > >=20
> > > 3. While the hidden device model (viz. coupled device model) is sti=
ll
> > >     being explored for automatic hot plugging (QEMU) and automatic =
datapath
> > >     switching (host-kernel), this series provides a supplemental se=
t
> > >     of interfaces if management software wants to drive the SR-IOV =
live
> > >     migration on its own. It should not conflict with the hidden de=
vice
> > >     model but just offers simplicity of implementation.
> > >=20
> > >=20
> > > Si-Wei Liu (2):
> > >    vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorten downtime=
 during failover
> > >    pci: query command extension to check the bus master enabling st=
atus of the failover-primary device
> > >=20
> > > Sridhar Samudrala (1):
> > >    virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.
> > >=20
> > > Venu Busireddy (2):
> > >    virtio_net: Add support for "Data Path Switching" during Live Mi=
gration.
> > >    virtio_net: Add a query command for FAILOVER_STANDBY_CHANGED eve=
nt.
> > >=20
> > > ---
> > > Changes in v3:
> > >    Fix issues with coding style in patch 3/5.
> > >=20
> > > Changes in v2:
> > >    Added a query command for FAILOVER_STANDBY_CHANGED event.
> > >    Added a query command for FAILOVER_PRIMARY_CHANGED event.
> > Hmm it looks like all feedback I sent e.g. here:
> > https://patchwork.kernel.org/patch/10721571/
> > got ignored.
> >=20
> > To summarize I suggest reworking the series adding a new command alon=
g
> > the lines of (naming is up to you):
> >=20
> > query-pci-master - this returns status for a device
> > 		   and enables a *single* event after
> > 		   it changes
> >=20
> > and then removing all status data from the event,
> > just notify about the change and *only once*.
> Why removing all status data from the event?

To make sure users do not forget to call query-pci-master to
re-enable more events.

> It does not hurt to keep them
> as the FAILOVER_PRIMARY_CHANGED event in general is of pretty low-frequ=
ency.

A malicious guest can make it as frequent as it wants to.
OTOH there is no way to limit.


> As can be seen other similar low-frequent QMP events do have data carri=
ed
> over.
>=20
> As this event relates to datapath switching, there's implication to coa=
lesce
> events as packets might not get a chance to send out as nothing would e=
ver
> happen when=A0 going through quick transitions like
> disabled->enabled->disabled. I would allow at least few packets to be s=
ent
> over wire rather than nothing. Who knows how fast management can react =
and
> consume these events?
>=20
> Thanks,
> -Siwei

OK if it's so important for latency let's include data in the event.
Please add comments explaining that you must always re-run query
afterwards to make sure it's stable and re-enable more events.



> > =09
> >=20
> > upon event management does query-pci-master
> > and acts accordingly.
> >=20
> >=20
> >=20
> >=20
> > >   hmp.c                          |   5 +++
> > >   hw/acpi/pcihp.c                |  27 +++++++++++
> > >   hw/net/virtio-net.c            |  42 +++++++++++++++++
> > >   hw/pci/pci.c                   |   5 +++
> > >   hw/vfio/pci.c                  |  60 +++++++++++++++++++++++++
> > >   hw/vfio/pci.h                  |   1 +
> > >   include/hw/pci/pci.h           |   1 +
> > >   include/hw/virtio/virtio-net.h |   1 +
> > >   include/net/net.h              |   2 +
> > >   net/net.c                      |  61 +++++++++++++++++++++++++
> > >   qapi/misc.json                 |   5 ++-
> > >   qapi/net.json                  | 100 ++++++++++++++++++++++++++++=
+++++++++++++
> > >   12 files changed, 309 insertions(+), 1 deletion(-)
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >=20
