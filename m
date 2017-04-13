Received: from eggs.gnu.org ([2001:4830:134:3::10]:56716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyYO7-0005mP-HX
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyYO3-0004H7-V1
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:37:51 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cyYO3-0004Gg-OT
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:37:47 -0400
Received: by mail-wr0-x232.google.com with SMTP id o21so29480539wrb.2
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 23:37:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170412095111.11728-1-xiaoguangrong@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdce9f8e-ec58-d210-3be2-932359e0dcf7@redhat.com>
Date: Thu, 13 Apr 2017 14:37:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170412095111.11728-1-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5] mc146818rtc: fix Windows VM clock
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



On 12/04/2017 17:51, guangrong.xiao@gmail.com wrote:
> The root cause is that the clock will be lost if the periodic period is
> changed as currently code counts the next periodic time like this:
>       next_irq_clock = (cur_clock & ~(period - 1)) + period;
> 
> consider the case if cur_clock = 0x11FF and period = 0x100, then the
> next_irq_clock is 0x1200, however, there is only 1 clock left to trigger
> the next irq. Unfortunately, Windows guests (at least Windows7) change
> the period very frequently if it runs the attached code, so that the
> lost clock is accumulated, the wall-time become faster and faster

Very interesting.

However, I think that the above should be exactly how the RTC should
work.  The original RTC circuit had 22 divider stages (see page 13 of
the datasheet[1], at the bottom right), and the periodic interrupt taps
the rising edge of one of the dividers (page 16, second paragraph).  The
datasheet also never mentions a comparator being used to trigger the
periodic interrupts.

Have you checked that this Windows bug doesn't happen on real hardware
too?  Or is the combination of driftfix=slew and changing periods that
is a problem?

The series also does more than this fix (or workaround), so I will
review it anyway.

[1] http://www.nxp.com/assets/documents/data/en/data-sheets/MC146818.pdf

Thanks,

Paolo
