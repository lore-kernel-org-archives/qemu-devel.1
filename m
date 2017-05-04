Received: from eggs.gnu.org ([2001:4830:134:3::10]:51331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d6FQc-0002Yr-Ud
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1d6FQX-0006aV-AI
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:00:15 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:33848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1d6FQX-0006Z2-4L
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:00:09 -0400
Received: by mail-pg0-x22d.google.com with SMTP id v1so7407022pgv.1
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 05:00:08 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu,  4 May 2017 19:59:43 +0800
Message-Id: <20170504115948.3048-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/5] mc146818rtc: fix Windows VM clock faster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, yunfangtai@tencent.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Changelog in v2:
Thanks to Paolo's review, the changes in this version are:
1) merge patch 2, 3, 4 together
2) use a nice way ((value ^ new_value) & BIT_MASK) to check if updating
   for periodic timer is needed
3) use a smarter way to calculate coalesced irqs and lost_clock
4) make sure only x86 can enable LOST_TICK_POLICY_SLEW
5) make the code depends on LOST_TICK_POLICY_SLEW rather than
   TARGET_I386

We noticed that the clock on some windows VMs, e.g, Window7 and window8
is really faster and the issue can be easily reproduced by staring the
VM with '-rtc base=localtime,clock=vm,driftfix=slew -no-hpet' and 
running attached code in the guest

The root cause is that the clock will be lost if the periodic period is
changed as currently code counts the next periodic time like this:
      next_irq_clock = (cur_clock & ~(period - 1)) + period;

consider the case if cur_clock = 0x11FF and period = 0x100, then the
next_irq_clock is 0x1200, however, there is only 1 clock left to trigger
the next irq. Unfortunately, Windows guests (at least Windows7) change
the period very frequently if it runs the attached code, so that the
lost clock is accumulated, the wall-time become faster and faster

The main idea to fix the issue is we use a accurate clock period to
calculate the next irq:
    next_irq_clock = cur_clock + period;

After that, it is really convenient to compensate clock if it is needed 

The code running in windows VM is attached:
// TimeInternalTest.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#pragma comment(lib, "winmm")
#include <stdio.h>
#include <windows.h>

#define SWITCH_PEROID  13

int _tmain(int argc, _TCHAR* argv[])
{
	if (argc != 2)
	{
		printf("parameter error!\n");
		printf("USAGE: *.exe time(ms)\n");
		printf("example: *.exe 40\n");
		return 0;
	}
	else
	{
		DWORD internal = atoi((char *)argv[1]);
		DWORD count = 0;

		while (1)
		{
			count++;
			timeBeginPeriod(1);
			DWORD start = timeGetTime();
			Sleep(internal);
			timeEndPeriod(1);
			if ((count % SWITCH_PEROID) == 0) {
				Sleep(1);
			}
		}
	}
	return 0;
}

Tai Yunfang (1):
  mc146818rtc: precisely count the clock for periodic timer

Xiao Guangrong (4):
  mc146818rtc: update periodic timer only if it is needed
  mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only enabled on
    TARGET_I386
  mc146818rtc: drop unnecessary '#ifdef TARGET_I386'
  mc146818rtc: embrace all x86 specific code

 hw/timer/mc146818rtc.c | 204 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 144 insertions(+), 60 deletions(-)

-- 
2.9.3
