Received: from eggs.gnu.org ([209.51.188.92]:57190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gh1rU-0007e4-GK
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 19:36:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gh1rT-0001Zw-Ho
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 19:36:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1gh1rT-0001Yq-8B
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 19:36:47 -0500
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<1546900184-27403-2-git-send-email-venu.busireddy@oracle.com>
	<6f5632f5-1469-7000-9b92-ef2564a63f63@oracle.com>
	<20190108172522.GA28457@troi>
	<41b85d40-0711-a0f3-6b45-bacd20644186@oracle.com>
	<ae13f571-8359-24bb-a24f-cb5727a9623a@intel.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <17db1d06-f703-6ac6-57c7-0002eaf64a71@oracle.com>
Date: Wed, 9 Jan 2019 08:39:07 +0800
MIME-Version: 1.0
In-Reply-To: <ae13f571-8359-24bb-a24f-cb5727a9623a@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Venu Busireddy <venu.busireddy@oracle.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, si-wei.liu@oracle.com

Hi Samudrala,

On 2019/1/9 =E4=B8=8A=E5=8D=888:18, Samudrala, Sridhar wrote:
> On 1/8/2019 4:14 PM, Dongli Zhang wrote:
>> Hi Venu,
>>
>> On 2019/1/9 =E4=B8=8A=E5=8D=881:25, Venu Busireddy wrote:
>>> On 2019-01-09 00:56:38 +0800, Dongli Zhang wrote:
>>>> I am not familiar with libvirt and I would like to play with this on=
ly with qemu.
>>>>
>>>> With failover, we need to hotplug the VF on destination server to VM=
 after live
>>>> migration. However, the VF on destination server would have differen=
t mac address.
>>>>
>>>> How can we specify the mac for the new VF to hotplug via qemu, as VF=
 is only a
>>>> vfio pci device?
>>> How is the VF device on the destination host any different from the V=
F
>>> on the source host?
>>>
>>> As you do on the source host, you first assign the MAC address of
>>> 00:00:00:00:00:00 to the VF. After the migration, you assign the same
>>> MAC address as that of the virtio_net device to the VF, and hotadd th=
e VF
>> This was what I was wondering.
>>
>> How the mac address is configured for VF (or any NIC like PF) after it=
 is
>> assigned to vfio?
>=20
> ip link set <pf> vf=C2=A0 <vf-num>=C2=A0 mac <MAC>
>=20
> See https://www.kernel.org/doc/html/latest/networking/net_failover.html
> for a sample script that shows the steps to initiate live migration wit=
h VF=20
> and virtio-net in standby mode.

Thank you very much for the help!

Sorry that I did not ask the question in the right way.

Although I was talking about VF, I would like to passthrough the entire P=
F (with
sriov_numvfs=3D0) to guest VM.

In this situation, I am not able to configure the mac address when the en=
tire PF
(or NIC) is assigned to VFIO. <pf> does not exist as it is belong to VFIO.

Thank you very much!

Dongli Zhang

>=20
>=20
>> Thank you very much!
>>
>> Dongli Zhang
>>
>>
>>> device to the VM. And then, after you receive the FAILOVER_PRIMARY_CH=
ANGED
>>> event, set the macvtap device to down state.
>>>
>>> Venu
>>>
>>>> I am trying to play with this with only qemu (w/o libvirt).
>>>>
>>>> Thank you very much!
>>>>
>>>> Dongli Zhang
>>>>
>>>> On 01/08/2019 06:29 AM, Venu Busireddy wrote:
>>>>> From: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>>>
>>>>> This feature bit can be used by a hypervisor to indicate to the vir=
tio_net
>>>>> device that it can act as a standby for another device with the sam=
e MAC
>>>>> address.
>>>>>
>>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>>> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
>>>>> ---
>>>>>  hw/net/virtio-net.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>>> index 385b1a0..411f8fb 100644
>>>>> --- a/hw/net/virtio-net.c
>>>>> +++ b/hw/net/virtio-net.c
>>>>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] =3D {
>>>>>                       true),
>>>>>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UN=
KNOWN),
>>>>>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>>>>> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_=
NET_F_STANDBY,
>>>>> +                      false),
>>>>>      DEFINE_PROP_END_OF_LIST(),
>>>>>  };
>>>>> =20
>>>>>
