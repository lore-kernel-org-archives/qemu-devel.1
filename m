Received: from eggs.gnu.org ([2001:4830:134:3::10]:42783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fTIni-0000Dh-JX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fTInf-0005c5-CV
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:19:54 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fTInf-0005bd-5w
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:19:51 -0400
Received: by mail-pg0-x242.google.com with SMTP id l65-v6so2225952pgl.8
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 20:19:50 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-2-xiaoguangrong@tencent.com>
	<20180611073920.GJ7736@xz-mi>
	<f9915861-a0bd-aa94-8796-64465cbf937c@gmail.com>
	<20180612031503.GL7736@xz-mi> <20180613154314.GI2676@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <089249ff-7f39-44db-310d-ae9ba7912b33@gmail.com>
Date: Thu, 14 Jun 2018 11:19:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180613154314.GI2676@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: do not wait if no free
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/13/2018 11:43 PM, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
>> On Tue, Jun 12, 2018 at 10:42:25AM +0800, Xiao Guangrong wrote:
>>>
>>>
>>> On 06/11/2018 03:39 PM, Peter Xu wrote:
>>>> On Mon, Jun 04, 2018 at 05:55:09PM +0800, guangrong.xiao@gmail.com wrote:
>>>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>>>
>>>>> Instead of putting the main thread to sleep state to wait for
>>>>> free compression thread, we can directly post it out as normal
>>>>> page that reduces the latency and uses CPUs more efficiently
>>>>
>>>> The feature looks good, though I'm not sure whether we should make a
>>>> capability flag for this feature since otherwise it'll be hard to
>>>> switch back to the old full-compression way no matter for what
>>>> reason.  Would that be a problem?
>>>>
>>>
>>> We assume this optimization should always be optimistic for all cases,
>>> particularly, we introduced the statistics of compression, then the user
>>> should adjust its parameters based on those statistics if anything works
>>> worse.
>>
>> Ah, that'll be good.
>>
>>>
>>> Furthermore, we really need to improve this optimization if it hurts
>>> any case rather than leaving a option to the user. :)
>>
>> Yeah, even if we make it a parameter/capability we can still turn that
>> on by default in new versions but keep the old behavior in old
>> versions. :) The major difference is that, then we can still _have_ a
>> way to compress every page. I'm just thinking if we don't have a
>> switch for that then if someone wants to measure e.g.  how a new
>> compression algo could help VM migration, then he/she won't be
>> possible to do that again since the numbers will be meaningless if
>> that bit is out of control on which page will be compressed.
>>
>> Though I don't know how much use it'll bring...  But if that won't be
>> too hard, it still seems good.  Not a strong opinion.
> 
> I think that is needed; it might be that some users have really awful
> networking and need the compression; I'd expect that for people who turn
> on compression they really expect the slowdown because they need it for
> their network, so changing that is a bit odd.

People should make sure the system has enough CPU resource to do
compression as well, so the perfect usage is that the 'busy-rate'
is low enough i think.

However, it's not a big deal, i will introduce a parameter,
maybe, compress-wait-free-thread.

Thank you all, Dave and Peter! :)
