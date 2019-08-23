Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F96C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE5521019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zsr3Ogkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE5521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DEt-0006x2-7o
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DDh-00065i-TB
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DDg-0001f6-V8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:19:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1DDg-0001eY-Ng
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:19:24 -0400
Received: by mail-pl1-x644.google.com with SMTP id w11so5451595plp.5
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z2x0jFIlNL76Uaj2LvW0TIgjYOb8Ha7i6oGNV0+efUY=;
 b=Zsr3OgkhCYAl7nknzayeh5HWZ69VAi9UaGnGvfoehqqBKpFNZCREazGz9A9YH/uS0v
 6seM3mZKAivOgrBIDFzYrEPnhwFXYDTAfBPjl52jLyJ7A1MPxr+abIfjzjecqp+6tkQw
 d+jAP2gQNU96hokkbo3Y/XQ7XkdgTRdKisGzilTunKu5M/gPqgZ5+jPeoJynF6746a0g
 FJEEMxVmu8J+LUu5ImNbnUGSYcK1x1MW0TqiS+ITbKaDMbPJJhcBMLrRKPOg5McoPGCt
 w4hzM6t3OISJhky5s0XvlhL2MMkdhX0Rt7VbbUk9A8m8TFrufx3xr793N/1ch04zjhvA
 6fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z2x0jFIlNL76Uaj2LvW0TIgjYOb8Ha7i6oGNV0+efUY=;
 b=flqyDQh0FUEJVf5O4sy8mzRyCmokShqRTuapj3LGRlGvakSvFAIvU1uiYjGWYwDr6e
 uoDcyE9kMGT4++inIcy7nyzrlShkdD7USoNqI399KMl/c6UDmBvznHND2W1m4jeM0a/0
 Gu59A5f9t9OCCLTo+BvPiJyxtjWxupWpkJ+cfhPnVh5GKT8AvabHGP2f8astUcSXeIoH
 AlR+Hm5BjWFWLoGvs20M9mHaxq0AxbwjfzBoIoTKGrpSkaAE1++Tc11YRFulV6HVsI5C
 jZHTtQqQXWUhaJRusqDRSHJ9j4h1pBdRiK/8ibL/P86A658NaJJhklmZdFy4pahEg1/q
 O8ig==
X-Gm-Message-State: APjAAAWL/eSh7I5/d7vM9bNUbWqh2/dVYplXtSoPXsgwzQwi/tXT8Jtr
 LL0jzQNeDQTu3DUqmiq593D6Cw==
X-Google-Smtp-Source: APXvYqwLVRC4x5+JNhg5FAQ5B44YXt/sFX9nF9cCgibfXxf6l4bsMQfA1mLa0z1a9+npeHBNoOfISQ==
X-Received: by 2002:a17:902:20c2:: with SMTP id
 v2mr5523918plg.209.1566580763504; 
 Fri, 23 Aug 2019 10:19:23 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t4sm3572917pfd.109.2019.08.23.10.19.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 10:19:22 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190823143249.8096-1-philmd@redhat.com>
 <20190823143249.8096-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7032b17b-148a-47c4-7347-8b954ae1dc52@linaro.org>
Date: Fri, 23 Aug 2019 10:19:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823143249.8096-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v2 1/6] hw/arm: Use ARM_CPU_TYPE_NAME()
 macro when appropriate
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
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 7:32 AM, Philippe Mathieu-Daudé wrote:
> Commit ba1ba5cca introduce the ARM_CPU_TYPE_NAME() macro.
> Unify the code base by use it in all places.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: rebased, use in imx25/31 (pm215)
> ---
>  hw/arm/allwinner-a10.c | 3 ++-
>  hw/arm/cubieboard.c    | 3 ++-
>  hw/arm/digic.c         | 3 ++-
>  hw/arm/fsl-imx25.c     | 2 +-
>  hw/arm/fsl-imx31.c     | 2 +-
>  hw/arm/fsl-imx6.c      | 3 ++-
>  hw/arm/fsl-imx6ul.c    | 2 +-
>  hw/arm/xlnx-zynqmp.c   | 8 ++++----
>  8 files changed, 15 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

