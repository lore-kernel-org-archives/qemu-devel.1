Received: from eggs.gnu.org ([209.51.188.92]:45576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3RPJ-0003Iq-U2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h3ROQ-00026v-AW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h3ROP-00022u-8J
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:19:26 -0400
Date: Mon, 11 Mar 2019 14:19:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190311141919.0c675efc@x1.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C983C63@SHSMSX104.ccr.corp.intel.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<20190221134051.2c28893e@w520.home>
	<20190225022255.GP16456@joy-OptiPlex-7040>
	<20190307104421.534ea56f@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C97CA6B@SHSMSX104.ccr.corp.intel.com>
	<20190308091133.3073f5db@x1.home> <20190308162146.GD2834@work-vm>
	<20190308150254.3d1af7d8@x1.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C983C63@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] QEMU VFIO live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Liu, Changpeng" <changpeng.liu@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "Wang,
	Zhi A" <zhi.a.wang@intel.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>

On Mon, 11 Mar 2019 02:33:11 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson
> > Sent: Saturday, March 9, 2019 6:03 AM
> > 
> > On Fri, 8 Mar 2019 16:21:46 +0000
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >   
> > > * Alex Williamson (alex.williamson@redhat.com) wrote:  
> > > > On Thu, 7 Mar 2019 23:20:36 +0000
> > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > >  
> > > > > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > > > > Sent: Friday, March 8, 2019 1:44 AM  
> > > > > > > >  
> > > > > > > > >         This kind of data needs to be saved / loaded in pre-copy and
> > > > > > > > >         stop-and-copy phase.
> > > > > > > > >         The data of device memory is held in device memory region.
> > > > > > > > >         Size of devie memory is usually larger than that of device
> > > > > > > > >         memory region. qemu needs to save/load it in chunks of size  
> > of  
> > > > > > > > >         device memory region.
> > > > > > > > >         Not all device has device memory. Like IGD only uses system  
> > > > > > memory.  
> > > > > > > >
> > > > > > > > It seems a little gratuitous to me that this is a separate region or
> > > > > > > > that this data is handled separately.  All of this data is opaque to
> > > > > > > > QEMU, so why do we need to separate it?  
> > > > > > > hi Alex,
> > > > > > > as the device state interfaces are provided by kernel, it is expected to
> > > > > > > meet as general needs as possible. So, do you think there are such  
> > use  
> > > > > > > cases from user space that user space knows well of the device, and
> > > > > > > it wants kernel to return desired data back to it.
> > > > > > > E.g. It just wants to get whole device config data including all mmios,
> > > > > > > page tables, pci config data...
> > > > > > > or, It just wants to get current device memory snapshot, not  
> > including any  
> > > > > > > dirty data.
> > > > > > > Or, It just needs the dirty pages in device memory or system memory.
> > > > > > > With all this accurate query, quite a lot of useful features can be
> > > > > > > developped in user space.
> > > > > > >
> > > > > > > If all of this data is opaque to user app, seems the only use case is
> > > > > > > for live migration.  
> > > > > >
> > > > > > I can certainly appreciate a more versatile interface, but I think
> > > > > > we're also trying to create the most simple interface we can, with the
> > > > > > primary target being live migration.  As soon as we start defining this
> > > > > > type of device memory and that type of device memory, we're going to
> > > > > > have another device come along that needs yet another because they  
> > have  
> > > > > > a slightly different requirement.  Even without that, we're going to
> > > > > > have vendor drivers implement it differently, so what works for one
> > > > > > device for a more targeted approach may not work for all devices.  Can
> > > > > > you enumerate some specific examples of the use cases you imagine  
> > your  
> > > > > > design to enable?
> > > > > >  
> > > > >
> > > > > Do we want to consider an use case where user space would like to
> > > > > selectively introspect a portion of the device state (including implicit
> > > > > state which are not available through PCI regions), and may ask for
> > > > > capability of direct mapping of selected portion for scanning (e.g.
> > > > > device memory) instead of always turning on dirty logging on all
> > > > > device state?  
> > > >
> > > > I don't see that a migration interface necessarily lends itself to this
> > > > use case.  A migration data stream has no requirement to be user
> > > > consumable as anything other than opaque data, there's also no
> > > > requirement that it expose state in a form that directly represents the
> > > > internal state of the device.  In fact I'm not sure we want to encourage
> > > > introspection via this data stream.  If a user knows how to interpret
> > > > the data, what prevents them from modifying the data in-flight?  I've
> > > > raised the question previously regarding how the vendor driver can
> > > > validate the integrity of the migration data stream.  Using the
> > > > migration interface to introspect the device certainly suggests an
> > > > interface ripe for exploiting any potential weakness in the vendor
> > > > driver reassembling that migration stream.  If the user has an mmap to
> > > > the actual live working state of the vendor driver, protection in the
> > > > hardware seems like the only way you could protect against a malicious
> > > > user.  Please be defensive in what is directly exposed to the user and
> > > > what safeguards are in place within the vendor driver for validating
> > > > incoming data.  Thanks,  
> > >
> > > Hmm; that sounds like a security-by-obscurity answer!  
> > 
> > Yup, that's fair.  I won't deny that in-kernel vendor driver state
> > passing through userspace from source to target systems scares me quite
> > a bit, but defining device introspection as a use case for the
> > migration interface imposes requirements on the vendor drivers that
> > don't otherwise exist.  Mdev vendor specific utilities could always be
> > written to interpret the migration stream to deduce the internal state,
> > but I think that imposing segregated device memory vs device config
> > regions with the expectation that internal state can be directly
> > tracked is beyond the scope of a migration interface.  
> 
> I'm fine with defining such interface aimed only for migration-like
> usages (e.g. also including fast check-pointing), but I didn't buy-in
> the point that such opaque way is more secure than segregated
> style since the layout can be anyway dumped out by looking at 
> source code of mdev driver.

I think I've fully conceded any notion of security by obscurity towards
opaque data already, but segregating types of device data still seems
to unnecessarily impose a usage model on the vendor driver that I think
we should try to avoid.  The migration interface should define the
protocol through which userspace can save and restore the device state,
not impose how the vendor driver exposes or manages that state.  Also, I
got the impression (perhaps incorrectly) that you were trying to mmap
live data to userspace, which would allow not only saving the state,
but also unchecked state modification by userspace. I think we want
more of a producer/consumer model of the state where consuming state
also involves at least some degree of sanity or consistency checking.
Let's not forget too that we're obviously dealing with non-open source
driver in the mdev universe as well.
 
> Also better we don't include any 'migration' word in related interface
> structure definition. It's just an opaque/dirty-logged way of get/set
> device state, e.g. instead of calling it "migration interface" can we
> call it "dirty-logged state interface"?

I think we're talking about the color of the interface now ;)

> > > The scripts/analyze-migration.py scripts will actually dump the
> > > migration stream data in an almost readable format.
> > > So if you properly define the VMState definitions it should be almost
> > > readable; it's occasionally been useful.  
> > 
> > That's true for emulated devices, but I expect an mdev device migration
> > stream is simply one blob of opaque data followed by another.  We can
> > impose the protocol that userspace uses to read and write this data
> > stream from the device, but not the data it contains.
> >   
> > > I agree that you should be very very careful to validate the incoming
> > > migration stream against:
> > >   a) Corruption
> > >   b) Wrong driver versions
> > >   c) Malicious intent
> > >     c.1) Especially by the guest
> > >     c.2) Or by someone trying to feed you a duff stream
> > >   d) Someone trying load the VFIO stream into completely the wrong
> > > device.  
> > 
> > Yes, and with open source mdev vendor drivers we can at least
> > theoretically audit the reload, but of course we also have proprietary
> > drivers.  I wonder if we should install the kill switch in advance to
> > allow users to opt-out of enabling migration at the mdev layer.
> >   
> > > Whether the migration interface is the right thing to use for that
> > > inspection hmm; well it might be - if you're trying to debug
> > > your device and need a dump of it's state, then why not?
> > > (I guess you end up with something not dissimilar to what things
> > > like intek_reg_snapshot in intel-gpu-tools does).  
> > 
> > Sure, as above there's nothing preventing mdev specific utilities from
> > decoding the migration stream, but I begin to have an issue if this
> > introspective use case imposes requirements on how device state is
> > represented through the migration interface that don't otherwise
> > exist.  If we want to define a standard for the actual data from the
> > device, we'll be at this for years :-\  Thanks,
> >   
> 
> Introspection is one potential usage when thinking about mmapped
> style in Yan's proposal, but it's not strong enough since introspection
> can be also done with opaque way (just not optimal meaning always
> need to track all the states). We may introduce new interface in the
> future when it becomes a real problem.
> 
> But I still didn't get your exact concern about security part. For
> version yes we still haven't worked out a sane way to represent
> vendor-specific compatibility requirement. But allowing user
> space to modify data through this interface has really no difference
> from allowing guest to modify data through trapped MMIO interface.
> mdev driver should guarantee that operations through both interfaces
> can modify only the state associated with the said mdev instance,
> w/o breaking the isolation boundary. Then the former becomes just
> a batch of operations to be verified in the same way as if they are
> done individually through the latter interface. 

It seems like you're assuming a working model for the vendor driver and
the data entering and exiting through this interface.  The vendor
drivers can expose data any way that they want.  All we need to do is
imagine that the migration data stream includes an array index count
somewhere which the user could modify to trigger the in-kernel vendor
driver to allocate an absurd array size and DoS the target.  This is
probably the most simplistic attack, possibly knowing the state machine
of the vendor driver a malicious user could trick it into providing
host kernel data.  We're not necessarily only conveying state that the
user already has access to via this interface, the vendor driver may
include non-visible internal state as well.  Even the state that is
user accessible is being pushed into the vendor driver via an alternate
path from the user mediation we have on the existing paths.

On the other hand, if your assertion that an incoming migration is
nothing more than a batch of operations through existing interfaces to
the device, then maybe this migration interface should be read-only to
generate an interpreted series of operations to the device.  I expect
we wouldn't get terribly far with such an approach though.  Thanks,

Alex
