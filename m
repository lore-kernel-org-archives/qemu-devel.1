Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B3C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36F72146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIROkNgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36F72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDA4h-0006iE-Gd
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDA3C-0005co-Go
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDA3B-0004UC-3s
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:21:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDA3A-0004Tu-U0
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:21:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id b24so5624387wmj.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OE0kmlrUS6geSOuECtrVZ4mYNbga+YvKugHDPVC+yMo=;
 b=cIROkNgUWXEd1Z3jZW1sF8VM6T/e1Ll7U1XMzOjgMOdDYnPbUvshRRdrD6RmVXVfZF
 LVXSvx2ALcCGAy8ECrOafX/ysMiojoB3sa2EsReX2RFn7wpzzXFcSUr53plkpnVT9bIW
 z16ChtGa2RtEf+E+TkmB4Oq8zf7tC4YimdQ4z7otv84r2k71m1ygmcosrXs4IrZdiVLB
 4uSTq6K63gOCt2QZVbAXHKAwFDVogJ0TT9/hzn6wy/r3ry1e9rZYVpFYZRSjPc1uAIBR
 g8i0nwgstZlaosGfkk2y8QzAy95xIsDtPqfUB3S40IACKGnQY+LwBi95abMfbHKXYKUq
 W4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OE0kmlrUS6geSOuECtrVZ4mYNbga+YvKugHDPVC+yMo=;
 b=CdmqME5kfAQBqMx1eXGCpR1A4Cqv2HVDaN0H+wFb23Nw3i8ymioeNX9XSXQ6Ibj/7Q
 n6g56wkVQQR/aAKC7WPeCm29AtOVUMu/30WB9SYJyqkBxoal6vVR8X54ANfhmb9w3vnK
 lY5ya30lXejLWX+WgxMeST7uRMC71CDXKPzgkFXRGn2Ben0hjMwMcvmcMLAO3LG70EJs
 bucjUiKdopIiNrM5IlmhvzLRssHGqnr/gIL97SbKJF8MhrpUd/KsuKoMsbj6VIQFisEe
 veRUH9U9AdCPwHDWPXORIi/eHifwGRBf58Ywm7HChe24W2jcQ8GR8X9tYjPDn6XQ8bMH
 PQtQ==
X-Gm-Message-State: APjAAAVFt56VL9PY+ZcYOMhB58IeT3Q8iQgpVlhUybacKTBrxHn8eTH0
 uskBFX0G4f7LfSo34WUH6JvPsQ==
X-Google-Smtp-Source: APXvYqyLNF13F5Dnapw4lJY6H883vZcY+qEN8h0FE/6ZRKaiS15ccqxznwpQzakBCtb/MUow2IMugw==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr8640780wmj.152.1569428514895; 
 Wed, 25 Sep 2019 09:21:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 17sm6840302wrl.15.2019.09.25.09.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 09:21:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F5D21FF87;
 Wed, 25 Sep 2019 17:21:53 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-13-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 12/16] cputlb: Handle TLB_NOTDIRTY in probe_access
In-reply-to: <20190923230004.9231-13-richard.henderson@linaro.org>
Date: Wed, 25 Sep 2019 17:21:53 +0100
Message-ID: <87o8z89wim.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

> We can use notdirty_write for the write and
> return a valid host pointer for this case.

nit: reflow the text

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cputlb.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 09b0df87c6..d0bdef1eb3 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1167,16 +1167,24 @@ void *probe_access(CPUArchState *env, target_ulon=
g addr, int size,
>          return NULL;
>      }
>
> -    /* Handle watchpoints.  */
> -    if (tlb_addr & TLB_WATCHPOINT) {
> -        cpu_check_watchpoint(env_cpu(env), addr, size,
> -                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
> -                             wp_access, retaddr);
> -    }
> +    if (unlikely(tlb_addr & TLB_FLAGS_MASK)) {
> +        CPUIOTLBEntry *iotlbentry =3D
> &env_tlb(env)->d[mmu_idx].iotlb[index];

I was going to say we compute this early but I'm assuming the compiler
can figure that out if it needs to.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--
Alex Benn=C3=A9e

