Received: from eggs.gnu.org ([2001:4830:134:3::10]:57879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQ1N8-0002m8-SQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 22:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQ1N5-0008Vh-N8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 22:06:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQ1N5-0008VX-I4
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 22:06:51 -0400
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d61c88c7-0803-ba1c-08ab-fc668cffa40b@redhat.com>
Date: Tue, 5 Jun 2018 10:06:41 +0800
MIME-Version: 1.0
In-Reply-To: <fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
 feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, qemu-devel@nongnu.org



On 2018=E5=B9=B406=E6=9C=8805=E6=97=A5 09:41, Samudrala, Sridhar wrote:
> Ping on this patch now that the kernel patches are accepted into=20
> davem's net-next tree.
> https://patchwork.ozlabs.org/cover/920005/
>
>
> On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
>> This feature bit can be used by hypervisor to indicate virtio_net=20
>> device to
>> act as a standby for another device with the same MAC address.
>>
>> I tested this with a small change to the patch to mark the STANDBY=20
>> feature 'true'
>> by default as i am using libvirt to start the VMs.
>> Is there a way to pass the newly added feature bit 'standby' to qemu=20
>> via libvirt
>> XML file?
>>

Maybe you can try qemu command line passthrough:

https://libvirt.org/drvqemu.html#qemucommand

The patch looks good to me. Let's see if Michael have any comment.

Thanks

>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>> =C2=A0 hw/net/virtio-net.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>> =C2=A0 include/standard-headers/linux/virtio_net.h | 3 +++
>> =C2=A0 2 files changed, 5 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 90502fca7c..38b3140670 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_INT32("speed", VirtIONet, n=
et_conf.speed,=20
>> SPEED_UNKNOWN),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_STRING("duplex", VirtIONet,=
 net_conf.duplex_str),
>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BIT64("standby", VirtIONet, host_featu=
res,=20
>> VIRTIO_NET_F_STANDBY,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),
>> =C2=A0 };
>> =C2=A0 diff --git a/include/standard-headers/linux/virtio_net.h=20
>> b/include/standard-headers/linux/virtio_net.h
>> index e9f255ea3f..01ec09684c 100644
>> --- a/include/standard-headers/linux/virtio_net.h
>> +++ b/include/standard-headers/linux/virtio_net.h
>> @@ -57,6 +57,9 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Steering *=
/
>> =C2=A0 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23=C2=A0=C2=A0=C2=A0 /* Set =
MAC address */
>> =C2=A0 +#define VIRTIO_NET_F_STANDBY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 62=C2=
=A0=C2=A0=C2=A0 /* Act as standby for=20
>> another device
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * with the same MAC.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0 #define VIRTIO_NET_F_SPEED_DUPLEX 63=C2=A0=C2=A0=C2=A0 /* Devic=
e set linkspeed and=20
>> duplex */
>> =C2=A0 =C2=A0 #ifndef VIRTIO_NET_NO_LEGACY
>
