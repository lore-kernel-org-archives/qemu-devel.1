Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D960C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F6A2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hjw0DGqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F6A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jic3F-0005jd-U4
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic2N-00052j-34
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:03:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21660
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic2L-0000Sk-QK
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591700600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AGuN3wM4I0BralfErs2ulp7k2NU1Mw2uS1iHN1MhyPM=;
 b=Hjw0DGqkKb/riXWMqn+f9iplwRDu8qEiXr7tpDYWrz02YwUD/zijRZCAqP1N92rrJUB+kl
 jn8Wtq6GG7URPz7yUT6gXDc8W5qSrIgBM2cSnJ0GY1dkng60ODEfUZ004HlPKCnOQFhyDy
 ZNG8Ih1pRxY1PZVTRR/xYk7/HNB6jyU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-AGKns1sEOxylKphsCAUxLQ-1; Tue, 09 Jun 2020 07:03:18 -0400
X-MC-Unique: AGKns1sEOxylKphsCAUxLQ-1
Received: by mail-wm1-f70.google.com with SMTP id k185so515297wme.8
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AGuN3wM4I0BralfErs2ulp7k2NU1Mw2uS1iHN1MhyPM=;
 b=ToAC2G9EJS4FzDhBaTHSneciBIrG7L2hijqxvQox/jg7a0GkdiJZAyeHT1nZp1mBSZ
 wJDmIOw60JpzHTlDebafTM/9CrJ6MKg1dPZMdJatnaw5876Xwov+wB0DHmUZQq2Ntm2n
 GaVxqjZ5syOUAx6bG6gdduB8iu8kf7aOJggru6Rr3TexmeKrNapRSyiR2VCIhNo9fqUU
 T9xe50rGCDHxjrSEzGcLW6VWPdRhUHscBReOAK2bwIzWLVCa6KAabNP486Eqk/kcLSUv
 TBCy2NS5E/SrnpNnD4biwLphCRBqjrmAhmjMMpK8o5u6o2WDqRMQ9LEwph2fOWu5XewG
 TWTw==
X-Gm-Message-State: AOAM531RsHziUAvb9ncLM/mYH9xtELTJ4DWKTdDYfqdZLRY7sm9yGMdN
 aMMx/8Mkkw6Pk9PhtPjVSpaMLp5ormD8/nuX/KFVQFUuiCUXcOCKlUHvKHYy/enTVv5LzFlg+1v
 E8WTin5YZjfQOMFQ=
X-Received: by 2002:adf:fdcd:: with SMTP id i13mr3615823wrs.190.1591700597658; 
 Tue, 09 Jun 2020 04:03:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDvLBQJgRiWZcWe2u7EwQcm+tdrRwDV7JS7cSYFfquo5pnCwJjyQFwLMFNNTExDMlkFTA1qg==
X-Received: by 2002:adf:fdcd:: with SMTP id i13mr3615759wrs.190.1591700597265; 
 Tue, 09 Jun 2020 04:03:17 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id u3sm2969549wrw.89.2020.06.09.04.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:03:16 -0700 (PDT)
Subject: Re: [RFC PATCH 33/35] hw/timer/slavio_timer: Emit warning when old
 code is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-34-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bc0385a-9738-a9ea-d3c9-115955d5e8e6@redhat.com>
Date: Tue, 9 Jun 2020 13:03:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-34-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>  hw/timer/slavio_timer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> index 4c5d65e391..16f21669bf 100644
> --- a/hw/timer/slavio_timer.c
> +++ b/hw/timer/slavio_timer.c
> @@ -31,6 +31,7 @@
>  #include "migration/vmstate.h"
>  #include "trace.h"
>  #include "qemu/module.h"
> +#include "hw/qdev-deprecated.h"
>  
>  /*
>   * Registers of hardware timer in sun4m.
> @@ -392,6 +393,8 @@ static void slavio_timer_init(Object *obj)
>      unsigned int i;
>      TimerContext *tc;
>  
> +    qdev_warn_deprecated_function_used();
> +
>      for (i = 0; i <= MAX_CPUS; i++) {
>          uint64_t size;
>          char timer_name[20];
> 

This one is okay.

Paolo


