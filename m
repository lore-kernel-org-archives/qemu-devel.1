Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1326FC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D014C207FA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GT+Ej+E1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D014C207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSigx-0007eU-L1
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSifI-0006HN-PB
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSiex-0001Em-5p
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:21:34 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSiew-0001DG-Tt
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:21:15 -0500
Received: by mail-wr1-x442.google.com with SMTP id p2so3263905wro.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eAKRZG3cT2GP679d1DQoMGdpZFfL/CJNZGt6UyTFnMM=;
 b=GT+Ej+E1R6WlgmoOpYRkIQQogoFyJTCHGjB0DSiYep/0XeHEloirS6Wvr+0RreY3Zm
 DajW+y3bXYEJkzSUGTPRYbCHabIN8Y5ux+H1oaMJqPPMPoytwaJHEicWOCO00OSjuHm4
 HPw6BTeUXQKyJb6RmgiLGYj/GlyjUd7nihqY7g1KCGN5CmDfnYb+vWZUlQ47EmONELT6
 I5cvpicNnq09nBulDrCkyYCz6+RNVUAs33IWXJsgzcDZhOYrRUq4tLGD+lA+FDqP365b
 tkhePQTluIR/rJJwB0GbiMaCFHU4svL2GlwjSmC6MDqrSvb3r5QGzrNugDi1bb1RsKic
 +Akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eAKRZG3cT2GP679d1DQoMGdpZFfL/CJNZGt6UyTFnMM=;
 b=n4iKblKb880nLahllTjBonjhsDroMxHv65llV53pnDIhhBUE65izesbc9lzl79Zq5x
 R69zD2tEruiwAMvfP+LtEFMsz1cQLu2Vg17yqsYLGWYX8yhk0H1Xy/XeibeHhxa+jIyt
 08vr6XdLQiHnS0v+WhxAAiAfjK1NI0vbJf+xpcAqYFb10NkvkpvuyJz5neuCxtuEFMNc
 OEfOy/pNru9KRv2lW9HQa53E6zIezErO0WV+4pXMOBXIuCwmQH/z/E29qAe3kzFZk8ot
 eag5S/d6Gc67oSQkMA+tfzU67buDpn56k9sAizoLxJgcIsFw7E5xfcZywG0gMdycu4Yx
 BJ6A==
X-Gm-Message-State: APjAAAVpXXDtIKT7fDkziDmAqPkQ6OBB9ei8kwKamhcTqPcL4VL8xWeS
 aepe/tvlss39K23ByU7h5BsFCQ==
X-Google-Smtp-Source: APXvYqx7C0MFvsKwILMW57X2kxm8+jLrBy+FN4VRt31Kv4DHhmU//bBk7Zb+QgM7Bx2nrA0GIiRCzA==
X-Received: by 2002:adf:a497:: with SMTP id g23mr2972148wrb.135.1573136472637; 
 Thu, 07 Nov 2019 06:21:12 -0800 (PST)
Received: from [192.168.8.102] (141.red-79-149-50.dynamicip.rima-tde.net.
 [79.149.50.141])
 by smtp.gmail.com with ESMTPSA id f143sm3497814wme.40.2019.11.07.06.21.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2019 06:21:12 -0800 (PST)
Subject: Re: [PATCH v1 2/3] target/microblaze: Plug temp leaks with delay slot
 setup
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-3-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a1642d55-edb4-c8bb-1977-9888ddc5c201@linaro.org>
Date: Thu, 7 Nov 2019 15:21:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191106141424.27244-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 3:14 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Plug temp leaks with delay slot setup.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

