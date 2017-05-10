Received: from eggs.gnu.org ([2001:4830:134:3::10]:39593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d8OJo-0002r7-Rv
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d8OJk-0001Vn-1I
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:54:04 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d8OJj-0001VX-Mk
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:53:59 -0400
Received: by mail-wr0-x244.google.com with SMTP id v42so6865279wrc.3
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 02:53:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9626326d-977f-bf26-851a-59d420f27993@redhat.com>
Date: Wed, 10 May 2017 11:53:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170510083259.3900-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] mc146818rtc: fix Windows VM clock
 faster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 10/05/2017 10:32, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Changelog in v3:
> Thanks to Paolo's the elaborate review comments, this version
> simplifies the logic of periodic_timer_update() significantly
> that includes:
> 1) introduce rtc_periodic_clock_ticks() that takes both regA and
>    regB into account and returns the period clock
> 2) count the clocks since last interrupt by always using current
>    clock subtracts the clock when last interrupt happened
> 3) improve the assert() logic
> 
> Paolo, all you comments have been reflected in this version except
> globally using s->period because in the current code, only x86 is
> using s->period so that we should obey this rule to keep compatible
> migration. I have added the comment to explain this suitable in the
> code:
> 
>             /*
>              * as the old QEMUs only used s->period for the case that
>              * LOST_TICK_POLICY_SLEW is used, in order to keep the
>              * compatible migration, we obey the rule as old QEMUs.
>              */
>             s->period = period;
> If anything i missed, please let me know. :)

Looks great.  Thanks for following up quickly on the reviews.

Paolo

> Changelog in v2:
> Thanks to Paolo's review, the changes in this version are:
> 1) merge patch 2, 3, 4 together
> 2) use a nice way ((value ^ new_value) & BIT_MASK) to check if updating
>    for periodic timer is needed
> 3) use a smarter way to calculate coalesced irqs and lost_clock
> 4) make sure only x86 can enable LOST_TICK_POLICY_SLEW
> 5) make the code depends on LOST_TICK_POLICY_SLEW rather than
>    TARGET_I386
> 
> We noticed that the clock on some windows VMs, e.g, Window7 and window8
> is really faster and the issue can be easily reproduced by staring the
> VM with '-rtc base=localtime,clock=vm,driftfix=slew -no-hpet' and 
> running attached code in the guest
> 
> The root cause is that the clock will be lost if the periodic period is
> changed as currently code counts the next periodic time like this:
>       next_irq_clock = (cur_clock & ~(period - 1)) + period;
> 
> consider the case if cur_clock = 0x11FF and period = 0x100, then the
> next_irq_clock is 0x1200, however, there is only 1 clock left to trigger
> the next irq. Unfortunately, Windows guests (at least Windows7) change
> the period very frequently if it runs the attached code, so that the
> lost clock is accumulated, the wall-time become faster and faster
> 
> The main idea to fix the issue is we use a accurate clock period to
> calculate the next irq:
>     next_irq_clock = cur_clock + period;
> 
> After that, it is really convenient to compensate clock if it is needed 
> 
> The code running in windows VM is attached:
> // TimeInternalTest.cpp : Defines the entry point for the console application.
> //
> 
> #include "stdafx.h"
> #pragma comment(lib, "winmm")
> #include <stdio.h>
> #include <windows.h>
> 
> #define SWITCH_PEROID  13
> 
> int _tmain(int argc, _TCHAR* argv[])
> {
> 	if (argc != 2)
> 	{
> 		printf("parameter error!\n");
> 		printf("USAGE: *.exe time(ms)\n");
> 		printf("example: *.exe 40\n");
> 		return 0;
> 	}
> 	else
> 	{
> 		DWORD internal = atoi((char *)argv[1]);
> 		DWORD count = 0;
> 
> 		while (1)
> 		{
> 			count++;
> 			timeBeginPeriod(1);
> 			DWORD start = timeGetTime();
> 			Sleep(internal);
> 			timeEndPeriod(1);
> 			if ((count % SWITCH_PEROID) == 0) {
> 				Sleep(1);
> 			}
> 		}
> 	}
> 	return 0;
> }
> 
> Tai Yunfang (1):
>   mc146818rtc: precisely count the clock for periodic timer
> 
> Xiao Guangrong (4):
>   mc146818rtc: update periodic timer only if it is needed
>   mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only enabled on
>     TARGET_I386
>   mc146818rtc: drop unnecessary '#ifdef TARGET_I386'
>   mc146818rtc: embrace all x86 specific code
> 
>  hw/timer/mc146818rtc.c | 212 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 149 insertions(+), 63 deletions(-)
> 
