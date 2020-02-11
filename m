Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D627C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5891320714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0r6J8Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5891320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1PpZ-0007hB-Fy
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Pov-0007Fo-R2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Pou-0000Ml-Id
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:18:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21897
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Pou-0000Me-FO
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581405536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6fz4SsBWc7eUoJoZCzMltLSxCALJ1e65tnFlRcvVm4=;
 b=D0r6J8RprJA0C02RjLxgy2HILQP/NVnkiXlZTvXBSGzTGtsypVm5T2TOxgasS/p/E6wmCn
 km3AkW4LUoyVOacmDqdqw6sqsIUMrkcmEH9e4w0oFX3Ck5JHq5AVWdB/MNpVZ1a31eRVFD
 Jbw4+G0WwiqRuo+o+TC7d+XmLDZQxVM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-JPspIBhxOmGEaPUHPhgm1w-1; Tue, 11 Feb 2020 02:18:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id u8so6440837wrp.10
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k6fz4SsBWc7eUoJoZCzMltLSxCALJ1e65tnFlRcvVm4=;
 b=PTaXay0DC1p/Z/rCxtoPdFrPb/qIDwr2mw+vFi1Ocs5P9uRj1RfQrapm/ZjHiJMKH7
 SrB5r7h+lbN0qCl4PqPJxYzF7WhkljVejUN2yrGBkWTX+ZKc6CM2YhNBCvAF+xD/5t9w
 +VvNX0sZOBt8ACViSlMxMCLi0Teo01FOKTMkUl22eVCoEL9S/a+ivrTuM31PmjU9QhRg
 KRWers6e+frX2KnnEVABC+ImjWlPbuCWm3CfFSN0ETmi0lf0FGyXz8pW9r1GS2fp/AH9
 xp3nkuDcaUNnUjA1AOcYkoWwv3HcG8OVIHxYihrfzQwmyvzlhbPhDlYzPuhGbumm41vV
 J/LA==
X-Gm-Message-State: APjAAAVV8AK1skPggHeTh/WTpGU53rzadrWa+lMEqr0ihl3Jb/q/fIWb
 97HUQNg1+HH9YwLonrY09HS3zDTOIbJEfPYMhgVc/VdjaPU2Mkw1rUt8HKJZcsNpVqXzlqSYlAF
 ob/TBZQEBcctJ2gY=
X-Received: by 2002:a1c:238e:: with SMTP id j136mr3883381wmj.33.1581405530875; 
 Mon, 10 Feb 2020 23:18:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOv0tUEHHCsrQ6SFQ3lwjHhY9b4GpwvIbZDj2A6/wxUnVVrTJlksK8d/A2vG0sgXGiENTJxQ==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr3883363wmj.33.1581405530677; 
 Mon, 10 Feb 2020 23:18:50 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l6sm4101457wrn.26.2020.02.10.23.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:18:50 -0800 (PST)
Subject: Re: [RFC PATCH 04/66] Hexagon register names
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-5-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3167438d-dccc-9cb9-7136-5c2ec4fd5c11@redhat.com>
Date: Tue, 11 Feb 2020 08:18:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-5-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: JPspIBhxOmGEaPUHPhgm1w-1
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
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/hex_regs.h | 97 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
>   create mode 100644 target/hexagon/hex_regs.h
> 
> diff --git a/target/hexagon/hex_regs.h b/target/hexagon/hex_regs.h
> new file mode 100644
> index 0000000..ba1ae10
> --- /dev/null
> +++ b/target/hexagon/hex_regs.h
> @@ -0,0 +1,97 @@
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
> +#ifndef HEX_REGS_H
> +#define HEX_REGS_H
> +

If this isn't generated I'd rather use an enum.

> +#define HEX_REG_R00 0
> +#define HEX_REG_R01 1
> +#define HEX_REG_R02 2
> +#define HEX_REG_R03 3
> +#define HEX_REG_R04 4
> +#define HEX_REG_R05 5
> +#define HEX_REG_R06 6
> +#define HEX_REG_R07 7
> +#define HEX_REG_R08 8
> +#define HEX_REG_R09 9
> +#define HEX_REG_R10 10
> +#define HEX_REG_R11 11
> +#define HEX_REG_R12 12
> +#define HEX_REG_R13 13
> +#define HEX_REG_R14 14
> +#define HEX_REG_R15 15
> +#define HEX_REG_R16 16
> +#define HEX_REG_R17 17
> +#define HEX_REG_R18 18
> +#define HEX_REG_R19 19
> +#define HEX_REG_R20 20
> +#define HEX_REG_R21 21
> +#define HEX_REG_R22 22
> +#define HEX_REG_R23 23
> +#define HEX_REG_R24 24
> +#define HEX_REG_R25 25
> +#define HEX_REG_R26 26
> +#define HEX_REG_R27 27
> +#define HEX_REG_R28 28
> +#define HEX_REG_R29 29
> +#define HEX_REG_SP 29
> +#define HEX_REG_FP 30
> +#define HEX_REG_R30 30
> +#define HEX_REG_LR 31
> +#define HEX_REG_R31 31
> +#define HEX_REG_SA0 32
> +#define HEX_REG_LC0 33
> +#define HEX_REG_SA1 34
> +#define HEX_REG_LC1 35
> +#define HEX_REG_P3_0 36
> +#define HEX_REG_M0 38
> +#define HEX_REG_M1 39
> +#define HEX_REG_USR 40
> +#define HEX_REG_PC 41
> +#define HEX_REG_UGP 42
> +#define HEX_REG_GP 43
> +#define HEX_REG_CS0 44
> +#define HEX_REG_CS1 45
> +#define HEX_REG_UPCYCLELO 46
> +#define HEX_REG_UPCYCLEHI 47
> +#define HEX_REG_FRAMELIMIT 48
> +#define HEX_REG_FRAMEKEY 49
> +#define HEX_REG_PKTCNTLO 50
> +#define HEX_REG_PKTCNTHI 51
> +/* Use reserved control registers for qemu execution counts */
> +#define HEX_REG_QEMU_PKT_CNT 52
> +#define HEX_REG_QEMU_INSN_CNT 53
> +#define HEX_REG_QEMU_HVX_CNT 54
> +#define HEX_REG_UTIMERLO 62
> +#define HEX_REG_UTIMERHI 63
> +
> +#ifndef CONFIG_USER_ONLY
> +#define HEX_REG_SGP0 64
> +#define HEX_REG_SGP1 65
> +#define HEX_REG_STID 66
> +#define HEX_REG_ELR 67
> +#define HEX_REG_BADVA0 68
> +#define HEX_REG_BADVA1 69
> +#define HEX_REG_SSR 70
> +#define HEX_REG_CCR 71
> +#define HEX_REG_HTID 72
> +#define HEX_REG_BADVA 73
> +#define HEX_REG_IMASK 74
> +#define HEX_REG_GEVB 75
> +#endif
> +
> +#endif
> 


