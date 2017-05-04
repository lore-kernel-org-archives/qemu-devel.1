Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d66rQ-00072A-1S
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d66rN-00085T-0W
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:51:20 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:35882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d66rM-000858-Qy
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:51:16 -0400
Received: by mail-pg0-x22f.google.com with SMTP id t7so823694pgt.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 19:51:16 -0700 (PDT)
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<20170412095111.11728-3-xiaoguangrong@tencent.com>
	<46377b3a-d06e-2119-eb97-5384013b0ac8@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <5872c8da-35ee-fa38-802b-b865dc170c3f@gmail.com>
Date: Thu, 4 May 2017 10:51:18 +0800
MIME-Version: 1.0
In-Reply-To: <46377b3a-d06e-2119-eb97-5384013b0ac8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] mc146818rtc: fix clock lost after
 scaling coalesced irq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 05/03/2017 11:15 PM, Paolo Bonzini wrote:
> 
> 
> On 12/04/2017 11:51, guangrong.xiao@gmail.com wrote:
>> +            int current_irq_coalesced = s->irq_coalesced;
>> +
>> +            s->irq_coalesced = (current_irq_coalesced * s->period) / period;
>> +
>> +            /*
>> +             * calculate the lost clock after it is scaled which should be
>> +             * compensated in the next interrupt.
>> +             */
>> +            lost_clock += current_irq_coalesced * s->period -
>> +                            s->irq_coalesced * period;
> 
> This is:
> 
>     lost_clock = current_irq_coalesced * s->period -
> 	(current_irq_coalesced * s->period) / period * period;
> 
> i.e.
> 
>     /* When switching from a shorter to a longer period, scale down the
>      * missing ticks since we expect the OS handler to treat the delayed
>      * ticks as longer.  Any leftovers are put back into next_irq_clock.
>      *
>      * When switching to a shorter period, scale up the missing ticks
>      * since we expect the OS handler to treat the delayed ticks as
>      * shorter.
>      */
>     lost_clock = (s->irq_coalesced * s->period) % period;
>     s->irq_coalesced = (s->irq_coalesced * s->period) / period;
> 
> Is this correct?
> 

Yes, it is correct, it looks smarter, will apply it in the next version.

Thanks!
