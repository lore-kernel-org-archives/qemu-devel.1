Received: from eggs.gnu.org ([209.51.188.92]:39883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gh5JG-00089K-Nv
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gh5JF-0007ca-MN
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:17:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gh5JF-0007Zk-Dk
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:17:41 -0500
Date: Tue, 8 Jan 2019 23:17:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190108231551-mutt-send-email-mst@kernel.org>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<1546900184-27403-2-git-send-email-venu.busireddy@oracle.com>
	<6f5632f5-1469-7000-9b92-ef2564a63f63@oracle.com>
	<20190108172522.GA28457@troi>
	<41b85d40-0711-a0f3-6b45-bacd20644186@oracle.com>
	<ae13f571-8359-24bb-a24f-cb5727a9623a@intel.com>
	<17db1d06-f703-6ac6-57c7-0002eaf64a71@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17db1d06-f703-6ac6-57c7-0002eaf64a71@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] virtio_net: Add
 VIRTIO_NET_F_STANDBY feature bit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Venu Busireddy <venu.busireddy@oracle.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, si-wei.liu@oracle.com

On Wed, Jan 09, 2019 at 08:39:07AM +0800, Dongli Zhang wrote:
> Hi Samudrala,
>=20
> On 2019/1/9 =E4=B8=8A=E5=8D=888:18, Samudrala, Sridhar wrote:
> > On 1/8/2019 4:14 PM, Dongli Zhang wrote:
> >> Hi Venu,
> >>
> >> On 2019/1/9 =E4=B8=8A=E5=8D=881:25, Venu Busireddy wrote:
> >>> On 2019-01-09 00:56:38 +0800, Dongli Zhang wrote:
> >>>> I am not familiar with libvirt and I would like to play with this =
only with qemu.
> >>>>
> >>>> With failover, we need to hotplug the VF on destination server to =
VM after live
> >>>> migration. However, the VF on destination server would have differ=
ent mac address.
> >>>>
> >>>> How can we specify the mac for the new VF to hotplug via qemu, as =
VF is only a
> >>>> vfio pci device?
> >>> How is the VF device on the destination host any different from the=
 VF
> >>> on the source host?
> >>>
> >>> As you do on the source host, you first assign the MAC address of
> >>> 00:00:00:00:00:00 to the VF. After the migration, you assign the sa=
me
> >>> MAC address as that of the virtio_net device to the VF, and hotadd =
the VF
> >> This was what I was wondering.
> >>
> >> How the mac address is configured for VF (or any NIC like PF) after =
it is
> >> assigned to vfio?
> >=20
> > ip link set <pf> vf=C2=A0 <vf-num>=C2=A0 mac <MAC>
> >=20
> > See https://www.kernel.org/doc/html/latest/networking/net_failover.ht=
ml
> > for a sample script that shows the steps to initiate live migration w=
ith VF=20
> > and virtio-net in standby mode.
>=20
> Thank you very much for the help!
>=20
> Sorry that I did not ask the question in the right way.
>=20
> Although I was talking about VF, I would like to passthrough the entire=
 PF (with
> sriov_numvfs=3D0) to guest VM.
>=20
> In this situation, I am not able to configure the mac address when the =
entire PF
> (or NIC) is assigned to VFIO. <pf> does not exist as it is belong to VF=
IO.
>=20
> Thank you very much!
>=20
> Dongli Zhang

I think that this mode isn't a good fit for the current (MAC address
based) failover. There was talk about supporting other ways to match
devices for failover, but no one implemented driver changes required
for this yet.


> >=20
> >=20
> >> Thank you very much!
> >>
> >> Dongli Zhang
> >>
> >>
> >>> device to the VM. And then, after you receive the FAILOVER_PRIMARY_=
CHANGED
> >>> event, set the macvtap device to down state.
> >>>
> >>> Venu
> >>>
> >>>> I am trying to play with this with only qemu (w/o libvirt).
> >>>>
> >>>> Thank you very much!
> >>>>
> >>>> Dongli Zhang
> >>>>
> >>>> On 01/08/2019 06:29 AM, Venu Busireddy wrote:
> >>>>> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >>>>>
> >>>>> This feature bit can be used by a hypervisor to indicate to the v=
irtio_net
> >>>>> device that it can act as a standby for another device with the s=
ame MAC
> >>>>> address.
> >>>>>
> >>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >>>>> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> >>>>> ---
> >>>>>  hw/net/virtio-net.c | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>>>> index 385b1a0..411f8fb 100644
> >>>>> --- a/hw/net/virtio-net.c
> >>>>> +++ b/hw/net/virtio-net.c
> >>>>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] =3D=
 {
> >>>>>                       true),
> >>>>>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_=
UNKNOWN),
> >>>>>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str)=
,
> >>>>> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTI=
O_NET_F_STANDBY,
> >>>>> +                      false),
> >>>>>      DEFINE_PROP_END_OF_LIST(),
> >>>>>  };
> >>>>> =20
> >>>>>
