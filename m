Received: from eggs.gnu.org ([2001:4830:134:3::10]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1dYXzg-0003Jp-Bf
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1dYXzb-0008Kx-EB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:29:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1dYXzb-0008Jy-5I
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:29:19 -0400
Date: Fri, 21 Jul 2017 09:29:15 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <46101617.33460557.1500643755247.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170721121241.GA18014@stefanha-x1.localdomain>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<945864462.33340808.1500620194836.JavaMail.zimbra@redhat.com>
	<20170721121241.GA18014@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, Rik van Riel <riel@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>


> > A] Problems to solve:
> > ------------------
> > 
> > 1] We are considering two approaches for 'fake DAX flushing interface'.
> >     
> >  1.1] fake dax with NVDIMM flush hints & KVM async page fault
> > 
> >      - Existing interface.
> > 
> >      - The approach to use flush hint address is already nacked upstream.
> >
> >      - Flush hint not queued interface for flushing. Applications might
> >        avoid to use it.
> 
> This doesn't contradicts the last point about async operation and vcpu
> control.  KVM async page faults turn the Address Flush Hints write into
> an async operation so the guest can get other work done while waiting
> for completion.
> 
> > 
> >      - Flush hint address traps from guest to host and do an entire fsync
> >        on backing file which itself is costly.
> > 
> >      - Can be used to flush specific pages on host backing disk. We can
> >        send data(pages information) equal to cache-line size(limitation)
> >        and tell host to sync corresponding pages instead of entire disk
> >        sync.
> 
> Are you sure?  Your previous point says only the entire device can be
> synced.  The NVDIMM Adress Flush Hints interface does not involve
> address range information.

Just syncing entire block device should be simple but costly. Using flush 
hint address to write data which contains list/info of dirty pages to 
flush requires more thought. This calls mmio write callback at Qemu side.
As per Intel (ACPI spec 6.1, Table 5-135) there is limit to max length 
of data guest can write and is equal to cache line size.
 
> 
> > 
> >      - This will be an asynchronous operation and vCPU control is returned
> >        quickly.
> > 
> > 
> >  1.2] Using additional para virt device in addition to pmem device(fake dax
> >  with device flush)
> 
> Perhaps this can be exposed via ACPI as part of the NVDIMM standards
> instead of a separate KVM-only paravirt device.

Same reason as above. If we decide on sending list of dirty pages there is
limit to send max size of data to host using flush hint address.  
> 
