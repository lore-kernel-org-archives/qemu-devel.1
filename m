Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096F4C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DC420708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7ic5P23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DC420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1PuW-0001mw-TP
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Ptg-0001KC-RR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Ptc-0005hL-KA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:23:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56417
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Ptc-0005gs-GS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581405827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oSckut5NL7xLB7rMbDvVENv9oVXvPnu0psCzoYvfHlw=;
 b=B7ic5P23b6uuhKPj8wC8pD7fy2nxlXzqYdZ5fmlfM00fcSwnfY0A8tRfY8Z/cn7goiYNzY
 1Wx/PW0DIAGXyygoAuSA3ctOb7QpAt8DqqXdCo8wglpjGz77BDf1KG6qzcMa0ruuehO2XG
 GSGlCmDKntDomVOylFf5cLy2qNc+bz0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-C2BGghxGM5ms0yVX1-2nNA-1; Tue, 11 Feb 2020 02:23:45 -0500
Received: by mail-wr1-f70.google.com with SMTP id l1so6477967wrt.4
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oSckut5NL7xLB7rMbDvVENv9oVXvPnu0psCzoYvfHlw=;
 b=N20ArzwkM7WjWrO+w/Pp8Rk6CXHNMAAi7tQOYNED8XjlQdsRV1+defbzUnEY37vNZi
 q69x2tT+QTQ7+IGoR3mLlDvE4HQV6GoRjnYpO+Z49+RUU8MoFpoWkDUwMbXf8OGqz0a2
 LXj3Mk0bSUPPoP21Esi60GSIEDcpvzzNs8Bzi+1uRAnUSUZ2e5UUxu6yhZDyTsA0JZq+
 Vy/B986RdxOWlRD7Cdla4IKgnImoUUPLNQhCJ1IJH5R1PlzGmVBqbw5HEPccTuuH52/J
 7HcFKQTREZBu0Nr0ZHsR2BB1gI4O2UUb2Z3V4dhM7WbNMR03PM+ph3Wa3nb9hcHr+TdX
 aNVA==
X-Gm-Message-State: APjAAAX5NY6GBF8fUBW4vnhGVghyy7N+TV04hMIni5Lm+wvIj3LY6b6f
 R8ljgyI5qFrq22+RgDRL7vqVRlFDxHZiBKuj5pUAKCGotush4FY4T1lBbkK20rugMwqnIsEDI5D
 ZsLjvWBsoNdr64Co=
X-Received: by 2002:adf:df03:: with SMTP id y3mr6887051wrl.260.1581405824804; 
 Mon, 10 Feb 2020 23:23:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/8jBcYKGVAs58GNuzH/ltH8a+3mpGb4KgQpV+mNE3S/ERu4i4jQoERJD2w53w2mJO1GFFBA==
X-Received: by 2002:adf:df03:: with SMTP id y3mr6887032wrl.260.1581405824567; 
 Mon, 10 Feb 2020 23:23:44 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id u4sm4069556wrt.37.2020.02.10.23.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:23:44 -0800 (PST)
Subject: Re: [RFC PATCH 09/66] Hexagon architecture types
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-10-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e86afdaa-d401-0c2c-323a-2779d1e75859@redhat.com>
Date: Tue, 11 Feb 2020 08:23:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-10-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: C2BGghxGM5ms0yVX1-2nNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:39 AM, Taylor Simpson wrote:
> Define types used in files imported from the Hexagon architecture library
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/hex_arch_types.h | 42 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 target/hexagon/hex_arch_types.h
> 
> diff --git a/target/hexagon/hex_arch_types.h b/target/hexagon/hex_arch_types.h
> new file mode 100644
> index 0000000..3f89986
> --- /dev/null
> +++ b/target/hexagon/hex_arch_types.h
> @@ -0,0 +1,42 @@
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
> +#ifndef HEXAGON_ARCH_TYPES_H
> +#define HEXAGON_ARCH_TYPES_H
> +
> +/*
> + * These types are used by the code generated from the Hexagon
> + * architecture library.
> + */
> +typedef unsigned char size1u_t;
> +typedef char size1s_t;
> +typedef unsigned short int size2u_t;
> +typedef short size2s_t;
> +typedef unsigned int size4u_t;
> +typedef int size4s_t;
> +typedef unsigned long long int size8u_t;
> +typedef long long int size8s_t;
> +typedef size8u_t paddr_t;
> +typedef size4u_t vaddr_t;
> +typedef size8u_t pcycles_t;
> +
> +typedef struct size16s {
> +    size8s_t hi;
> +    size8u_t lo;
> +} size16s_t;
> +
> +#endif
> 

Please introduce this patch before the previous one, it makes review 
smoother:

[PATCH 08/66] Hexagon architecture types
[PATCH 09/66] Hexagon instruction and packet types


