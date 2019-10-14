Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A75C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBB92133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeYT3fGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBB92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3ks-0003et-5k
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK30M-0002Sp-O3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK30K-00059T-6b
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:15:30 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK30K-00058x-0l
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:15:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id q15so8207891pll.11
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fsxGhNZ46QEvwK37EracEo8Sos6V5W7DxZrOs9pIpdU=;
 b=eeYT3fGJLAucLD+aBe7Wmqm7JyDupeJ6QmUd6IeoEWqCJAOpjnn0wi17gnxOqtUfs5
 HyrojbFWhlTvlFGMpvZvO1H1OUnsYZfobJeBwjGoi7tSEAxyHQv7EXjLy2PqFYLcaB4U
 DOG8twWClZZv4JT2Ic6YRU9uyceHR5tjAp4fLmpLl5Y4jLEbNvHswlg/8SWPvzsyPh9t
 E7CkPDYr8sIGF5WTQmctAYigsHarFL3EVOYOOC/DzVtkfUHnn7LuoNN9TUEqKZz1VubX
 XHzL4i1OT6wEFC640VRHIzKU5EXIlMyw2SKP9DLBc8SgjO5ZQJ4BoYI6uC3zmYNUtbsQ
 qkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fsxGhNZ46QEvwK37EracEo8Sos6V5W7DxZrOs9pIpdU=;
 b=uaZE3VXQFV8cq6R76C3em+cjsz0QP/Orutu8yMyXPfX6DKhugaWuB0kt1qCd8K+oAR
 OUmsWT16NU0vvLG/W9ohx5RQ/rCnQhMNm9zzm50rWja8pNtjM2yggxt4EHtQBgNaXkqT
 CTAU5McX8y8Qv0516L830bQDq1S5kLtJEGXtdS7My8zV9RNg+ZTwCIQE5eLxXJlbQjbK
 RK6ewlFvyQdye3ZOXdjYqv4DUS38pcTvoavnpuPquXvFSDgpihdNLPAOPRLyyiQxOuGT
 dVNKzJINqmonNrX/21I+AqjAreUr1Z+T0eUN2R12an3zif3Lob1M60+SthRKiGfD355W
 5WnA==
X-Gm-Message-State: APjAAAUexR4uS/m6xcbn6gG2qiwFHKqUNVtp28hU0akE3UqQ0P0bYo8v
 ASnW7ywiL3llnxSZ8km1kQWhlw==
X-Google-Smtp-Source: APXvYqwOlqOlqNmX15okjosWN7WP1JQQyoFOdc/z/qwKhb1sBil1BFHf/IpwGgVnHoZpmvTisTvaIw==
X-Received: by 2002:a17:902:74ca:: with SMTP id
 f10mr30466934plt.117.1571069727039; 
 Mon, 14 Oct 2019 09:15:27 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y80sm19607130pfc.30.2019.10.14.09.15.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 09:15:26 -0700 (PDT)
Subject: Re: [PATCH v5 40/55] tests/tcg/Makefile.target: fix path to
 config-host.mak
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-41-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7df2ef1a-3c53-98ad-f6e1-46e7aeb1489a@linaro.org>
Date: Mon, 14 Oct 2019 09:15:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014104948.4291-41-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: robert.foley@futurewei.com, cota@braap.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aaron@os.amperecomputing.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 3:49 AM, Alex Bennée wrote:
> Since moving where the tests are run the path to config-host.mak has
> been wrong. This doesn't affect much but things like the time fallback
> for CONFIG_DEBUG_TCG and will also get in the way of checking for
> PLUGINS support.
> 
> Fixes: fc76c56d3f4
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


