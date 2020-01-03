Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B57C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 23:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B018724649
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 23:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKtgEJNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B018724649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inW9Z-0001FL-So
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 18:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1inW8z-0000o2-GR
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1inW8y-0007xr-Bk
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:14:13 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1inW8y-0007to-3c
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:14:12 -0500
Received: by mail-pg1-x544.google.com with SMTP id k25so24027345pgt.7
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 15:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oUP0/y1mzkWJW3eu8wJUad0wf8SKejS98YqpmYOsdEk=;
 b=jKtgEJNzi+KrlR7j3fySw/xZloVkcL31s7V0tRGx18wzRPdGBrjNXSM8QeEO115f0y
 3g5CuQtEaiSsGz6B9c4rVbS/HnyTU57lbUatEzzHzBpkmYyHebRTZ/66niGirftHETSS
 0yxdKPFIrn5+lSsuX073zkrjzilCrsexcbSreUPugmYUVSbxa/UrhdOGGQx9MkRFvu3g
 /LER+EuVu6rKd+5e+ZfAcZHFg5yKdtd1j7kwNOPtFuHIUApp7KOWBeXf78/5r4FGr4Oe
 KASzqm2BF2WZbgNphm9a1kPVyJ5mliB0L8yFMmikjPzsfeNB9bROnBP97SkTSIQEbL+T
 RDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oUP0/y1mzkWJW3eu8wJUad0wf8SKejS98YqpmYOsdEk=;
 b=lTnG7ZL5j9vwidWvl3+DijqJuhWYbUloZhv+Dm2thYo/IYI9WGILzyFWA/57+YKw8O
 cp0niPi9HecxFAn8Nna66VHdiFuQBQfmVJiu/gbsD7z1GaZtVBD4ZN5INAfTAM0xeWPE
 yIcPsWFQRXw1RK6Li8epKdeDEccdH5OAbQyRp6fnPGNMjwZitgTpaMphXaYUseyRLvI4
 sbk76UUs4+DB2Pjq+L37u+0uG3OEuAVIwLYIm6t9iTPNoqm/CjYdwwThkQ9HcPc3Tkac
 z2ORP8VHHJq2N9GCjnvtqThQgJylpFvmHkvBarbZjcDOnThfr8/2SC2mDOSM+popRCOx
 n2nQ==
X-Gm-Message-State: APjAAAU4anwJdzCkhyQY0qu96UXhLndVJfa3T9NS1hx7ItbPzKLccABh
 4KEBdr4lsZssQH1ozLXK9XPdBw==
X-Google-Smtp-Source: APXvYqweqyrXgwamIPM68rTH0ZnBIhS06kz//67oMKGRxTn7F0lWZzBCl1xhlTL/7Uy71pMo6Rebvw==
X-Received: by 2002:aa7:9729:: with SMTP id k9mr98165992pfg.72.1578093250978; 
 Fri, 03 Jan 2020 15:14:10 -0800 (PST)
Received: from [10.103.5.8] (59-100-211-22.bri.static-ipl.aapt.com.au.
 [59.100.211.22])
 by smtp.gmail.com with ESMTPSA id c22sm46367427pfo.50.2020.01.03.15.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 15:14:10 -0800 (PST)
Subject: Re: [PATCH v3 3/4] RISC-V: support vector extension csr
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
 <20200103033347.20909-4-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87e202c0-9956-351d-8504-932b4b0aef55@linaro.org>
Date: Sat, 4 Jan 2020 10:14:03 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103033347.20909-4-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 2:33 PM, LIU Zhiwei wrote:
> Until v0.7.1 specification, vector status is still not defined for
> mstatus.

Using "until" imples that v0.7.1 *does* define the vector status.

Better said as "The v0.7.1 specification does not define vector status within
mstatus.  A future revision will define the privileged portion of the vector
status."

Although lack of a privileged spec does suggest to me that perhaps we ought to
support the vector extension only for CONFIG_USER_ONLY for now.


r~

