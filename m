Received: from eggs.gnu.org ([2001:4830:134:3::10]:51077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyYyE-0008BT-E8
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 04:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyYyB-0004C6-8X
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 04:19:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyYyB-0004Bu-39
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 04:19:39 -0400
Date: Wed, 21 Mar 2018 16:19:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180321081923.GB20571@xz-mi>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-2-xiaoguangrong@tencent.com>
	<20180315102501.GA3062@work-vm>
	<423c901d-16b6-67fb-262b-3021e30871ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <423c901d-16b6-67fb-262b-3021e30871ec@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] migration: stop compressing page in
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, liang.z.li@intel.com, kvm@vger.kernel.org, quintela@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com

On Fri, Mar 16, 2018 at 04:05:14PM +0800, Xiao Guangrong wrote:
> 
> Hi David,
> 
> Thanks for your review.
> 
> On 03/15/2018 06:25 PM, Dr. David Alan Gilbert wrote:
> 
> > >   migration/ram.c | 32 ++++++++++++++++----------------
> > 
> > Hi,
> >    Do you have some performance numbers to show this helps?  Were those
> > taken on a normal system or were they taken with one of the compression
> > accelerators (which I think the compression migration was designed for)?
> 
> Yes, i have tested it on my desktop, i7-4790 + 16G, by locally live migrate
> the VM which has 8 vCPUs + 6G memory and the max-bandwidth is limited to 350.
> 
> During the migration, a workload which has 8 threads repeatedly written total
> 6G memory in the VM. Before this patchset, its bandwidth is ~25 mbps, after
> applying, the bandwidth is ~50 mbps.

Hi, Guangrong,

Not really review comments, but I got some questions. :)

IIUC this patch will only change the behavior when last_sent_block
changed.  I see that the performance is doubled after the change,
which is really promising.  However I don't fully understand why it
brings such a big difference considering that IMHO current code is
sending dirty pages per-RAMBlock.  I mean, IMHO last_sent_block should
not change frequently?  Or am I wrong?

Another follow-up question would be: have you measured how long time
needed to compress a 4k page, and how many time to send it?  I think
"sending the page" is not really meaningful considering that we just
put a page into the buffer (which should be extremely fast since we
don't really flush it every time), however I would be curious on how
slow would compressing a page be.

Thanks,

> 
> BTW, Compression will use almost all valid bandwidth after all of our work
> which i will post it out part by part.
> 

-- 
Peter Xu
