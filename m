Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE422C47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737052074A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Euz3L1cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737052074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUN48-0002eL-Ic
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 00:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUN3I-00025p-12
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUN3H-0005eD-85
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:13:27 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUN3G-0005al-MV
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:13:26 -0400
Received: by mail-pg1-x544.google.com with SMTP id q124so4048067pgq.13
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 21:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=NHSmdMDC/Sy24mN5oHrLE1OujPQ2Z8sWGmcyLx2TPDo=;
 b=Euz3L1cdEEmL5uTHrhXJZnfsu+ZJld0pdcncpdYY1+QdwJ/Jb5oI2M+l+qXPhRl1ba
 a5OhPrpkIIagtI3m9smZ2Z6Tq9OS6yuk2H+U++qgE5yhqlURZ9ej2OaJifKvLXwcgbcK
 Vcwz6QdPyJS/Px6wsIko7o0PZ0+94GhP/JNx2XphvqUm9gxe+XgKZBqIsMC2MPojFdxD
 eyqQQp/QNSuE25aYNqp26nWZYomFoUQBUPtyAtkVyLHphyZWD2SUAtaHJffHq0NkSOYm
 jP8lWn8wknZ4RO33cbqA+OotV7rkCBSOrX3fGxW3bNliCn1vfs26Ep3+EI+7NxJyo7me
 HJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NHSmdMDC/Sy24mN5oHrLE1OujPQ2Z8sWGmcyLx2TPDo=;
 b=pjFonp/mRFATWT8NGYi64/HURHtQdxNNemxuPUaRU3VMUZCOy0LWuCCPvotH13RScK
 +EEBL7L3dp3pFz3lGt5btv1vIxFGmVbSQT1Z3IpncOEw/ChIU1IOvIgIJrwFPS0anyYH
 qIgTJZB3r20tZPE0H7YBtMHMMWwjktxg6UalI8DZyJ1F6TD2RgRwuehEzN89+s0ltCBb
 3Nkr4g/dW5sN9aqcZGEoZneTDd8LU/EcnnQdAibt21r/AGdHvuMbWyxXXNib5w+lowPe
 jyNoLYfkIr/Yq891n4DyH+qPj6oO1iEdg8GgAfnToT7NHWLrfbcuDb82pzBUqQBRCRBj
 XWzw==
X-Gm-Message-State: AGi0Pub8ckLBU9ykRHYTVesr4tgjCIDYH+j9BoywaFPIJg1CazJZXHlO
 YEAsDnbQB0jAQzykj4Zec1jF9xkDUY8=
X-Google-Smtp-Source: APiQypIuGzd4fNjmkiVGcJoEhPZJdC2gi/u0/n96mqULDcsjdFq3vysXPtUmLy8vDGxx813bJHoekg==
X-Received: by 2002:aa7:957c:: with SMTP id x28mr2230445pfq.31.1588306405034; 
 Thu, 30 Apr 2020 21:13:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id e135sm1080723pfh.37.2020.04.30.21.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 21:13:24 -0700 (PDT)
Subject: Re: [PATCH 35/36] target/arm: Convert Neon fp
 VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-36-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a57ff88f-57d2-9bf2-0cbf-1839003a3783@linaro.org>
Date: Thu, 30 Apr 2020 21:13:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-36-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 11:10 AM, Peter Maydell wrote:
> Convert the Neon fp VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS 3-reg-same
> insns to decodetree. (These are all the remaining non-accumulation
> instructions in this group.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 60 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 42 ++---------------------
>  target/arm/neon-dp.decode       |  6 ++++
>  3 files changed, 68 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

