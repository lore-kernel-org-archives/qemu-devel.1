Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C9CC10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 08:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF4D20869
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 08:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH/YCdSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF4D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hI7So-0002Li-Vz
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 04:04:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hI7RZ-0001kd-4K
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 04:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shahab.vahedi@gmail.com>) id 1hI7RX-0004Hj-Tr
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 04:03:21 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shahab.vahedi@gmail.com>)
	id 1hI7RX-0004Gz-K0
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 04:03:19 -0400
Received: by mail-ed1-x541.google.com with SMTP id i13so7373519edf.11
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=TyxIrURYS5pu8F9J0uvgC4k2N5ldZRF3B6pqpmpsHjw=;
	b=lH/YCdSmsmW/byJYF1/POD3QOZh+Axcmzsj6DSDaRgYXUr+4j/42q1PQSoK+jvZpoA
	99jL1VzDmIeqjL2RZFsyEOEzrQLT3GxtfRfapkU7eEgaYokofTypVwUUXvx6MU3Y1Iya
	muCz6piOpGsviDFmA3OTfUBx7ACJSb7iF2IkjnTSTm5ixDUEofb22PjC/j5RCRKMF16E
	lH3F2YaM9j4VfpOUH2Bhx7EV51HtbfVYx46MAHAuJSG0fJ9ue2Xiji1g7RgVmXGVe3aL
	9Nt1hpRZvZH3LTF1lyt9kHwD8EIv/ik/fXyQtajgC1BsX25f3aO9iEYqxbGH6tcVKZd5
	Prcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=TyxIrURYS5pu8F9J0uvgC4k2N5ldZRF3B6pqpmpsHjw=;
	b=bnltqscdXY+H2X9dIWBVf9EMC5GtZdijgC0SfJ7wMpUP4QjbxgD129dRltpGKkAhay
	bmzj/YZYs/15A8pk3t1NQ73nksMoegqcuXb7lcY287CtHso0zi1OrQUIUvYabaEawL05
	e9H0dfFkzWPQ3YY8Nag9kH/Ssz+XadBAKlJSD+JX/buY52rsUKv/r0TQE2A5cEgVnyb1
	70bpgXozR4GeT5/mswXOtF97o2zt+BF956/ht60Suar8puoDrPx53GKAWZ2ndm/o46R7
	4+t6yU5QVa73IvbDcxmLT+kTaPlRlVWlUme8bRARQ8xYD2G8wDMbryX7r7vGIxlIVMah
	AvbA==
X-Gm-Message-State: APjAAAUTZs2e08O57yE9LGQZpF7lLNUooyG5pa2SYSqVZB5qYZr4UM0G
	MAcUiO1mpi6xphJ3uLvTJ2A=
X-Google-Smtp-Source: APXvYqyDg96GauRRUIWhc8LMdkf0nKAF/7jJwmEag0a3PlV6lUi1qHowL8t+M0B07zsWQrl3f9veNQ==
X-Received: by 2002:a50:8bbd:: with SMTP id m58mr8400863edm.42.1555833797813; 
	Sun, 21 Apr 2019 01:03:17 -0700 (PDT)
Received: from gmail.com (ip-217-103-128-141.ip.prioritytelecom.net.
	[217.103.128.141]) by smtp.gmail.com with ESMTPSA id
	c26sm1680276eja.86.2019.04.21.01.03.16
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 21 Apr 2019 01:03:16 -0700 (PDT)
Date: Sun, 21 Apr 2019 10:03:14 +0200
From: Shahab Vahedi <shahab.vahedi@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190421080314.GA1817@gmail.com>
References: <20190419114502.20388-1-shahab.vahedi@gmail.com>
	<CAFEAcA_2aNt10Ti8HCTbCvHrgFYt7Uw2z=pNWBWyWMsbR6kjoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_2aNt10Ti8HCTbCvHrgFYt7Uw2z=pNWBWyWMsbR6kjoQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	"open list:Overall" <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421080314.TofyomnqJbNkiXs-h08XgwfRUAQnhETW3_s00eyB8No@z>

Hi Peter,

On Sat, Apr 20, 2019 at 07:57:31PM +0100, Peter Maydell wrote:
> On Fri, 19 Apr 2019 at 12:46, Shahab Vahedi <shahab.vahedi@gmail.com> wrote:
> >
> > This change adapts io_readx() to its input access_type. Currently
> > io_readx() treats any memory access as a read, although it has an
> > input argument "MMUAccessType access_type". This results in:
> >
> > 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> > 2) Considering only entry->addr_read as the tlb_addr
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
> >
> > Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> > ---
> > Changelog:
> > - Extra space before closing parenthesis is removed
> >
> >  accel/tcg/cputlb.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Hi; this patch mostly looks good; thanks for submitting it.
> 
Please let me remind you that there is a newer [PATCH v3].

> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 88cc8389e9..4a305ac942 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
> >          CPUTLBEntry *entry;
> >          target_ulong tlb_addr;
> >
> > -        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> > +        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
> >
> >          entry = tlb_entry(env, mmu_idx, addr);
> > -        tlb_addr = entry->addr_read;
> > +        tlb_addr =
> > +            (access_type == MMU_DATA_LOAD)  ? entry->addr_read  :
> > +            (access_type == MMU_DATA_STORE) ? entry->addr_write :
> > +            entry->addr_code;
> 
> Here you don't need to handle MMU_DATA_STORE, because
> we're in io_readx -- stores will go to io_writex, not here.
> 
This concern was already raised by Alex (Bennée) and in [PATCH v3] I
addressed it the way he suggested: an _assert_ in the beginning to
verify that "access_type" is only for fetching and reading.
I must say, Philippe (Mathieu-Daudé) has his doubts about using an
_assert_ like this.

>
> Style-wise it's probably better just to use an
>   if (...) {
>       tlb_addr = ...;
>   } else {
>       tlb_addr = ...;
>   }
> 
> rather than a multi-line ?: expression.
> 
Sure Peter, I will do that, but please let me remind you that in
[PATCH v3] the conditional part is a two-liner (i.s.o the three-
liner here).

> >          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
> >              /* RAM access */
> >              uintptr_t haddr = addr + entry->addend;
> > --
> > 2.21.0
> >
> 
> thanks
> -- PMM

I have a question though: Richard (Henderson) has already _reviewed_
[PATCH v3]. Is it OK if I change the code further and submit yet a
newer version?

Cheers,
Shahab

