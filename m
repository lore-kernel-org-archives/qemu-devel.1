Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E2AC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 03:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8A22173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 03:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdhRppxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8A22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0eCC-0002wJ-FU
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 23:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0eAz-0002Uq-BM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0eAp-0002GR-2k
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:54:17 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0eAo-0002G2-LA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 23:54:07 -0400
Received: by mail-ot1-x342.google.com with SMTP id b1so4194860otp.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 20:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=W0xke+mpQ2J2f4U13H5MOqdsv3TuUBrrnZEEQPVmhY0=;
 b=LdhRppxP0T4e8218DuoR1TYsBcPrh1QSyD7FZu33GHoPqMahwwlRMDoCXXf5ReZqLW
 2zDgd9VKBNP9kD7+beGIP5b0U4g7+6QVcA/jo61aKJtI9R7q8jl0fn/hFiHScONrlOl1
 V1Wapiyo77ZFhg/Hnq56Nt/KeMTG0HXq5Md5MUzrYWWtKx+OZuMvcVW+R8SSwNdkBJPi
 wFy5pXnWpBy/KUzeEkZjvCRU/Vm9mMGPeZDofQ0FOb/sbao6owQxLiT10zdITipt9KwC
 0Gx/kuZtEyjqtfkV31+MfFHWHfbDjyfNLdSrbZwtQqlWUReZWLJfD2ff8V2DhlpVEYfh
 7vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=W0xke+mpQ2J2f4U13H5MOqdsv3TuUBrrnZEEQPVmhY0=;
 b=aP2QPO5WE+Pk2ommKJHV/K/5n+kFoV3l3wGUV6dL3NQfnR+pMpZgQAcArBiyG1eVY5
 cvywW5/y4wqS0YMBq8jhoTATX24azdt3qW7CPYPfjJKUIT8/fc9Rouhe8t12LufG+o1+
 40u0kK5oDTu6KvVxqSjQ0dkZO8aafdpugl1EENaOdqMPJiW5vXsUQriUTd15N+R6pqR/
 8UnrHyPygw9hesLmB3kqYbAkWxHMpL20qzs7H9gD+MA2oXvoGNjE+UUIYEzIjgeRkx5x
 2AUy0dmqJb+I5AbaqUdgHU1YiFKIAM5roFUwRjn6SUTBxsr0M9mX0xPOf2qj4iICmcQQ
 fpfA==
X-Gm-Message-State: APjAAAXZvqIZNye98dAzMkRYLDc8xO6oy6fO+aWOM9FtpYP4fwPdf3bE
 QV8DnbvuDHh/imiiugxcKfONxcnXnc15lVJ/17o=
X-Google-Smtp-Source: APXvYqxnqOba65va5o61By5xLTbkvSfm9izkCPizAKxlr/4NVm0MpBIp3oIY4tcwabUesG6B0CL76YCLk81I18hMr70=
X-Received: by 2002:a9d:1288:: with SMTP id g8mr1500013otg.306.1566446044866; 
 Wed, 21 Aug 2019 20:54:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 20:54:04
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Wed, 21 Aug 2019 20:54:04
 -0700 (PDT)
In-Reply-To: <20190821172951.15333-65-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
 <20190821172951.15333-65-jan.bobek@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 22 Aug 2019 05:54:04 +0200
Message-ID: <CAL1e-=hxgWnQFTiYWFRhNnmoo-pPockNBE-m2pRTsErP89fzag@mail.gmail.com>
To: Jan Bobek <jan.bobek@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v4 64/75] target/i386: introduce AVX2
 vector instructions to sse-opcode.inc.h
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.08.2019. 20.49, "Jan Bobek" <jan.bobek@gmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Add all the AVX2 vector instruction entries to sse-opcode.inc.h.
>

Why is AVX-related code inserted in a file whose name says SSE? Perhaps the
file should be named vector-opcode.inc.h?

Also, some vector extensions contain non-vector instructions. Even if you
don't intend to implement emulation of such instructions, you should
mention them in places like this file, since this file mainly deals with
decoding, which is known to you. Without it, you leave the file unfinished
without a good reason.

Thanks,
Aleksandar

> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/sse-opcode.inc.h | 362 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 359 insertions(+), 3 deletions(-)
>
> diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
> index c3c0ec4f89..abbb0a15d7 100644
> --- a/target/i386/sse-opcode.inc.h
> +++ b/target/i386/sse-opcode.inc.h
> @@ -855,6 +855,181 @@
>   * VEX.128.66.0F.WIG 73 /3 ib      VPSRLDQ xmm1, xmm2, imm8
>   * VEX.LZ.0F.WIG AE /2             VLDMXCSR m32
>   * VEX.LZ.0F.WIG AE /3             VSTMXCSR m32
> + *
> + * AVX2 Instructions
> + * ------------------
> + * VEX.256.66.0F.W0 D7 /r          VPMOVMSKB r32, ymm1
> + * VEX.256.66.0F.W1 D7 /r          VPMOVMSKB r64, ymm1
> + * VEX.256.66.0F.WIG FC /r         VPADDB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG FD /r         VPADDW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG FE /r         VPADDD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG D4 /r         VPADDQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG EC /r         VPADDSB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG ED /r         VPADDSW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG DC /r         VPADDUSB ymm1,ymm2,ymm3/m256
> + * VEX.256.66.0F.WIG DD /r         VPADDUSW ymm1,ymm2,ymm3/m256
> + * VEX.256.66.0F38.WIG 01 /r       VPHADDW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 02 /r       VPHADDD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 03 /r       VPHADDSW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG F8 /r         VPSUBB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG F9 /r         VPSUBW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG FA /r         VPSUBD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG FB /r         VPSUBQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG E8 /r         VPSUBSB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG E9 /r         VPSUBSW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG D8 /r         VPSUBUSB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG D9 /r         VPSUBUSW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 05 /r       VPHSUBW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 06 /r       VPHSUBD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 07 /r       VPHSUBSW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG D5 /r         VPMULLW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 40 /r       VPMULLD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG E5 /r         VPMULHW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG E4 /r         VPMULHUW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 28 /r       VPMULDQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG F4 /r         VPMULUDQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 0B /r       VPMULHRSW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG F5 /r         VPMADDWD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 04 /r       VPMADDUBSW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F DA /r             VPMINUB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38 3A /r           VPMINUW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 3B /r       VPMINUD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38 38 /r           VPMINSB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F EA /r             VPMINSW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 39 /r       VPMINSD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F DE /r             VPMAXUB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38 3E /r           VPMAXUW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 3F /r       VPMAXUD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 3C /r       VPMAXSB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG EE /r         VPMAXSW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 3D /r       VPMAXSD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG E0 /r         VPAVGB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG E3 /r         VPAVGW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG F6 /r         VPSADBW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F3A.WIG 42 /r ib    VMPSADBW ymm1, ymm2, ymm3/m256, imm8
> + * VEX.256.66.0F38.WIG 1C /r       VPABSB ymm1, ymm2/m256
> + * VEX.256.66.0F38.WIG 1D /r       VPABSW ymm1, ymm2/m256
> + * VEX.256.66.0F38.WIG 1E /r       VPABSD ymm1, ymm2/m256
> + * VEX.256.66.0F38.WIG 08 /r       VPSIGNB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 09 /r       VPSIGNW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 0A /r       VPSIGND ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 74 /r         VPCMPEQB ymm1,ymm2,ymm3/m256
> + * VEX.256.66.0F.WIG 75 /r         VPCMPEQW ymm1,ymm2,ymm3/m256
> + * VEX.256.66.0F.WIG 76 /r         VPCMPEQD ymm1,ymm2,ymm3/m256
> + * VEX.256.66.0F38.WIG 29 /r       VPCMPEQQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 64 /r         VPCMPGTB ymm1,ymm2,ymm3/m256
> + * VEX.256.66.0F.WIG 65 /r         VPCMPGTW ymm1,ymm2,ymm3/m256
> + * VEX.256.66.0F.WIG 66 /r         VPCMPGTD ymm1,ymm2,ymm3/m256
> + * VEX.256.66.0F38.WIG 37 /r       VPCMPGTQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG DB /r         VPAND ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG DF /r         VPANDN ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG EB /r         VPOR ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG EF /r         VPXOR ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG F1 /r         VPSLLW ymm1, ymm2, xmm3/m128
> + * VEX.256.66.0F.WIG F2 /r         VPSLLD ymm1, ymm2, xmm3/m128
> + * VEX.256.66.0F.WIG F3 /r         VPSLLQ ymm1, ymm2, xmm3/m128
> + * VEX.128.66.0F38.W0 47 /r        VPSLLVD xmm1, xmm2, xmm3/m128
> + * VEX.256.66.0F38.W0 47 /r        VPSLLVD ymm1, ymm2, ymm3/m256
> + * VEX.128.66.0F38.W1 47 /r        VPSLLVQ xmm1, xmm2, xmm3/m128
> + * VEX.256.66.0F38.W1 47 /r        VPSLLVQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG D1 /r         VPSRLW ymm1, ymm2, xmm3/m128
> + * VEX.256.66.0F.WIG D2 /r         VPSRLD ymm1, ymm2, xmm3/m128
> + * VEX.256.66.0F.WIG D3 /r         VPSRLQ ymm1, ymm2, xmm3/m128
> + * VEX.128.66.0F38.W0 45 /r        VPSRLVD xmm1, xmm2, xmm3/m128
> + * VEX.256.66.0F38.W0 45 /r        VPSRLVD ymm1, ymm2, ymm3/m256
> + * VEX.128.66.0F38.W1 45 /r        VPSRLVQ xmm1, xmm2, xmm3/m128
> + * VEX.256.66.0F38.W1 45 /r        VPSRLVQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG E1 /r         VPSRAW ymm1,ymm2,xmm3/m128
> + * VEX.256.66.0F.WIG E2 /r         VPSRAD ymm1,ymm2,xmm3/m128
> + * VEX.128.66.0F38.W0 46 /r        VPSRAVD xmm1, xmm2, xmm3/m128
> + * VEX.256.66.0F38.W0 46 /r        VPSRAVD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F3A.WIG 0F /r ib    VPALIGNR ymm1, ymm2, ymm3/m256, imm8
> + * VEX.256.66.0F.WIG 63 /r         VPACKSSWB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 6B /r         VPACKSSDW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 67 /r         VPACKUSWB ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38 2B /r           VPACKUSDW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 68 /r         VPUNPCKHBW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 69 /r         VPUNPCKHWD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 6A /r         VPUNPCKHDQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 6D /r         VPUNPCKHQDQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 60 /r         VPUNPCKLBW ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 61 /r         VPUNPCKLWD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 62 /r         VPUNPCKLDQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F.WIG 6C /r         VPUNPCKLQDQ ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.WIG 00 /r       VPSHUFB ymm1, ymm2, ymm3/m256
> + * VEX.256.F2.0F.WIG 70 /r ib      VPSHUFLW ymm1, ymm2/m256, imm8
> + * VEX.256.F3.0F.WIG 70 /r ib      VPSHUFHW ymm1, ymm2/m256, imm8
> + * VEX.256.66.0F.WIG 70 /r ib      VPSHUFD ymm1, ymm2/m256, imm8
> + * VEX.256.66.0F3A.W0 4C /r /is4   VPBLENDVB ymm1, ymm2, ymm3/m256, ymm4
> + * VEX.256.66.0F3A.WIG 0E /r ib    VPBLENDW ymm1, ymm2, ymm3/m256, imm8
> + * VEX.128.66.0F3A.W0 02 /r ib     VPBLENDD xmm1, xmm2, xmm3/m128, imm8
> + * VEX.256.66.0F3A.W0 02 /r ib     VPBLENDD ymm1, ymm2, ymm3/m256, imm8
> + * VEX.256.66.0F3A.W0 38 /r ib     VINSERTI128 ymm1, ymm2, xmm3/m128,
imm8
> + * VEX.256.66.0F3A.W0 39 /r ib     VEXTRACTI128 xmm1/m128, ymm2, imm8
> + * VEX.128.66.0F38.W0 78 /r        VPBROADCASTB xmm1,xmm2/m8
> + * VEX.256.66.0F38.W0 78 /r        VPBROADCASTB ymm1,xmm2/m8
> + * VEX.128.66.0F38.W0 79 /r        VPBROADCASTW xmm1,xmm2/m16
> + * VEX.256.66.0F38.W0 79 /r        VPBROADCASTW ymm1,xmm2/m16
> + * VEX.128.66.0F38.W0 58 /r        VPBROADCASTD xmm1,xmm2/m32
> + * VEX.256.66.0F38.W0 58 /r        VPBROADCASTD ymm1,xmm2/m32
> + * VEX.128.66.0F38.W0 59 /r        VPBROADCASTQ xmm1,xmm2/m64
> + * VEX.256.66.0F38.W0 59 /r        VPBROADCASTQ ymm1,xmm2/m64
> + * VEX.128.66.0F38.W0 18 /r        VBROADCASTSS xmm1, xmm2
> + * VEX.256.66.0F38.W0 18 /r        VBROADCASTSS ymm1, xmm2
> + * VEX.256.66.0F38.W0 19 /r        VBROADCASTSD ymm1, xmm2
> + * VEX.256.66.0F38.W0 5A /r        VBROADCASTI128 ymm1,m128
> + * VEX.256.66.0F3A.W0 46 /r ib     VPERM2I128 ymm1, ymm2, ymm3/m256, imm=
8
> + * VEX.256.66.0F38.W0 36 /r        VPERMD ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F38.W0 16 /r        VPERMPS ymm1, ymm2, ymm3/m256
> + * VEX.256.66.0F3A.W1 00 /r ib     VPERMQ ymm1, ymm2/m256, imm8
> + * VEX.256.66.0F3A.W1 01 /r ib     VPERMPD ymm1, ymm2/m256, imm8
> + * VEX.128.66.0F38.W0 92 /r        VGATHERDPS xmm1, vm32x, xmm2
> + * VEX.256.66.0F38.W0 92 /r        VGATHERDPS ymm1, vm32y, ymm2
> + * VEX.128.66.0F38.W1 92 /r        VGATHERDPD xmm1, vm32x, xmm2
> + * VEX.256.66.0F38.W1 92 /r        VGATHERDPD ymm1, vm32x, ymm2
> + * VEX.128.66.0F38.W0 93 /r        VGATHERQPS xmm1, vm64x, xmm2
> + * VEX.256.66.0F38.W0 93 /r        VGATHERQPS xmm1, vm64y, xmm2
> + * VEX.128.66.0F38.W1 93 /r        VGATHERQPD xmm1, vm64x, xmm2
> + * VEX.256.66.0F38.W1 93 /r        VGATHERQPD ymm1, vm64y, ymm2
> + * VEX.128.66.0F38.W0 90 /r        VPGATHERDD xmm1, vm32x, xmm2
> + * VEX.256.66.0F38.W0 90 /r        VPGATHERDD ymm1, vm32y, ymm2
> + * VEX.128.66.0F38.W1 90 /r        VPGATHERDQ xmm1, vm32x, xmm2
> + * VEX.256.66.0F38.W1 90 /r        VPGATHERDQ ymm1, vm32x, ymm2
> + * VEX.128.66.0F38.W0 91 /r        VPGATHERQD xmm1, vm64x, xmm2
> + * VEX.256.66.0F38.W0 91 /r        VPGATHERQD xmm1, vm64y, xmm2
> + * VEX.128.66.0F38.W1 91 /r        VPGATHERQQ xmm1, vm64x, xmm2
> + * VEX.256.66.0F38.W1 91 /r        VPGATHERQQ ymm1, vm64y, ymm2
> + * VEX.256.66.0F38.WIG 20 /r       VPMOVSXBW ymm1, xmm2/m128
> + * VEX.256.66.0F38.WIG 21 /r       VPMOVSXBD ymm1, xmm2/m64
> + * VEX.256.66.0F38.WIG 22 /r       VPMOVSXBQ ymm1, xmm2/m32
> + * VEX.256.66.0F38.WIG 23 /r       VPMOVSXWD ymm1, xmm2/m128
> + * VEX.256.66.0F38.WIG 24 /r       VPMOVSXWQ ymm1, xmm2/m64
> + * VEX.256.66.0F38.WIG 25 /r       VPMOVSXDQ ymm1, xmm2/m128
> + * VEX.256.66.0F38.WIG 30 /r       VPMOVZXBW ymm1, xmm2/m128
> + * VEX.256.66.0F38.WIG 31 /r       VPMOVZXBD ymm1, xmm2/m64
> + * VEX.256.66.0F38.WIG 32 /r       VPMOVZXBQ ymm1, xmm2/m32
> + * VEX.256.66.0F38.WIG 33 /r       VPMOVZXWD ymm1, xmm2/m128
> + * VEX.256.66.0F38.WIG 34 /r       VPMOVZXWQ ymm1, xmm2/m64
> + * VEX.256.66.0F38.WIG 35 /r       VPMOVZXDQ ymm1, xmm2/m128
> + * VEX.128.66.0F38.W0 8C /r        VPMASKMOVD xmm1, xmm2, m128
> + * VEX.128.66.0F38.W0 8E /r        VPMASKMOVD m128, xmm1, xmm2
> + * VEX.256.66.0F38.W0 8C /r        VPMASKMOVD ymm1, ymm2, m256
> + * VEX.256.66.0F38.W0 8E /r        VPMASKMOVD m256, ymm1, ymm2
> + * VEX.128.66.0F38.W1 8C /r        VPMASKMOVQ xmm1, xmm2, m128
> + * VEX.128.66.0F38.W1 8E /r        VPMASKMOVQ m128, xmm1, xmm2
> + * VEX.256.66.0F38.W1 8C /r        VPMASKMOVQ ymm1, ymm2, m256
> + * VEX.256.66.0F38.W1 8E /r        VPMASKMOVQ m256, ymm1, ymm2
> + * VEX.256.66.0F38.WIG 2A /r       VMOVNTDQA ymm1, m256
> + * VEX.256.66.0F.WIG 71 /6 ib      VPSLLW ymm1, ymm2, imm8
> + * VEX.256.66.0F.WIG 71 /2 ib      VPSRLW ymm1, ymm2, imm8
> + * VEX.256.66.0F.WIG 71 /4 ib      VPSRAW ymm1,ymm2,imm8
> + * VEX.256.66.0F.WIG 72 /6 ib      VPSLLD ymm1, ymm2, imm8
> + * VEX.256.66.0F.WIG 72 /2 ib      VPSRLD ymm1, ymm2, imm8
> + * VEX.256.66.0F.WIG 72 /4 ib      VPSRAD ymm1,ymm2,imm8
> + * VEX.256.66.0F.WIG 73 /6 ib      VPSLLQ ymm1, ymm2, imm8
> + * VEX.256.66.0F.WIG 73 /7 ib      VPSLLDQ ymm1, ymm2, imm8
> + * VEX.256.66.0F.WIG 73 /2 ib      VPSRLQ ymm1, ymm2, imm8
> + * VEX.256.66.0F.WIG 73 /3 ib      VPSRLDQ ymm1, ymm2, imm8
>   */
>
>  OPCODE(movd, LEG(NP, 0F, 0, 0x6e), MMX, WR, Pq, Ed)
> @@ -943,6 +1118,8 @@ OPCODE(pmovmskb, LEG(66, 0F, 0, 0xd7), SSE2, WR, Gd,
Udq)
>  OPCODE(pmovmskb, LEG(66, 0F, 1, 0xd7), SSE2, WR, Gq, Udq)
>  OPCODE(vpmovmskb, VEX(128, 66, 0F, 0, 0xd7), AVX, WR, Gd, Udq)
>  OPCODE(vpmovmskb, VEX(128, 66, 0F, 1, 0xd7), AVX, WR, Gq, Udq)
> +OPCODE(vpmovmskb, VEX(256, 66, 0F, 0, 0xd7), AVX2, WR, Gd, Uqq)
> +OPCODE(vpmovmskb, VEX(256, 66, 0F, 1, 0xd7), AVX2, WR, Gq, Uqq)
>  OPCODE(movmskps, LEG(NP, 0F, 0, 0x50), SSE, WR, Gd, Udq)
>  OPCODE(movmskps, LEG(NP, 0F, 1, 0x50), SSE, WR, Gq, Udq)
>  OPCODE(vmovmskps, VEX(128, NP, 0F, 0, 0x50), AVX, WR, Gd, Udq)
> @@ -970,27 +1147,35 @@ OPCODE(vmovddup, VEX(256, F2, 0F, IG, 0x12), AVX,
WR, Vqq, Wqq)
>  OPCODE(paddb, LEG(NP, 0F, 0, 0xfc), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(paddb, LEG(66, 0F, 0, 0xfc), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpaddb, VEX(128, 66, 0F, IG, 0xfc), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpaddb, VEX(256, 66, 0F, IG, 0xfc), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(paddw, LEG(NP, 0F, 0, 0xfd), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(paddw, LEG(66, 0F, 0, 0xfd), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpaddw, VEX(128, 66, 0F, IG, 0xfd), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpaddw, VEX(256, 66, 0F, IG, 0xfd), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(paddd, LEG(NP, 0F, 0, 0xfe), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(paddd, LEG(66, 0F, 0, 0xfe), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpaddd, VEX(128, 66, 0F, IG, 0xfe), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpaddd, VEX(256, 66, 0F, IG, 0xfe), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(paddq, LEG(NP, 0F, 0, 0xd4), SSE2, WRR, Pq, Pq, Qq)
>  OPCODE(paddq, LEG(66, 0F, 0, 0xd4), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpaddq, VEX(128, 66, 0F, IG, 0xd4), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpaddq, VEX(256, 66, 0F, IG, 0xd4), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(paddsb, LEG(NP, 0F, 0, 0xec), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(paddsb, LEG(66, 0F, 0, 0xec), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpaddsb, VEX(128, 66, 0F, IG, 0xec), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpaddsb, VEX(256, 66, 0F, IG, 0xec), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(paddsw, LEG(NP, 0F, 0, 0xed), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(paddsw, LEG(66, 0F, 0, 0xed), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpaddsw, VEX(128, 66, 0F, IG, 0xed), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpaddsw, VEX(256, 66, 0F, IG, 0xed), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(paddusb, LEG(NP, 0F, 0, 0xdc), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(paddusb, LEG(66, 0F, 0, 0xdc), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpaddusb, VEX(128, 66, 0F, IG, 0xdc), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpaddusb, VEX(256, 66, 0F, IG, 0xdc), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(paddusw, LEG(NP, 0F, 0, 0xdd), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(paddusw, LEG(66, 0F, 0, 0xdd), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpaddusw, VEX(128, 66, 0F, IG, 0xdd), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpaddusw, VEX(256, 66, 0F, IG, 0xdd), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(addps, LEG(NP, 0F, 0, 0x58), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vaddps, VEX(128, NP, 0F, IG, 0x58), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vaddps, VEX(256, NP, 0F, IG, 0x58), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1004,12 +1189,15 @@ OPCODE(vaddsd, VEX(IG, F2, 0F, IG, 0x58), AVX,
WRR, Vq, Hq, Wq)
>  OPCODE(phaddw, LEG(NP, 0F38, 0, 0x01), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(phaddw, LEG(66, 0F38, 0, 0x01), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vphaddw, VEX(128, 66, 0F38, IG, 0x01), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vphaddw, VEX(256, 66, 0F38, IG, 0x01), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(phaddd, LEG(NP, 0F38, 0, 0x02), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(phaddd, LEG(66, 0F38, 0, 0x02), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vphaddd, VEX(128, 66, 0F38, IG, 0x02), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vphaddd, VEX(256, 66, 0F38, IG, 0x02), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(phaddsw, LEG(NP, 0F38, 0, 0x03), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(phaddsw, LEG(66, 0F38, 0, 0x03), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vphaddsw, VEX(128, 66, 0F38, IG, 0x03), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vphaddsw, VEX(256, 66, 0F38, IG, 0x03), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(haddps, LEG(F2, 0F, 0, 0x7c), SSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vhaddps, VEX(128, F2, 0F, IG, 0x7c), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vhaddps, VEX(256, F2, 0F, IG, 0x7c), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1019,27 +1207,35 @@ OPCODE(vhaddpd, VEX(256, 66, 0F, IG, 0x7c), AVX,
WRR, Vqq, Hqq, Wqq)
>  OPCODE(psubb, LEG(NP, 0F, 0, 0xf8), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psubb, LEG(66, 0F, 0, 0xf8), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsubb, VEX(128, 66, 0F, IG, 0xf8), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsubb, VEX(256, 66, 0F, IG, 0xf8), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psubw, LEG(NP, 0F, 0, 0xf9), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psubw, LEG(66, 0F, 0, 0xf9), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsubw, VEX(128, 66, 0F, IG, 0xf9), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsubw, VEX(256, 66, 0F, IG, 0xf9), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psubd, LEG(NP, 0F, 0, 0xfa), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psubd, LEG(66, 0F, 0, 0xfa), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsubd, VEX(128, 66, 0F, IG, 0xfa), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsubd, VEX(256, 66, 0F, IG, 0xfa), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psubq, LEG(NP, 0F, 0, 0xfb), SSE2, WRR, Pq, Pq, Qq)
>  OPCODE(psubq, LEG(66, 0F, 0, 0xfb), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsubq, VEX(128, 66, 0F, IG, 0xfb), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsubq, VEX(256, 66, 0F, IG, 0xfb), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psubsb, LEG(NP, 0F, 0, 0xe8), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psubsb, LEG(66, 0F, 0, 0xe8), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsubsb, VEX(128, 66, 0F, IG, 0xe8), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsubsb, VEX(256, 66, 0F, IG, 0xe8), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psubsw, LEG(NP, 0F, 0, 0xe9), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psubsw, LEG(66, 0F, 0, 0xe9), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsubsw, VEX(128, 66, 0F, IG, 0xe9), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsubsw, VEX(256, 66, 0F, IG, 0xe9), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psubusb, LEG(NP, 0F, 0, 0xd8), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psubusb, LEG(66, 0F, 0, 0xd8), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsubusb, VEX(128, 66, 0F, IG, 0xd8), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsubusb, VEX(256, 66, 0F, IG, 0xd8), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psubusw, LEG(NP, 0F, 0, 0xd9), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psubusw, LEG(66, 0F, 0, 0xd9), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsubusw, VEX(128, 66, 0F, IG, 0xd9), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsubusw, VEX(256, 66, 0F, IG, 0xd9), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(subps, LEG(NP, 0F, 0, 0x5c), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vsubps, VEX(128, NP, 0F, IG, 0x5c), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vsubps, VEX(256, NP, 0F, IG, 0x5c), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1053,12 +1249,15 @@ OPCODE(vsubsd, VEX(IG, F2, 0F, IG, 0x5c), AVX,
WRR, Vq, Hq, Wq)
>  OPCODE(phsubw, LEG(NP, 0F38, 0, 0x05), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(phsubw, LEG(66, 0F38, 0, 0x05), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vphsubw, VEX(128, 66, 0F38, IG, 0x05), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vphsubw, VEX(256, 66, 0F38, IG, 0x05), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(phsubd, LEG(NP, 0F38, 0, 0x06), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(phsubd, LEG(66, 0F38, 0, 0x06), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vphsubd, VEX(128, 66, 0F38, IG, 0x06), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vphsubd, VEX(256, 66, 0F38, IG, 0x06), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(phsubsw, LEG(NP, 0F38, 0, 0x07), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(phsubsw, LEG(66, 0F38, 0, 0x07), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vphsubsw, VEX(128, 66, 0F38, IG, 0x07), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vphsubsw, VEX(256, 66, 0F38, IG, 0x07), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(hsubps, LEG(F2, 0F, 0, 0x7d), SSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vhsubps, VEX(128, F2, 0F, IG, 0x7d), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vhsubps, VEX(256, F2, 0F, IG, 0x7d), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1074,22 +1273,29 @@ OPCODE(vaddsubpd, VEX(256, 66, 0F, IG, 0xd0),
AVX, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmullw, LEG(NP, 0F, 0, 0xd5), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pmullw, LEG(66, 0F, 0, 0xd5), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmullw, VEX(128, 66, 0F, IG, 0xd5), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmullw, VEX(256, 66, 0F, IG, 0xd5), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmulld, LEG(66, 0F38, 0, 0x40), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmulld, VEX(128, 66, 0F38, IG, 0x40), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmulld, VEX(256, 66, 0F38, IG, 0x40), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmulhw, LEG(NP, 0F, 0, 0xe5), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pmulhw, LEG(66, 0F, 0, 0xe5), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmulhw, VEX(128, 66, 0F, IG, 0xe5), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmulhw, VEX(256, 66, 0F, IG, 0xe5), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmulhuw, LEG(NP, 0F, 0, 0xe4), SSE, WRR, Pq, Pq, Qq)
>  OPCODE(pmulhuw, LEG(66, 0F, 0, 0xe4), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmulhuw, VEX(128, 66, 0F, IG, 0xe4), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmulhuw, VEX(256, 66, 0F, IG, 0xe4), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmuldq, LEG(66, 0F38, 0, 0x28), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmuldq, VEX(128, 66, 0F38, IG, 0x28), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmuldq, VEX(256, 66, 0F38, IG, 0x28), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmuludq, LEG(NP, 0F, 0, 0xf4), SSE2, WRR, Pq, Pq, Qq)
>  OPCODE(pmuludq, LEG(66, 0F, 0, 0xf4), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmuludq, VEX(128, 66, 0F, IG, 0xf4), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmuludq, VEX(256, 66, 0F, IG, 0xf4), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmulhrsw, LEG(NP, 0F38, 0, 0x0b), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(pmulhrsw, LEG(66, 0F38, 0, 0x0b), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmulhrsw, VEX(128, 66, 0F38, IG, 0x0b), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmulhrsw, VEX(256, 66, 0F38, IG, 0x0b), AVX2, WRR, Vqq, Hqq, Wqq=
)
>  OPCODE(mulps, LEG(NP, 0F, 0, 0x59), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vmulps, VEX(128, NP, 0F, IG, 0x59), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vmulps, VEX(256, NP, 0F, IG, 0x59), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1103,9 +1309,11 @@ OPCODE(vmulsd, VEX(IG, F2, 0F, IG, 0x59), AVX,
WRR, Vq, Hq, Wq)
>  OPCODE(pmaddwd, LEG(NP, 0F, 0, 0xf5), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pmaddwd, LEG(66, 0F, 0, 0xf5), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmaddwd, VEX(128, 66, 0F, IG, 0xf5), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmaddwd, VEX(256, 66, 0F, IG, 0xf5), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmaddubsw, LEG(NP, 0F38, 0, 0x04), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(pmaddubsw, LEG(66, 0F38, 0, 0x04), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmaddubsw, VEX(128, 66, 0F38, IG, 0x04), AVX, WRR, Vdq, Hdq, Wdq=
)
> +OPCODE(vpmaddubsw, VEX(256, 66, 0F38, IG, 0x04), AVX2, WRR, Vqq, Hqq,
Wqq)
>  OPCODE(divps, LEG(NP, 0F, 0, 0x5e), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vdivps, VEX(128, NP, 0F, IG, 0x5e), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vdivps, VEX(256, NP, 0F, IG, 0x5e), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1139,17 +1347,23 @@ OPCODE(vrsqrtss, VEX(IG, F3, 0F, IG, 0x52), AVX,
WRR, Vd, Hd, Wd)
>  OPCODE(pminub, LEG(NP, 0F, 0, 0xda), SSE, WRR, Pq, Pq, Qq)
>  OPCODE(pminub, LEG(66, 0F, 0, 0xda), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpminub, VEX(128, 66, 0F, IG, 0xda), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpminub, VEX(256, 66, 0F, IG, 0xda), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pminuw, LEG(66, 0F38, 0, 0x3a), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpminuw, VEX(128, 66, 0F38, IG, 0x3a), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpminuw, VEX(256, 66, 0F38, IG, 0x3a), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pminud, LEG(66, 0F38, 0, 0x3b), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpminud, VEX(128, 66, 0F38, IG, 0x3b), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpminud, VEX(256, 66, 0F38, IG, 0x3b), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pminsb, LEG(66, 0F38, 0, 0x38), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpminsb, VEX(128, 66, 0F38, IG, 0x38), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpminsb, VEX(256, 66, 0F38, IG, 0x38), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pminsw, LEG(NP, 0F, 0, 0xea), SSE, WRR, Pq, Pq, Qq)
>  OPCODE(pminsw, LEG(66, 0F, 0, 0xea), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpminsw, VEX(128, 66, 0F, IG, 0xea), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpminsw, VEX(256, 66, 0F, IG, 0xea), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pminsd, LEG(66, 0F38, 0, 0x39), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpminsd, VEX(128, 66, 0F38, IG, 0x39), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpminsd, VEX(256, 66, 0F38, IG, 0x39), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(minps, LEG(NP, 0F, 0, 0x5d), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vminps, VEX(128, NP, 0F, IG, 0x5d), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vminps, VEX(256, NP, 0F, IG, 0x5d), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1165,17 +1379,23 @@ OPCODE(vphminposuw, VEX(128, 66, 0F38, IG, 0x41),
AVX, WR, Vdq, Wdq)
>  OPCODE(pmaxub, LEG(NP, 0F, 0, 0xde), SSE, WRR, Pq, Pq, Qq)
>  OPCODE(pmaxub, LEG(66, 0F, 0, 0xde), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmaxub, VEX(128, 66, 0F, IG, 0xde), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmaxub, VEX(256, 66, 0F, IG, 0xde), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmaxuw, LEG(66, 0F38, 0, 0x3e), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmaxuw, VEX(128, 66, 0F38, IG, 0x3e), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmaxuw, VEX(256, 66, 0F38, IG, 0x3e), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmaxud, LEG(66, 0F38, 0, 0x3f), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmaxud, VEX(128, 66, 0F38, IG, 0x3f), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmaxud, VEX(256, 66, 0F38, IG, 0x3f), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmaxsb, LEG(66, 0F38, 0, 0x3c), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmaxsb, VEX(128, 66, 0F38, IG, 0x3c), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmaxsb, VEX(256, 66, 0F38, IG, 0x3c), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmaxsw, LEG(NP, 0F, 0, 0xee), SSE, WRR, Pq, Pq, Qq)
>  OPCODE(pmaxsw, LEG(66, 0F, 0, 0xee), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmaxsw, VEX(128, 66, 0F, IG, 0xee), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmaxsw, VEX(256, 66, 0F, IG, 0xee), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pmaxsd, LEG(66, 0F38, 0, 0x3d), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpmaxsd, VEX(128, 66, 0F38, IG, 0x3d), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpmaxsd, VEX(256, 66, 0F38, IG, 0x3d), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(maxps, LEG(NP, 0F, 0, 0x5f), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vmaxps, VEX(128, NP, 0F, IG, 0x5f), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vmaxps, VEX(256, NP, 0F, IG, 0x5f), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1189,32 +1409,42 @@ OPCODE(vmaxsd, VEX(IG, F2, 0F, IG, 0x5f), AVX,
WRR, Vq, Hq, Wq)
>  OPCODE(pavgb, LEG(NP, 0F, 0, 0xe0), SSE, WRR, Pq, Pq, Qq)
>  OPCODE(pavgb, LEG(66, 0F, 0, 0xe0), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpavgb, VEX(128, 66, 0F, IG, 0xe0), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpavgb, VEX(256, 66, 0F, IG, 0xe0), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pavgw, LEG(NP, 0F, 0, 0xe3), SSE, WRR, Pq, Pq, Qq)
>  OPCODE(pavgw, LEG(66, 0F, 0, 0xe3), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpavgw, VEX(128, 66, 0F, IG, 0xe3), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpavgw, VEX(256, 66, 0F, IG, 0xe3), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psadbw, LEG(NP, 0F, 0, 0xf6), SSE, WRR, Pq, Pq, Qq)
>  OPCODE(psadbw, LEG(66, 0F, 0, 0xf6), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsadbw, VEX(128, 66, 0F, IG, 0xf6), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsadbw, VEX(256, 66, 0F, IG, 0xf6), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(mpsadbw, LEG(66, 0F3A, 0, 0x42), SSE4_1, WRRR, Vdq, Vdq, Wdq, Ib)
>  OPCODE(vmpsadbw, VEX(128, 66, 0F3A, IG, 0x42), AVX, WRRR, Vdq, Hdq, Wdq,
Ib)
> +OPCODE(vmpsadbw, VEX(256, 66, 0F3A, IG, 0x42), AVX2, WRRR, Vqq, Hqq,
Wqq, Ib)
>  OPCODE(pabsb, LEG(NP, 0F38, 0, 0x1c), SSSE3, WR, Pq, Qq)
>  OPCODE(pabsb, LEG(66, 0F38, 0, 0x1c), SSSE3, WR, Vdq, Wdq)
>  OPCODE(vpabsb, VEX(128, 66, 0F38, IG, 0x1c), AVX, WR, Vdq, Wdq)
> +OPCODE(vpabsb, VEX(256, 66, 0F38, IG, 0x1c), AVX2, WR, Vqq, Wqq)
>  OPCODE(pabsw, LEG(NP, 0F38, 0, 0x1d), SSSE3, WR, Pq, Qq)
>  OPCODE(pabsw, LEG(66, 0F38, 0, 0x1d), SSSE3, WR, Vdq, Wdq)
>  OPCODE(vpabsw, VEX(128, 66, 0F38, IG, 0x1d), AVX, WR, Vdq, Wdq)
> +OPCODE(vpabsw, VEX(256, 66, 0F38, IG, 0x1d), AVX2, WR, Vqq, Wqq)
>  OPCODE(pabsd, LEG(NP, 0F38, 0, 0x1e), SSSE3, WR, Pq, Qq)
>  OPCODE(pabsd, LEG(66, 0F38, 0, 0x1e), SSSE3, WR, Vdq, Wdq)
>  OPCODE(vpabsd, VEX(128, 66, 0F38, IG, 0x1e), AVX, WR, Vdq, Wdq)
> +OPCODE(vpabsd, VEX(256, 66, 0F38, IG, 0x1e), AVX2, WR, Vqq, Wqq)
>  OPCODE(psignb, LEG(NP, 0F38, 0, 0x08), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(psignb, LEG(66, 0F38, 0, 0x08), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsignb, VEX(128, 66, 0F38, IG, 0x08), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsignb, VEX(256, 66, 0F38, IG, 0x08), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psignw, LEG(NP, 0F38, 0, 0x09), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(psignw, LEG(66, 0F38, 0, 0x09), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsignw, VEX(128, 66, 0F38, IG, 0x09), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsignw, VEX(256, 66, 0F38, IG, 0x09), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psignd, LEG(NP, 0F38, 0, 0x0a), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(psignd, LEG(66, 0F38, 0, 0x0a), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsignd, VEX(128, 66, 0F38, IG, 0x0a), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsignd, VEX(256, 66, 0F38, IG, 0x0a), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(dpps, LEG(66, 0F3A, 0, 0x40), SSE4_1, WRRR, Vdq, Vdq, Wdq, Ib)
>  OPCODE(vdpps, VEX(128, 66, 0F3A, IG, 0x40), AVX, WRRR, Vdq, Hdq, Wdq, Ib=
)
>  OPCODE(vdpps, VEX(256, 66, 0F3A, IG, 0x40), AVX, WRRR, Vqq, Hqq, Wqq, Ib=
)
> @@ -1247,25 +1477,33 @@ OPCODE(vpclmulqdq, VEX(128, 66, 0F3A, IG, 0x44),
PCLMULQDQ_AVX, WRRR, Vdq, Hdq,
>  OPCODE(pcmpeqb, LEG(NP, 0F, 0, 0x74), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pcmpeqb, LEG(66, 0F, 0, 0x74), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpcmpeqb, VEX(128, 66, 0F, IG, 0x74), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpcmpeqb, VEX(256, 66, 0F, IG, 0x74), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pcmpeqw, LEG(NP, 0F, 0, 0x75), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pcmpeqw, LEG(66, 0F, 0, 0x75), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpcmpeqw, VEX(128, 66, 0F, IG, 0x75), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpcmpeqw, VEX(256, 66, 0F, IG, 0x75), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pcmpeqd, LEG(NP, 0F, 0, 0x76), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pcmpeqd, LEG(66, 0F, 0, 0x76), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpcmpeqd, VEX(128, 66, 0F, IG, 0x76), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpcmpeqd, VEX(256, 66, 0F, IG, 0x76), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pcmpeqq, LEG(66, 0F38, 0, 0x29), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpcmpeqq, VEX(128, 66, 0F38, IG, 0x29), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpcmpeqq, VEX(256, 66, 0F38, IG, 0x29), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pcmpgtb, LEG(NP, 0F, 0, 0x64), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pcmpgtb, LEG(66, 0F, 0, 0x64), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpcmpgtb, VEX(128, 66, 0F, IG, 0x64), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpcmpgtb, VEX(256, 66, 0F, IG, 0x64), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pcmpgtw, LEG(NP, 0F, 0, 0x65), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pcmpgtw, LEG(66, 0F, 0, 0x65), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpcmpgtw, VEX(128, 66, 0F, IG, 0x65), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpcmpgtw, VEX(256, 66, 0F, IG, 0x65), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pcmpgtd, LEG(NP, 0F, 0, 0x66), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pcmpgtd, LEG(66, 0F, 0, 0x66), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpcmpgtd, VEX(128, 66, 0F, IG, 0x66), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpcmpgtd, VEX(256, 66, 0F, IG, 0x66), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pcmpgtq, LEG(66, 0F38, 0, 0x37), SSE4_2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpcmpgtq, VEX(128, 66, 0F38, IG, 0x37), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpcmpgtq, VEX(256, 66, 0F38, IG, 0x37), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pcmpestrm, LEG(66, 0F3A, 0, 0x60), SSE4_2, RRR, Vdq, Wdq, Ib)
>  OPCODE(vpcmpestrm, VEX(128, 66, 0F3A, IG, 0x60), AVX, RRR, Vdq, Wdq, Ib)
>  OPCODE(pcmpestri, LEG(66, 0F3A, 0, 0x61), SSE4_2, RRR, Vdq, Wdq, Ib)
> @@ -1302,6 +1540,7 @@ OPCODE(vcomisd, VEX(IG, 66, 0F, IG, 0x2f), AVX, RR,
Vq, Wq)
>  OPCODE(pand, LEG(NP, 0F, 0, 0xdb), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pand, LEG(66, 0F, 0, 0xdb), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpand, VEX(128, 66, 0F, IG, 0xdb), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpand, VEX(256, 66, 0F, IG, 0xdb), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(andps, LEG(NP, 0F, 0, 0x54), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vandps, VEX(128, NP, 0F, IG, 0x54), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vandps, VEX(256, NP, 0F, IG, 0x54), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1311,6 +1550,7 @@ OPCODE(vandpd, VEX(256, 66, 0F, IG, 0x54), AVX,
WRR, Vqq, Hqq, Wqq)
>  OPCODE(pandn, LEG(NP, 0F, 0, 0xdf), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pandn, LEG(66, 0F, 0, 0xdf), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpandn, VEX(128, 66, 0F, IG, 0xdf), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpandn, VEX(256, 66, 0F, IG, 0xdf), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(andnps, LEG(NP, 0F, 0, 0x55), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vandnps, VEX(128, NP, 0F, IG, 0x55), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vandnps, VEX(256, NP, 0F, IG, 0x55), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1320,6 +1560,7 @@ OPCODE(vandnpd, VEX(256, 66, 0F, IG, 0x55), AVX,
WRR, Vqq, Hqq, Wqq)
>  OPCODE(por, LEG(NP, 0F, 0, 0xeb), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(por, LEG(66, 0F, 0, 0xeb), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpor, VEX(128, 66, 0F, IG, 0xeb), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpor, VEX(256, 66, 0F, IG, 0xeb), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(orps, LEG(NP, 0F, 0, 0x56), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vorps, VEX(128, NP, 0F, IG, 0x56), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vorps, VEX(256, NP, 0F, IG, 0x56), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1329,6 +1570,7 @@ OPCODE(vorpd, VEX(256, 66, 0F, IG, 0x56), AVX, WRR,
Vqq, Hqq, Wqq)
>  OPCODE(pxor, LEG(NP, 0F, 0, 0xef), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pxor, LEG(66, 0F, 0, 0xef), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpxor, VEX(128, 66, 0F, IG, 0xef), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpxor, VEX(256, 66, 0F, IG, 0xef), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(xorps, LEG(NP, 0F, 0, 0x57), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vxorps, VEX(128, NP, 0F, IG, 0x57), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vxorps, VEX(256, NP, 0F, IG, 0x57), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1338,63 +1580,94 @@ OPCODE(vxorpd, VEX(256, 66, 0F, IG, 0x57), AVX,
WRR, Vqq, Hqq, Wqq)
>  OPCODE(psllw, LEG(NP, 0F, 0, 0xf1), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psllw, LEG(66, 0F, 0, 0xf1), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsllw, VEX(128, 66, 0F, IG, 0xf1), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsllw, VEX(256, 66, 0F, IG, 0xf1), AVX2, WRR, Vqq, Hqq, Wdq)
>  OPCODE(pslld, LEG(NP, 0F, 0, 0xf2), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(pslld, LEG(66, 0F, 0, 0xf2), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpslld, VEX(128, 66, 0F, IG, 0xf2), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpslld, VEX(256, 66, 0F, IG, 0xf2), AVX2, WRR, Vqq, Hqq, Wdq)
>  OPCODE(psllq, LEG(NP, 0F, 0, 0xf3), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psllq, LEG(66, 0F, 0, 0xf3), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsllq, VEX(128, 66, 0F, IG, 0xf3), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsllq, VEX(256, 66, 0F, IG, 0xf3), AVX2, WRR, Vqq, Hqq, Wdq)
> +OPCODE(vpsllvd, VEX(128, 66, 0F38, 0, 0x47), AVX2, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsllvd, VEX(256, 66, 0F38, 0, 0x47), AVX2, WRR, Vqq, Hqq, Wqq)
> +OPCODE(vpsllvq, VEX(128, 66, 0F38, 1, 0x47), AVX2, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsllvq, VEX(256, 66, 0F38, 1, 0x47), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psrlw, LEG(NP, 0F, 0, 0xd1), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psrlw, LEG(66, 0F, 0, 0xd1), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsrlw, VEX(128, 66, 0F, IG, 0xd1), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsrlw, VEX(256, 66, 0F, IG, 0xd1), AVX2, WRR, Vqq, Hqq, Wdq)
>  OPCODE(psrld, LEG(NP, 0F, 0, 0xd2), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psrld, LEG(66, 0F, 0, 0xd2), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsrld, VEX(128, 66, 0F, IG, 0xd2), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsrld, VEX(256, 66, 0F, IG, 0xd2), AVX2, WRR, Vqq, Hqq, Wdq)
>  OPCODE(psrlq, LEG(NP, 0F, 0, 0xd3), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psrlq, LEG(66, 0F, 0, 0xd3), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsrlq, VEX(128, 66, 0F, IG, 0xd3), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsrlq, VEX(256, 66, 0F, IG, 0xd3), AVX2, WRR, Vqq, Hqq, Wdq)
> +OPCODE(vpsrlvd, VEX(128, 66, 0F38, 0, 0x45), AVX2, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsrlvd, VEX(256, 66, 0F38, 0, 0x45), AVX2, WRR, Vqq, Hqq, Wqq)
> +OPCODE(vpsrlvq, VEX(128, 66, 0F38, 1, 0x45), AVX2, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsrlvq, VEX(256, 66, 0F38, 1, 0x45), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(psraw, LEG(NP, 0F, 0, 0xe1), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psraw, LEG(66, 0F, 0, 0xe1), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsraw, VEX(128, 66, 0F, IG, 0xe1), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsraw, VEX(256, 66, 0F, IG, 0xe1), AVX2, WRR, Vqq, Hqq, Wdq)
>  OPCODE(psrad, LEG(NP, 0F, 0, 0xe2), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(psrad, LEG(66, 0F, 0, 0xe2), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpsrad, VEX(128, 66, 0F, IG, 0xe2), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsrad, VEX(256, 66, 0F, IG, 0xe2), AVX2, WRR, Vqq, Hqq, Wdq)
> +OPCODE(vpsravd, VEX(128, 66, 0F38, 0, 0x46), AVX2, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpsravd, VEX(256, 66, 0F38, 0, 0x46), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(palignr, LEG(NP, 0F3A, 0, 0x0f), SSSE3, WRRR, Pq, Pq, Qq, Ib)
>  OPCODE(palignr, LEG(66, 0F3A, 0, 0x0f), SSSE3, WRRR, Vdq, Vdq, Wdq, Ib)
>  OPCODE(vpalignr, VEX(128, 66, 0F3A, IG, 0x0f), AVX, WRRR, Vdq, Hdq, Wdq,
Ib)
> +OPCODE(vpalignr, VEX(256, 66, 0F3A, IG, 0x0f), AVX2, WRRR, Vqq, Hqq,
Wqq, Ib)
>  OPCODE(packsswb, LEG(NP, 0F, 0, 0x63), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(packsswb, LEG(66, 0F, 0, 0x63), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpacksswb, VEX(128, 66, 0F, IG, 0x63), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpacksswb, VEX(256, 66, 0F, IG, 0x63), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(packssdw, LEG(NP, 0F, 0, 0x6b), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(packssdw, LEG(66, 0F, 0, 0x6b), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpackssdw, VEX(128, 66, 0F, IG, 0x6b), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpackssdw, VEX(256, 66, 0F, IG, 0x6b), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(packuswb, LEG(NP, 0F, 0, 0x67), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(packuswb, LEG(66, 0F, 0, 0x67), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpackuswb, VEX(128, 66, 0F, IG, 0x67), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpackuswb, VEX(256, 66, 0F, IG, 0x67), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(packusdw, LEG(66, 0F38, 0, 0x2b), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpackusdw, VEX(128, 66, 0F38, IG, 0x2b), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpackusdw, VEX(256, 66, 0F38, IG, 0x2b), AVX2, WRR, Vqq, Hqq, Wqq=
)
>  OPCODE(punpckhbw, LEG(NP, 0F, 0, 0x68), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(punpckhbw, LEG(66, 0F, 0, 0x68), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpunpckhbw, VEX(128, 66, 0F, IG, 0x68), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpunpckhbw, VEX(256, 66, 0F, IG, 0x68), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(punpckhwd, LEG(NP, 0F, 0, 0x69), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(punpckhwd, LEG(66, 0F, 0, 0x69), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpunpckhwd, VEX(128, 66, 0F, IG, 0x69), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpunpckhwd, VEX(256, 66, 0F, IG, 0x69), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(punpckhdq, LEG(NP, 0F, 0, 0x6a), MMX, WRR, Pq, Pq, Qq)
>  OPCODE(punpckhdq, LEG(66, 0F, 0, 0x6a), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpunpckhdq, VEX(128, 66, 0F, IG, 0x6a), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpunpckhdq, VEX(256, 66, 0F, IG, 0x6a), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(punpckhqdq, LEG(66, 0F, 0, 0x6d), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpunpckhqdq, VEX(128, 66, 0F, IG, 0x6d), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpunpckhqdq, VEX(256, 66, 0F, IG, 0x6d), AVX2, WRR, Vqq, Hqq, Wqq=
)
>  OPCODE(punpcklbw, LEG(NP, 0F, 0, 0x60), MMX, WRR, Pq, Pq, Qd)
>  OPCODE(punpcklbw, LEG(66, 0F, 0, 0x60), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpunpcklbw, VEX(128, 66, 0F, IG, 0x60), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpunpcklbw, VEX(256, 66, 0F, IG, 0x60), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(punpcklwd, LEG(NP, 0F, 0, 0x61), MMX, WRR, Pq, Pq, Qd)
>  OPCODE(punpcklwd, LEG(66, 0F, 0, 0x61), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpunpcklwd, VEX(128, 66, 0F, IG, 0x61), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpunpcklwd, VEX(256, 66, 0F, IG, 0x61), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(punpckldq, LEG(NP, 0F, 0, 0x62), MMX, WRR, Pq, Pq, Qd)
>  OPCODE(punpckldq, LEG(66, 0F, 0, 0x62), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpunpckldq, VEX(128, 66, 0F, IG, 0x62), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpunpckldq, VEX(256, 66, 0F, IG, 0x62), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(punpcklqdq, LEG(66, 0F, 0, 0x6c), SSE2, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpunpcklqdq, VEX(128, 66, 0F, IG, 0x6c), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpunpcklqdq, VEX(256, 66, 0F, IG, 0x6c), AVX2, WRR, Vqq, Hqq, Wqq=
)
>  OPCODE(unpcklps, LEG(NP, 0F, 0, 0x14), SSE, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vunpcklps, VEX(128, NP, 0F, IG, 0x14), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vunpcklps, VEX(256, NP, 0F, IG, 0x14), AVX, WRR, Vqq, Hqq, Wqq)
> @@ -1410,13 +1683,17 @@ OPCODE(vunpckhpd, VEX(256, 66, 0F, IG, 0x15),
AVX, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pshufb, LEG(NP, 0F38, 0, 0x00), SSSE3, WRR, Pq, Pq, Qq)
>  OPCODE(pshufb, LEG(66, 0F38, 0, 0x00), SSSE3, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpshufb, VEX(128, 66, 0F38, IG, 0x00), AVX, WRR, Vdq, Hdq, Wdq)
> +OPCODE(vpshufb, VEX(256, 66, 0F38, IG, 0x00), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(pshufw, LEG(NP, 0F, 0, 0x70), SSE, WRR, Pq, Qq, Ib)
>  OPCODE(pshuflw, LEG(F2, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
>  OPCODE(vpshuflw, VEX(128, F2, 0F, IG, 0x70), AVX, WRR, Vdq, Wdq, Ib)
> +OPCODE(vpshuflw, VEX(256, F2, 0F, IG, 0x70), AVX2, WRR, Vqq, Wqq, Ib)
>  OPCODE(pshufhw, LEG(F3, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
>  OPCODE(vpshufhw, VEX(128, F3, 0F, IG, 0x70), AVX, WRR, Vdq, Wdq, Ib)
> +OPCODE(vpshufhw, VEX(256, F3, 0F, IG, 0x70), AVX2, WRR, Vqq, Wqq, Ib)
>  OPCODE(pshufd, LEG(66, 0F, 0, 0x70), SSE2, WRR, Vdq, Wdq, Ib)
>  OPCODE(vpshufd, VEX(128, 66, 0F, IG, 0x70), AVX, WRR, Vdq, Wdq, Ib)
> +OPCODE(vpshufd, VEX(256, 66, 0F, IG, 0x70), AVX2, WRR, Vqq, Wqq, Ib)
>  OPCODE(shufps, LEG(NP, 0F, 0, 0xc6), SSE, WRRR, Vdq, Vdq, Wdq, Ib)
>  OPCODE(vshufps, VEX(128, NP, 0F, IG, 0xc6), AVX, WRRR, Vdq, Hdq, Wdq, Ib=
)
>  OPCODE(vshufps, VEX(256, NP, 0F, IG, 0xc6), AVX, WRRR, Vqq, Hqq, Wqq, Ib=
)
> @@ -1437,8 +1714,12 @@ OPCODE(vblendvpd, VEX(128, 66, 0F3A, 0, 0x4b),
AVX, WRRR, Vdq, Hdq, Wdq, Ldq)
>  OPCODE(vblendvpd, VEX(256, 66, 0F3A, 0, 0x4b), AVX, WRRR, Vqq, Hqq, Wqq,
Lqq)
>  OPCODE(pblendvb, LEG(66, 0F38, 0, 0x10), SSE4_1, WRR, Vdq, Vdq, Wdq)
>  OPCODE(vpblendvb, VEX(128, 66, 0F3A, 0, 0x4c), AVX, WRRR, Vdq, Hdq, Wdq,
Ldq)
> +OPCODE(vpblendvb, VEX(256, 66, 0F3A, 0, 0x4c), AVX2, WRRR, Vqq, Hqq,
Wqq, Lqq)
>  OPCODE(pblendw, LEG(66, 0F3A, 0, 0x0e), SSE4_1, WRRR, Vdq, Vdq, Wdq, Ib)
>  OPCODE(vpblendw, VEX(128, 66, 0F3A, IG, 0x0e), AVX, WRRR, Vdq, Hdq, Wdq,
Ib)
> +OPCODE(vpblendw, VEX(256, 66, 0F3A, IG, 0x0e), AVX2, WRRR, Vqq, Hqq,
Wqq, Ib)
> +OPCODE(vpblendd, VEX(128, 66, 0F3A, 0, 0x02), AVX2, WRRR, Vdq, Hdq, Wdq,
Ib)
> +OPCODE(vpblendd, VEX(256, 66, 0F3A, 0, 0x02), AVX2, WRRR, Vqq, Hqq, Wqq,
Ib)
>  OPCODE(insertps, LEG(66, 0F3A, 0, 0x21), SSE4_1, WRRR, Vdq, Vdq, Wd, Ib)
>  OPCODE(vinsertps, VEX(128, 66, 0F3A, IG, 0x21), AVX, WRRR, Vdq, Hdq, Wd,
Ib)
>  OPCODE(pinsrb, LEG(66, 0F3A, 0, 0x20), SSE4_1, WRRR, Vdq, Vdq, RdMb, Ib)
> @@ -1451,6 +1732,7 @@ OPCODE(vpinsrd, VEX(128, 66, 0F3A, 0, 0x22), AVX,
WRRR, Vdq, Hdq, Ed, Ib)
>  OPCODE(pinsrq, LEG(66, 0F3A, 1, 0x22), SSE4_1, WRRR, Vdq, Vdq, Eq, Ib)
>  OPCODE(vpinsrq, VEX(128, 66, 0F3A, 1, 0x22), AVX, WRRR, Vdq, Hdq, Eq, Ib=
)
>  OPCODE(vinsertf128, VEX(256, 66, 0F3A, 0, 0x18), AVX, WRRR, Vqq, Hqq,
Wdq, Ib)
> +OPCODE(vinserti128, VEX(256, 66, 0F3A, 0, 0x38), AVX2, WRRR, Vqq, Hqq,
Wdq, Ib)
>  OPCODE(extractps, LEG(66, 0F3A, 0, 0x17), SSE4_1, WRR, Ed, Vdq, Ib)
>  OPCODE(vextractps, VEX(128, 66, 0F3A, IG, 0x17), AVX, WRR, Ed, Vdq, Ib)
>  OPCODE(pextrb, LEG(66, 0F3A, 0, 0x14), SSE4_1, WRR, RdMb, Vdq, Ib)
> @@ -1468,11 +1750,24 @@ OPCODE(pextrw, LEG(66, 0F, 1, 0xc5), SSE2, WRR,
Gq, Udq, Ib)
>  OPCODE(vpextrw, VEX(128, 66, 0F, 0, 0xc5), AVX, WRR, Gd, Udq, Ib)
>  OPCODE(vpextrw, VEX(128, 66, 0F, 1, 0xc5), AVX, WRR, Gq, Udq, Ib)
>  OPCODE(vextractf128, VEX(256, 66, 0F3A, 0, 0x19), AVX, WRR, Wdq, Vqq, Ib=
)
> -OPCODE(vbroadcastss, VEX(128, 66, 0F38, 0, 0x18), AVX, WR, Vdq, Md)
> -OPCODE(vbroadcastss, VEX(256, 66, 0F38, 0, 0x18), AVX, WR, Vqq, Md)
> -OPCODE(vbroadcastsd, VEX(256, 66, 0F38, 0, 0x19), AVX, WR, Vqq, Mq)
> +OPCODE(vextracti128, VEX(256, 66, 0F3A, 0, 0x39), AVX2, WRR, Wdq, Vqq,
Ib)
> +OPCODE(vpbroadcastb, VEX(128, 66, 0F38, 0, 0x78), AVX2, WR, Vdq, Wb)
> +OPCODE(vpbroadcastb, VEX(256, 66, 0F38, 0, 0x78), AVX2, WR, Vqq, Wb)
> +OPCODE(vpbroadcastw, VEX(128, 66, 0F38, 0, 0x79), AVX2, WR, Vdq, Ww)
> +OPCODE(vpbroadcastw, VEX(256, 66, 0F38, 0, 0x79), AVX2, WR, Vqq, Ww)
> +OPCODE(vpbroadcastd, VEX(128, 66, 0F38, 0, 0x58), AVX2, WR, Vdq, Wd)
> +OPCODE(vpbroadcastd, VEX(256, 66, 0F38, 0, 0x58), AVX2, WR, Vqq, Wd)
> +OPCODE(vpbroadcastq, VEX(128, 66, 0F38, 0, 0x59), AVX2, WR, Vdq, Wq)
> +OPCODE(vpbroadcastq, VEX(256, 66, 0F38, 0, 0x59), AVX2, WR, Vqq, Wq)
> +OPCODE(vbroadcastss, VEX(128, 66, 0F38, 0, 0x18), AVX, WRR, Vdq, Wd,
modrm_mod)
> +OPCODE(vbroadcastss, VEX(256, 66, 0F38, 0, 0x18), AVX, WRR, Vqq, Wd,
modrm_mod)
> +OPCODE(vbroadcastsd, VEX(256, 66, 0F38, 0, 0x19), AVX, WRR, Vqq, Wq,
modrm_mod)
>  OPCODE(vbroadcastf128, VEX(256, 66, 0F38, 0, 0x1a), AVX, WR, Vqq, Mdq)
> +OPCODE(vbroadcasti128, VEX(256, 66, 0F38, 0, 0x5a), AVX2, WR, Vqq, Mdq)
>  OPCODE(vperm2f128, VEX(256, 66, 0F3A, 0, 0x06), AVX, WRRR, Vqq, Hqq,
Wqq, Ib)
> +OPCODE(vperm2i128, VEX(256, 66, 0F3A, 0, 0x46), AVX2, WRRR, Vqq, Hqq,
Wqq, Ib)
> +OPCODE(vpermd, VEX(256, 66, 0F38, 0, 0x36), AVX2, WRR, Vqq, Hqq, Wqq)
> +OPCODE(vpermps, VEX(256, 66, 0F38, 0, 0x16), AVX2, WRR, Vqq, Hqq, Wqq)
>  OPCODE(vpermilps, VEX(128, 66, 0F38, 0, 0x0c), AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vpermilps, VEX(256, 66, 0F38, 0, 0x0c), AVX, WRR, Vqq, Hqq, Wqq)
>  OPCODE(vpermilps, VEX(128, 66, 0F3A, 0, 0x04), AVX, WRR, Vdq, Wdq, Ib)
> @@ -1481,30 +1776,60 @@ OPCODE(vpermilpd, VEX(128, 66, 0F38, 0, 0x0d),
AVX, WRR, Vdq, Hdq, Wdq)
>  OPCODE(vpermilpd, VEX(256, 66, 0F38, 0, 0x0d), AVX, WRR, Vqq, Hqq, Wqq)
>  OPCODE(vpermilpd, VEX(128, 66, 0F3A, 0, 0x05), AVX, WRR, Vdq, Wdq, Ib)
>  OPCODE(vpermilpd, VEX(256, 66, 0F3A, 0, 0x05), AVX, WRR, Vqq, Wqq, Ib)
> +OPCODE(vpermq, VEX(256, 66, 0F3A, 1, 0x00), AVX2, WRR, Vqq, Wqq, Ib)
> +OPCODE(vpermpd, VEX(256, 66, 0F3A, 1, 0x01), AVX2, WRR, Vqq, Wqq, Ib)
> +OPCODE(vgatherdps, VEX(128, 66, 0F38, 0, 0x92), AVX2, WWRRR, Vdq, Hdq,
Vdq, MDdq, Hdq)
> +OPCODE(vgatherdps, VEX(256, 66, 0F38, 0, 0x92), AVX2, WWRRR, Vqq, Hqq,
Vqq, MDqq, Hqq)
> +OPCODE(vgatherdpd, VEX(128, 66, 0F38, 1, 0x92), AVX2, WWRRR, Vdq, Hdq,
Vdq, MDdq, Hdq)
> +OPCODE(vgatherdpd, VEX(256, 66, 0F38, 1, 0x92), AVX2, WWRRR, Vqq, Hqq,
Vqq, MDdq, Hqq)
> +OPCODE(vgatherqps, VEX(128, 66, 0F38, 0, 0x93), AVX2, WWRRR, Vdq, Hdq,
Vdq, MQdq, Hdq)
> +OPCODE(vgatherqps, VEX(256, 66, 0F38, 0, 0x93), AVX2, WWRRR, Vdq, Hdq,
Vdq, MQqq, Hdq)
> +OPCODE(vgatherqpd, VEX(128, 66, 0F38, 1, 0x93), AVX2, WWRRR, Vdq, Hdq,
Vdq, MQdq, Hdq)
> +OPCODE(vgatherqpd, VEX(256, 66, 0F38, 1, 0x93), AVX2, WWRRR, Vqq, Hqq,
Vqq, MQqq, Hqq)
> +OPCODE(vpgatherdd, VEX(128, 66, 0F38, 0, 0x90), AVX2, WWRRR, Vdq, Hdq,
Vdq, MDdq, Hdq)
> +OPCODE(vpgatherdd, VEX(256, 66, 0F38, 0, 0x90), AVX2, WWRRR, Vqq, Hqq,
Vqq, MDqq, Hqq)
> +OPCODE(vpgatherdq, VEX(128, 66, 0F38, 1, 0x90), AVX2, WWRRR, Vdq, Hdq,
Vdq, MDdq, Hdq)
> +OPCODE(vpgatherdq, VEX(256, 66, 0F38, 1, 0x90), AVX2, WWRRR, Vqq, Hqq,
Vqq, MDdq, Hqq)
> +OPCODE(vpgatherqd, VEX(128, 66, 0F38, 0, 0x91), AVX2, WWRRR, Vdq, Hdq,
Vdq, MQdq, Hdq)
> +OPCODE(vpgatherqd, VEX(256, 66, 0F38, 0, 0x91), AVX2, WWRRR, Vdq, Hdq,
Vdq, MQqq, Hdq)
> +OPCODE(vpgatherqq, VEX(128, 66, 0F38, 1, 0x91), AVX2, WWRRR, Vdq, Hdq,
Vdq, MQdq, Hdq)
> +OPCODE(vpgatherqq, VEX(256, 66, 0F38, 1, 0x91), AVX2, WWRRR, Vqq, Hqq,
Vqq, MQqq, Hqq)
>  OPCODE(pmovsxbw, LEG(66, 0F38, 0, 0x20), SSE4_1, WR, Vdq, Wq)
>  OPCODE(vpmovsxbw, VEX(128, 66, 0F38, IG, 0x20), AVX, WR, Vdq, Wq)
> +OPCODE(vpmovsxbw, VEX(256, 66, 0F38, IG, 0x20), AVX2, WR, Vqq, Wdq)
>  OPCODE(pmovsxbd, LEG(66, 0F38, 0, 0x21), SSE4_1, WR, Vdq, Wd)
>  OPCODE(vpmovsxbd, VEX(128, 66, 0F38, IG, 0x21), AVX, WR, Vdq, Wd)
> +OPCODE(vpmovsxbd, VEX(256, 66, 0F38, IG, 0x21), AVX2, WR, Vqq, Wq)
>  OPCODE(pmovsxbq, LEG(66, 0F38, 0, 0x22), SSE4_1, WR, Vdq, Ww)
>  OPCODE(vpmovsxbq, VEX(128, 66, 0F38, IG, 0x22), AVX, WR, Vdq, Ww)
> +OPCODE(vpmovsxbq, VEX(256, 66, 0F38, IG, 0x22), AVX2, WR, Vqq, Wd)
>  OPCODE(pmovsxwd, LEG(66, 0F38, 0, 0x23), SSE4_1, WR, Vdq, Wq)
>  OPCODE(vpmovsxwd, VEX(128, 66, 0F38, IG, 0x23), AVX, WR, Vdq, Wq)
> +OPCODE(vpmovsxwd, VEX(256, 66, 0F38, IG, 0x23), AVX2, WR, Vqq, Wdq)
>  OPCODE(pmovsxwq, LEG(66, 0F38, 0, 0x24), SSE4_1, WR, Vdq, Wd)
>  OPCODE(vpmovsxwq, VEX(128, 66, 0F38, IG, 0x24), AVX, WR, Vdq, Wd)
> +OPCODE(vpmovsxwq, VEX(256, 66, 0F38, IG, 0x24), AVX2, WR, Vqq, Wq)
>  OPCODE(pmovsxdq, LEG(66, 0F38, 0, 0x25), SSE4_1, WR, Vdq, Wq)
>  OPCODE(vpmovsxdq, VEX(128, 66, 0F38, IG, 0x25), AVX, WR, Vdq, Wq)
> +OPCODE(vpmovsxdq, VEX(256, 66, 0F38, IG, 0x25), AVX2, WR, Vqq, Wdq)
>  OPCODE(pmovzxbw, LEG(66, 0F38, 0, 0x30), SSE4_1, WR, Vdq, Wq)
>  OPCODE(vpmovzxbw, VEX(128, 66, 0F38, IG, 0x30), AVX, WR, Vdq, Wq)
> +OPCODE(vpmovzxbw, VEX(256, 66, 0F38, IG, 0x30), AVX2, WR, Vqq, Wdq)
>  OPCODE(pmovzxbd, LEG(66, 0F38, 0, 0x31), SSE4_1, WR, Vdq, Wd)
>  OPCODE(vpmovzxbd, VEX(128, 66, 0F38, IG, 0x31), AVX, WR, Vdq, Wd)
> +OPCODE(vpmovzxbd, VEX(256, 66, 0F38, IG, 0x31), AVX2, WR, Vqq, Wq)
>  OPCODE(pmovzxbq, LEG(66, 0F38, 0, 0x32), SSE4_1, WR, Vdq, Ww)
>  OPCODE(vpmovzxbq, VEX(128, 66, 0F38, IG, 0x32), AVX, WR, Vdq, Ww)
> +OPCODE(vpmovzxbq, VEX(256, 66, 0F38, IG, 0x32), AVX2, WR, Vqq, Wd)
>  OPCODE(pmovzxwd, LEG(66, 0F38, 0, 0x33), SSE4_1, WR, Vdq, Wq)
>  OPCODE(vpmovzxwd, VEX(128, 66, 0F38, IG, 0x33), AVX, WR, Vdq, Wq)
> +OPCODE(vpmovzxwd, VEX(256, 66, 0F38, IG, 0x33), AVX2, WR, Vqq, Wdq)
>  OPCODE(pmovzxwq, LEG(66, 0F38, 0, 0x34), SSE4_1, WR, Vdq, Wd)
>  OPCODE(vpmovzxwq, VEX(128, 66, 0F38, IG, 0x34), AVX, WR, Vdq, Wd)
> +OPCODE(vpmovzxwq, VEX(256, 66, 0F38, IG, 0x34), AVX2, WR, Vqq, Wq)
>  OPCODE(pmovzxdq, LEG(66, 0F38, 0, 0x35), SSE4_1, WR, Vdq, Wq)
>  OPCODE(vpmovzxdq, VEX(128, 66, 0F38, IG, 0x35), AVX, WR, Vdq, Wq)
> +OPCODE(vpmovzxdq, VEX(256, 66, 0F38, IG, 0x35), AVX2, WR, Vqq, Wdq)
>  OPCODE(cvtpi2ps, LEG(NP, 0F, 0, 0x2a), SSE, WR, Vdq, Qq)
>  OPCODE(cvtsi2ss, LEG(F3, 0F, 0, 0x2a), SSE, WR, Vd, Ed)
>  OPCODE(cvtsi2ss, LEG(F3, 0F, 1, 0x2a), SSE, WR, Vd, Eq)
> @@ -1574,6 +1899,14 @@ OPCODE(vmaskmovpd, VEX(128, 66, 0F38, 0, 0x2d),
AVX, WRR, Vdq, Hdq, Mdq)
>  OPCODE(vmaskmovpd, VEX(128, 66, 0F38, 0, 0x2f), AVX, WRR, Mdq, Hdq, Vdq)
>  OPCODE(vmaskmovpd, VEX(256, 66, 0F38, 0, 0x2d), AVX, WRR, Vqq, Hqq, Mqq)
>  OPCODE(vmaskmovpd, VEX(256, 66, 0F38, 0, 0x2f), AVX, WRR, Mqq, Hqq, Vqq)
> +OPCODE(vpmaskmovd, VEX(128, 66, 0F38, 0, 0x8c), AVX2, WRR, Vdq, Hdq, Mdq=
)
> +OPCODE(vpmaskmovd, VEX(128, 66, 0F38, 0, 0x8e), AVX2, WRR, Mdq, Hdq, Vdq=
)
> +OPCODE(vpmaskmovd, VEX(256, 66, 0F38, 0, 0x8c), AVX2, WRR, Vqq, Hqq, Mqq=
)
> +OPCODE(vpmaskmovd, VEX(256, 66, 0F38, 0, 0x8e), AVX2, WRR, Mqq, Hqq, Vqq=
)
> +OPCODE(vpmaskmovq, VEX(128, 66, 0F38, 1, 0x8c), AVX2, WRR, Vdq, Hdq, Mdq=
)
> +OPCODE(vpmaskmovq, VEX(128, 66, 0F38, 1, 0x8e), AVX2, WRR, Mdq, Hdq, Vdq=
)
> +OPCODE(vpmaskmovq, VEX(256, 66, 0F38, 1, 0x8c), AVX2, WRR, Vqq, Hqq, Mqq=
)
> +OPCODE(vpmaskmovq, VEX(256, 66, 0F38, 1, 0x8e), AVX2, WRR, Mqq, Hqq, Vqq=
)
>  OPCODE(movntps, LEG(NP, 0F, 0, 0x2b), SSE, WR, Mdq, Vdq)
>  OPCODE(vmovntps, VEX(128, NP, 0F, IG, 0x2b), AVX, WR, Mdq, Vdq)
>  OPCODE(vmovntps, VEX(256, NP, 0F, IG, 0x2b), AVX, WR, Mqq, Vqq)
> @@ -1588,6 +1921,7 @@ OPCODE(vmovntdq, VEX(128, 66, 0F, IG, 0xe7), AVX,
WR, Mdq, Vdq)
>  OPCODE(vmovntdq, VEX(256, 66, 0F, IG, 0xe7), AVX, WR, Mqq, Vqq)
>  OPCODE(movntdqa, LEG(66, 0F38, 0, 0x2a), SSE4_1, WR, Vdq, Mdq)
>  OPCODE(vmovntdqa, VEX(128, 66, 0F38, IG, 0x2a), AVX, WR, Vdq, Mdq)
> +OPCODE(vmovntdqa, VEX(256, 66, 0F38, IG, 0x2a), AVX2, WR, Vqq, Mqq)
>  OPCODE(pause, LEG(F3, NA, 0, 0x90), SSE2, )
>  OPCODE(emms, LEG(NP, 0F, 0, 0x77), MMX, )
>  OPCODE(vzeroupper, VEX(128, NP, 0F, IG, 0x77), AVX, )
> @@ -1614,6 +1948,13 @@ OPCODE_GRP_BEGIN(grp12_VEX_128_66)
>      OPCODE_GRPMEMB(grp12_VEX_128_66, vpsraw, 4, AVX, WRR, Hdq, Udq, Ib)
>  OPCODE_GRP_END(grp12_VEX_128_66)
>
> +OPCODE_GRP(grp12_VEX_256_66, VEX(256, 66, 0F, IG, 0x71))
> +OPCODE_GRP_BEGIN(grp12_VEX_256_66)
> +    OPCODE_GRPMEMB(grp12_VEX_256_66, vpsllw, 6, AVX2, WRR, Hqq, Uqq, Ib)
> +    OPCODE_GRPMEMB(grp12_VEX_256_66, vpsrlw, 2, AVX2, WRR, Hqq, Uqq, Ib)
> +    OPCODE_GRPMEMB(grp12_VEX_256_66, vpsraw, 4, AVX2, WRR, Hqq, Uqq, Ib)
> +OPCODE_GRP_END(grp12_VEX_256_66)
> +
>  OPCODE_GRP(grp13_LEG_66, LEG(66, 0F, 0, 0x72))
>  OPCODE_GRP_BEGIN(grp13_LEG_66)
>      OPCODE_GRPMEMB(grp13_LEG_66, pslld, 6, SSE2, WRR, Udq, Udq, Ib)
> @@ -1635,6 +1976,13 @@ OPCODE_GRP_BEGIN(grp13_VEX_128_66)
>      OPCODE_GRPMEMB(grp13_VEX_128_66, vpsrad, 4, AVX, WRR, Hdq, Udq, Ib)
>  OPCODE_GRP_END(grp13_VEX_128_66)
>
> +OPCODE_GRP(grp13_VEX_256_66, VEX(256, 66, 0F, IG, 0x72))
> +OPCODE_GRP_BEGIN(grp13_VEX_256_66)
> +    OPCODE_GRPMEMB(grp13_VEX_256_66, vpslld, 6, AVX2, WRR, Hqq, Uqq, Ib)
> +    OPCODE_GRPMEMB(grp13_VEX_256_66, vpsrld, 2, AVX2, WRR, Hqq, Uqq, Ib)
> +    OPCODE_GRPMEMB(grp13_VEX_256_66, vpsrad, 4, AVX2, WRR, Hqq, Uqq, Ib)
> +OPCODE_GRP_END(grp13_VEX_256_66)
> +
>  OPCODE_GRP(grp14_LEG_66, LEG(66, 0F, 0, 0x73))
>  OPCODE_GRP_BEGIN(grp14_LEG_66)
>      OPCODE_GRPMEMB(grp14_LEG_66, psllq, 6, SSE2, WRR, Udq, Udq, Ib)
> @@ -1657,6 +2005,14 @@ OPCODE_GRP_BEGIN(grp14_VEX_128_66)
>      OPCODE_GRPMEMB(grp14_VEX_128_66, vpsrldq, 3, AVX, WRR, Hdq, Udq, Ib)
>  OPCODE_GRP_END(grp14_VEX_128_66)
>
> +OPCODE_GRP(grp14_VEX_256_66, VEX(256, 66, 0F, IG, 0x73))
> +OPCODE_GRP_BEGIN(grp14_VEX_256_66)
> +    OPCODE_GRPMEMB(grp14_VEX_256_66, vpsllq, 6, AVX2, WRR, Hqq, Uqq, Ib)
> +    OPCODE_GRPMEMB(grp14_VEX_256_66, vpslldq, 7, AVX2, WRR, Hqq, Uqq, Ib=
)
> +    OPCODE_GRPMEMB(grp14_VEX_256_66, vpsrlq, 2, AVX2, WRR, Hqq, Uqq, Ib)
> +    OPCODE_GRPMEMB(grp14_VEX_256_66, vpsrldq, 3, AVX2, WRR, Hqq, Uqq, Ib=
)
> +OPCODE_GRP_END(grp14_VEX_256_66)
> +
>  OPCODE_GRP(grp15_LEG_NP, LEG(NP, 0F, 0, 0xae))
>  OPCODE_GRP_BEGIN(grp15_LEG_NP)
>      OPCODE_GRPMEMB(grp15_LEG_NP, sfence_clflush, 7, SSE, RR, modrm_mod,
modrm)
> --
> 2.20.1
>
>
