Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6E9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994CB207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLI4a2aL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994CB207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicHS-0007jd-PT
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicB6-0007Ul-Vw
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:12:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicB6-00029t-2z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4X2TCEtUozOLaXo/L8sScbontTQvUPvWMYmEeL8dy0=;
 b=ZLI4a2aLt3CRTUxwrgbCbxqfQ+ezX64gtEFCWNJbZNJs0KZ7dlkF4ASVsXN0MFLQquTO3e
 ps+2ml6rPZTj/NU6M7NmzBfMW0RZ49EIZnqdiunJZ5SyXUYNaWJpd8IpJSjva09Hz+7PXZ
 7QVbYJDBcXD3V24akhCKZYjVrxlCouE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-ZE_YTduAMkWdXciefXnIoQ-1; Tue, 09 Jun 2020 07:12:19 -0400
X-MC-Unique: ZE_YTduAMkWdXciefXnIoQ-1
Received: by mail-wm1-f72.google.com with SMTP id h25so789195wmb.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l4X2TCEtUozOLaXo/L8sScbontTQvUPvWMYmEeL8dy0=;
 b=sk3ydFFYxU2ldjdbOp7pUFfkiDyYglnbPwihORQHACn1gUPpgguvNWjzumDELDcVtz
 bBM3zf8PwOi8UGyb5yh2mtxoNZv4lAAeR3S30Jjqe34kTm/9S//IsmYm7nyYiTVemgdR
 bUVLyCBXn438dLPRbEiW7A67/nkRYYtsKadeUhfAR2FZh9T45+NZx07Nxo4I+B5V71WK
 PS4NS6pMZYQSH26Rk4CVgCG6Q5VkiupZNXtRk9jOkmClLWHWt/lG6Bo/HYL0PKU+0wF3
 0Z6Ac0N8Hl6xJKtCXlBREekUz4HvXXvR5V9d3BXQnu7a9LHqDW+llpJAu7O4muho1wk9
 p//g==
X-Gm-Message-State: AOAM532ttT4l4/SLb2fFMA6L5InWoL+JdW8L8i52dyQmatPtUBK80xHC
 PZLpdbS45E0MC7+nKumeLtB+dkw+U+l3sFRz8YAP4+ijqtPGvpLC7ELoZSJANh7CgWo3Cd2YAiN
 2v+OdJEJs4UKWLtI=
X-Received: by 2002:a05:600c:4102:: with SMTP id
 j2mr3433697wmi.48.1591701138456; 
 Tue, 09 Jun 2020 04:12:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0awk5HkX0L04n6QbPdprXKsckBJOO0WwKyuM0S0l/M/wQqyP9e9ViVkr5nd7Ja+7n12153w==
X-Received: by 2002:a05:600c:4102:: with SMTP id
 j2mr3433671wmi.48.1591701138230; 
 Tue, 09 Jun 2020 04:12:18 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id o18sm2614689wme.19.2020.06.09.04.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:12:17 -0700 (PDT)
Subject: Re: [RFC PATCH 30/35] hw/ppc/virtex_ml507: Emit warning when old code
 is used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-31-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85d75dcd-f08c-0506-46ee-97e2b5869e0b@redhat.com>
Date: Tue, 9 Jun 2020 13:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-31-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
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
>  hw/ppc/virtex_ml507.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 0dacfcd236..17b8036c38 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -40,7 +40,7 @@
>  #include "qemu/log.h"
>  #include "qemu/option.h"
>  #include "exec/address-spaces.h"
> -
> +#include "hw/qdev-deprecated.h"
>  #include "hw/ppc/ppc.h"
>  #include "hw/ppc/ppc4xx.h"
>  #include "hw/qdev-properties.h"
> @@ -95,6 +95,8 @@ static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sysclk)
>      CPUPPCState *env;
>      qemu_irq *irqs;
>  
> +    qdev_warn_deprecated_function_used();
> +
>      cpu = POWERPC_CPU(cpu_create(cpu_type));
>      env = &cpu->env;
>  
> 

This one is okay.

Paolo


