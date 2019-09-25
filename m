Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46300C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152EE21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hsr4vVyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152EE21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9Ro-0008RB-CB
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iD8wB-0001fb-0P
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iD8w9-0007KF-N7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:10:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46260
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iD8w9-0007Js-JL
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569424237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=7MEWNQSOIRLz3EnplHHi7HZEANrG8mAVhO9wmv5Rkd0=;
 b=Hsr4vVyoGnH0Ogm0nXcwbYhLqZbP+Bi7sA9Qawnblm7X63xrGMvHjbJotTHZ2SAK5sPYg2
 qCFseC50NGsjrE8PimqYPFtWW/IKw5y3OBcL1HdriZjunWcaXhgVOQDRUXYL8jK34dI98Z
 Djq1ieqids+T7UyKg3+mBfzsFFKlKBo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-Ai6jZfmtNTCZZaS0QKbuYA-1; Wed, 25 Sep 2019 11:10:35 -0400
Received: by mail-wm1-f72.google.com with SMTP id j125so2337619wmj.6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RzdNIAnlQjsk+r7lP6jU9PiomePHq5DuJcoE/NUlFKs=;
 b=eci5LypLR42pem4rCkPbIfFZS2oe0D60R5p/SihTd0X/bgGDTwt9OOy3XWD2BXsNeD
 QwC0uK1d5VyZU+3Wd/k/cFMUuqFPFIRaGAbHXOf+pulLL1TiWfIzTOSnMSqVEhA+jzpU
 rPgjRu+WxlMVex562pXT0HdQr5hfz7gEB8unT28oBg2kETi7OZ7FKQ+bYLNxmCjZYIPY
 VR32QYd/7NJMyzW0tHum50+xnoOCDyLcyUIosGgOWr0z+OINqT509DvbpKN2RH6+diLb
 bGXIPZdAMTsFM/2sHE4NTGQhfWLcexfXx8MRprJiYK/vGIw+WdpoJW0HQHyGaYS0I76o
 qHoA==
X-Gm-Message-State: APjAAAXZTIh055GmEQRkjnEm5jRnwqDRd6rv2Dk4S+4d1KoMOa2WCP5K
 m/NKYW/vccovJ29X4/byjuwE9ANjg5DoPFm/DnqdPajnVvITQFKnW9C9BBUdYcqy1KW6d7TU96T
 Ei1pJEkrx3mLE59g=
X-Received: by 2002:adf:fb87:: with SMTP id a7mr9295900wrr.370.1569424234191; 
 Wed, 25 Sep 2019 08:10:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy94JmsTcFMOjr7D1KsKOru5uOoT98a2lsKk070Bx35qRpxlFJRX3JsuPsvyU5re2QB4eCBiA==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr9295878wrr.370.1569424233969; 
 Wed, 25 Sep 2019 08:10:33 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id r18sm5370645wme.48.2019.09.25.08.10.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 08:10:33 -0700 (PDT)
Subject: Re: [PATCH v2 04/20] target/mips: Clean up mips-defs.h
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1569415572-19635-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7109aad7-e61e-fc0e-8fcb-2aa297f0cda5@redhat.com>
Date: Wed, 25 Sep 2019 17:10:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1569415572-19635-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-MC-Unique: Ai6jZfmtNTCZZaS0QKbuYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: arikalo@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 9/25/19 2:45 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
>=20
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/mips-defs.h | 53 ++++++++++++++++++++++++++-----------------=
------
>  1 file changed, 28 insertions(+), 25 deletions(-)
>=20
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index bbf056a..938c0de 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -2,7 +2,7 @@
>  #define QEMU_MIPS_DEFS_H
> =20
>  /* If we want to use host float regs... */
> -//#define USE_HOST_FLOAT_REGS
> +/* #define USE_HOST_FLOAT_REGS */

I'd use the same block comment for the description and the commented
USE_HOST_FLOAT_REGS, like you did with MIPS_STRICT_STANDARD below.

Anyway, with or without this change:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> =20
>  /* Real pages are variable size... */
>  #define MIPS_TLB_MAX 128
> @@ -57,43 +57,46 @@
>  #define ASE_MXU           0x0200000000000000ULL
> =20
>  /* MIPS CPU defines. */
> -#define=09=09CPU_MIPS1=09(ISA_MIPS1)
> -#define=09=09CPU_MIPS2=09(CPU_MIPS1 | ISA_MIPS2)
> -#define=09=09CPU_MIPS3=09(CPU_MIPS2 | ISA_MIPS3)
> -#define=09=09CPU_MIPS4=09(CPU_MIPS3 | ISA_MIPS4)
> -#define=09=09CPU_VR54XX=09(CPU_MIPS4 | INSN_VR54XX)
> -#define         CPU_R5900       (CPU_MIPS3 | INSN_R5900)
> -#define=09=09CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
> -#define=09=09CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
> +#define CPU_MIPS1       (ISA_MIPS1)
> +#define CPU_MIPS2       (CPU_MIPS1 | ISA_MIPS2)
> +#define CPU_MIPS3       (CPU_MIPS2 | ISA_MIPS3)
> +#define CPU_MIPS4       (CPU_MIPS3 | ISA_MIPS4)
> +#define CPU_VR54XX      (CPU_MIPS4 | INSN_VR54XX)
> +#define CPU_R5900       (CPU_MIPS3 | INSN_R5900)
> +#define CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
> +#define CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
> =20
> -#define=09=09CPU_MIPS5=09(CPU_MIPS4 | ISA_MIPS5)
> +#define CPU_MIPS5       (CPU_MIPS4 | ISA_MIPS5)
> =20
>  /* MIPS Technologies "Release 1" */
> -#define=09=09CPU_MIPS32=09(CPU_MIPS2 | ISA_MIPS32)
> -#define=09=09CPU_MIPS64=09(CPU_MIPS5 | CPU_MIPS32 | ISA_MIPS64)
> +#define CPU_MIPS32      (CPU_MIPS2 | ISA_MIPS32)
> +#define CPU_MIPS64      (CPU_MIPS5 | CPU_MIPS32 | ISA_MIPS64)
> =20
>  /* MIPS Technologies "Release 2" */
> -#define=09=09CPU_MIPS32R2=09(CPU_MIPS32 | ISA_MIPS32R2)
> -#define=09=09CPU_MIPS64R2=09(CPU_MIPS64 | CPU_MIPS32R2 | ISA_MIPS64R2)
> +#define CPU_MIPS32R2    (CPU_MIPS32 | ISA_MIPS32R2)
> +#define CPU_MIPS64R2    (CPU_MIPS64 | CPU_MIPS32R2 | ISA_MIPS64R2)
> =20
>  /* MIPS Technologies "Release 3" */
> -#define CPU_MIPS32R3 (CPU_MIPS32R2 | ISA_MIPS32R3)
> -#define CPU_MIPS64R3 (CPU_MIPS64R2 | CPU_MIPS32R3 | ISA_MIPS64R3)
> +#define CPU_MIPS32R3    (CPU_MIPS32R2 | ISA_MIPS32R3)
> +#define CPU_MIPS64R3    (CPU_MIPS64R2 | CPU_MIPS32R3 | ISA_MIPS64R3)
> =20
>  /* MIPS Technologies "Release 5" */
> -#define CPU_MIPS32R5 (CPU_MIPS32R3 | ISA_MIPS32R5)
> -#define CPU_MIPS64R5 (CPU_MIPS64R3 | CPU_MIPS32R5 | ISA_MIPS64R5)
> +#define CPU_MIPS32R5    (CPU_MIPS32R3 | ISA_MIPS32R5)
> +#define CPU_MIPS64R5    (CPU_MIPS64R3 | CPU_MIPS32R5 | ISA_MIPS64R5)
> =20
>  /* MIPS Technologies "Release 6" */
> -#define CPU_MIPS32R6 (CPU_MIPS32R5 | ISA_MIPS32R6)
> -#define CPU_MIPS64R6 (CPU_MIPS64R5 | CPU_MIPS32R6 | ISA_MIPS64R6)
> +#define CPU_MIPS32R6    (CPU_MIPS32R5 | ISA_MIPS32R6)
> +#define CPU_MIPS64R6    (CPU_MIPS64R5 | CPU_MIPS32R6 | ISA_MIPS64R6)
> =20
>  /* Wave Computing: "nanoMIPS" */
> -#define CPU_NANOMIPS32 (CPU_MIPS32R6 | ISA_NANOMIPS32)
> +#define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
> =20
> -/* Strictly follow the architecture standard:
> -   - Disallow "special" instruction handling for PMON/SPIM.
> -   Note that we still maintain Count/Compare to match the host clock. */
> -//#define MIPS_STRICT_STANDARD 1
> +/*
> + * Strictly follow the architecture standard:
> + * - Disallow "special" instruction handling for PMON/SPIM.
> + * Note that we still maintain Count/Compare to match the host clock.
> + *
> + * #define MIPS_STRICT_STANDARD 1
> + */
> =20
>  #endif /* QEMU_MIPS_DEFS_H */
>=20


