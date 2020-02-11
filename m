Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8EAC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97981206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvltbHQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97981206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1QAz-0004UM-R7
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1QAE-0003FL-1u
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1QAC-0006BD-9a
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:40:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1QAC-0006Ai-4d
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581406855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zVirhvmPouX0smYT5feIyfQrsKLglM/q5GUTkG+kr4=;
 b=RvltbHQn+ipoA7gYXe5mr1tuOnFJeZvN8qrekZpd24NrZbW3US0bir9ZAKHF7b53AIjX2f
 q4jEEyW/ThJ8/pZCcVJzdR4rSGq/Qn4MWEhfpyhQBFuLJ+z15f440pQmp76FOtCyJOK2Xg
 VJ/0VUYNfdT0QmYQOsn+4UJvan1e8L8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-OgFUvht_Ojed3PkbvV5AJQ-1; Tue, 11 Feb 2020 02:40:54 -0500
Received: by mail-wm1-f71.google.com with SMTP id z7so709123wmi.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/zVirhvmPouX0smYT5feIyfQrsKLglM/q5GUTkG+kr4=;
 b=nAenBh6DiSX437A4dP4wzMXd2Ige+NDjSOwZxXV6yNC7RwyBkG6b/i/mBL4uW9+VVx
 9snv2b+a4Zobwtbq1d7IZXYgikfcHymgvp75yXBi4woZQ8kE9CvXXW7I+zDaFWMB86SU
 gb5JUzg3pB7GHo5K081PV9aEtj8onMr5REiBSvpEGc7v3hFXpsQuhPPFnLJeiEcA7ZXd
 iU63tKC+f8ezrem1wMj5jZAJS47KqD3oewvkRIxRw3C4MRYcq7V5eduDNBIpSWBFbp+B
 lvHelzxMXvD4VmBP6t4/gCv2sS9MjGfnBRkOhG/LKEWQt31WpVam7xQxrHvQ2qedBbMl
 u6mA==
X-Gm-Message-State: APjAAAWlPpSp0XFv0VtdGiTCMpOOjk7T35K8x5nePvxeyiIgWBEJAMSv
 8l1XuwF0Fu1TqOXDymn5qk8I2vEIgwdbOgwFAXE+HxbtylJ1qwy8Itfuh1zFXce4Q55CFg3m1SN
 0VAEnY3hDFUWLMXU=
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr7024330wru.6.1581406852892;
 Mon, 10 Feb 2020 23:40:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmh7Mb1aZonYRgsBEFEuHrSIjQYeKVEsajz5lrE6nv/wCb9HyE32PihncZxSpoBf2mr30phA==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr7024293wru.6.1581406852543;
 Mon, 10 Feb 2020 23:40:52 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s22sm2539672wmh.4.2020.02.10.23.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:40:52 -0800 (PST)
Subject: Re: [RFC PATCH 29/66] Hexagon opcode data structures
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-30-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <154bb9da-0ee7-ac41-7a3e-3d0f9d5c0036@redhat.com>
Date: Tue, 11 Feb 2020 08:40:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-30-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: OgFUvht_Ojed3PkbvV5AJQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 2/11/20 1:40 AM, Taylor Simpson wrote:
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/opcodes.c | 223 +++++++++++++++++++++++++++++++++++++++++++++++
>   target/hexagon/opcodes.h |  67 ++++++++++++++
>   2 files changed, 290 insertions(+)
>   create mode 100644 target/hexagon/opcodes.c
>   create mode 100644 target/hexagon/opcodes.h
> 
> diff --git a/target/hexagon/opcodes.c b/target/hexagon/opcodes.c
> new file mode 100644
> index 0000000..1c1b200
> --- /dev/null
> +++ b/target/hexagon/opcodes.c
> @@ -0,0 +1,223 @@
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
> + * opcodes.c
> + *
> + * data tables generated automatically
> + * Maybe some functions too
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <strings.h>
> +#include <string.h>
> +#include <stdarg.h>
> +#include <ctype.h>

Previous includes not needed ("qemu/osdep.h" includes them for you).

> +#include "qemu/osdep.h"
> +#include "opcodes.h"
> +#include "decode.h"
> +
> +#define VEC_DESCR(A, B, C) DESCR(A, B, C)
> +#define DONAME(X) #X
> +
> +const char *opcode_names[] = {
> +#define OPCODE(IID) DONAME(IID)
> +#include "opcodes_def_generated.h"
> +    NULL
> +#undef OPCODE
> +};
> +
> +const char *opcode_reginfo[] = {
> +#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)    /* nothing */
> +#define REGINFO(TAG, REGINFO, RREGS, WREGS) REGINFO,
> +#include "op_regs_generated.h"
> +    NULL
> +#undef REGINFO
> +#undef IMMINFO
> +};
> +
> +
> +const char *opcode_rregs[] = {
> +#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)    /* nothing */
> +#define REGINFO(TAG, REGINFO, RREGS, WREGS) RREGS,
> +#include "op_regs_generated.h"
> +    NULL
> +#undef REGINFO
> +#undef IMMINFO
> +};
> +
> +
> +const char *opcode_wregs[] = {
> +#define IMMINFO(TAG, SIGN, SIZE, SHAMT, SIGN2, SIZE2, SHAMT2)    /* nothing */
> +#define REGINFO(TAG, REGINFO, RREGS, WREGS) WREGS,
> +#include "op_regs_generated.h"
> +    NULL
> +#undef REGINFO
> +#undef IMMINFO
> +};
> +
> +const char *opcode_short_semantics[] = {
> +#define OPCODE(X)              NULL
> +#include "opcodes_def_generated.h"
> +#undef OPCODE
> +    NULL
> +};
> +
> +
> +size4u_t
> +    opcode_attribs[XX_LAST_OPCODE][(A_ZZ_LASTATTRIB / ATTRIB_WIDTH) + 1] = {0};
> +
> +static void init_attribs(int tag, ...)
> +{
> +    va_list ap;
> +    int attr;
> +    va_start(ap, tag);
> +    while ((attr = va_arg(ap, int)) != 0) {
> +        opcode_attribs[tag][attr / ATTRIB_WIDTH] |= 1 << (attr % ATTRIB_WIDTH);
> +    }
> +}
> +
> +static size4u_t str2val(const char *str)
> +{
> +    size4u_t ret = 0;
> +    for ( ; *str; str++) {
> +        switch (*str) {
> +        case ' ':
> +        case '\t':
> +            break;
> +        case 's':
> +        case 't':
> +        case 'u':
> +        case 'v':
> +        case 'w':
> +        case 'd':
> +        case 'e':
> +        case 'x':
> +        case 'y':
> +        case 'i':
> +        case 'I':
> +        case 'P':
> +        case 'E':
> +        case 'o':
> +        case '-':
> +        case '0':
> +            ret = (ret << 1) | 0;
> +            break;
> +        case '1':
> +            ret = (ret << 1) | 1;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +    return ret;
> +}
> +
> +static size1u_t has_ee(const char *str)
> +{
> +    return (strchr(str, 'E') != NULL);
> +}
> +
> +opcode_encoding_t opcode_encodings[] = {
> +#define DEF_ENC32(OPCODE, ENCSTR) \
> +    [OPCODE] = { .encoding = ENCSTR },
> +
> +#define DEF_ENC_SUBINSN(OPCODE, CLASS, ENCSTR) \
> +    [OPCODE] = { .encoding = ENCSTR, .enc_class = CLASS },
> +
> +#define DEF_EXT_ENC(OPCODE, CLASS, ENCSTR) \
> +    [OPCODE] = { .encoding = ENCSTR, .enc_class = CLASS },
> +
> +#include "imported/encode.def"
> +
> +#undef DEF_ENC32
> +#undef DEF_ENC_SUBINSN
> +#undef DEF_EXT_ENC
> +};
> +
> +void opcode_init(void)
> +{
> +    init_attribs(0, 0);
> +
> +#define DEF_ENC32(OPCODE, ENCSTR) \
> +    opcode_encodings[OPCODE].vals = str2val(ENCSTR); \
> +    opcode_encodings[OPCODE].is_ee = has_ee(ENCSTR);
> +
> +#define DEF_ENC_SUBINSN(OPCODE, CLASS, ENCSTR) \
> +    opcode_encodings[OPCODE].vals = str2val(ENCSTR);
> +
> +#define LEGACY_DEF_ENC32(OPCODE, ENCSTR) \
> +    opcode_encodings[OPCODE].dep_vals = str2val(ENCSTR);
> +
> +#define DEF_EXT_ENC(OPCODE, CLASS, ENCSTR) \
> +    opcode_encodings[OPCODE].vals = str2val(ENCSTR);
> +
> +#include "imported/encode.def"
> +
> +#undef LEGACY_DEF_ENC32
> +#undef DEF_ENC32
> +#undef DEF_ENC_SUBINSN
> +#undef DEF_EXT_ENC
> +
> +#define ATTRIBS(...) , ## __VA_ARGS__, 0
> +#define OP_ATTRIB(TAG, ARGS) init_attribs(TAG ARGS);
> +#include "op_attribs_generated.h"
> +#undef OP_ATTRIB
> +#undef ATTRIBS
> +
> +    decode_init();
> +
> +#define DEF_QEMU(TAG, SHORTCODE, HELPER, GENFN, HELPFN) \
> +    opcode_short_semantics[TAG] = #SHORTCODE;
> +#include "qemu_def_generated.h"
> +#undef DEF_QEMU
> +}
> +
> +
> +#define NEEDLE "IMMEXT("
> +
> +int opcode_which_immediate_is_extended(opcode_t opcode)
> +{
> +    const char *p;
> +    if (opcode >= XX_LAST_OPCODE) {
> +        g_assert_not_reached();
> +        return 0;
> +    }
> +    if (!GET_ATTRIB(opcode, A_EXTENDABLE)) {
> +        g_assert_not_reached();
> +        return 0;
> +    }
> +    p = opcode_short_semantics[opcode];
> +    p = strstr(p, NEEDLE);
> +    if (p == NULL) {
> +        g_assert_not_reached();
> +        return 0;
> +    }
> +    p += strlen(NEEDLE);
> +    while (isspace(*p)) {
> +        p++;
> +    }
> +    /* lower is always imm 0, upper always imm 1. */
> +    if (islower(*p)) {
> +        return 0;
> +    } else if (isupper(*p)) {
> +        return 1;
> +    } else {
> +        g_assert_not_reached();
> +    }
> +}
> diff --git a/target/hexagon/opcodes.h b/target/hexagon/opcodes.h
> new file mode 100644
> index 0000000..ff90207
> --- /dev/null
> +++ b/target/hexagon/opcodes.h
> @@ -0,0 +1,67 @@
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
> +#ifndef OPCODES_H

HEXAGON_OPCODES_H

I wonder if it would ease review to split this patch in 2, keep the C 
here, but provide opcodes.h in an earlier patch.

> +#define OPCODES_H
> +
> +#include "hex_arch_types.h"
> +#include "attribs.h"
> +
> +typedef enum {
> +#define OPCODE(IID) IID
> +#include "opcodes_def_generated.h"
> +    XX_LAST_OPCODE
> +#undef OPCODE
> +} opcode_t;
> +
> +typedef enum {
> +    NORMAL,
> +    HALF,
> +    SUBINSN_A,
> +    SUBINSN_L1,
> +    SUBINSN_L2,
> +    SUBINSN_S1,
> +    SUBINSN_S2,
> +    EXT_noext,
> +    EXT_mmvec,
> +    XX_LAST_ENC_CLASS
> +} enc_class_t;
> +
> +extern const char *opcode_names[];
> +
> +extern const char *opcode_reginfo[];
> +extern const char *opcode_rregs[];
> +extern const char *opcode_wregs[];
> +
> +typedef struct {
> +    const char * const encoding;
> +    size4u_t vals;
> +    size4u_t dep_vals;
> +    const enc_class_t enc_class;
> +    size1u_t is_ee:1;
> +} opcode_encoding_t;
> +
> +extern opcode_encoding_t opcode_encodings[XX_LAST_OPCODE];
> +
> +extern size4u_t
> +    opcode_attribs[XX_LAST_OPCODE][(A_ZZ_LASTATTRIB / ATTRIB_WIDTH) + 1];
> +
> +extern void opcode_init(void);
> +
> +extern int opcode_which_immediate_is_extended(opcode_t opcode);
> +
> +#endif
> 


