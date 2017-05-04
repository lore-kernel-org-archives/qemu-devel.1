Received: from eggs.gnu.org ([2001:4830:134:3::10]:52041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6FSi-0004d8-Ds
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6FSc-0008R6-N9
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:02:24 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d6FSc-0008QE-Gh
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:02:18 -0400
Received: by mail-wm0-x242.google.com with SMTP id z129so2838684wmb.1
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 05:02:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
	<20170412095111.11728-4-xiaoguangrong@tencent.com>
	<b855686b-20cd-9403-c765-c8b3a3268302@redhat.com>
	<9f781039-dbe4-cf6e-d7e1-64197537dc5c@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79e4d52d-f85f-e496-1e3c-9f5ca2f5945a@redhat.com>
Date: Thu, 4 May 2017 14:02:13 +0200
MIME-Version: 1.0
In-Reply-To: <9f781039-dbe4-cf6e-d7e1-64197537dc5c@gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 04/05/2017 04:54, Xiao Guangrong wrote:
>>>
>>> +            /*
>>> +             * if more than period clocks were passed, i.e, the
>>> timer interrupt
>>> +             * has been lost, we should catch up the time.
>>> +             */
>>> +            if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW &&
>>> +                (lost_clo / period)) {
>>> +                int lost_interrupt = lost_clock / period;
>>> +
>>> +                s->irq_coalesced += lost_interrupt;
>>> +                lost_clock -= lost_interrupt * period;
>>> +                if (lost_interrupt) {
>>> +                    DPRINTF_C("cmos: compensate %d interrupts,
>>> coalesced irqs "
>>> +                              "increased to %d\n", lost_interrupt,
>>> +                              s->irq_coalesced);
>>> +                    rtc_coalesced_timer_update(s);
>>> +                }
>>
>> I think you should merge these two patches, since both of them
>> essentially update the number of coalesced ticks and then split it
>> between s->irq_coalesced and lost_clock.
> 
> I thought these two patches fix two different issues, one for clock
> lost for coalesced-irq and another for period reconfiguration. Your
> suggestion sounds reasonable indeed, will merged them in the next
> version. :)

Yunfang's patch in turn has two parts, one that is only for SLEW and one
that is not.  You can keep the first separate, and merge the second with
yours.

Paolo
