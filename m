Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F6EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5CA021848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzjgBTQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CA021848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DH1-0008S3-1j
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DG3-0007rm-4u
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DG2-0002VL-7X
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:21:51 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1DG1-0002Uz-W8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:21:50 -0400
Received: by mail-pf1-x443.google.com with SMTP id y9so6493254pfl.4
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GjxqU995+mgVYP/D/PQvEgIjIycH7neC4TN5rf+9wRA=;
 b=dzjgBTQLSsNxDghtavmUoWpVjxfQasfilMidz6Kx+fzpJFJ3gTS9CGlYwCXdwwZHrO
 wBUyd9yFUksR/XT5wGqo80M696DzDKJPZTv4z1/3XRlKjFffdStyz2AB79VktnriNsOE
 0+mIRpKjtNp6q3b1HqQy4mTgzBA5kd4fq3+qVOjgsGgbXVces5E4ZIKiy2aDjfhLrJgE
 RozioY+3Cg7JrANXY/e7brpy8D8jXInvogm2ZbxHHl3nQ5syJESfHWzmOR7GroEvNVWx
 030ImehtAznn2Ya8Ik0C4T/hzN0p1JdytATzElbAmIZdMFx7uiQOUrYPh4GFHZ+Yqcc0
 7AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GjxqU995+mgVYP/D/PQvEgIjIycH7neC4TN5rf+9wRA=;
 b=m95p1ZEDskIM2M19557iczEscd2SuzWWQP9DQVaMJcSduKkNsJfBweu6oUUotjklHZ
 9jX1U/nNMheqwluXSSH3Z6h3ku+s6gsb10XHR0cD6S7S+ldSvAjreqBnagLmL0PIV8Yl
 R7T3tZpNaSXZ1jLcCnov4oCa1rr1TO58fkQx1q6jFX329JHYkZOiKYnae0azZBijXxfJ
 wNITAKBYKrFJi3e7FV+mDtP/TxkSVnLm6J0Zf/w1IUqurc3sGStWs03AjovcZFUj72S6
 iXaH/5BuOFxDFHaTy66O4vQSvDVirpuv+dT4slg8EmtIlyAZ+N9JNy0xuipfkdcRCn/+
 WIqw==
X-Gm-Message-State: APjAAAUNa3J8M0GKcUheviUMNgA5Pf3nTJ+O//R7huo1ggN6tG3I98iS
 9uLnlsVveEirJ/KK4bKzSOy2oQ==
X-Google-Smtp-Source: APXvYqzd+TEN94izEd1ijNFbkF9EfyIt5amddlSc6dqkehzilps13E/v0dcVAuODUAp409UdF9kNfQ==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr6448724pfh.179.1566580908253; 
 Fri, 23 Aug 2019 10:21:48 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z16sm2707496pgi.8.2019.08.23.10.21.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 10:21:47 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190823143249.8096-1-philmd@redhat.com>
 <20190823143249.8096-3-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c084a635-f043-06bf-6226-9832978ca003@linaro.org>
Date: Fri, 23 Aug 2019 10:21:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823143249.8096-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 2/6] hw/arm: Use object_initialize_child
 for correct reference counting
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 7:32 AM, Philippe Mathieu-Daudé wrote:
> As explained in commit aff39be0ed97:
> 
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/mcimx7d-sabre.c |  9 ++++-----
>  hw/arm/mps2-tz.c       | 15 +++++++--------
>  hw/arm/musca.c         |  9 +++++----
>  3 files changed, 16 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


