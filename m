Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B4C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9002073A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHAaLCZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9002073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irfP0-0001S2-FU
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 04:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irfOI-0000wu-QW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irfOH-00027a-J3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:55:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irfOH-00027N-CH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:55:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so17121231wmb.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 01:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5eOAh+nIdbYxkH+Kl8RWYvebr18Hxf8XbzAYIKXw9yw=;
 b=uHAaLCZxfvDJmsqUWZZoGKXuCifWzz5FHVuHWRSAmqF1wkw1NC8OECM8o4+R/XjjB9
 rYBt9tHsMSGGfrmFACwxGrTl5sIQt39yHGk9RVSAZscTzWeo0k1gEvq2MXLpDKfUn2aK
 BsXSqawDoRveankkE1AzDD1/ey7gdKw72SfSPOzDTzFvjPWjZxSSo7QsxlaE6sVVv3ZX
 fCXtdRx4ulshNDK/+bp1dkASBTuQdc92lYrnXb8z/bp43mU/Pi8NO7M6A6g/0DlTcoCq
 I4Hzc2ptUdSND6TKbDIJN/ao4uu+2UgA5b7OTuc4U5RnLKDuAVh1Uq/hIskiBVTlDjEY
 0GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5eOAh+nIdbYxkH+Kl8RWYvebr18Hxf8XbzAYIKXw9yw=;
 b=E8Yacpj1oDeY9F+uNdhu0iVk5QuD7nRxyqGoHV6KuVRqGLzpNJYg4+omxi/zig+LLa
 wwIEpimRa7bk8/MFRPwmOE2hFRqoX/bWykuAK5vVrSkwdN0ilWlAS15iqRmq1Yus7G/U
 sAAdnrhFUV1UrmLQ7rtOc3+G0LhmNiif/L5g7ApnX8DGEnqmYdP+2etNYYbRUvwtFcxY
 zWCa6p8dvjQoRN/6DHzbhkF8n1o1u/+aB29wYxaWClY3wlHen966UiuZ+kf+NASOLrtA
 yUduXe3rB9tNzVoPwY7xpp9FqNBC3H3Z0ByOCVUi7V6f4FPIdiCferkZfbStsKKW5ugG
 MesA==
X-Gm-Message-State: APjAAAUo2ILFmsePpDxnw11H5s0MdwHh2ywmFkadzvdZtG+jgyegG/mS
 tpZBgdIeW57evQeZW27TozbCHw==
X-Google-Smtp-Source: APXvYqz/SaO5Mkb/Ar5/+bealoP3LnrBmgji//7WMEWm+nxlXt+psS0BavNfFRpjiS77fFAWICXrKw==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr31375964wmc.64.1579082108274; 
 Wed, 15 Jan 2020 01:55:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 25sm21951124wmi.32.2020.01.15.01.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 01:55:07 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6AC571FF87;
 Wed, 15 Jan 2020 09:55:06 +0000 (GMT)
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <20200114210921.11216-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/3] target/i386: Renumber EXCP_SYSCALL
In-reply-to: <20200114210921.11216-2-richard.henderson@linaro.org>
Date: Wed, 15 Jan 2020 09:55:06 +0000
Message-ID: <875zhdm4cl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We are not short of numbers for EXCP_*.  There is no need to confuse thin=
gs
> by having EXCP_VMEXIT and EXCP_SYSCALL overlap, even though the former is
> only used for system mode and the latter is only used for user mode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/cpu.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 594326a794..164d038d1f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -998,9 +998,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>  #define EXCP11_ALGN	17
>  #define EXCP12_MCHK	18
>=20=20
> -#define EXCP_SYSCALL    0x100 /* only happens in user only emulation
> -                                 for syscall instruction */
> -#define EXCP_VMEXIT     0x100
> +#define EXCP_VMEXIT     0x100 /* only for system emulation */
> +#define EXCP_SYSCALL    0x101 /* only for user emulation */
>=20=20
>  /* i386-specific interrupt pending bits.  */
>  #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1


--=20
Alex Benn=C3=A9e

