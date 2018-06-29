Received: from eggs.gnu.org ([2001:4830:134:3::10]:41920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYkQQ-0005bP-Q5
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYkQN-0004y3-O2
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:50:22 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:41878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fYkQN-0004wD-HC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 23:50:19 -0400
Received: by mail-pl0-x243.google.com with SMTP id w8-v6so3788133ply.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 20:50:19 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-7-xiaoguangrong@tencent.com>
	<20180619073034.GA14814@xz-mi>
	<e945c2af-ccfb-f777-fdbf-724d4572dd0a@gmail.com>
	<20180628093650.GB3513@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <5c82a24f-6058-9b0d-a99e-dc298ba85674@gmail.com>
Date: Fri, 29 Jun 2018 11:50:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180628093650.GB3513@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/12] migration: do not detect zero page
 for compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, dgilbert@redhat.com, qemu-devel@nongnu.org, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, pbonzini@redhat.com


Hi Daniel,

On 06/28/2018 05:36 PM, Daniel P. Berrangé wrote:
> On Thu, Jun 28, 2018 at 05:12:39PM +0800, Xiao Guangrong wrote:
>>

>> After this patch, the workload is moved to the worker thread, is it
>> acceptable?
> 
> It depends on your point of view. If you have spare / idle CPUs on the host,
> then moving workload to a thread is ok, despite the CPU cost of compression
> in that thread being much higher what what was replaced, since you won't be
> taking CPU resources away from other contending workloads.
> 
> I'd venture to suggest though that we should probably *not* be optimizing for
> the case of idle CPUs on the host. More realistic is to expect that the host
> CPUs are near fully committed to work, and thus the (default) goal should be
> to minimize CPU overhead for the host as a whole. From this POV, zero-page
> detection is better than compression due to > x10 better speed.
> 
> Given the CPU overheads of compression, I think it has fairly narrow use
> in migration in general when considering hosts are often highly committed
> on CPU.

I understand your concern, however, it is not bad.

First, we tolerate the case that the thread runs little slowly - we do
not wait the thread becoming free, instead, we directly posted the page
out as normal (zero detecting still works for the normal page), so it
at least makes the performance not worse then the case compression is
not used.

Second we think the reasonable configuration is that the system should
have enough CPU resource to run the number of threads the user
configured. BTW, the work we will post out will make these parameters
be runtimely configurable, then a control daemon (e.g, libvirt) will
adjust them based on the current load of the system and the statistic
from QEMU. This is the topic we submitted to KVM Forum this year,
hope it can be accepted.

At last, we have a watermark to trigger live migration on a
load-balanced production, the watermark makes sure there is some free
CPU resource left for other works.

Thanks!
