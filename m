Received: from eggs.gnu.org ([2001:4830:134:3::10]:41406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eyyXM-0006Oc-QB
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1eyyXJ-000367-N4
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:37:40 -0400
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:36730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1eyyXJ-00034f-Gf
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 07:37:37 -0400
Received: by mail-io0-x233.google.com with SMTP id o4so10552933iod.3
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 04:37:37 -0700 (PDT)
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-2-xiaoguangrong@tencent.com>
	<20180315102501.GA3062@work-vm>
	<423c901d-16b6-67fb-262b-3021e30871ec@gmail.com>
	<20180321081923.GB20571@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <b957b756-4996-7e79-406d-9587000839c1@gmail.com>
Date: Thu, 22 Mar 2018 19:38:07 +0800
MIME-Version: 1.0
In-Reply-To: <20180321081923.GB20571@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, liang.z.li@intel.com, kvm@vger.kernel.org, quintela@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com



On 03/21/2018 04:19 PM, Peter Xu wrote:
> On Fri, Mar 16, 2018 at 04:05:14PM +0800, Xiao Guangrong wrote:
>>
>> Hi David,
>>
>> Thanks for your review.
>>
>> On 03/15/2018 06:25 PM, Dr. David Alan Gilbert wrote:
>>
>>>>    migration/ram.c | 32 ++++++++++++++++----------------
>>>
>>> Hi,
>>>     Do you have some performance numbers to show this helps?  Were those
>>> taken on a normal system or were they taken with one of the compression
>>> accelerators (which I think the compression migration was designed for)?
>>
>> Yes, i have tested it on my desktop, i7-4790 + 16G, by locally live migrate
>> the VM which has 8 vCPUs + 6G memory and the max-bandwidth is limited to 350.
>>
>> During the migration, a workload which has 8 threads repeatedly written total
>> 6G memory in the VM. Before this patchset, its bandwidth is ~25 mbps, after
>> applying, the bandwidth is ~50 mbps.
> 
> Hi, Guangrong,
> 
> Not really review comments, but I got some questions. :)

Your comments are always valuable to me! :)

> 
> IIUC this patch will only change the behavior when last_sent_block
> changed.  I see that the performance is doubled after the change,
> which is really promising.  However I don't fully understand why it
> brings such a big difference considering that IMHO current code is
> sending dirty pages per-RAMBlock.  I mean, IMHO last_sent_block should
> not change frequently?  Or am I wrong?

It's depends on the configuration, each memory-region which is ram or
file backend has a RAMBlock.

Actually, more benefits comes from the fact that the performance & throughput
of the multithreads has been improved as the threads is fed by the
migration thread and the result is consumed by the migration
thread.

> 
> Another follow-up question would be: have you measured how long time
> needed to compress a 4k page, and how many time to send it?  I think
> "sending the page" is not really meaningful considering that we just
> put a page into the buffer (which should be extremely fast since we
> don't really flush it every time), however I would be curious on how
> slow would compressing a page be.

I haven't benchmark the performance of zlib, i think it is CPU intensive
workload, particularly, there no compression-accelerator (e.g, QAT) on
our production. BTW, we were using lzo instead of zlib which worked
better for some workload.

Putting a page into buffer should depend on the network, i,e, if the
network is congested it should take long time. :)
