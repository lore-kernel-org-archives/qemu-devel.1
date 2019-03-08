Received: from eggs.gnu.org ([209.51.188.92]:49875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2I60-0008Cd-NK
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1h2I5z-0001N5-Qc
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:11:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1h2I5z-0001Mj-GC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:11:39 -0500
Date: Fri, 8 Mar 2019 09:11:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190308091133.3073f5db@x1.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19C97CA6B@SHSMSX104.ccr.corp.intel.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<20190221134051.2c28893e@w520.home>
	<20190225022255.GP16456@joy-OptiPlex-7040>
	<20190307104421.534ea56f@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C97CA6B@SHSMSX104.ccr.corp.intel.com>
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
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "Yang, Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "eauger@redhat.com" <eauger@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu, Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "cjia@nvidia.com" <cjia@nvidia.com>, "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

On Thu, 7 Mar 2019 23:20:36 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Friday, March 8, 2019 1:44 AM  
> > > >  
> > > > >         This kind of data needs to be saved / loaded in pre-copy and
> > > > >         stop-and-copy phase.
> > > > >         The data of device memory is held in device memory region.
> > > > >         Size of devie memory is usually larger than that of device
> > > > >         memory region. qemu needs to save/load it in chunks of size of
> > > > >         device memory region.
> > > > >         Not all device has device memory. Like IGD only uses system  
> > memory.  
> > > >
> > > > It seems a little gratuitous to me that this is a separate region or
> > > > that this data is handled separately.  All of this data is opaque to
> > > > QEMU, so why do we need to separate it?  
> > > hi Alex,
> > > as the device state interfaces are provided by kernel, it is expected to
> > > meet as general needs as possible. So, do you think there are such use
> > > cases from user space that user space knows well of the device, and
> > > it wants kernel to return desired data back to it.
> > > E.g. It just wants to get whole device config data including all mmios,
> > > page tables, pci config data...
> > > or, It just wants to get current device memory snapshot, not including any
> > > dirty data.
> > > Or, It just needs the dirty pages in device memory or system memory.
> > > With all this accurate query, quite a lot of useful features can be
> > > developped in user space.
> > >
> > > If all of this data is opaque to user app, seems the only use case is
> > > for live migration.  
> > 
> > I can certainly appreciate a more versatile interface, but I think
> > we're also trying to create the most simple interface we can, with the
> > primary target being live migration.  As soon as we start defining this
> > type of device memory and that type of device memory, we're going to
> > have another device come along that needs yet another because they have
> > a slightly different requirement.  Even without that, we're going to
> > have vendor drivers implement it differently, so what works for one
> > device for a more targeted approach may not work for all devices.  Can
> > you enumerate some specific examples of the use cases you imagine your
> > design to enable?
> >   
> 
> Do we want to consider an use case where user space would like to
> selectively introspect a portion of the device state (including implicit 
> state which are not available through PCI regions), and may ask for
> capability of direct mapping of selected portion for scanning (e.g.
> device memory) instead of always turning on dirty logging on all
> device state?

I don't see that a migration interface necessarily lends itself to this
use case.  A migration data stream has no requirement to be user
consumable as anything other than opaque data, there's also no
requirement that it expose state in a form that directly represents the
internal state of the device.  In fact I'm not sure we want to encourage
introspection via this data stream.  If a user knows how to interpret
the data, what prevents them from modifying the data in-flight?  I've
raised the question previously regarding how the vendor driver can
validate the integrity of the migration data stream.  Using the
migration interface to introspect the device certainly suggests an
interface ripe for exploiting any potential weakness in the vendor
driver reassembling that migration stream.  If the user has an mmap to
the actual live working state of the vendor driver, protection in the
hardware seems like the only way you could protect against a malicious
user.  Please be defensive in what is directly exposed to the user and
what safeguards are in place within the vendor driver for validating
incoming data.  Thanks,

Alex
