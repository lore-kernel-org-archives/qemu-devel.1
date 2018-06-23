Received: from eggs.gnu.org ([2001:4830:134:3::10]:35429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fWW3A-0004o9-5W
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 20:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fWW38-0003V1-Oc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 20:05:08 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:40126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fWW38-0003Uv-H4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 20:05:06 -0400
Received: by mail-it0-x244.google.com with SMTP id 188-v6so5131809ita.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 17:05:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180623012934-mutt-send-email-mst@kernel.org>
References: <20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
	<20180621211712-mutt-send-email-mst@kernel.org>
	<20180622170955.298900c1.cohuck@redhat.com>
	<20180622214259-mutt-send-email-mst@kernel.org>
	<CADGSJ22e=Sa8S-HqM4XtOa6ngBKPL73SiQRPh8PUzQgRaie5oA@mail.gmail.com>
	<20180623003022-mutt-send-email-mst@kernel.org>
	<CADGSJ22oFhP955cuTmMWeSt0UOsG5K1A--c34QUSMx5z3Up2SA@mail.gmail.com>
	<20180623012934-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Fri, 22 Jun 2018 17:05:04 -0700
Message-ID: <CADGSJ21HNd4VYNcCt4H0gJ_CCx1GUFpHrDof2N=4WqhD24Zc2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Fri, Jun 22, 2018 at 3:33 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Jun 22, 2018 at 02:57:39PM -0700, Siwei Liu wrote:
>> On Fri, Jun 22, 2018 at 2:32 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Fri, Jun 22, 2018 at 01:21:45PM -0700, Siwei Liu wrote:
>> >> On Fri, Jun 22, 2018 at 12:05 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > On Fri, Jun 22, 2018 at 05:09:55PM +0200, Cornelia Huck wrote:
>> >> >> On Thu, 21 Jun 2018 21:20:13 +0300
>> >> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> >>
>> >> >> > On Thu, Jun 21, 2018 at 04:59:13PM +0200, Cornelia Huck wrote:
>> >> >> > > OK, so what about the following:
>> >> >> > >
>> >> >> > > - introduce a new feature bit, VIRTIO_NET_F_STANDBY_UUID that indicates
>> >> >> > >   that we have a new uuid field in the virtio-net config space
>> >> >> > > - in QEMU, add a property for virtio-net that allows to specify a uuid,
>> >> >> > >   offer VIRTIO_NET_F_STANDBY_UUID if set
>> >> >> > > - when configuring, set the property to the group UUID of the vfio-pci
>> >> >> > >   device
>> >> >> > > - in the guest, use the uuid from the virtio-net device's config space
>> >> >> > >   if applicable; else, fall back to matching by MAC as done today
>> >> >> > >
>> >> >> > > That should work for all virtio transports.
>> >> >> >
>> >> >> > True. I'm a bit unhappy that it's virtio net specific though
>> >> >> > since down the road I expect we'll have a very similar feature
>> >> >> > for scsi (and maybe others).
>> >> >> >
>> >> >> > But we do not have a way to have fields that are portable
>> >> >> > both across devices and transports, and I think it would
>> >> >> > be a useful addition. How would this work though? Any idea?
>> >> >>
>> >> >> Can we introduce some kind of device-independent config space area?
>> >> >> Pushing back the device-specific config space by a certain value if the
>> >> >> appropriate feature is negotiated and use that for things like the uuid?
>> >> >
>> >> > So config moves back and forth?
>> >> > Reminds me of the msi vector mess we had with pci.
>> >> > I'd rather have every transport add a new config.
>> >> >
>> >> >> But regardless of that, I'm not sure whether extending this approach to
>> >> >> other device types is the way to go. Tying together two different
>> >> >> devices is creating complicated situations at least in the hypervisor
>> >> >> (even if it's fairly straightforward in the guest). [I have not come
>> >> >> around again to look at the "how to handle visibility in QEMU"
>> >> >> questions due to lack of cycles, sorry about that.]
>> >> >>
>> >> >> So, what's the goal of this approach? Only to allow migration with
>> >> >> vfio-pci, or also to plug in a faster device and use it instead of an
>> >> >> already attached paravirtualized device?
>> >> >
>> >> > These are two sides of the same coin, I think the second approach
>> >> > is closer to what we are doing here.
>> >>
>> >> I'm leaning towards being conservative to keep the potential of doing
>> >> both. It's the vfio migration itself that has to be addessed, not to
>> >> make every virtio device to have an accelerated datapath, right?
>> >>
>> >> -Siwei
>> >
>> > I think that the approach we took (signal configuration
>> > through standby) assumes standby always present and
>> > primary appearing and disappearing.
>>
>> I can imagine that's still true even for 1-netdev model. As long as we
>> can hide the lower devices.
>>
>> That's what I said "to keep the potential to support both" models. But
>> we should not go further along to assume the other aspect ie. to get
>> PV accelerated whenever possible, but not to get VF migrated whenever
>> possible. That's essetially a big diveregence of the priority for the
>> goal we'd want to pursue.
>>
>> -Siwei
>
> I suspect the diveregence will be lost on most users though
> simply because they don't even care about vfio. They just
> want things to go fast.

Like Jason said, VF isn't faster than virtio-net in all cases. It
depends on the workload and performance metrics: throughput, latency,
or packet per second.

>
> Rephrasing requirements in terms of acceleration actually
> made things implementable. So I'm not in a hurry to try
> and go back to asking for a migrateable vfio - very
> easy to get stuck there.

Understood. When we get all ethtool_ops exposed on the failover
interface, we'll get back to attack migrateable vfio with the 1-netdev
model.

-Siwei


>
>> >
>> > Anything else isn't well supported and I'm not sure we
>> > should complicate code too much to support it.
>> >
>> >>
>> >> >
>> >> >> What about migration of vfio devices that are not easily replaced by a
>> >> >> paravirtualized device? I'm thinking of vfio-ccw, where our main (and
>> >> >> currently only) supported device is dasd (disks) -- which can do a lot
>> >> >> of specialized things that virtio-blk does not support (and should not
>> >> >> or even cannot support).
>> >> >
>> >> > But maybe virtio-scsi can?
>> >> >
>> >> >> Would it be more helpful to focus on generic
>> >> >> migration support for vfio instead of going about it device by device?
>> >> >>
>> >> >> This network device approach already seems far along, so it makes sense
>> >> >> to continue with it. But I'm not sure whether we want to spend time and
>> >> >> energy on that for other device types rather than working on a general
>> >> >> solution for vfio migration.
>> >> >
>> >> > I'm inclined to say finalizing this feature would be a good first step
>> >> > and will teach us how we can move forward.
>> >> >
>> >> > --
>> >> > MST
