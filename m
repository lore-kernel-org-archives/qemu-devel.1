Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04790C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADBE22314
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wHpZX0nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADBE22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hef-00051G-0U
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hdf-0003hG-Jg
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hde-0007m3-LX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:32:39 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2hde-0007ky-G2
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:32:38 -0500
Received: by mail-pf1-x442.google.com with SMTP id y5so5403290pfb.11
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 12:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+PgIueiEHeE8hNvIiKSs71g7wCMFIuCfz2Pul38Bob4=;
 b=wHpZX0nqtYXbob6cuzNzS/rkqJSLF6CxmppKaR8mDWBCo/jT/ij0ZqYzCjrfDI5Mnw
 Yf29mavflch03Msv1cEcintt3X2RXgdjk7Yc3eGD2zoA6sjlL2tNR4eiGDXqQ56EfTOp
 dMZ58SxX1VRGNX0+RaaHfs23isbOaU9T+7LRTLBQ8quGorICWF+tJh1k0a9iVTIBu23Q
 BIOVK5/+mpiXjbZYS3HXyFNQwOsQFItmqdIxVOHdZJnLJrryHlc5L7AkKo88zCSQOmHR
 h5PyWaU1OcUJ+ZMja1LGpKVc4RZJ5Cq5esYtVGVPfuh0aFLSiOpLUPRredS9V2SWK8Hn
 VgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+PgIueiEHeE8hNvIiKSs71g7wCMFIuCfz2Pul38Bob4=;
 b=IbCGpdj6gxaWluVuibDEss1bgvYDP12KYU40L9KRhvLJNXDY8gsZa2skgdwQ2qWma4
 1CSKaMAihycqIdzhPqMr6vEj0+loY74f8DL/7J8171sZ/T2CIRO+VaJ1io0ftLOh8HsL
 P3WDkrcc6CM+6ZYDR8rlhRVsgxCf7QUWh4TJKse8cKgivvw6vJjNaXg2DUh+r0a4bZR0
 MLHiIqkBDi/cUCxbaZig10DgcMspa7UGCBACELTftM578tkemoCgGgznf8vTfpPJ4ApS
 voYOdJgAuFJ81eP2IIxUZD4cQdrXH0Iwx8Js3q8IR48Ee2rijWQrndaYBwTbd8PGPl0B
 +8og==
X-Gm-Message-State: APjAAAVJFEKCr+fXuQwWmQe9nZKejwF+kxr2e3BPi810zrHPtVKkEWIg
 O1VFuV2s6lM81KpbTrVF0MaU7A==
X-Google-Smtp-Source: APXvYqzQ6nRBuRmQcF0QFGnlzpTFNrbdg8BHNJWGgLUdJYwpLborIFofyafczLrOy5InMC0Og0MlSw==
X-Received: by 2002:a62:8245:: with SMTP id w66mr5133395pfd.93.1581712357505; 
 Fri, 14 Feb 2020 12:32:37 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 ep2sm7275072pjb.31.2020.02.14.12.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 12:32:36 -0800 (PST)
Subject: Re: [PATCH v2 20/21] target/arm: Use FIELD_EX32 for testing 32-bit
 fields
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200214175116.9164-1-peter.maydell@linaro.org>
 <20200214175116.9164-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f657693f-af24-37fc-04e6-666cebf47a80@linaro.org>
Date: Fri, 14 Feb 2020 12:32:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214175116.9164-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 9:51 AM, Peter Maydell wrote:
> Cut-and-paste errors mean we're using FIELD_EX64() to extract fields from
> some 32-bit ID register fields. Use FIELD_EX32() instead. (This makes
> no difference in behaviour, it's just more consistent.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

