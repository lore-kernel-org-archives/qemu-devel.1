Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC04EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C4D206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ED25fFzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C4D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCi5N-0005nG-PX
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 07:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCi4o-0005Ob-Dy
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCi4n-0008Ec-1V
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:02:02 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCi4m-0008CS-QL
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:02:00 -0400
Received: by mail-oi1-x243.google.com with SMTP id d62so8840684oia.11
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VigoVHca70TvAPFaPktE/7Y2kQt1HIxeUPy2QgHQcQ0=;
 b=ED25fFzXMQEPT5qNW5RbhLgB9yn1gdKTlU0JwJTG0470d69nWxoKi+XWUzvJrJbFgq
 wS+CP4dkpoM5ylmpzpOiNei1yJ05/hChipxgLd+dfJKeRIF3Ag3y4llbFgOaehaH+96z
 SyrcHsABvCUvx1TwNQW//bLMTr3HrzxIIMoV0pKvDp1+9yMxgus3ITTDpS0UU3gJFsJ7
 ssETtcNdGLZZktZfXM5uJ075JJnO3SKwwk4QL5iVnqbvmLFbSMWsTyjqEgRHmKV9tTwV
 oHQgFmdkZrZoNERc2OdHFQBCnvHTueZ6eEou/RVhVEaldomGfGKRLxg9gFQtm1wCsu/5
 4VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VigoVHca70TvAPFaPktE/7Y2kQt1HIxeUPy2QgHQcQ0=;
 b=Z0orlXQIG8pPNuIKuHtgcsz7wsPDUZxTm6uKnJReyIIxbb9i3FFnTrgsq6uw8hXB9T
 14Ox00MSGkVA+FZMGL88nIXCHdsORqabQMbM9JPV5CY+FbweDudNiMANGzVCT5ePcCsl
 noAQF4RJC664qkSyxya1cMQ8h6JykhiEUEYs3UH55LWWPBPByP79GeOwS+DLv4rItDJ2
 rmqX3UV8TffLQJG6y9JeklfUQOXLBjoJCAqhUb45+vqkfaGaSMI63ZCGNi06UJPoh/C/
 gEqc9wc2T0cLw6t7Qc/CDj0ar7YN7pw9bTk9vzEaXPjlHkxj6Bn6+eCsa4Yx7ZxMdfdb
 c8Gg==
X-Gm-Message-State: ANhLgQ2qqysxtqmckHVtxDg7zzm0qUoVutbiWTt/b5B5geceJisjkMNB
 5Y0XLzbfvJ0g16kyKUZIU2vqIBNCZmHOAbj1Kda99A==
X-Google-Smtp-Source: ADFU+vtP5qdz+q+eDUF/X34oBHhSAZJizHH8lBGPFWGbBaw2+/okp6+x/q6vPCEtM54mmtboXFm8F/YNn2kJySasT8w=
X-Received: by 2002:aca:c608:: with SMTP id w8mr6559640oif.163.1584097319606; 
 Fri, 13 Mar 2020 04:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200214004753.15736-1-f4bug@amsat.org>
In-Reply-To: <20200214004753.15736-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 11:01:48 +0000
Message-ID: <CAFEAcA9CdtrbTTFAkngP90jNaSALVN2svOx75qLORhLKGUoUUA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/i82596: Correct command bitmask (CID 1419392)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Jason Wang <jasowang@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 00:48, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The command is 32-bit, but we are loading the 16 upper bits with
> the 'get_uint16(s->scb + 2)' call.
>
> Once shifted by 16, the command bits match the status bits:
>
> - Command
>   Bit 31 ACK-CX   Acknowledges that the CU completed an Action Command.
>   Bit 30 ACK-FR   Acknowledges that the RU received a frame.
>   Bit 29 ACK-CNA  Acknowledges that the Command Unit became not active.
>   Bit 28 ACK-RNR  Acknowledges that the Receive Unit became not ready.
>
> - Status
>   Bit 15 CX       The CU finished executing a command with its I(interrup=
t) bit set.
>   Bit 14 FR       The RU finished receiving a frame.
>   Bit 13 CNA      The Command Unit left the Active state.
>   Bit 12 RNR      The Receive Unit left the Ready state.
>
> Add the SCB_COMMAND_ACK_MASK definition to simplify the code.
>
> This fixes Coverity 1419392 (CONSTANT_EXPRESSION_RESULT):
>
>   /hw/net/i82596.c: 352 in examine_scb()
>   346         cuc =3D (command >> 8) & 0x7;
>   347         ruc =3D (command >> 4) & 0x7;
>   348         DBG(printf("MAIN COMMAND %04x  cuc %02x ruc %02x\n", comman=
d, cuc, ruc));
>   349         /* and clear the scb command word */
>   350         set_uint16(s->scb + 2, 0);
>   351
>   >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
>   >>>     "command & (2147483648UL /* 1UL << 31 */)" is always 0 regardle=
ss of the values of its operands. This occurs as the logical operand of "if=
".
>   352         if (command & BIT(31))      /* ACK-CX */
>   353             s->scb_status &=3D ~SCB_STATUS_CX;
>   >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
>   >>>     "command & (1073741824UL /* 1UL << 30 */)" is always 0 regardle=
ss of the values of its operands. This occurs as the logical operand of "if=
".
>   354         if (command & BIT(30))      /*ACK-FR */
>   355             s->scb_status &=3D ~SCB_STATUS_FR;
>   >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
>   >>>     "command & (536870912UL /* 1UL << 29 */)" is always 0 regardles=
s of the values of its operands. This occurs as the logical operand of "if"=
.
>   356         if (command & BIT(29))      /*ACK-CNA */
>   357             s->scb_status &=3D ~SCB_STATUS_CNA;
>   >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
>   >>>     "command & (268435456UL /* 1UL << 28 */)" is always 0 regardles=
s of the values of its operands. This occurs as the logical operand of "if"=
.
>   358         if (command & BIT(28))      /*ACK-RNR */
>   359             s->scb_status &=3D ~SCB_STATUS_RNR;
>
> Fixes: Covertiy CID 1419392 (commit 376b851909)

("Coverity")

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Jason, are you planning to pick this one up?

thanks
-- PMM

