Received: from eggs.gnu.org ([209.51.188.92]:60985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1ghqlD-0008EX-7U
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <si-wei.liu@oracle.com>) id 1ghql9-0003Aq-Hz
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:57:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <si-wei.liu@oracle.com>)
	id 1ghql7-00036W-0w
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:57:37 -0500
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<20190107182604-mutt-send-email-mst@kernel.org>
	<7f230258-0950-9155-ec9c-6c6102ed2c2b@oracle.com>
	<20190107212122-mutt-send-email-mst@kernel.org>
	<96c1a360-3c21-a4ed-83ea-f094eeaf3b7c@oracle.com>
	<20190109083137-mutt-send-email-mst@kernel.org>
From: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <0b89ff8d-c1d0-6a37-21c6-58bed6d2f5ae@oracle.com>
Date: Thu, 10 Jan 2019 22:57:28 -0800
MIME-Version: 1.0
In-Reply-To: <20190109083137-mutt-send-email-mst@kernel.org>
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



On 01/09/2019 05:39 AM, Michael S. Tsirkin wrote:
> On Tue, Jan 08, 2019 at 08:55:35PM -0800, si-wei liu wrote:
>>
>> On 1/7/2019 6:25 PM, Michael S. Tsirkin wrote:
>>
>>      On Mon, Jan 07, 2019 at 05:45:22PM -0800, si-wei liu wrote:
>>
>>          On 01/07/2019 03:32 PM, Michael S. Tsirkin wrote:
>>
>>              On Mon, Jan 07, 2019 at 05:29:39PM -0500, Venu Busireddy =
wrote:
>>
>>                  Implement the infrastructure to support datapath swit=
ching during live
>>                  migration involving SR-IOV devices.
>>
>>                  1. This patch is based off on the current VIRTIO_NET_=
F_STANDBY feature
>>                      bit and MAC address device pairing.
>>
>>                  2. This set of events will be consumed by userspace m=
anagement software
>>                      to orchestrate all the hot plug and datapath swit=
ching activities.
>>                      This scheme has the least QEMU modifications whil=
e allowing userspace
>>                      software to build its own intelligence to control=
 the whole process
>>                      of SR-IOV live migration.
>>
>>                  3. While the hidden device model (viz. coupled device=
 model) is still
>>                      being explored for automatic hot plugging (QEMU) =
and automatic datapath
>>                      switching (host-kernel), this series provides a s=
upplemental set
>>                      of interfaces if management software wants to dri=
ve the SR-IOV live
>>                      migration on its own. It should not conflict with=
 the hidden device
>>                      model but just offers simplicity of implementatio=
n.
>> And if guest*does*  need the switch because e.g. attaching xdp wants t=
o
>> resent the card?
>>
>>
>>
>>                  Si-Wei Liu (2):
>>                     vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to sh=
orten downtime during failover
>>                     pci: query command extension to check the bus mast=
er enabling status of the failover-primary device
>>
>>                  Sridhar Samudrala (1):
>>                     virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.
>>
>>                  Venu Busireddy (2):
>>                     virtio_net: Add support for "Data Path Switching" =
during Live Migration.
>>                     virtio_net: Add a query command for FAILOVER_STAND=
BY_CHANGED event.
>>
>>                  ---
>>                  Changes in v3:
>>                     Fix issues with coding style in patch 3/5.
>>
>>                  Changes in v2:
>>                     Added a query command for FAILOVER_STANDBY_CHANGED=
 event.
>>                     Added a query command for FAILOVER_PRIMARY_CHANGED=
 event.
>>
>>              Hmm it looks like all feedback I sent e.g. here:
>>              https://patchwork.kernel.org/patch/10721571/
>>              got ignored.
>>
>>              To summarize I suggest reworking the series adding a new =
command along
>>              the lines of (naming is up to you):
>>
>>              query-pci-master - this returns status for a device
>>                                 and enables a *single* event after
>>                                 it changes
>>
>>              and then removing all status data from the event,
>>              just notify about the change and *only once*.
>>
>>          Why removing all status data from the event?
>>
>>      To make sure users do not forget to call query-pci-master to
>>      re-enable more events.
>>
>> IMO the FAILOVER_PRIMARY_CHANGED event is on the performance path, it'=
s an
>> overkill to enforce round trip query for each event in normal situatio=
ns.
>>
>>          It does not hurt to keep them
>>          as the FAILOVER_PRIMARY_CHANGED event in general is of pretty=
 low-frequency.
>>
>>      A malicious guest can make it as frequent as it wants to.
>>      OTOH there is no way to limit.
>>
>> Will throttle the event rate (say, limiting to no more than 1 event pe=
r second)
> And if guest *does* need the switch because e.g. attaching xdp wants to
> resent the card?
Device reset during attaching XDP prog doesn't end up with PCI master=20
status reset as far as I see. Even so (say with FLR or slot reset), the=20
ending state would be reflected (without having to do a query) if=20
state's going through quick transitions. And, suppressing event emission=20
until next query seems to make management stack perform worse in this=20
case? Management stack end up having to query commands for couple of=20
times to see if status is settled.

>
>> a way to limit (as opposed to control guest behavior) ? The other simi=
lar
>> events that apply rate limiting don't suppress event emission until th=
e next
>> query at all.
> We have some problematic interfaces already, that's true.
>
>> Doing so would just cause more events missing. As stated in the
>> earlier example, we should give guest NIC a chance to flush queued pac=
kets even
>> if ending state is same between two events.
> I haven't seen that requirement. I guess a reset just stops processing
> buffers rather than flush. Care to repeat?
If for some reason a VF driver runs into some hardware/firmware fault=20
and keeps resetting just attempts to fix itself, wouldn't it be=20
necessary for failover to use the PV path temporarily? Without proper=20
interleaving all packets can be dropped in the worst case. Severe packet=20
drops deteriorate network performance quite badly, and may even lead to=20
fatal errors if storage device is being hosted over the network (e.g.=20
iSCSI) in particular.

>
>>          As can be seen other similar low-frequent QMP events do have =
data carried
>>          over.
>>
>>          As this event relates to datapath switching, there's implicat=
ion to coalesce
>>          events as packets might not get a chance to send out as nothi=
ng would ever
>>          happen when=C2=A0 going through quick transitions like
>>          disabled->enabled->disabled. I would allow at least few packe=
ts to be sent
>>          over wire rather than nothing. Who knows how fast management =
can react and
>>          consume these events?
>>
>>          Thanks,
>>          -Siwei
>>
>>      OK if it's so important for latency let's include data in the eve=
nt.
>>      Please add comments explaining that you must always re-run query
>>      afterwards to make sure it's stable and re-enable more events.
>>
>> I can add comments describing why we need to carry data in the event, =
and apply
>> rate limiting to events. But I don't follow why it must suppress event=
 until
>> next query.
> Rate limiting is fundamentally broken.
What is the issue with rate limiting? Seems pretty good fit to me, as=20
otherwise mgmt stack still need to check the status periodically with=20
some slow rate if experiencing malicious attack.
> Try a stress of resets and there goes your promise of low downtime.
Is this a normal user would do? I guess only malicious guest may do so.=20
With this in mind, what's more important is to defend the attack by=20
imposing rate limiter, and downtime is not even a factor to consider in=20
this context. The point is that I view rate limiting as a way to defend=20
malicious attack, and it's a good trade-off as reset itself doesn't=20
happen very often in normal situations. And we can always find a proper=20
rate that could balance both needs well.

BTW, there's no way to promise latency/downtime either way - all is=20
based on best effort with the current datapatch switching scheme that=20
involves userspace management stack. IMHO ideally the only way with some=20
latency/downtime guarantee is to have guest to kick off datapath=20
switching through a control queue message, which would cause guest to=20
exit and host kernel would then take the turn to handle the MAC filter=20
movement in a synchronized context. Or we should wait Intel to fix their=20
legacy drivers.

>
> Let me try to re-state: state query is fundamentally required
> because otherwise e.g. management restarts do not work.
Yes, we've added the query command for such purpose (handle management=20
restarts). There's no argue about this.

> And it is much better to force management to run query every event
> and every restart than just hope it handles racy corner cases correctly.
There's no way to handle those racy corner cases with what you=20
suggested, I see missing packets when switching promiscuous mode on=20
virtio-net, and I see no chance it can be improved with the current schem=
e.

>
> If we do include data in the event then there is no real latency cost t=
o
> that, since management can take action in response to the event then do
> the query asynchronously at leasure.
> So let me turn it around and say I don't follow why you have objections
> to blocking following events until query.
See my explanations above.

thanks,
-Siwei
>
>
>> Thanks,
>> -Siwei
>>
>>
>>
>>
>>
>>
>>
>>              upon event management does query-pci-master
>>              and acts accordingly.
>>
>>
>>
>>
>>
>>                    hmp.c                          |   5 +++
>>                    hw/acpi/pcihp.c                |  27 +++++++++++
>>                    hw/net/virtio-net.c            |  42 ++++++++++++++=
+++
>>                    hw/pci/pci.c                   |   5 +++
>>                    hw/vfio/pci.c                  |  60 ++++++++++++++=
+++++++++++
>>                    hw/vfio/pci.h                  |   1 +
>>                    include/hw/pci/pci.h           |   1 +
>>                    include/hw/virtio/virtio-net.h |   1 +
>>                    include/net/net.h              |   2 +
>>                    net/net.c                      |  61 ++++++++++++++=
+++++++++++
>>                    qapi/misc.json                 |   5 ++-
>>                    qapi/net.json                  | 100 ++++++++++++++=
+++++++++++++++++++++++++++
>>                    12 files changed, 309 insertions(+), 1 deletion(-)
>>
>>              ---------------------------------------------------------=
------------
>>              To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasi=
s-open.org
>>              For additional commands, e-mail: virtio-dev-help@lists.oa=
sis-open.org
>>
>>
>>      -----------------------------------------------------------------=
----
>>      To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.o=
rg
>>      For additional commands, e-mail: virtio-dev-help@lists.oasis-open=
.org
>>
>>
>>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
