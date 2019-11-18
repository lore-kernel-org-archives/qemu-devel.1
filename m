Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0ACC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92C720692
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5l6RIsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92C720692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdC0-0006Kb-Kb
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWdAh-0005M3-TO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWdAg-0005Vt-Ud
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:18:11 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWdAg-0005VE-NO
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:18:10 -0500
Received: by mail-wr1-x441.google.com with SMTP id n1so18446721wra.10
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 01:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dBltSqMfc78oMDhG0bcMTqKcDslRY7QiuMmUrx3d/0s=;
 b=S5l6RIsE7KOJ7n0B00DaMjYFsyUyYF5j4iQdoFRvlpWvFqaSflqnB9kKOU5quYFSDx
 AgZCyQ6lxwdJ0ovNalTyQfxtNSV0i6X1uyeSWga55sSzrFDIk4z1CR7iJKRr0xJNErA9
 okgZN6gkQhpze/K2G0N+sg0X+X0p7k5kMxnhpOnCY+Q2kf68orb1hsCCHJ2sGY6DSCeU
 9V2E7FzYl/RLIFwf3It16UhJVaIoVIZb5qxcs6BCYx2Nvc9DNhnfSrnz8evzY6Hp2WU8
 SX48LOklOL7IEOHpjsYoB09qZFGl85Wh4epTLC2v+lYhwbE8m2fXwygJl6pQob6+uAMv
 cooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dBltSqMfc78oMDhG0bcMTqKcDslRY7QiuMmUrx3d/0s=;
 b=BjkCm8uzTHCFnN2iTM7mOFZDCZp+ikyMGVffZ28mKVZXgHQ31qqjFd5crnVKRCSalg
 IOfVlViEPXFFwCn8MClznbwt6bQFIowZn4o/VkkRzmPBKylj80k9gfFUXT5Ea9UYAClI
 w4SsqqBn0dhpeFALeYb27swvlj24+alQyeEI5LGSU6lUn0lg2m/ifov9zElhl28J2mn3
 wahNADd/ddJw5Dxuh17ecJDYU2diijgjwhPRedVDldKAGDfdeIvM1vT6Kbkh4s1r25v6
 3SahacfL+4xC/G9bqSUu104roE8xtF8/1KciSHoWEN9tionH+OEriSAj8bJl5ydIJgap
 mGlQ==
X-Gm-Message-State: APjAAAWsXT+gNNPGmPF6kIjGMKGPIIUQFaHApJpjMdnLf26RsHL8M25f
 spHi30Dlm5a/n3GxF/bHaotrkRM6UCNklA==
X-Google-Smtp-Source: APXvYqxyaw9BWtVfp2l2aYr89m0JWxs8TbfLPO627VWS5J8o/HtAnwVvpvD/BWACCbz5OnXFDhQxeg==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr8176005wru.54.1574068689329;
 Mon, 18 Nov 2019 01:18:09 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id w4sm22442213wrs.1.2019.11.18.01.18.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 01:18:08 -0800 (PST)
Subject: Re: [PATCH] Modify tests to work with clang
To: Taylor Simpson <tsimpson@quicinc.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
References: <1574032465-12186-1-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <71cd523d-c03a-79b3-669a-ee966745f74d@linaro.org>
Date: Mon, 18 Nov 2019 10:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574032465-12186-1-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

On 11/18/19 12:14 AM, Taylor Simpson wrote:
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  tests/tcg/multiarch/float_helpers.c | 2 --
>  tests/tcg/multiarch/linux-test.c    | 6 +++++-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


