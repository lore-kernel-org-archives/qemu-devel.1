Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948CEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9C8207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKUqEEYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9C8207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicCP-0000WZ-Ip
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic9v-0005gh-2X
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:11:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic9u-00022r-6x
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gC6WEmr69REgLn2lsRvv9NiGoR/bD5T6HVmJ4ITPF7o=;
 b=MKUqEEYxr+tXS/WnVImsNVkESZCN52rzgnGVVqCOo47TU9mBwPU7xgPtfJqSU2yicTt/c0
 kqm3UXwsk6R1nlldv+2Yuc8xZHoR2WQvCO8yBXP2Xfa60juhVkINNCJTJM+V+9qUIcS1bM
 ejboYQ2UZdp6GUZ9WV8DPfS1HSPgFR8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-BscNuXfWPEu63lrZVCSaiA-1; Tue, 09 Jun 2020 07:11:07 -0400
X-MC-Unique: BscNuXfWPEu63lrZVCSaiA-1
Received: by mail-wr1-f69.google.com with SMTP id i6so6868526wrr.23
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gC6WEmr69REgLn2lsRvv9NiGoR/bD5T6HVmJ4ITPF7o=;
 b=jOqE9Q6kXX4XC3VEg7m+/vp0Qq/vff3dKcxOeUs6aiVIUkRSEhyEuzeBc4/TuoXSnq
 ruVob3BXHB2iDhgFpLqFnoi8diIV7vz55cCW3ttxUHiVWvWqG7ROAljPQKgTMHHoFPeJ
 nCOFxgf4G7P/hmmcOUXHBDx6dskZhHy9XDM5LhjXyjtMdGWYagqZowQqq2wRE071A+Kc
 E72eLNh5kgMat+pzIxHev0oERlnsQ4qxqUBsRyGFp/1U6IjbMEU3EjD2eQ2z+O/UWK0e
 Hy1f8esKRW0Mw01p8HIhBFv3+iO0y9h6zPEpqvT8HVPDW030DDr4Ne28HKAyY/L7jogc
 25DQ==
X-Gm-Message-State: AOAM533ia7xefvQMkjrvxcuFEWDTyOKvNx0VE6uOmryMjn5Gy2MpLB4+
 MlRszJNm9/zpwhmU9ZIMckKTGFrIbzdIhL2VwbdEHloLYrqYcWSmeKmNXS62RIFm9BP906ra/co
 LdnMLKL+QW2PlfhU=
X-Received: by 2002:a5d:628c:: with SMTP id k12mr3812479wru.211.1591701066334; 
 Tue, 09 Jun 2020 04:11:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY3Up1ym4TzRU1NS9l49R/XWUODvDMW5M2cEwgU3BofYT4BEs0ckiayOWBTvyLMfPr7vv94w==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr3812427wru.211.1591701066086; 
 Tue, 09 Jun 2020 04:11:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id r12sm3176227wrc.22.2020.06.09.04.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:11:05 -0700 (PDT)
Subject: Re: [RFC PATCH 21/35] hw/lm32/lm32_hwsetup: Emit warning when old
 code is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-22-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e036ca7-753b-55fb-3a19-7d50f5b6fd19@redhat.com>
Date: Tue, 9 Jun 2020 13:11:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-22-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/06/20 18:00, Philippe Mathieu-Daudé wrote:
> This code hasn't been QOM'ified yet. Warn the user.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/lm32/lm32_hwsetup.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
> index de94de177a..f4a4d8fe4b 100644
> --- a/hw/lm32/lm32_hwsetup.h
> +++ b/hw/lm32/lm32_hwsetup.h
> @@ -27,6 +27,7 @@
>  
>  #include "qemu/cutils.h"
>  #include "hw/loader.h"
> +#include "hw/qdev-deprecated.h"
>  
>  typedef struct {
>      void *data;
> @@ -57,6 +58,8 @@ static inline HWSetup *hwsetup_init(void)
>  {
>      HWSetup *hw;
>  
> +    qdev_warn_deprecated_function_used();
> +
>      hw = g_malloc(sizeof(HWSetup));
>      hw->data = g_malloc0(TARGET_PAGE_SIZE);
>      hw->ptr = hw->data;
> 

This one is okay.

Paolo


