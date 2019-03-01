Received: from eggs.gnu.org ([209.51.188.92]:57980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gziLE-0006wE-89
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gziLD-0002Zy-5x
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:36:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gziLC-0002ZK-Sw
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:36:43 -0500
Date: Fri, 1 Mar 2019 14:36:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190301143630.474870d2.cohuck@redhat.com>
In-Reply-To: <f15fecfe-26c0-05fa-da3b-20156145d287@nvidia.com>
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
	<1550611400-13703-2-git-send-email-kwankhede@nvidia.com>
	<20190221152344.431ced05@w520.home>
	<f15fecfe-26c0-05fa-da3b-20156145d287@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] VFIO KABI for migration interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, cjia@nvidia.com, kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, yan.y.zhao@intel.com, yulei.zhang@intel.com, qemu-devel@nongnu.org

On Wed, 27 Feb 2019 01:35:01 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Alex,
> 
> On 2/22/2019 3:53 AM, Alex Williamson wrote:
> > On Wed, 20 Feb 2019 02:53:16 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> - Defined MIGRATION region type and sub-type.
> >> - Used 2 bits to define VFIO device states.
> >>     Bit 0 => 0/1 => _STOPPED/_RUNNING
> >>     Bit 1 => 0/1 => _RESUMING/_SAVING
> >>     Combination of these bits defines VFIO device's state during migration
> >>     _RUNNING => Normal VFIO device running state.
> >>     _STOPPED => VFIO device stopped.
> >>     _SAVING | _RUNNING => vCPUs are running, VFIO device is running but start
> >>                           saving state of device i.e. pre-copy state
> >>     _SAVING | _STOPPED => vCPUs are stoppped, VFIO device should be stopped, and
> >>                           save device state,i.e. stop-n-copy state
> >>     _RESUMING => VFIO device resuming state.  
> > 
> > Shouldn't we have a non-_RESUMING/_SAVING run state?  If these are
> > indicating directly flow, maybe we need two bits:
> > 
> >   00b - None, normal runtime
> >   01b - Saving
> >   10b - Resuming
> >   11b - Invalid/reserved (maybe a Failed state indicator)
> >   
> 
> There has to be 2 more states:
> _SAVING | _RUNNING => SAVING while device is RUNNING - pre-copy phase
> _SAVING | _STOPPED => SAVING while device is STOPPED - stop-and-copy phase
> 
> So the 2 bits used in this patch are:
> 00b - _RESUMING
> 01b - _RUNNING - Normal Running
> 10b - _SAVING | _STOPPED - stop-and-copy phase
> 11b - _SAVING | _RUNNING - pre-copy phase

Not sure if the "use two bits" approach is the most elegant here --
rightmost bit unset can mean either _RESUMING or _STOPPED...

What about simply making this four distinct states?

#define _RESUMING 0
#define _RUNNING 1 //or the other way around?
#define _SAVING_STOPPED 2
#define _SAVING_RUNNING 3

You could still check if you're currently SAVING by ANDing with 10b.

(...)

> >> + *
> >> + * data_offset: (read/write)
> >> + *      User application should read data_offset in migration region from where
> >> + *      user application should read data during _SAVING state.
> >> + *      User application would write data_offset in migration region from where
> >> + *      user application is had written data during _RESUMING state.  
> > 
> > Why wouldn't data_offset simply be fixed?  Do we really want to support
> > the user writing a arbitrary offsets in the migration region?  Each
> > chunk can simply start at the kernel provided data_offset.
> >  
> 
> data_offset differs based on region is trapped on mapped. In case when
> region is mmaped, QEMU writes data to mapped region and then write
> data_offset field, indicating data is present in mmaped buffer. Read
> below for more detailed steps.
> 
> >> + *
> >> + * data_size: (write only)
> >> + *      User application should write size of data copied in migration region
> >> + *      during _RESUMING state.  
> > 
> > How much does the user read on _SAVING then?
> >   
> 
> pending_bytes tells bytes that should be read on _SAVING.
> 
> >> + *
> >> + * start_pfn: (write only)
> >> + *      Start address pfn to get bitmap of dirty pages from vendor driver duing
> >> + *      _SAVING state.
> >> + *
> >> + * page_size: (write only)
> >> + *      User application should write the page_size of pfn.
> >> + *
> >> + * total_pfns: (write only)
> >> + *      Total pfn count from start_pfn for which dirty bitmap is requested.  
> > 
> > So effectively the area that begins at data_offset is dual purpose
> > (triple purpose vs Yan's, config, memory, and dirty bitmap) 

I'm wondering whether splitting it would combine the best of the two
approaches: Just having an optional dirty bitmap region would make it
more obvious if dirty page tracking is not available.
