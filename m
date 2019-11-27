Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45272C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C66204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoL6e381"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C66204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2fr-0003Qq-7P
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ia2dg-00025F-Dk
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ia2df-0003an-5f
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:06:12 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ia2de-0003Ys-Dz
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:06:11 -0500
Received: by mail-wr1-x442.google.com with SMTP id n1so28004628wra.10
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=J4UstZVhkxJqSvjuXzaCT6c+FsskFsTVJNyf0IBQcMg=;
 b=VoL6e381bly3lJsMAmHalYnRoCJAXGn84Xf0CwwMv38ZBvlLKXkXjnzmyCsKCs2+QC
 GwZY9BL0GSZ7S1vMlOqU37bdxxoJI4tqLihvTgx1bjSl6rvZoQuCzuMowAGJin95ldwd
 SndB5aGFWGIv2PeGta6H4u9pSxDTmA53eb9iZavr0y6o6x/AGaRC5F1UWctarhuwdfd/
 f4x19oqXfFUOmOzyzUGG+6Wf/Xmkgi4D283nNGFb4EI0AeSaK+ejixmCyUxAZSirys1u
 Kxhp/inpQVG9e+/ECEdHABlR2u9rND3VePbA49w/1pZr/KuQGLRp9WAH4BhfPa38dY51
 IxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=J4UstZVhkxJqSvjuXzaCT6c+FsskFsTVJNyf0IBQcMg=;
 b=hMXsnI57Ywl6RHaVDTmUFIDiGKSCu89JIazuYEEkrVHL3ksmNZK2QjBFrohfkFwBTy
 JcnSP0IbmU5dfxAc3WtwXRog/cenGsWKpXqJBqMDFDYRJc5Dg4nawHuMp2aBrNNnPz39
 KnscPaCwRpw5V2UlFEde7Js7U8+BnDb9K3lnvUK4D83vs+2Ew6R6r4esMQu6TjeVjm2T
 qkZGcTBw630NzEFdISX599d8zJgWPTrJ4c+7BCCApQ707BflB4hfRU83Eu8lA8V2xxES
 hTTfRlAv4oHQTvoHYWV/9vXOf0akwpnKojwJgasSi8xqlgaeemZNX3d8nYu5DoVlrKnz
 L2nw==
X-Gm-Message-State: APjAAAXHZZsW9RTzQPSs63CtYpWrzqmtDLnfsUeG4F9zQ1OMH02RMf0V
 tA1EWiTGtHeApDwZdR5cJ1MvWw==
X-Google-Smtp-Source: APXvYqw9wk07JnRoiLnFBg0Aaooj8d5jy+jbbmTbCXVj39pXe21veFc2Lh2lWSUqWd2XQyHkN+cxZw==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr46088855wro.346.1574881567426; 
 Wed, 27 Nov 2019 11:06:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p1sm7702017wmc.38.2019.11.27.11.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 11:06:05 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4C2501FF87;
 Wed, 27 Nov 2019 19:06:04 +0000 (GMT)
References: <20191126222607.25653-1-jcmvbkbc@gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [RFC] exec: flush CPU TB cache when breakpoint address
 translation fails
In-reply-to: <20191126222607.25653-1-jcmvbkbc@gmail.com>
Date: Wed, 27 Nov 2019 19:06:04 +0000
Message-ID: <87tv6pf8bn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Filippov <jcmvbkbc@gmail.com> writes:

> When a breakpoint is inserted at location for which there's currently no
> virtual to physical translation no action is taken on CPU TB cache. If a
> TB for that virtual address already exists but is not visible ATM the
> breakpoint won't be hit next time an instruction at that address will be
> executed.

So the userspace has run once but is currently paged out?

>
> Flush entire CPU TB cache when a breakpoint is set for a virtual address
> that cannot be translated to physical address.
>
> This change fixes the following workflow:
> - linux user application is running
> - a breakpoint is inserted from QEMU gdbstub for a user address that is
>   not currently present in the target CPU TLB
> - an instruction at that address is executed, but the external debugger
>   doesn't get control.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  exec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/exec.c b/exec.c
> index ffdb5185353b..918945f8097e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1024,6 +1024,8 @@ static void breakpoint_invalidate(CPUState *cpu, ta=
rget_ulong pc)
>          /* Locks grabbed by tb_invalidate_phys_addr */
>          tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
>                                  phys | (pc & ~TARGET_PAGE_MASK), attrs);
> +    } else {
> +        tb_flush(cpu);
>      }
>  }
>  #endif


--=20
Alex Benn=C3=A9e

