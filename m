Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B818AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8686A207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbGx7in6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8686A207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jic5G-0007li-Om
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic4G-0006kd-L0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:05:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32785
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jic4E-0000ig-7v
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591700717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4OQhSEiQViO6+Bf5ntoxU/3fnBLGSIOBfTZnNbLbrw=;
 b=AbGx7in6sRZ3b14INbHAPUtJGmz5Ii1j7cP4sRn4nHXj5QluqLWZzW0DDMsHnEMeAjs+i8
 668mhZPYiI34nF4OCVXLGUP32EqITZ8apuJATGH/C3tad/Hg2GzrAwXfilJw1ZzXOxc0FY
 2NXIeWBIlAwYXnhstblzZ25kc/ldBvM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-GTS7Qgq6PVi20wDKmlWw2Q-1; Tue, 09 Jun 2020 07:05:14 -0400
X-MC-Unique: GTS7Qgq6PVi20wDKmlWw2Q-1
Received: by mail-wr1-f69.google.com with SMTP id w4so8489626wrl.13
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S4OQhSEiQViO6+Bf5ntoxU/3fnBLGSIOBfTZnNbLbrw=;
 b=bu6dXDBZeXuj0eVL3kq7KX/PGQhG7ABzODrAiPMXalV/vJsFRN+dDsWO54XETg8GPV
 DV2GAMQAAh6x6e3mzxaFeP711eHOoB+pCVXcvJ1Gc4QcNkBgrp2P2VGm7Q6m2Oe1Cpv4
 c7fGbNA1LPFFZgMfMVgWFw0slDFRL9DWSXZVXVRjXH/DcBTZmZ+9PyjDw297pKjtouzN
 nruuJNGf1l0v6BMfy6IPaY0MzNvsx6jDTG/wOH88ti3PA2emJziZ5vOKQxSYo5eH+BT4
 S0JGSiWcsu20+h1x5KMkK7Z2/6FceT2PJPWADpDVX1c0SSkR0Yj6k/MBhzCXUF1qfP4r
 lv+Q==
X-Gm-Message-State: AOAM533VKq/tV0LDWsdUSjtO2Q+JoICPxvEECWIrY1Dd0N+wpNJesy0L
 0wX1DPhCYmFd/yyw+fxB8bCxYDmZw2cKehdgNyNdcCwWAQZcVuaOo7fOiVG0AzCLFwvFrow9OlD
 iIN9raXyLQKGVMSA=
X-Received: by 2002:adf:ef83:: with SMTP id d3mr3590960wro.145.1591700713616; 
 Tue, 09 Jun 2020 04:05:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypMcVAQwaW/I6vICjH3pnYoVeg7kiHWBRxB9LtVfTU1+Z7wL7jJgUZk4SDqi6hRzq7g/7iig==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr3590931wro.145.1591700713378; 
 Tue, 09 Jun 2020 04:05:13 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id u7sm2957241wrm.23.2020.06.09.04.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:05:12 -0700 (PDT)
Subject: Re: [RFC PATCH 23/35] hw/misc/applesmc: Emit warning when old code is
 used
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-24-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac20d382-3ac3-5c29-8e1e-e3ba1d424138@redhat.com>
Date: Tue, 9 Jun 2020 13:05:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608160044.15531-24-philmd@redhat.com>
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
>  hw/misc/applesmc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> index 1c4addb201..d63f19038d 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -36,6 +36,7 @@
>  #include "ui/console.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
> +#include "hw/qdev-deprecated.h"
>  
>  /* #define DEBUG_SMC */
>  
> @@ -253,6 +254,8 @@ static void applesmc_add_key(AppleSMCState *s, const char *key,
>  {
>      struct AppleSMCData *def;
>  
> +    qdev_warn_deprecated_function_used();
> +
>      def = g_malloc0(sizeof(struct AppleSMCData));
>      def->key = key;
>      def->len = len;
> 

This one is okay.

Paolo


