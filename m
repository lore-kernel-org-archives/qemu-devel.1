Received: from eggs.gnu.org ([2001:4830:134:3::10]:37838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ek6Jb-0004Pv-Tx
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ek6JX-0003VG-JL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:53:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ek6JX-0003Uq-BQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:53:55 -0500
Date: Fri, 9 Feb 2018 10:53:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180209105335.GA2428@work-vm>
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<20180208201523.GE2326@work-vm> <5A7D1121.6030903@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A7D1121.6030903@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] virtio-balloon: free page hint
 reporting support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:
> On 02/09/2018 04:15 AM, Dr. David Alan Gilbert wrote:
> > * Wei Wang (wei.w.wang@intel.com) wrote:
> > > This is the deivce part implementation to add a new feature,
> > > VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
> > > receives the guest free page hints from the driver and clears the
> > > corresponding bits in the dirty bitmap, so that those free pages are
> > > not transferred by the migration thread to the destination.
> > > 
> > > Please see the driver patch link for test results:
> > > https://lkml.org/lkml/2018/2/4/60
> > Hi Wei,
> >     I'll look at the code a bit more - but first some more basic
> > questions on that lkml post:
> > 
> >      a) The idle guest time thing is a nice result; can you just state
> >         what the host was, speed of connection, and what other options
> >         you were using?
> > 
> >      b) The workload test, the one with the kernel compile; you list
> >         the kernel compile time but don't mention any changes in the
> >         migration times of the ping-pong; can you give those times as
> >         well?
> > 
> >      c) What's your real workload that this is aimed at?
> >         Is it really for people migrating idle VMs - or do you have some
> >         NFV application in mind, if so why not include a figure for
> >         those?
> > 
> 
> Hi Dave,
> 
> Thanks for joining the review. Please see below info.
> 
> a) Environment info
>     - Host:
>         - Physical CPU: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>         - kernel: 3.10.0
> 
>     - Guest:
>         - kernel: 4.15.0
>         - QEMU setup: -cpu host -M pc -smp 4,threads=1,sockets=1 -m 8G
> --mem-prealloc -realtime mlock=on -balloon virtio,free-page-hint=true
> 
>     - Migration setup:
>         - migrate_set_speed 0
>         - migrate_set_downtime 0.01  (10ms)

That's an unusually low downtime (and I'm not sure what setting the
speed to 0 does!).

> b) Michael asked the same question on the kernel patches, I'll reply there
> with you cc-ed, so that kernel maintainers can also see it. Btw, do you have
> any other workloads you would suggest to have a try?

No, not really; I guess it's best for VMs that are either idle or have
lots of spare RAM.

> c) This feature is requested by many customers (e.g. general cloud vendors).
> It's for general use cases. As long as the guest has free memory, it will
> benefit from this optimization when doing migration. It's not specific for
> NFV usages, but for sure NFV will also benefit from this feature if we think
> about service chaining, where multiple VMs need to co-work with each other.
> In that case, migrating one VM will just break the working model, which
> means we will need to migrate all the VMs. A shorter migration time will be
> very helpful.

I thought of NFV because their VMs tend to have lots of extra RAM but
most seems unused most of the time.

Dave

> 
> Best,
> Wei
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
