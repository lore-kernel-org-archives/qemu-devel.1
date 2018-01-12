Received: from eggs.gnu.org ([2001:4830:134:3::10]:40749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1ea34h-0005ZF-BJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1ea34g-0000Wc-Fd
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:25:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 12 Jan 2018 18:24:53 +0100
From: Jean-Christophe Dubois <jcd@tribudubois.net>
In-Reply-To: <CAFEAcA9q9tKedxXxMDS3e2jWA8geL2q2pe=Oo3-E8RQ=cD7LFg@mail.gmail.com>
References: <20180110203823.22292-1-jcd@tribudubois.net>
	<CAFEAcA9q9tKedxXxMDS3e2jWA8geL2q2pe=Oo3-E8RQ=cD7LFg@mail.gmail.com>
Message-ID: <8afa9593623a3a77ed6770a9fd07fea7@tribudubois.net>
Subject: Re: [Qemu-devel] [PATCH] i.MX: Fix FEC/ENET receive funtions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, fyleo45@gmail.com, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Jason Wang <jasowang@redhat.com>

Le 2018-01-12 18:08, Peter Maydell a écrit :
> On 10 January 2018 at 20:38, Jean-Christophe Dubois 
> <jcd@tribudubois.net> wrote:
>> The actual imx_eth_enable_rx() function is buggy.
>> 
>> It updates s->regs[ENET_RDAR] after calling 
>> qemu_flush_queued_packets().
>> 
>> qemu_flush_queued_packets() is going to call imx_XXX_receive() which 
>> itself
>> is going to call imx_eth_enable_rx().
>> 
>> By updating s->regs[ENET_RDAR] after calling 
>> qemu_flush_queued_packets()
>> we end up updating the register with an outdated value which might
>> lead to disabling the receive function in the i.MX FEC/ENET device.
>> 
>> This patch change the place where the register update is done so that 
>> the
>> register value stays up to date and the receive function can keep
>> running.
>> 
>> Reported-by: Fyleo <fyleo45@gmail.com>
>> Tested-by: Fyleo <fyleo45@gmail.com>
>> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> 
> Could you have a look at current QEMU master, please? I think that
> commit b2b012afdd9c has probably fixed this bug. (At any rate it
> has changed that code so that your patch won't apply.)

It seems the patch (imx_fec: Refactor imx_eth_enable_rx()) only renamed 
a variable (from tmp to rx_ring_full) without changing the logic. So I 
don't expect the bug to be fixed in mainline.

I'll rebase and resubmit my patch.

JC


> 
> thanks
> -- PMM
