Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C1BC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A7620679
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOjAxfmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A7620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2GM1-0006EG-D9
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Fsw-0007It-9J
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2Fsu-0003aW-Do
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:22:18 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2Fsu-0003Zr-6x
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:22:16 -0400
Received: by mail-pg1-x541.google.com with SMTP id i18so10708905pgl.11
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kc7AH2q1bUZr62LaZVr8ME4H/0KBqzm432Og2Vs8AtU=;
 b=OOjAxfmhG8gCR3jVNdlt74CBlLFCFmiBobkOFoHAyAZbqvxMBEetMESFpj7CZNCfNJ
 +0EOk6p0ZcUdVL3wlfKBwZz7SJ+Jq4SphIa4s1zPgLo1CMt//8ElqF8jLyBvakDXLxJg
 zn2ppKm8vX5eEOHVgFWeQ0J24dKl1ApwtI2SKUeI7WEpkL1BUxk62GytPD7ADd6pML0m
 MXUpVfIQwbSvBTOxK1GKqr8LihjLtTdFHmKl0rYt2MlCY6QAhDyOpQP2nuSSKx2r5hPt
 oj2Ou7HKVkDCm7hSbMasQtm21PFN7Hnmwn+5lmAE0HYek0WSQ2ewnMwIfREqdDrtb07c
 gqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kc7AH2q1bUZr62LaZVr8ME4H/0KBqzm432Og2Vs8AtU=;
 b=avyOLJ5davTvkBpyUXT84rGE7n53CBXCq8+JqIuyNYuCvgMyekNGzcIVm3Lk+ym3Vo
 mUZuZ7fT4/HtR1lMPdU5VbXHtQxbv2DGVXLjNDNVae/sHePJNo5qbWNcDa3dHx2dswUQ
 KarYRPlzknkUXzgb36izpG+tTM/MyjKPWiRRiVmpW+BTeY9K6WkGRGKmyGUTlSJ5NXRQ
 uR5LtB6ZKMBOePFwqrxgu+rc8I1RlTrugzgT2b89dHH1M3Co6pdABEF/veGGzLLb7wUv
 oix7cFOMZQ1gnye6bhWMDu1DfnNWvymAkNz9kO5vtJDMFHeAbosfKgucq0dV1cTIJLQU
 NU/A==
X-Gm-Message-State: APjAAAVSwnsAEZB8m60IQEsMJEDxF0ggnetTYGoRub4P2ec+7IhDOeCK
 oGMvZ9lMo3LwrgHQQZSnkLIe2w==
X-Google-Smtp-Source: APXvYqzSGa22bpchNFk8UumOXv//nshjwZet0/TLcMT1EtkJ+KC9VSVk8t6jpWJgA33llcnAIqIHLQ==
X-Received: by 2002:a62:1d57:: with SMTP id d84mr19501515pfd.99.1566829335367; 
 Mon, 26 Aug 2019 07:22:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a6sm11877171pjv.30.2019.08.26.07.22.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 07:22:14 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190826075112.25637-1-david@redhat.com>
 <20190826075112.25637-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <69bc2320-c443-96c6-3a3d-df18eb34ae89@linaro.org>
Date: Mon, 26 Aug 2019 07:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826075112.25637-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v2 4/7] tcg: Enforce single page access in
 probe_write()
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/19 12:51 AM, David Hildenbrand wrote:
> Let's enforce the interface restriction.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  accel/tcg/cputlb.c    | 2 ++
>  accel/tcg/user-exec.c | 2 ++
>  2 files changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

