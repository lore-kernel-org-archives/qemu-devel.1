Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EF621872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H467Snk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EF621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO3GB-0000hi-Ej
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO2mn-0004TM-HV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO2mm-0004Nd-8s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:50:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO2mm-0004N0-2k
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:50:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id g7so2865457wmk.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zx6XwIyFQ0x5ZUJaoOLc643ilC0msPixGlH7xt6GnbM=;
 b=H467Snk/01MnHUNJdySfk+Cp6/Raq7LhAt9FhuUz8XFBtnOKjHg4TbJ8xMV6xTWMZU
 pGX2v55pkcXDicHhkyRn4sRyi143QjTdgvRJknquKUCZSB+EetG0ONFSAQkfxtfUInBc
 2Ktn6Ov4iShrwzJ4tlj4l2Grd3h8Cu89PS2tOx/4Oy5A6yvz4Qxqj0yupTvru3XqJh9H
 BxH3DppK9EFrenUuAah/YhtkU8doPk23OoBKpHC7VK1szs4rbX83oxJns9Z0hKxY430T
 oUBl8ZtTZWT8MncxTFFRfj2LhrrbgmJIOhBptK/yKTBvftOIf7w47lhGxCheCY2/t0q2
 sJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zx6XwIyFQ0x5ZUJaoOLc643ilC0msPixGlH7xt6GnbM=;
 b=YrERW3n2y7y26O/ZdxpU6fKFYmCfCT1D5g3TtO5j6JiUPQN8UDDHdbz0QuBzN3VlvA
 mqq6ANdlFMqeB8rqmdlXhjoU+nyzevU2o0T65lmoGmtZ/6LW48+6wHUhBuLzhks9wtjh
 xGem1aq8V27RP4pNp2jaWTRZG2JLA5PgLrYtOolYtUlV0o08gZOPh+VrJZPPvh4lcACV
 V3p0lOR1TIYzolUbJCaO+pfNRUUWhxQr9U1VPTgDNycFNMLyEJYEUhAQ4om8MtFbLCeO
 CWLS3Mso1eKNNIYE23fj4CFLO7CxbylgnSWgkYT+5xKYUnc+hD8P4/eogRqWHWMXQJzv
 fRmA==
X-Gm-Message-State: APjAAAW+pVgAeTQ6x0tvdFX2KbVE2o/32yomFUeh1vVwo6xvO9fpDDAV
 40Kd1x9Xsbc6MLJbu3omPLIRjA==
X-Google-Smtp-Source: APXvYqzRYwZHuZj2No2f6YZx36zgxaLeIh6sjYUnEEg3bbgkddlkv+bA4DnDCNr4klMcvJ4XD6EqRA==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr4657105wmc.64.1572022198272;
 Fri, 25 Oct 2019 09:49:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p126sm2696424wme.0.2019.10.25.09.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 09:49:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DCD9C1FF87;
 Fri, 25 Oct 2019 17:49:56 +0100 (BST)
References: <20191025155848.17362-1-peter.maydell@linaro.org>
 <20191025155848.17362-2-peter.maydell@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 1/4] tcg/aarch64/tcg-target.opc.h: Add copyright/license
In-reply-to: <20191025155848.17362-2-peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 17:49:56 +0100
Message-ID: <87imoclqh7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add the copyright/license boilerplate for target/aarch64/tcg-target.opc.h.
> This file has only had two commits: 14e4c1e2355473ccb29
> and 79525dfd08262d8, both by Linaro engineers.

Both in fact by the same Linaro engineer - I only reviewed them.

> The license is GPL-2-or-later, since that's what the
> rest of tcg/aarch64 uses.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.opc.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target.opc.h
> index 59e1d3f7f7d..26bfd9c4609 100644
> --- a/tcg/aarch64/tcg-target.opc.h
> +++ b/tcg/aarch64/tcg-target.opc.h
> @@ -1,5 +1,14 @@
> -/* Target-specific opcodes for host vector expansion.  These will be
> -   emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
> -   consider these to be UNSPEC with names.  */
> +/*
> + * Copyright (c) 2019 Linaro
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.
> + *
> + * See the COPYING file in the top-level directory for details.
> + *
> + * Target-specific opcodes for host vector expansion.  These will be
> + * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
> + * consider these to be UNSPEC with names.
> + */
>
>  DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)


--
Alex Benn=C3=A9e

