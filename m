Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8A4C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6699B20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MibMugrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6699B20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Prm-0000k2-K9
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Pqs-0008N5-Ng
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Pqq-0002JN-Ek
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:20:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Pqp-0002IR-AX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581405654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4AV1CUQHtsVrSnLDkaG768reuiX9koGgA/JZEzm7GqM=;
 b=MibMugrC/L4SiMC6IVm1MuwRFuFGRdPJt2v8zu/N2loSe8YmWBA6e6xkouXJ2khvQZw8Ao
 lzsMUr81V/2TCYB6LPVLgeCQfA21Hk82l4Unb3mrSfU8OWRwxpQ3lKF3lz199uwVoWYlgc
 b7EgbWe2qIXEPmDLdqmzM3ONB9iZ6J4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-EFsqAoj9NT6wsnWqTZazyQ-1; Tue, 11 Feb 2020 02:20:52 -0500
Received: by mail-wr1-f70.google.com with SMTP id a12so6426727wrn.19
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4AV1CUQHtsVrSnLDkaG768reuiX9koGgA/JZEzm7GqM=;
 b=b6iC7OazIlYftAII92FP3+vTtsEFpKB5XkOvImUPRrCMkhs7x4mHZJ4WfLamDMQ+9r
 80CF4IrEAJr4vd7Uo2wJ9z7xfYnz/iOSwP1+y01MSkrBexk+JvXWFqShhnSjSe6k7RqW
 omZM2LxIpa9cEu6ZKLKoGgEh+pBkt8xa+LXo5KSjJvHgg22CZpPqiZ3ZgWfGqAmjy+jp
 0J0s1PT3SHe9+EHe34K82fxAqfBccFDtrYV2oo3cdS2hhfe6lFNB3HxqiqFI0zxkTycY
 k9eJeFm8aQv7Svln9lUJl4p/Cp8Xr8W/XWcXXZ4c/xiWZXsTbF1jD78tszi/kttSBNCX
 4OAQ==
X-Gm-Message-State: APjAAAUe5inj70zGBjBEESC82q2zEFOr0B6UrNs2804rCQ1xM/hnU3/d
 2FGqOBAxk1fRSpoOv7MJrTk+wH6sP84427fdtCWRV12lGCwFvg5gFaOER0ElqqIUe15Wt2qHhZm
 pp2S/bLOVwgpd+cc=
X-Received: by 2002:a5d:410e:: with SMTP id l14mr6510840wrp.238.1581405650858; 
 Mon, 10 Feb 2020 23:20:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRhvNALuLVJaCIsJ8xDo0dY9UVjjCYfQ3rwZWgykwwRmPZyARIbo7BoFVl1upcoAOkPiVH7A==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr6510782wrp.238.1581405650350; 
 Mon, 10 Feb 2020 23:20:50 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g17sm4072996wru.13.2020.02.10.23.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:20:49 -0800 (PST)
Subject: Re: [RFC PATCH 05/66] Hexagon Disassembler
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-6-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9783f836-fe69-ef8a-bde9-eb1db2f66d77@redhat.com>
Date: Tue, 11 Feb 2020 08:20:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-6-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: EFsqAoj9NT6wsnWqTZazyQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:39 AM, Taylor Simpson wrote:
> The Hexagon disassembler calls disassemble_hexagon to decode a packet
> and format it for printing
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   disas/Makefile.objs     |  1 +
>   disas/hexagon.c         | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
>   include/disas/dis-asm.h |  1 +
>   3 files changed, 58 insertions(+)
>   create mode 100644 disas/hexagon.c
> 
> diff --git a/disas/Makefile.objs b/disas/Makefile.objs
> index 3c1cdce..0e86964 100644
> --- a/disas/Makefile.objs
> +++ b/disas/Makefile.objs
> @@ -24,6 +24,7 @@ common-obj-$(CONFIG_SH4_DIS) += sh4.o
>   common-obj-$(CONFIG_SPARC_DIS) += sparc.o
>   common-obj-$(CONFIG_LM32_DIS) += lm32.o
>   common-obj-$(CONFIG_XTENSA_DIS) += xtensa.o
> +common-obj-$(CONFIG_HEXAGON_DIS) += hexagon.o
>   
>   # TODO: As long as the TCG interpreter and its generated code depend
>   # on the QEMU target, we cannot compile the disassembler here.
> diff --git a/disas/hexagon.c b/disas/hexagon.c
> new file mode 100644
> index 0000000..fd9af10
> --- /dev/null
> +++ b/disas/hexagon.c
> @@ -0,0 +1,56 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * QEMU Hexagon Disassembler
> + */
> +
> +#include "qemu/osdep.h"
> +#include "disas/dis-asm.h"
> +#include "target/hexagon/cpu_bits.h"
> +
> +int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
> +{
> +    uint32_t words[PACKET_WORDS_MAX];
> +    int len, slen;
> +    char buf[1028];

Why 1028?

> +    int status;
> +    int i;
> +
> +    for (i = 0; i < PACKET_WORDS_MAX; i++) {
> +        status = (*info->read_memory_func)(memaddr + i * sizeof(uint32_t),
> +                                           (bfd_byte *)&words[i],
> +                                           sizeof(uint32_t), info);
> +        if (status) {
> +            if (i > 0) {
> +                break;
> +            }
> +            (*info->memory_error_func)(status, memaddr, info);
> +            return status;
> +        }
> +    }
> +
> +    len = disassemble_hexagon(words, i, buf, 1028);

1028 -> sizeof(buf)

> +    slen = strlen(buf);
> +    if (buf[slen - 1] == '\n') {
> +        buf[slen - 1] = '\0';
> +    }
> +    (*info->fprintf_func)(info->stream, "%s", buf);
> +
> +    return len;
> +}
> +
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index f87f468..a7fa82d 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -436,6 +436,7 @@ int print_insn_little_nios2     (bfd_vma, disassemble_info*);
>   int print_insn_xtensa           (bfd_vma, disassemble_info*);
>   int print_insn_riscv32          (bfd_vma, disassemble_info*);
>   int print_insn_riscv64          (bfd_vma, disassemble_info*);
> +int print_insn_hexagon          (bfd_vma, disassemble_info*);
>   
>   #if 0
>   /* Fetch the disassembler for a given BFD, if that support is available.  */
> 


