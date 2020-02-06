Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F831C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 02:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52C9420674
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 02:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTp9LyG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C9420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izWzQ-0006jH-Ef
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 21:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1izWyg-00065v-U9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 21:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1izWyf-0000LC-OC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 21:33:14 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1izWyf-0000A9-Ft; Wed, 05 Feb 2020 21:33:13 -0500
Received: by mail-pl1-x641.google.com with SMTP id j7so1697528plt.1;
 Wed, 05 Feb 2020 18:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZdfUgBkfz60SNfHeVfoXvAA+AksJADBEEzbi6ytTegk=;
 b=bTp9LyG0LwS7YguY+QHQ+RA7KELjqnaHBXR0wdoLabNaZKZfFSsgyxuv/aBuRBWTqY
 K9TEIVtO1uantRbnDD8FbRqsR/Vx4HOC8ZqWDEkrHrK69xP8mkZ1vxikSU3vtTXOTy+K
 k/Wzx/t7XuUw7wRh12znXvmHktMQuzlBNg66uF+rCw/eJLmYlGzUCh6FMYUHSVtW42qT
 kzYkv7/BDNQPE1VNEg17UHGJZ4vAoYvYlgJyVRyXc1Z7IiBqy59wSyiXo5zI2zE7JnUp
 fhwqTISfHOyNnU32875k115zRdOcCdXmM97YPdn3F4jj1VyA3fH/VrTAkX2iu6egniOo
 E9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZdfUgBkfz60SNfHeVfoXvAA+AksJADBEEzbi6ytTegk=;
 b=eYEcKy1Pb+G2H6GDOT8TFwz3i7r5PAxch+n7YAuuobT7uGme+TSufXIolbIXo+6uzD
 hzTr4/8vufR0FTzfH0evx9sIbmK+VRxoHGS0mnROJm8Xm9gtERFLHhDbAXqNvJN0DzNp
 qtjSxVQLmJ3/yxNgK4kxBg0YhvD9afofZzCv0q8P8D+CwZXUPrN+0qBacuK29djGztqC
 USDcTG87cHCA6UwnnIhB80G/tD5q97XFR1zhYhMu7J1LVfme6cOg7agR3RLlM3U8CvrC
 KqqXVZXl/dSTjn3KPQoS/lJoXjZY7vCZ64rpx0yAc5ch/M7wwkeL+TWaScq+ypGRtoVZ
 8AsQ==
X-Gm-Message-State: APjAAAVO8Jxkdgel6i4umfam2l0fK0ZinsU7g2SehUBU5u8T7XC2nCiK
 Fr0xfYHKU9NtpdcK3MoKcfg=
X-Google-Smtp-Source: APXvYqyjcgcKKJ7EjCA1wC8CIPXigSeEq8FTW50txbwNv1NbGgeo8EcbV1cycLCpUDVL9hwvEist/A==
X-Received: by 2002:a17:90a:be03:: with SMTP id
 a3mr1397038pjs.99.1580956389629; 
 Wed, 05 Feb 2020 18:33:09 -0800 (PST)
Received: from mail.google.com ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id 5sm834856pfx.163.2020.02.05.18.33.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Feb 2020 18:33:08 -0800 (PST)
Date: Thu, 6 Feb 2020 02:33:06 +0000
From: Changbin Du <changbin.du@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] tcg: gdbstub: Fix missing breakpoint issue
Message-ID: <20200206023305.dp47phjlyqhxxix3@mail.google.com>
References: <20200124021728.32518-1-changbin.du@gmail.com>
 <1c765091-54dc-1ea5-ef25-ec4786506fb4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c765091-54dc-1ea5-ef25-ec4786506fb4@linaro.org>
User-Agent: NeoMutt/20180716-508-7c9a6d
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 05, 2020 at 11:03:23AM +0000, Richard Henderson wrote:
> On 1/24/20 2:17 AM, Changbin Du wrote:
> > When inserting breakpoints, we need to invalidate related TBs to apply
> > helper call. This is done by breakpoint_invalidate(). But many users
> > found the BPs sometimes never hit.
> > 
> > In system mode emulation, the BPs are global in guest but not particular
> > address space. The issue is that the current implementation only trys to
> > invalidate TB of paddr corresponding to the target vaddr in current MMU
> > context. Then some cached TBs continue running without BPs applied.
> > 
> > To fix this issue, we can just invalidate all TBs as what step mode does.
> > (For old version users, issuing a step command can workaround this problem.)
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  exec.c | 29 +----------------------------
> >  1 file changed, 1 insertion(+), 28 deletions(-)
> > 
> > diff --git a/exec.c b/exec.c
> > index 67e520d18e..9d9fd48519 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -997,36 +997,9 @@ static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
> >      tb_invalidate_phys_addr(pc);
> >  }
> >  #else
> > -void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
> 
> You can't remove this function yet.
> You should have seen that xtensa-softmmu no longer builds.
> 
> I've cc'd you into Max Filippov's thread that addresses the same problem, and
> I'm going to apply his fix for now.
> 
> 
> r~
>
Got it, just go ahead with that one. thanks~

-- 
Cheers,
Changbin Du

