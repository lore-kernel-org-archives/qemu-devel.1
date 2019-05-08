Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4923DC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED8421530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED8421530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKTt-0001nV-7E
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:11:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKSD-0000DE-ST
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKSC-0007bA-D1
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:09:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKSC-0007aE-0p
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:09:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id f2so2722798wmj.3
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wr0k0q7FKcI6IsoL0WjH9SOSxiIfGfF8JyhCKV2olgE=;
	b=JbIu0EB0ucUuK5MERSHSdx8R8djVfJlcQ3oiNDb0wZTeMgZ8LU+dj1szWHyR4Kzfes
	91dgGRANlvJGTk27IB30tbg9JUZeOOTf0ZK4esSBBWjNakiw62rDLGmdRG+IEph1DSLC
	hvaOW+/p0oNXPEPHic3tXBu2SooHZR/sCsDBhi2gN/voE07FonEDq+7vYE/yiOsgD9nE
	kM9Ens4Y5ESE8Xj9QafzUGkRR4lJtr6V8h6xhiTJKsfSV9TdHpB4EAJIoD1fsOV8I9By
	HC3Enc+aOFUt0ltUdAnKY58Rw2VcCbAV93MStNOBH6S3nTDyat8QZZ2ZK/jNKol75iF1
	2BMQ==
X-Gm-Message-State: APjAAAVw8k5HgOLgFDI4oV2O5g44hJkZujomiK/lAoliBfrDpx+JMNYB
	TG5vzceD+RHc9d1/1114d9RJxQ==
X-Google-Smtp-Source: APXvYqxB6gHopXIN3NsqFEyy1Xj42EP8Pf6N7DkMibF7Tgfq/7m4fbRY+7Uc8OLtg7mOcpFFHy1gAQ==
X-Received: by 2002:a1c:988b:: with SMTP id a133mr2036763wme.89.1557313777401; 
	Wed, 08 May 2019 04:09:37 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	b10sm2905437wme.25.2019.05.08.04.09.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:09:36 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-5-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a261e867-ff96-d9f7-cf99-6f08e50b20f8@redhat.com>
Date: Wed, 8 May 2019 13:09:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 04/16] hw/arm/bcm2835: Use TYPE_PL011
 instead of hardcoded string
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/19 11:34, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/bcm2835_peripherals.c         | 2 +-
>  include/hw/arm/bcm2835_peripherals.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 6be7660e8cb..7ffb51b6927 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -46,7 +46,7 @@ static void bcm2835_peripherals_init(Object *obj)
>      qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
>  
>      /* UART0 */
> -    s->uart0 = SYS_BUS_DEVICE(object_new("pl011"));
> +    s->uart0 = SYS_BUS_DEVICE(object_new(TYPE_PL011));
>      object_property_add_child(obj, "uart0", OBJECT(s->uart0), NULL);
>      qdev_set_parent_bus(DEVICE(s->uart0), sysbus_get_default());
>  
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
> index f5b193f6707..959508d57dd 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -13,6 +13,7 @@
>  
>  #include "qemu-common.h"
>  #include "hw/sysbus.h"
> +#include "hw/char/pl011.h"
>  #include "hw/char/bcm2835_aux.h"
>  #include "hw/display/bcm2835_fb.h"
>  #include "hw/dma/bcm2835_dma.h"
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

