Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BC4C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B4C206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7M9FJkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B4C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1PxD-0003Lj-64
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Pvw-0002qg-Bo
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Pvu-0007Q0-VI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:26:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28307
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Pvu-0007Of-R9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581405970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTYMiSS0y5uQ9IRHjKZu1aTJtwkQuC+21Z7EEPXAecs=;
 b=i7M9FJkxuzoI6xFLMMgRmhbIi1ao+0FN7Gp/sX20o3BtyXiBkWoJzku3OzMI/RnwoqPEgQ
 AjtXCtcvByBEV2DT/+WtaAoy/2I3GavBbhFLhuZMsniz9CmnUyuB9faQt/NE0Wmw9lcArR
 Y5X1xpA6Gm11OtNRs0VsWboiBfbBRGc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-phjHnV-4M72m7HPHX4_raw-1; Tue, 11 Feb 2020 02:26:08 -0500
Received: by mail-wr1-f72.google.com with SMTP id d15so6444322wru.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xTYMiSS0y5uQ9IRHjKZu1aTJtwkQuC+21Z7EEPXAecs=;
 b=ua/OyjRwzP7j2/SZc81q44lGU62qq6Li2LT1p/fAlZbzSJb1sezQI5iHDsCREs9Pxa
 RDnTDf0fW8+S74/D8GFfb28dM623wiWZYsW+yxpFdy4YzThU5WVQDSHytEgC4S26C2O1
 chWRh0OO67FjiqPQuHnRmyZbR5u1VyDjuzblOgquNsxDBaqEeE/sMicum5ME9HgywpnF
 YIkDOPMh+9yKbxwva7SLFpXxUa8Lz7t1ow3O4A4foIKvc3HoPQkX9fCc4F0bv9NyIqXZ
 AffnHjZbGkUbPygB9OTMiNc1qCXKGMcScVSMooNUoU8t2DHFQkZj8gychftRxtNWUHjA
 MwuA==
X-Gm-Message-State: APjAAAW4h964PuoAWzQHVuI4IpvUAzAJiI+fPz2vWu7qj48LojjGNbXx
 fpK4xwP5tjQSKdV8dvy/k7G2MwwukIPcv4UwqKn+NX48iRAif8mXXWzMkcB/9DdybkVRCK5Vyqs
 XDqIhLryeTUzRvmw=
X-Received: by 2002:a05:600c:211:: with SMTP id
 17mr3864436wmi.60.1581405967219; 
 Mon, 10 Feb 2020 23:26:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyfQnFNby4ZD9TYAnBTKJDD/f/kuBrLHy/zRgGawN1mMEOIZ06qkuwXuUglvTj0h4WXIxAm6A==
X-Received: by 2002:a05:600c:211:: with SMTP id
 17mr3864408wmi.60.1581405966956; 
 Mon, 10 Feb 2020 23:26:06 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s8sm2604883wmf.45.2020.02.10.23.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:26:06 -0800 (PST)
Subject: Re: [RFC PATCH 12/66] Hexagon register map
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-13-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f46f6d3c-5a4a-be09-b5c9-538fad251fac@redhat.com>
Date: Tue, 11 Feb 2020 08:26:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-13-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: phjHnV-4M72m7HPHX4_raw-1
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
> Certain operand types represent a non-contiguous set of values.
> For example, the compound compare-and-jump instruction can only access
> registers R0-R7 and R16-23.
> This table represents the mapping from the encoding to the actual values.
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/regmap.h | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 target/hexagon/regmap.h
> 
> diff --git a/target/hexagon/regmap.h b/target/hexagon/regmap.h
> new file mode 100644
> index 0000000..fbeb03a
> --- /dev/null
> +++ b/target/hexagon/regmap.h
> @@ -0,0 +1,38 @@
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
> + *  Certain operand types represent a non-contiguous set of values.
> + *  For example, the compound compare-and-jump instruction can only access
> + *  registers R0-R7 and R16-23.
> + *  This table represents the mapping from the encoding to the actual values.
> + */
> +
> +#ifndef REGMAP_H
> +#define REGMAP_H

I'd try to be consistent and use all header under target/hexagon/ 
guarded with a HEXAGON_ prefix:

    #ifndef HEXAGON_REGMAP_H
    ...

> +
> +        /* Name   Num Table */
> +DEF_REGMAP(R_16,  16, 0, 1, 2, 3, 4, 5, 6, 7, 16, 17, 18, 19, 20, 21, 22, 23)
> +DEF_REGMAP(R__8,  8,  0, 2, 4, 6, 16, 18, 20, 22)
> +DEF_REGMAP(R__4,  4,  0, 2, 4, 6)
> +DEF_REGMAP(R_4,   4,  0, 1, 2, 3)
> +DEF_REGMAP(R_8S,  8,  0, 1, 2, 3, 16, 17, 18, 19)
> +DEF_REGMAP(R_8,   8,  0, 1, 2, 3, 4, 5, 6, 7)
> +DEF_REGMAP(V__8,  8,  0, 4, 8, 12, 16, 20, 24, 28)
> +DEF_REGMAP(V__16, 16, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30)
> +
> +#endif
> 


