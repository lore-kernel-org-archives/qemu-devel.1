Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5805C41514
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769F321848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cF/eo0TM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769F321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DUL-0003AA-In
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DNt-0005SE-J4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1DNs-00056f-HU
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:29:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1DNs-00056E-B0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:29:56 -0400
Received: by mail-pf1-x442.google.com with SMTP id o70so6880811pfg.5
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lSRc/EYedoSGfDyvA5pSG0DkenOoEztPhaYLjMmZDjg=;
 b=cF/eo0TMTCpLiYbUD+lgWP+o9BMD/A51fAhT6CY67bHsSKB99l9Xn/YtlZ/Gl0Kky6
 LUGW9pAAOXkxmppc3cWD8q8024NgJRTlm+JKoHSdvqot2DmC6lHTS1pZQuE1y43afux7
 8TT3dI46TZJOCxLQLD12Q/JywrNdoyBSte5NixFHfsuzFhLtZl7NnwCimGCtiOaTtieX
 l27x55j+bg/I4VZW1yW66XS41dy41MpXlW4z2nhAL3yI9ZZcdvoyB/R9ODdH8RSMFqw4
 y4eViap4eRP8m/uWmxtlnYd1DuV2tOZe8Z/kNDhquzU2QQZAZgpfUJLnFY5n1pZIXs2x
 H0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lSRc/EYedoSGfDyvA5pSG0DkenOoEztPhaYLjMmZDjg=;
 b=Urv+Qw1pjs0nvP8Rmk09/vAExAnatWeHgQ5imdzhzhdoac3yz1lXnDAkMYGQOLSl+k
 GSvbaAtoCruRtnbMdNt/ObL/62l45IusbRE9mpUiGuDpxir6O1X7I8knpfmC+/eJeaJ1
 uP54pkQz410ZiBCJc5eSGwd8cdV4mkCIZwkM6xooMF3TKfI58Nce2xflXCzhJxIKmluZ
 SEbaeVANFvha0E+oB0iEIhMZFOUFymywlSFQi81PTrhEIPmCroR2EBA+DTNLrJSLd1yp
 ZdeD2Tlvtb0KzUfk64vCYjigPqPMxGL/1myO2PUGw+JM6RTIhLfcWIXzUp+qsjwf4tPT
 82eA==
X-Gm-Message-State: APjAAAWw/gJp+9gpza5Y4/K5+lHwubTM8sm45LS724KS2gpQ51rtlfwe
 I+hDfkpD6gNf3B6zg2of2n1Fxw==
X-Google-Smtp-Source: APXvYqyXaTYcAI2MdcUAwtwj851r8E4jKQ2X7iOt29xHr0GEA1HkGKcPAIaBPXCz95jNUx4e4aQ3mw==
X-Received: by 2002:a17:90a:d592:: with SMTP id
 v18mr6359471pju.135.1566581395250; 
 Fri, 23 Aug 2019 10:29:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p1sm3154585pff.44.2019.08.23.10.29.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 10:29:54 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190823143249.8096-1-philmd@redhat.com>
 <20190823143249.8096-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9cca044d-47d0-8048-02d4-f34d05755b76@linaro.org>
Date: Fri, 23 Aug 2019 10:29:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823143249.8096-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 5/6] hw/dma/xilinx_axi: Use
 object_initialize_child for correct ref. counting
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
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: fix typo ENET -> DMA in TYPE macro name
> ---
>  hw/dma/xilinx_axidma.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


