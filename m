Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343DBC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F276520873
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT5AqvVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F276520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XV9-0008UO-5i
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1XUA-0007bp-Fz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1XU8-0001rC-5K
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:30:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44428
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1XU8-0001qx-0j
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581434999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3X3CKAWx/76QN7E5uSJ213D5O4BYkAUZ3PYwDDYQyU=;
 b=iT5AqvVoJcueUQ3ehBngqvxIGKmPQ1QRO6tf0+5oqry66y4jajKyv6gZluMLdxP/XaJYEz
 qdFQeS8E65SNgBNhHXS12H4LhClO11XmeSpbEmJhpnPrTAhJ8mZhQUQibOwZoolmhOxcRn
 zrigD0RGq5qDygrbCox2PoLtJ0W7skw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-SA_IMBCtNc2MaHpCcwrsFw-1; Tue, 11 Feb 2020 10:29:57 -0500
Received: by mail-wr1-f70.google.com with SMTP id p8so7074641wrw.5
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 07:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h3X3CKAWx/76QN7E5uSJ213D5O4BYkAUZ3PYwDDYQyU=;
 b=AFyEMNeDGI8pobCWaXCuAAnpmbUtiwOWKROBqPfOwkUe39QVI9mKJfk/d6b5fSQw7s
 ISHTRT/sswqn/uA8dOFZqp8bQVBNK06k+gQ1XgWDShWCb6NYX4B14vQ/xF5fF7kVbAtg
 HWwZPYvLpG1mMzkvoJEFOdm17Ix7H3dUWkZDpcCEvFnOo5iClI02Bss2mttE9o3KCkUW
 QNqwMiPNbbm6JY0LICdnnwIcZhX3lKw1hL6+tcz6v3EWmuktIXA7deROts4iesSVM3VX
 Q/ehx0YNsC2Yei/mz2DblFddtZtSF2clq3ryrfiTCI4UIOwABKO8b52z1Kbwkj3VCpmh
 aCEw==
X-Gm-Message-State: APjAAAWow/wYdZdwmFNW/WsddZuVmhTx/9KOx3SBiFN2B1qMo4zPYtGt
 w1dChXfJBZlK5ByAgiTDa/DtxmEOE9TMZtJ/L5rQ6BvjcsjLn4vK2tvbTyxe8+NI818/psIV/31
 GvWP2iMVou8YWCYQ=
X-Received: by 2002:a05:600c:118a:: with SMTP id
 i10mr6363462wmf.142.1581434996023; 
 Tue, 11 Feb 2020 07:29:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxg3ChiwnNSIgDuJBFAi/n9yyJE73Nutzjpvzr75jHQePQKYu4EqinN52Ocg6/E/HggEIRupg==
X-Received: by 2002:a05:600c:118a:: with SMTP id
 i10mr6363433wmf.142.1581434995650; 
 Tue, 11 Feb 2020 07:29:55 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id g18sm4017848wmh.48.2020.02.11.07.29.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 07:29:55 -0800 (PST)
Subject: Re: [RFC PATCH 10/66] Hexagon register fields
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-11-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <652c203f-b091-b63f-4b9c-85d46d3550df@redhat.com>
Date: Tue, 11 Feb 2020 16:29:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-11-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: SA_IMBCtNc2MaHpCcwrsFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
> Declare bitfields within registers such as user status register (USR)
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/reg_fields.c     |  28 +++++++++++
>   target/hexagon/reg_fields.h     |  40 +++++++++++++++
>   target/hexagon/reg_fields_def.h | 109 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 177 insertions(+)
>   create mode 100644 target/hexagon/reg_fields.c
>   create mode 100644 target/hexagon/reg_fields.h
>   create mode 100644 target/hexagon/reg_fields_def.h
> 
> diff --git a/target/hexagon/reg_fields.c b/target/hexagon/reg_fields.c
> new file mode 100644
> index 0000000..983655e
> --- /dev/null
> +++ b/target/hexagon/reg_fields.c
> @@ -0,0 +1,28 @@
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
> +#include <string.h>

Replace by:

   #include "qemu/osdep.h"

> +#include "reg_fields.h"
> +
> +reg_field_t reg_field_info[] = {
> +#define DEF_REG_FIELD(TAG, NAME, START, WIDTH, DESCRIPTION)    \
> +      {NAME, START, WIDTH, DESCRIPTION},
> +#include "reg_fields_def.h"
> +      {NULL, 0, 0}
> +#undef DEF_REG_FIELD
> +};
> +
> diff --git a/target/hexagon/reg_fields.h b/target/hexagon/reg_fields.h
> new file mode 100644
> index 0000000..79857c5
> --- /dev/null
> +++ b/target/hexagon/reg_fields.h
> @@ -0,0 +1,40 @@
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
> +#ifndef REGS_H
> +#define REGS_H

Maybe HEXAGON_REG_FIELDS?

> +
> +#define NUM_GEN_REGS 32
> +
> +typedef struct {
> +    const char *name;
> +    int offset;
> +    int width;
> +    const char *description;
> +} reg_field_t;
> +
> +extern reg_field_t reg_field_info[];
> +
> +enum reg_fields_enum {
> +#define DEF_REG_FIELD(TAG, NAME, START, WIDTH, DESCRIPTION) \
> +    TAG,
> +#include "reg_fields_def.h"
> +    NUM_REG_FIELDS
> +#undef DEF_REG_FIELD
> +};
> +
> +#endif
> diff --git a/target/hexagon/reg_fields_def.h b/target/hexagon/reg_fields_def.h
> new file mode 100644
> index 0000000..095a776
> --- /dev/null
> +++ b/target/hexagon/reg_fields_def.h
> @@ -0,0 +1,109 @@
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
> + * For registers that have individual fields, explain them here
> + *   DEF_REG_FIELD(tag,
> + *                 name,
> + *                 bit start offset,
> + *                 width,
> + *                 description
> + */
> +
> +/* USR fields */
> +DEF_REG_FIELD(USR_OVF,
> +    "ovf", 0, 1,
> +    "Sticky Saturation Overflow - "
> +    "Set when saturation occurs while executing instruction that specifies "
> +    "optional saturation, remains set until explicitly cleared by a USR=Rs "
> +    "instruction.")
> +DEF_REG_FIELD(USR_FPINVF,
> +    "fpinvf", 1, 1,
> +    "Floating-point IEEE Invalid Sticky Flag.")
> +DEF_REG_FIELD(USR_FPDBZF,
> +    "fpdbzf", 2, 1,
> +    "Floating-point IEEE Divide-By-Zero Sticky Flag.")
> +DEF_REG_FIELD(USR_FPOVFF,
> +    "fpovff", 3, 1,
> +    "Floating-point IEEE Overflow Sticky Flag.")
> +DEF_REG_FIELD(USR_FPUNFF,
> +    "fpunff", 4, 1,
> +    "Floating-point IEEE Underflow Sticky Flag.")
> +DEF_REG_FIELD(USR_FPINPF,
> +    "fpinpf", 5, 1,
> +    "Floating-point IEEE Inexact Sticky Flag.")
> +
> +DEF_REG_FIELD(USR_LPCFG,
> +    "lpcfg", 8, 2,
> +    "Hardware Loop Configuration: "
> +    "Number of loop iterations (0-3) remaining before pipeline predicate "
> +    "should be set.")
> +DEF_REG_FIELD(USR_PKTCNT_U,
> +    "pktcnt_u", 10, 1,
> +    "Enable packet counting in User mode.")
> +DEF_REG_FIELD(USR_PKTCNT_G,
> +    "pktcnt_g", 11, 1,
> +    "Enable packet counting in Guest mode.")
> +DEF_REG_FIELD(USR_PKTCNT_M,
> +    "pktcnt_m", 12, 1,
> +    "Enable packet counting in Monitor mode.")
> +DEF_REG_FIELD(USR_HFD,
> +    "hfd", 13, 2,
> +    "Two bits that let the user control the amount of L1 hardware data cache "
> +    "prefetching (up to 4 cache lines): "
> +    "00: No prefetching, "
> +    "01: Prefetch Loads with post-updating address mode when execution is "
> +        "within a hardware loop, "
> +    "10: Prefetch any hardware-detected striding Load when execution is within "
> +        "a hardware loop, "
> +    "11: Prefetch any hardware-detected striding Load.")
> +DEF_REG_FIELD(USR_HFI,
> +    "hfi", 15, 2,
> +    "Two bits that let the user control the amount of L1 instruction cache "
> +    "prefetching. "
> +    "00: No prefetching, "
> +    "01: Allow prefetching of at most 1 additional cache line, "
> +    "10: Allow prefetching of at most 2 additional cache lines.")
> +
> +DEF_REG_FIELD(USR_FPRND,
> +    "fprnd", 22, 2,
> +    "Rounding Mode for Floating-Point Instructions: "
> +    "00: Round to nearest, ties to even (default), "
> +    "01: Toward zero, "
> +    "10: Downward (toward negative infinity), "
> +    "11: Upward (toward positive infinity).")
> +
> +DEF_REG_FIELD(USR_FPINVE,
> +    "fpinve", 25, 1,
> +    "Enable trap on IEEE Invalid.")
> +DEF_REG_FIELD(USR_FPDBZE,
> +    "fpdbze", 26, 1, "Enable trap on IEEE Divide-By-Zero.")
> +DEF_REG_FIELD(USR_FPOVFE,
> +    "fpovfe", 27, 1,
> +    "Enable trap on IEEE Overflow.")
> +DEF_REG_FIELD(USR_FPUNFE,
> +    "fpunfe", 28, 1,
> +    "Enable trap on IEEE Underflow.")
> +DEF_REG_FIELD(USR_FPINPE,
> +    "fpinpe", 29, 1,
> +    "Enable trap on IEEE Inexact.")
> +DEF_REG_FIELD(USR_PFA,
> +    "pfa", 31, 1,
> +    "L2 Prefetch Active: Set when non-blocking l2fetch instruction is "
> +    "prefetching requested data, remains set until l2fetch prefetch operation "
> +    "is completed (or not active).") /* read-only */
> +
> 


