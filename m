Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E37C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B85207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mz+fl3bQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B85207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicCm-0000zS-FY
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicBQ-0007u5-Lm
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:12:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28358
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicBP-0002C3-Vq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lAgcTDN/dV/f7SK/NrjUs5/i9Qjg44Eo04qPw3cNtk=;
 b=Mz+fl3bQkC2GwzPhzDzAPlW0mcFnghKc2FTnQ6pT895aKpseCPHXf2DpXbmgmCMe2bkZxX
 n8sG6pi1jkELTAt8I0m5qK4x9uGRO8Uy0Qiwr5sbH2KYBqOBFibYEOcLKP/F2zkh7aQj5C
 4B9YlvwXOI2wQHQ7354DUIM/ecRA4rw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-6xRH__nnNgWxuEx-pVoSIQ-1; Tue, 09 Jun 2020 07:12:32 -0400
X-MC-Unique: 6xRH__nnNgWxuEx-pVoSIQ-1
Received: by mail-wm1-f70.google.com with SMTP id b65so605304wmb.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6lAgcTDN/dV/f7SK/NrjUs5/i9Qjg44Eo04qPw3cNtk=;
 b=fhaRcXDgXTor1ZbXpCFA8uL8otG7pT3VDCzxlmLT9DIEZGiemvet9EQ9LrjiUbxkoQ
 MRabnR38yWNdGMkS+T+aHk+uayezMwtvOQIdvHNOhcHQIV7ZJrHLUBlVSZrttnSq/FPJ
 XtPKPQ2qWuPqgmXwKOCdDCkTZgXU+7rycFBS/lMjY/mgHbC0SvCo/5PhxvGV+1XpGF44
 J6AB8SoUid81RcUqp5cP5mW4wAlKpYTcQPdDPVCHYvvUTWtA0bcuoDHrY7j3vpbCHrHl
 oLYjZmNT5QgkNwdTy+ThyfxxNk2raDUO/8qTU9vWz0NabnykPL4rsgMjbS3cSoxKadMJ
 jNuA==
X-Gm-Message-State: AOAM531gKELQ80dU/DLfMG1ymhYpJ/1BiRg+u+5mxYjvyrZ6J2Q3Ldor
 aQP4bHH1pIjK1/Lrn1IVAhuZnjKdnZb4xY9KfwvSWt3G55Rc5JenCLpzeVildk4wBUl8cFd20x0
 eVTlGbwB/yTGDfFQ=
X-Received: by 2002:a1c:a7c3:: with SMTP id q186mr3257022wme.141.1591701150720; 
 Tue, 09 Jun 2020 04:12:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwew58hVelVmOrF+efwHZuIRFPhx2tAfnSXNsxzJkV6M1Bdv9a4oEF967FsVILY6ztkPcXqaQ==
X-Received: by 2002:a1c:a7c3:: with SMTP id q186mr3256994wme.141.1591701150493; 
 Tue, 09 Jun 2020 04:12:30 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id u130sm2587221wmg.32.2020.06.09.04.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:12:29 -0700 (PDT)
Subject: Re: [RFC PATCH 29/35] hw/ppc/ppc_booke: Emit warning when old code is
 used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-30-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c932d51a-1b7d-bec3-5dfa-222c9ba5090e@redhat.com>
Date: Tue, 9 Jun 2020 13:12:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-30-philmd@redhat.com>
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
>  hw/ppc/ppc_booke.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
> index 652a21b806..a9e5e68578 100644
> --- a/hw/ppc/ppc_booke.c
> +++ b/hw/ppc/ppc_booke.c
> @@ -31,7 +31,7 @@
>  #include "qemu/log.h"
>  #include "hw/loader.h"
>  #include "kvm_ppc.h"
> -
> +#include "hw/qdev-deprecated.h"
>  
>  /* Timer Control Register */
>  
> @@ -338,6 +338,8 @@ void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags)
>      booke_timer_t *booke_timer;
>      int ret = 0;
>  
> +    qdev_warn_deprecated_function_used();
> +
>      tb_env      = g_malloc0(sizeof(ppc_tb_t));
>      booke_timer = g_malloc0(sizeof(booke_timer_t));
>  
> 

This one is okay.

Paolo


