Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3F8C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC78217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sC4TXVpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC78217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKbC-0004af-Eh
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSKZY-00030u-RJ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSKZX-0007CM-Iz
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:38:04 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSKZX-0007AJ-CL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:38:03 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so25535712wrm.8
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 04:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YOge0QqtcuIlddFRrjy7ps5JM5zsRKGYUfXqx3lLARs=;
 b=sC4TXVpJ5b1BJBWCrlK4a+7PRDZyI4lap2vz/xRWxWuE7B8ntd98YEkuIijBY/fCYw
 tcfwKis3KfZuf+sWPCr7hXqoe5SPg5iK4+OHfDK7v1VXDfeSFpUl++dCS5GQXEQS5Dhl
 QbaQPGlsiWflYKgpO69mBk2BTM03h9cpnIIRxRQhC2UlSl8H//PkqlaXqb0R0R+3icGH
 X/1yNHwj1rK3yGuhLAnVQT+YFCoixP4W2AuyAjlC39cCvfN4IkQY2qocuaxxujdl/Gld
 yf5WCQ7W2bJ4FO66HdzrUYg0nI0XNQvX0x3XxlOkcMK+TgkxB8ObOBuP0mKMFgm2oKQd
 +/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YOge0QqtcuIlddFRrjy7ps5JM5zsRKGYUfXqx3lLARs=;
 b=uA28X7d/UmbsmAsoc9qzWihLvyxoIaCLTQ16xsAonCDgJgPTSWW8VgoJJrqnaYnKho
 n36lJBT1primlzKXhkXfBYKiEzy6COxgWYWdHWhA+friF5oAE278gfa4Cu6lyc041h4T
 tXG3Av8vk1Q+/6YmCu4HjXzCnFegwPyCQUItm6QtvpAPPTXHSOP/HgPsqLlWooN6tHfK
 G1gtb2iQZtMj0QI2T83RMPCXnIKE7JwghiwPKaP2uGIayyyX7Y4zYHF9TBV5E1jdWT9p
 VlZblismyD/lcBSEHt9x0wexekLfRmeuFhmrerXis0Meb2ghcOe5M8ccIZ//jd18qyAO
 RQ7A==
X-Gm-Message-State: APjAAAUlW7NNaIVAlzSue5JTCuiDxucyEYw3h/XeAtwLPU+cDAnJVzSI
 7QG4ii7fe1wvqzZEAp5euUYdVQ==
X-Google-Smtp-Source: APXvYqzKbuvTV/Ug12/b+y870UfB4QkxxsRZ5ndWseoBEkZ16fhfBKVgH5ViMCrXNGD4XrhHJA1Ndw==
X-Received: by 2002:a5d:5230:: with SMTP id i16mr2529051wra.317.1573043881912; 
 Wed, 06 Nov 2019 04:38:01 -0800 (PST)
Received: from [192.168.8.102] (31.red-176-87-122.dynamicip.rima-tde.net.
 [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id w22sm2545916wmc.16.2019.11.06.04.38.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2019 04:38:01 -0800 (PST)
Subject: Re: [PATCH v2 4/4] target/arm: Add support for DC CVAP & DC CVADP ins
To: Beata Michalska <beata.michalska@linaro.org>, qemu-devel@nongnu.org
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-5-beata.michalska@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c7f96f08-1ab2-e5ea-68d7-ec181017ab78@linaro.org>
Date: Wed, 6 Nov 2019 13:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105234100.22052-5-beata.michalska@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 12:41 AM, Beata Michalska wrote:
> ARMv8.2 introduced support for Data Cache Clean instructions
> to PoP (point-of-persistence) - DC CVAP and PoDP (point-of-deep-persistence)
> - DV CVADP. Both specify conceptual points in a memory system where all writes
> that are to reach them are considered persistent.
> The support provided considers both to be actually the same so there is no
> distinction between the two. If none is available (there is no backing store
> for given memory) both will result in Data Cache Clean up to the point of
> coherency. Otherwise sync for the specified range shall be performed.
> 
> Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> ---
>  linux-user/elfload.c |  2 ++
>  target/arm/cpu.h     | 10 ++++++++++
>  target/arm/cpu64.c   |  1 +
>  target/arm/helper.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 69 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

