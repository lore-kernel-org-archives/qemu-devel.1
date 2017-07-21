Received: from eggs.gnu.org ([2001:4830:134:3::10]:56189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1dYS05-0002XB-SM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1dYS02-00015g-Dh
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:05:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1dYS02-00014c-4C
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:05:22 -0400
Date: Fri, 21 Jul 2017 02:56:34 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <945864462.33340808.1500620194836.JavaMail.zimbra@redhat.com>
In-Reply-To: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>
Cc: Rik van Riel <riel@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, ross.zwisler@linux.intel.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong.eric@gmail.com, Haozhong Zhang <haozhong.zhang@intel.com>


Hello,

We shared a proposal for 'KVM fake DAX flushing interface'.

https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02478.html

We did initial POC in which we used 'virtio-blk' device to perform 
a device flush on pmem fsync on ext4 filesystem. They are few hacks 
to make things work. We need suggestions on below points before we 
start actual implementation.

A] Problems to solve:
------------------

1] We are considering two approaches for 'fake DAX flushing interface'.
    
 1.1] fake dax with NVDIMM flush hints & KVM async page fault

     - Existing interface.

     - The approach to use flush hint address is already nacked upstream.

     - Flush hint not queued interface for flushing. Applications might 
       avoid to use it.

     - Flush hint address traps from guest to host and do an entire fsync 
       on backing file which itself is costly.

     - Can be used to flush specific pages on host backing disk. We can 
       send data(pages information) equal to cache-line size(limitation) 
       and tell host to sync corresponding pages instead of entire disk sync.

     - This will be an asynchronous operation and vCPU control is returned 
       quickly.


 1.2] Using additional para virt device in addition to pmem device(fake dax with device flush)

     - New interface

     - Guest maintains information of DAX dirty pages as exceptional entries in 
       radix tree.

     - If we want to flush specific pages from guest to host, we need to send 
       list of the dirty pages corresponding to file on which we are doing fsync.

     - This will require implementation of new interface, a new paravirt device 
       for sending flush requests.

     - Host side will perform fsync/fdatasync on list of dirty pages or entire 
       block device backed file.

2] Questions:
-----------

 2.1] Not sure why WPQ flush is not a queued interface? We can force applications 
      to call this? device DAX neither calls fsync/msync?

 2.2] Depending upon interface we decide, we need optimal solution to sync 
      range of pages?

     - Send range of pages from guest to host to sync asynchronously instead 
       of syncing entire block device?

     - Other option is to sync entire disk backing file to make sure all the 
       writes are persistent. In our case, backing file is a regular file on 
       non NVDIMM device so host page cache has list of dirty pages which
       can be used either with fsync or similar interface.

 2.3] If we do host fsync on entire disk we will be flushing all the dirty data
      to backend file. Just thinking what would be better approach, flushing 
      pages on corresponding guest file fsync or entire block device?

 2.4] If we decide to choose one of the above approaches, we need to consider 
      all DAX supporting filesystems(ext4/xfs). Would hooking code to corresponding
      fsync code of fs seems reasonable? Just thinking for flush hint address use-case?
      Or how flush hint addresses would be invoked with fsync or similar api?

 2.5] Also with filesystem journalling and other mount options like barriers, 
      ordered etc, how we decide to use page flush hint or regular fsync on file?
 
 2.6] If at guest side we have PFN of all the dirty pages in radixtree? and we send 
      these to to host? At host side would we able to find corresponding page and flush 
      them all?

Suggestions & ideas are welcome.

Thanks,
Pankaj
