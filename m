Received: from eggs.gnu.org ([209.51.188.92]:45861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1gh5u8-0007X4-UQ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1gh5u7-0006IZ-1t
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:55:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <si-wei.liu@oracle.com>)
	id 1gh5u3-0006Ez-5G
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 23:55:45 -0500
From: si-wei liu <si-wei.liu@oracle.com>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<20190107182604-mutt-send-email-mst@kernel.org>
	<7f230258-0950-9155-ec9c-6c6102ed2c2b@oracle.com>
	<20190107212122-mutt-send-email-mst@kernel.org>
Message-ID: <96c1a360-3c21-a4ed-83ea-f094eeaf3b7c@oracle.com>
Date: Tue, 8 Jan 2019 20:55:35 -0800
MIME-Version: 1.0
In-Reply-To: <20190107212122-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Liran Alon <liran.alon@oracle.com>



On 1/7/2019 6:25 PM, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 05:45:22PM -0800, si-wei liu wrote:
>> On 01/07/2019 03:32 PM, Michael S. Tsirkin wrote:
>>> On Mon, Jan 07, 2019 at 05:29:39PM -0500, Venu Busireddy wrote:
>>>> Implement the infrastructure to support datapath switching during li=
ve
>>>> migration involving SR-IOV devices.
>>>>
>>>> 1. This patch is based off on the current VIRTIO_NET_F_STANDBY featu=
re
>>>>      bit and MAC address device pairing.
>>>>
>>>> 2. This set of events will be consumed by userspace management softw=
are
>>>>      to orchestrate all the hot plug and datapath switching activiti=
es.
>>>>      This scheme has the least QEMU modifications while allowing use=
rspace
>>>>      software to build its own intelligence to control the whole pro=
cess
>>>>      of SR-IOV live migration.
>>>>
>>>> 3. While the hidden device model (viz. coupled device model) is stil=
l
>>>>      being explored for automatic hot plugging (QEMU) and automatic =
datapath
>>>>      switching (host-kernel), this series provides a supplemental se=
t
>>>>      of interfaces if management software wants to drive the SR-IOV =
live
>>>>      migration on its own. It should not conflict with the hidden de=
vice
>>>>      model but just offers simplicity of implementation.
>>>>
>>>>
>>>> Si-Wei Liu (2):
>>>>     vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorten downtime=
 during failover
>>>>     pci: query command extension to check the bus master enabling st=
atus of the failover-primary device
>>>>
>>>> Sridhar Samudrala (1):
>>>>     virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.
>>>>
>>>> Venu Busireddy (2):
>>>>     virtio_net: Add support for "Data Path Switching" during Live Mi=
gration.
>>>>     virtio_net: Add a query command for FAILOVER_STANDBY_CHANGED eve=
nt.
>>>>
>>>> ---
>>>> Changes in v3:
>>>>     Fix issues with coding style in patch 3/5.
>>>>
>>>> Changes in v2:
>>>>     Added a query command for FAILOVER_STANDBY_CHANGED event.
>>>>     Added a query command for FAILOVER_PRIMARY_CHANGED event.
>>> Hmm it looks like all feedback I sent e.g. here:
>>> https://patchwork.kernel.org/patch/10721571/
>>> got ignored.
>>>
>>> To summarize I suggest reworking the series adding a new command alon=
g
>>> the lines of (naming is up to you):
>>>
>>> query-pci-master - this returns status for a device
>>> 		   and enables a *single* event after
>>> 		   it changes
>>>
>>> and then removing all status data from the event,
>>> just notify about the change and *only once*.
>> Why removing all status data from the event?
> To make sure users do not forget to call query-pci-master to
> re-enable more events.
IMO the FAILOVER_PRIMARY_CHANGED event is on the performance path, it's=20
an overkill to enforce round trip query for each event in normal situatio=
ns.
>> It does not hurt to keep them
>> as the FAILOVER_PRIMARY_CHANGED event in general is of pretty low-freq=
uency.
> A malicious guest can make it as frequent as it wants to.
> OTOH there is no way to limit.
Will throttle the event rate (say, limiting to no more than 1 event per=20
second) a way to limit (as opposed to control guest behavior) ? The=20
other similar events that apply rate limiting don't suppress event=20
emission until the next query at all. Doing so would just cause more=20
events missing. As stated in the earlier example, we should give guest=20
NIC a chance to flush queued packets even if ending state is same=20
between two events.

>> As can be seen other similar low-frequent QMP events do have data carr=
ied
>> over.
>>
>> As this event relates to datapath switching, there's implication to co=
alesce
>> events as packets might not get a chance to send out as nothing would =
ever
>> happen when=C2=A0 going through quick transitions like
>> disabled->enabled->disabled. I would allow at least few packets to be =
sent
>> over wire rather than nothing. Who knows how fast management can react=
 and
>> consume these events?
>>
>> Thanks,
>> -Siwei
> OK if it's so important for latency let's include data in the event.
> Please add comments explaining that you must always re-run query
> afterwards to make sure it's stable and re-enable more events.
I can add comments describing why we need to carry data in the event,=20
and apply rate limiting to events. But I don't follow why it must=20
suppress event until next query.


Thanks,
-Siwei

>
>
>>> =09
>>>
>>> upon event management does query-pci-master
>>> and acts accordingly.
>>>
>>>
>>>
>>>
>>>>    hmp.c                          |   5 +++
>>>>    hw/acpi/pcihp.c                |  27 +++++++++++
>>>>    hw/net/virtio-net.c            |  42 +++++++++++++++++
>>>>    hw/pci/pci.c                   |   5 +++
>>>>    hw/vfio/pci.c                  |  60 +++++++++++++++++++++++++
>>>>    hw/vfio/pci.h                  |   1 +
>>>>    include/hw/pci/pci.h           |   1 +
>>>>    include/hw/virtio/virtio-net.h |   1 +
>>>>    include/net/net.h              |   2 +
>>>>    net/net.c                      |  61 +++++++++++++++++++++++++
>>>>    qapi/misc.json                 |   5 ++-
>>>>    qapi/net.json                  | 100 ++++++++++++++++++++++++++++=
+++++++++++++
>>>>    12 files changed, 309 insertions(+), 1 deletion(-)
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail:virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail:virtio-dev-help@lists.oasis-open.org
>>>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail:virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail:virtio-dev-help@lists.oasis-open.org
>
