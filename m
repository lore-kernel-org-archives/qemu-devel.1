Received: from eggs.gnu.org ([2001:4830:134:3::10]:50131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d66uO-00005u-Bk
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d66uL-0001M8-AD
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:54:24 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d66uL-0001Li-3t
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:54:21 -0400
Received: by mail-pg0-x243.google.com with SMTP id v1so230899pgv.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 19:54:20 -0700 (PDT)
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<20170412095111.11728-4-xiaoguangrong@tencent.com>
	<b855686b-20cd-9403-c765-c8b3a3268302@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <9f781039-dbe4-cf6e-d7e1-64197537dc5c@gmail.com>
Date: Thu, 4 May 2017 10:54:22 +0800
MIME-Version: 1.0
In-Reply-To: <b855686b-20cd-9403-c765-c8b3a3268302@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] mc146818rtc: properly count the time
 for the next interrupt
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



On 05/03/2017 11:32 PM, Paolo Bonzini wrote:
> On 12/04/2017 11:51, guangrong.xiao@gmail.com wrote:
>> +#ifdef TARGET_I386
>> +            /*
>> +             * if more than period clocks were passed, i.e, the timer interrupt
>> +             * has been lost, we should catch up the time.
>> +             */
>> +            if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
>> +                (lost_clo / period)) {
>> +                int lost_interrupt = lost_clock / period;
>> +
>> +                s->irq_coalesced += lost_interrupt;
>> +                lost_clock -= lost_interrupt * period;
>> +                if (lost_interrupt) {
>> +                    DPRINTF_C("cmos: compensate %d interrupts, coalesced irqs "
>> +                              "increased to %d\n", lost_interrupt,
>> +                              s->irq_coalesced);
>> +                    rtc_coalesced_timer_update(s);
>> +                }
> 
> I think you should merge these two patches, since both of them
> essentially update the number of coalesced ticks and then split it
> between s->irq_coalesced and lost_clock.

I thought these two patches fix two different issues, one for clock
lost for coalesced-irq and another for period reconfiguration. Your
suggestion sounds reasonable indeed, will merged them in the next
version. :)
