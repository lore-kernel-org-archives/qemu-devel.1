Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A330C73C6D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 07:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963FD20693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 07:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H83HKWhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963FD20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl6ok-0003AL-JA
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 03:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58057)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hl6oE-0002fJ-M9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hl6oD-0007qf-D5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:14:34 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hl6oD-0007pj-1H
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:14:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id n5so1156799otk.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h5S9zXKt2KZUpFw1CUz/xrLyFiXFBrqUIN37igt1/Ec=;
 b=H83HKWhIRijbLJo31EI5qu0ud6sr5wOd2RdlH94W2msrE/vb7h1Kpiu0Ynn62Kpn8q
 unkh3iBPE0JEa6rtA8dWuNwwOU1B5dfv9DM/cca0mnMePPNJ5eRyjIZ686lplVZ0/SnA
 cEXNfRPdpKW/pmVb6P1eH15+uhYZQIZbtsdpqAwL4Rwvd94e5uavkmPmXokXC+YyZWRU
 RvFPY1ytpel4i70ov5M64XiFOhAXOClozrd/gjt2m3MnEg9qm8HzJTLF5i0I1F430of0
 lPBycSXlNECNBu1ksMvooXcDifAFNs+gBWKVuVPqN36boiwACLAxFlKpCre1Q9McUBp7
 dRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h5S9zXKt2KZUpFw1CUz/xrLyFiXFBrqUIN37igt1/Ec=;
 b=jmncLPN5X7jHZfXrU+ayvEvR1b5I1AUioGZs+JSQij4aftsvPt/3MlU9AFJZtwBiuK
 cVWHqr3k/cOIev7YLcTi5/qQCZx/baebe5k01K4K7YjV9kyou/V6wpjEm5C3Wm0QCWvx
 mfvYCUMg95GW7aCxRBwt5wN5ZHw8kZWhej/d/qP3ITuZFu1Fkd8zYiiH12g+ybinAG/F
 DP03VkKbd4BqEk0ZtU3duXzl2YA9ZPkyaVUUbN2Im2oGIiyGIx1+ddmwYMNm5QRrTAmP
 coqaH29bRVONCMDXWnYk6OqHPWYBRnyGfViXo6wLMkcAqYtZd+tzitB+XBXBKRbYzULu
 Im+g==
X-Gm-Message-State: APjAAAWVJViLuHKgll246T5re+ajdcc/OZ4qstOL8hpc9z/GRammYrFf
 SeC7PAu90WLyvausBBYsqk2T8Q==
X-Google-Smtp-Source: APXvYqw+x2+k/dfy1dgX97DTyXtqPJy4dECE0GVAhrop20WK33O+1tkYhmuIYllKBQ6y2u7wXzssDw==
X-Received: by 2002:a9d:664c:: with SMTP id q12mr21149674otm.175.1562742871937; 
 Wed, 10 Jul 2019 00:14:31 -0700 (PDT)
Received: from [192.168.43.94] ([172.56.7.82])
 by smtp.gmail.com with ESMTPSA id r130sm556344oib.41.2019.07.10.00.14.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 00:14:31 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190705160421.19015-1-alex.bennee@linaro.org>
 <20190705160421.19015-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <aec9314d-c1e9-2521-6170-d8ce6be97a97@linaro.org>
Date: Wed, 10 Jul 2019 09:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190705160421.19015-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 4/5] gdbstub: add some notes to the
 header comment
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/19 6:04 PM, Alex Bennée wrote:
> Add a link to the remote protocol spec and an SPDX tag.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 8618e34311..ea3349d1aa 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1,6 +1,10 @@
>  /*
>   * gdb server stub
>   *
> + * This implements a subset of the remote protocol as described in:
> + *
> + *   https://sourceware.org/gdb/onlinedocs/gdb/Remote-Protocol.html
> + *

Ack.

>   * Copyright (c) 2003-2005 Fabrice Bellard
>   *
>   * This library is free software; you can redistribute it and/or
> @@ -15,6 +19,8 @@
>   *
>   * You should have received a copy of the GNU Lesser General Public
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later

Nack.  The text is for the LGPL.


r~

