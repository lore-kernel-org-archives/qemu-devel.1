Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D566C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA2321D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGoeOIKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA2321D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDAD2-0004MJ-9z
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDABI-0003iJ-Rn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDABH-0007AD-Kz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:30:20 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDABH-00079v-Eg
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:30:19 -0400
Received: by mail-wm1-x341.google.com with SMTP id i16so6456761wmd.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=C7g9vEpRuDe+8AHGKYkcWIbAj6mc5TIDYjrHAmdjSpE=;
 b=dGoeOIKBA8mKhWKUAkUwezvapZWsbFG68MTa8+OHA57bJuPnORP8q5P0vw0JUFO9bL
 iLcwX9CDygQ1jwO/ReuruzR9NOsTqTKdQPRIQme3zQ5jpbNM6HNoSIRSC9XkAFqjkJI0
 uqRGtQomlC3yZQhZNHrEEHm2IzBjbtMMUp7En/QNmw3kYJjxpIAcEFIViWNnNxAHhfwi
 z2+5O6DEs0Qg0MbaHukUnqnhWfTG3gi0iduABeWBPCa/NHmQP5zw6A7WWQM1N3SGJOQD
 fo57JcjciPj4vuQcC/tM38JhCR0BlB6PteUXTq8FHHFzwBcAZ4XYO0kKa8WlzPg9cB59
 6SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=C7g9vEpRuDe+8AHGKYkcWIbAj6mc5TIDYjrHAmdjSpE=;
 b=Hsbn0WakDeL2rU6XMtMF8hcWBWOfo8eLtRnFVpCVzHpZQ+OyKlB3A2d/mq6g1wtWpf
 y35e09FGQCOdHFvB3PvVQdQ2IhjTIRl2giXoTLOto0tJeyK1Epp++J0lMnC7beH8/8X/
 4bRXv/MsRPOypVLtBNL9pfejGXrgWu6ARwZXMc8+X17Rg9L12Vp0R+MBx7IUG6TGHswZ
 bje9DZPRflQ96XKtagC6LQiJvHvjjRay3Qq+IytxWGdjp6YGK7GQ8n7/aJUcem0iAMYO
 PDjp0ELTKFWOWzCVDUNlhcqj7oSqnUdWbiwbrna5VI8JnJZ7iCRSOWkfSqjf3gJ1oaZU
 v0DA==
X-Gm-Message-State: APjAAAXU/cqz7k79CynxakUoYSUGNJi09DBAuACg671L+7yic1Mo7CDn
 kVX7GBWhxGqRPsB62ICmr2soow==
X-Google-Smtp-Source: APXvYqzjteeBR7HLNUIqcyPech197xZCDkbX3NgaMTLIzW4gZxbQEzOYVzbcO759ljYmSiQFRRut2g==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr7543594wmg.38.1569429018160; 
 Wed, 25 Sep 2019 09:30:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e30sm10779863wra.48.2019.09.25.09.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 09:30:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 967151FF87;
 Wed, 25 Sep 2019 17:30:16 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-17-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 16/16] cputlb: Pass retaddr to tb_check_watchpoint
In-reply-to: <20190923230004.9231-17-richard.henderson@linaro.org>
Date: Wed, 25 Sep 2019 17:30:16 +0100
Message-ID: <87impg9w4n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Fixes the previous TLB_WATCHPOINT patches because we are currently
> failing to set cpu->mem_io_pc with the call to cpu_check_watchpoint.
> Pass down the retaddr directly because it's readily available.
>
> Fixes: 50b107c5d61
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.h | 2 +-
>  accel/tcg/translate-all.c | 6 +++---
>  exec.c                    | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
> index 135c1ea96a..a557b4e2bb 100644
> --- a/accel/tcg/translate-all.h
> +++ b/accel/tcg/translate-all.h
> @@ -30,7 +30,7 @@ void tb_invalidate_phys_page_fast(struct page_collectio=
n *pages,
>                                    tb_page_addr_t start, int len,
>                                    uintptr_t retaddr);
>  void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t =
end);
> -void tb_check_watchpoint(CPUState *cpu);
> +void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
>
>  #ifdef CONFIG_USER_ONLY
>  int page_unprotect(target_ulong address, uintptr_t pc);
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index db77fb221b..66d4bc4341 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -2142,16 +2142,16 @@ static bool tb_invalidate_phys_page(tb_page_addr_=
t addr, uintptr_t pc)
>  #endif
>
>  /* user-mode: call with mmap_lock held */
> -void tb_check_watchpoint(CPUState *cpu)
> +void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
>  {
>      TranslationBlock *tb;
>
>      assert_memory_lock();
>
> -    tb =3D tcg_tb_lookup(cpu->mem_io_pc);
> +    tb =3D tcg_tb_lookup(retaddr);
>      if (tb) {
>          /* We can use retranslation to find the PC.  */
> -        cpu_restore_state_from_tb(cpu, tb, cpu->mem_io_pc, true);
> +        cpu_restore_state_from_tb(cpu, tb, retaddr, true);
>          tb_phys_invalidate(tb, -1);
>      } else {
>          /* The exception probably happened in a helper.  The CPU state s=
hould
> diff --git a/exec.c b/exec.c
> index b3df826039..8a0a6613b1 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2758,7 +2758,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr=
, vaddr len,
>                  cpu->watchpoint_hit =3D wp;
>
>                  mmap_lock();
> -                tb_check_watchpoint(cpu);
> +                tb_check_watchpoint(cpu, ra);
>                  if (wp->flags & BP_STOP_BEFORE_ACCESS) {
>                      cpu->exception_index =3D EXCP_DEBUG;
>                      mmap_unlock();


--
Alex Benn=C3=A9e

