Received: from eggs.gnu.org ([2001:4830:134:3::10]:39570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ejz2T-0004Nf-NL
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 22:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ejz2Q-00049F-Hq
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 22:07:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:32732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ejz2Q-00048r-99
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 22:07:46 -0500
Message-ID: <5A7D1121.6030903@intel.com>
Date: Fri, 09 Feb 2018 11:10:25 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<20180208201523.GE2326@work-vm>
In-Reply-To: <20180208201523.GE2326@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 02/09/2018 04:15 AM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> This is the deivce part implementation to add a new feature,
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
>> receives the guest free page hints from the driver and clears the
>> corresponding bits in the dirty bitmap, so that those free pages are
>> not transferred by the migration thread to the destination.
>>
>> Please see the driver patch link for test results:
>> https://lkml.org/lkml/2018/2/4/60
> Hi Wei,
>     I'll look at the code a bit more - but first some more basic
> questions on that lkml post:
>
>      a) The idle guest time thing is a nice result; can you just state
>         what the host was, speed of connection, and what other options
>         you were using?
>
>      b) The workload test, the one with the kernel compile; you list
>         the kernel compile time but don't mention any changes in the
>         migration times of the ping-pong; can you give those times as
>         well?
>
>      c) What's your real workload that this is aimed at?
>         Is it really for people migrating idle VMs - or do you have some
>         NFV application in mind, if so why not include a figure for
>         those?
>

Hi Dave,

Thanks for joining the review. Please see below info.

a) Environment info
     - Host:
         - Physical CPU: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
         - kernel: 3.10.0

     - Guest:
         - kernel: 4.15.0
         - QEMU setup: -cpu host -M pc -smp 4,threads=1,sockets=1 -m 8G 
--mem-prealloc -realtime mlock=on -balloon virtio,free-page-hint=true

     - Migration setup:
         - migrate_set_speed 0
         - migrate_set_downtime 0.01  (10ms)

b) Michael asked the same question on the kernel patches, I'll reply 
there with you cc-ed, so that kernel maintainers can also see it. Btw, 
do you have any other workloads you would suggest to have a try?

c) This feature is requested by many customers (e.g. general cloud 
vendors). It's for general use cases. As long as the guest has free 
memory, it will benefit from this optimization when doing migration. 
It's not specific for NFV usages, but for sure NFV will also benefit 
from this feature if we think about service chaining, where multiple VMs 
need to co-work with each other. In that case, migrating one VM will 
just break the working model, which means we will need to migrate all 
the VMs. A shorter migration time will be very helpful.


Best,
Wei
