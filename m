Received: from eggs.gnu.org ([2001:4830:134:3::10]:42874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1faUlG-0004QO-Sa
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 19:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1faUlF-0005OB-Io
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 19:31:06 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1faUlF-0005Nz-De
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 19:31:05 -0400
Received: by mail-it0-x243.google.com with SMTP id y124-v6so5077791itc.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:31:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703165200.180c93bb.cohuck@redhat.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<20180703142817.GA3088@vbusired-vm>
	<20180703165200.180c93bb.cohuck@redhat.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Tue, 3 Jul 2018 16:31:03 -0700
Message-ID: <CADGSJ23+sZiMCx=n=DytZ=TT2z7i0sMhrmnPuFYtuZhSc=qA+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>, si-wei liu <si-wei.liu@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Tue, Jul 3, 2018 at 7:52 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, 3 Jul 2018 09:28:17 -0500
> Venu Busireddy <venu.busireddy@oracle.com> wrote:
>
>> On 2018-07-03 12:58:25 +0300, Roman Kagan wrote:
>> > On Mon, Jul 02, 2018 at 02:14:52PM -0700, si-wei liu wrote:
>> > > On 7/2/2018 9:14 AM, Roman Kagan wrote:
>> > > > Is the scheme going to be applied/extended to other transports (vmbus,
>> > > > virtio-ccw, etc.)?
>> > > Well, it depends on the use case, and how feasible it can be extended to
>> > > other transport due to constraints and transport specifics.
>> > >
>> > > > Is the failover group concept going to be used beyond PT-PV network
>> > > > device failover?
>> > > Although the concept of failover group is generic, the implementation itself
>> > > may vary.
>> >
>> > My point with these two questions is that since this patchset is
>> > defining external interfaces -- with guest OS, with management layer --
>>
>> This patch set is not defining any external interfaces. All this is doing
>> is provide the means and locations to store the "group identifier". How
>> that info will be used, I thought, should be another patch set.
>>
>> Venu
>>
>> > which are not easy to change later, it might make sense to try and see
>> > if the interfaces map to other usecases.  E.g. I think we can get enough
>> > information on how Hyper-V handles PT-PV network device failover from
>> > the current Linux implementation; it may be a good idea to share some
>> > concepts and workflows with virtio-pci.
>
> But this patch set defines a host<->guest interface to make pairing
> information on the host available to the guest, no?
>
> From my point of view, there are several concerns:
> - This approach assumes a homogeneous pairing (same transport), and
>   even more, it assumes that this transport is pci.

Not really.

There could be some other place to define a generic (transport
independent) virtio feature, whereas the data (group ID) can be stored
in transport specific way. That generic virtio feature and the way to
specify target transport to group with is yet to be defined. I don't
see this patch is in conflict with that direction.


> - It won't work for zPCI (although zPCI is really strange) -- this
>   means it will be completely unusable on s390x.
I still need more information about this use case. First off, does
zPCI support all the hot plug semantics or functionality the same way
as PCI? Or there has to be some platform or firmeware support like
ACPI hotplug? Does QEMU have all the pieces ready for s390 zPCI
hotplug?

Does the s390x use case in your mind concerns with VFIO migraition, or
replacement of a PT device with backup virtio-ccw path? Or something
else?

As the assumption of SR-IOV migration is that, hotplug is used as an
inidicator for datapath switch - which maps to moving MAC address or
VLAN filter around between PV and VF. I am not sure how that maps to
s390x and zPCI with regard to host coordination.

-Siwei

> - It is too focused on a narrow use case. How is it supposed to be
>   extended?
>
> What I would prefer:
> - Implement a pairing id support that does not rely on a certain
>   transport, but leverages virtio (which is in the game anyway). We'd
>   get at least the "virtio-net device paired with vfio" use case, which
>   is what is currently implemented in the Linux kernel.
> - Think about a more generic way to relay configuration metadata to the
>   host.
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
