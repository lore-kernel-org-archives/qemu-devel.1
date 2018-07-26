Received: from eggs.gnu.org ([2001:4830:134:3::10]:47758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fidql-00080h-9g
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fidqi-0006fr-91
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:50:27 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:46053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fidqi-0006fM-32
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:50:24 -0400
Received: by mail-oi0-x22b.google.com with SMTP id q11-v6so2106592oic.12
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 03:50:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <MWHPR02MB247893FCAFB6011E0CB1AACBCA540@MWHPR02MB2478.namprd02.prod.outlook.com>
References: <MWHPR02MB247893FCAFB6011E0CB1AACBCA540@MWHPR02MB2478.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Jul 2018 11:50:03 +0100
Message-ID: <CAFEAcA91Y+stC3mQdnMU4535OjTHfkZyQnW399F1XAqJpDByBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] tb_flush during softreset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sai Pavan Boddu <saipava@xilinx.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>

On 25 July 2018 at 09:04, Sai Pavan Boddu <saipava@xilinx.com> wrote:
> We are seeing issue when fetching tb cache, any suggestions for debug would be helpful.
>
> Issue: Post soft reset of the core, bootloader(running over different cpu) reloads the program memory and releases the reset. At that point CPU crashes after first tb cache fetch.
>
> Note: cpu's have mmu disabled. So no tlb_flush_pages are called.
>
> Question: Is tb_flush called when bootloader has written to program memory of the target cpu ?

(NB: TB flush and TLB flush are different things.)

When anything writes to memory it should result in the relevant
TB entries being flushed -- this happens via code in exec.c
which calls tb_invalidate_phys_page_fast() for writes to
notdirty memory.

Personally I would try debugging this by running QEMU under
rr (rr-project.org), and looking at where the stray tb cache
entry has come from and tracking it backwards to where it
went in, and looking at what happened for the memory writes
that should in theory have resulted in it being flushed.

thanks
-- PMM
