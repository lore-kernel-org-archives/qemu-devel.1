Received: from eggs.gnu.org ([209.51.188.92]:47636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gwdXz-000679-Oa
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 20:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gwdXy-0002Ca-9i
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 20:53:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:46745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gwdXx-0002AJ-Ts
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 20:53:10 -0500
Date: Wed, 20 Feb 2019 20:47:45 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20190221014744.GJ16456@joy-OptiPlex-7040>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
	<1550566334-3602-1-git-send-email-yan.y.zhao@intel.com>
	<20190219140918.476ac9d1.cohuck@redhat.com>
	<20190220073636.GD16456@joy-OptiPlex-7040>
	<20190220180813.17e6ab86.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220180813.17e6ab86.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] vfio/migration: define kernel
 interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, arei.gonglei@huawei.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com, intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com, zhi.a.wang@intel.com, jonathan.davies@nutanix.com

On Wed, Feb 20, 2019 at 06:08:13PM +0100, Cornelia Huck wrote:
> On Wed, 20 Feb 2019 02:36:36 -0500
> Zhao Yan <yan.y.zhao@intel.com> wrote:
> 
> > On Tue, Feb 19, 2019 at 02:09:18PM +0100, Cornelia Huck wrote:
> > > On Tue, 19 Feb 2019 16:52:14 +0800
> > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> (...)
> > > > + *          Size of device config data is smaller than or equal to that of
> > > > + *          device config region.  
> > > 
> > > Not sure if I understand that sentence correctly... but what if a
> > > device has more config state than fits into this region? Is that
> > > supposed to be covered by the device memory region? Or is this assumed
> > > to be something so exotic that we don't need to plan for it?
> > >   
> > Device config data and device config region are all provided by vendor
> > driver, so vendor driver is always able to create a large enough device
> > config region to hold device config data.
> > So, if a device has data that are better to be saved after device stop and
> > saved/loaded in strict order, the data needs to be in device config region.
> > This kind of data is supposed to be small.
> > If the device data can be saved/loaded several times, it can also be put
> > into device memory region.
> 
> So, it is the vendor driver's decision which device information should
> go via which region? With the device config data supposed to be
> saved/loaded in one go?
Right, exactly.


> (...)
> > > > +/* version number of the device state interface */
> > > > +#define VFIO_DEVICE_STATE_INTERFACE_VERSION 1  
> > > 
> > > Hm. Is this supposed to be backwards-compatible, should we need to bump
> > > this?
> > >  
> > currently no backwords-compatible. we can discuss on that.
> 
> It might be useful if we discover that we need some extensions. But I'm
> not sure how much work it would be.
> 
> (...)
> > > > +/*
> > > > + * DEVICE STATES
> > > > + *
> > > > + * Four states are defined for a VFIO device:
> > > > + * RUNNING, RUNNING & LOGGING, STOP & LOGGING, STOP.
> > > > + * They can be set by writing to device_state field of
> > > > + * vfio_device_state_ctl region.  
> > > 
> > > Who controls this? Userspace?  
> > 
> > Yes. Userspace notifies vendor driver to do the state switching.
> 
> Might be good to mention this (just to make it obvious).
>
Got it. thanks

> > > > + * LOGGING state is a special state that it CANNOT exist
> > > > + * independently.  
> > > 
> > > So it's not a state, but rather a modifier?
> > >   
> > yes. or thinking LOGGING/not LOGGING as bit 1 of a device state,
> > whereas RUNNING/STOPPED is bit 0 of a device state.
> > They have to be got as a whole.
> 
> So it is (on a bit level):
> RUNNING -> 00
> STOPPED -> 01
> LOGGING/RUNNING -> 10
> LOGGING/STOPPED -> 11
> 

Yes.

> > > > + * It must be set alongside with state RUNNING or STOP, i.e,
> > > > + * RUNNING & LOGGING, STOP & LOGGING.
> > > > + * It is used for dirty data logging both for device memory
> > > > + * and system memory.
> > > > + *
> > > > + * LOGGING only impacts device/system memory. In LOGGING state, get buffer
> > > > + * of device memory returns dirty pages since last call; outside LOGGING
> > > > + * state, get buffer of device memory returns whole snapshot of device
> > > > + * memory. system memory's dirty page is only available in LOGGING state.
> > > > + *
> > > > + * Device config should be always accessible and return whole config snapshot
> > > > + * regardless of LOGGING state.
> > > > + * */
> > > > +#define VFIO_DEVICE_STATE_RUNNING 0
> > > > +#define VFIO_DEVICE_STATE_STOP 1
> > > > +#define VFIO_DEVICE_STATE_LOGGING 2
> 
> This makes it look a bit like LOGGING were an individual state, while 2
> is in reality LOGGING/RUNNING... not sure how to make that more
> obvious. Maybe (as we are dealing with a u32):
> 
> #define VFIO_DEVICE_STATE_RUNNING 0x00000000
> #define VFIO_DEVICE_STATE_STOPPED 0x00000001
> #define VFIO_DEVICE_STATE_LOGGING_RUNNING 0x00000002
> #define VFIO_DEVICE_STATE_LOGGING_STOPPED 0x00000003
> #define VFIO_DEVICE_STATE_LOGGING_MASK 0x00000002
>
Yes, yours are better, thanks:)

> > > > +
> > > > +/* action to get data from device memory or device config
> > > > + * the action is write to device state's control region, and data is read
> > > > + * from device memory region or device config region.
> > > > + * Each time before read device memory region or device config region,
> > > > + * action VFIO_DEVICE_DATA_ACTION_GET_BUFFER is required to write to action
> > > > + * field in control region. That is because device memory and devie config
> > > > + * region is mmaped into user space. vendor driver has to be notified of
> > > > + * the the GET_BUFFER action in advance.
> > > > + */
> > > > +#define VFIO_DEVICE_DATA_ACTION_GET_BUFFER 1
> > > > +
> > > > +/* action to set data to device memory or device config
> > > > + * the action is write to device state's control region, and data is
> > > > + * written to device memory region or device config region.
> > > > + * Each time after write to device memory region or device config region,
> > > > + * action VFIO_DEVICE_DATA_ACTION_GET_BUFFER is required to write to action
> > > > + * field in control region. That is because device memory and devie config
> > > > + * region is mmaped into user space. vendor driver has to be notified of
> > > > + * the the SET_BUFFER action after data written.
> > > > + */
> > > > +#define VFIO_DEVICE_DATA_ACTION_SET_BUFFER 2  
> > > 
> > > Let me describe this in my own words to make sure that I understand
> > > this correctly.
> > > 
> > > - The actions are set by userspace to notify the kernel that it is
> > >   going to get data or that it has just written data.
> > > - This is needed as a notification that the mmapped data should not be
> > >   changed resp. just has changed.  
> > we need this notification is because when userspace read the mmapped data,
> > it's from the ptr returned from mmap(). So, when userspace reads that ptr,
> > there will be no page fault or read/write system calls, so vendor driver
> > does not know whether read/write opertation happens or not. 
> > Therefore, before userspace reads the ptr from mmap, it first writes action
> > field in control region (through write system call), and vendor driver
> > will not return the write system call until data prepared.
> > 
> > When userspace writes to that ptr from mmap, it writes data to the data
> > region first, then writes the action field in control region (through write
> > system call) to notify vendor driver. vendor driver will return the system
> > call after it copies the buffer completely.
> > > 
> > > So, how does the kernel know whether the read action has finished resp.
> > > whether the write action has started? Even if userspace reads/writes it
> > > as a whole.
> > >   
> > kernel does not touch the data region except when in response to the
> > "action" write system call.
> 
> Thanks for the explanation, that makes sense.
> (...)
welcome:)
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev
