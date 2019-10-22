Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967C2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C312084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgk84VbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C312084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMq6g-0002md-Js
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iMq5y-0002Ls-06
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iMq5w-00041u-O2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:04:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iMq5w-00041U-G5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:04:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so11869674wrr.10
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=UmHm3AiSqt2iVMcVU/NWv6PsSOjF93eUoyVo/nVpHXM=;
 b=Rgk84VbKzRTyfv2LVMoR7vqhHqHp5oTrMRf+xv+FCx3r4wd3HQMHsipV4lG2qWuAHO
 AMSC/3S8nilAy2d/SvFgAvKr//ftRq66xa4AfaU2ndrs/6adFk8yIzILaCUV4AfLXQ4Q
 dFwdVChZJl4JGiyTmB6+8A/NJYOPyg+ZLP2KiwqUMQteLL3KT4SzJSXDAaKxbwq3lvve
 rMhPul5oFsqt0IZQj7j0z6kUK+rvw8K5fpK37fMChZvrijEYXgK6k7b1SLTusZfmaSoa
 dQG2GKhwhjSMF2bYpuD+N74wWmPs3vWKEBBNAWz2UYTSdYqSEMwQDLnKDcYeDIaZlxrq
 T/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=UmHm3AiSqt2iVMcVU/NWv6PsSOjF93eUoyVo/nVpHXM=;
 b=LgP6e3/244gEO6neovFSSvy5mp7scZ3sdbUkIeluJqYvmOrtS0WHq5iSZNj/N7hGKM
 HywC2KXhsmBAwYYgTh9TunmS/8Z2JUGv/jZfgZPnTp0ZTMDXRFTWFuwH8/fMGZY0Apcf
 3fBz5VPvIhlyt4oPlFMSH6xtKIMX1LzwQ3fxjBAR6EZmni2RPbzCXk2TYCJglpRLvcIB
 2o+3SLS6SvqNjoXufVrpMtJtHfuSYsrtFqRKfS+KFb1mfcAuylQM+pTS7IHGbGn/Bu8d
 fmME+t7o/qaLOf5BhJ0PWPXatwb668sGuOv1P+FC55XlN1cPWWHKy8vCYVPDNpNICjZk
 qq/w==
X-Gm-Message-State: APjAAAWn2VQ9zMduAutK/oxJ/V1j7aFqn7Eqw+wMcK2OKdgqzPmspMx3
 EYD6dwTH3kitYaU5f6XPnG8=
X-Google-Smtp-Source: APXvYqxVYmvwr0OhwG+/kv7s0CufodGfHDOH/vZgEl7VSIlA5CXUiiaAI8JhuMY9dP0g5S0uSulMcw==
X-Received: by 2002:adf:b219:: with SMTP id u25mr2318597wra.327.1571735087015; 
 Tue, 22 Oct 2019 02:04:47 -0700 (PDT)
Received: from ?IPv6:2a01:c23:604c:2a00:af2b:2e92:39f9:c05b?
 ([2a01:c23:604c:2a00:af2b:2e92:39f9:c05b])
 by smtp.gmail.com with ESMTPSA id v11sm15086925wml.30.2019.10.22.02.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 02:04:46 -0700 (PDT)
Message-ID: <43c8125af50404df58b1336a22dbc0298ac0f868.camel@gmail.com>
Subject: Re: [PATCH v2 06/20] piix4: Add a i8257 DMA Controller as specified
 in datasheet
From: Esteban Bosse <estebanbosse@gmail.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org
Date: Tue, 22 Oct 2019 11:01:16 +0200
In-Reply-To: <20191018134754.16362-7-philmd@redhat.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-7-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

El vie, 18-10-2019 a las 15:47 +0200, Philippe Mathieu-Daudé escribió:
> From: Hervé Poussineau <hpoussin@reactos.org>
> 
> Remove i8257 instantiated in malta board, to not have it twice.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-9-hpoussin@reactos.org>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> [PMD: rebased]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/isa/piix4.c       | 4 ++++
>  hw/mips/mips_malta.c | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index ac9383a658..0b24d8323c 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -29,6 +29,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/isa/isa.h"
>  #include "hw/sysbus.h"
> +#include "hw/dma/i8257.h"
>  #include "migration/vmstate.h"
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
> @@ -167,6 +168,9 @@ static void piix4_realize(PCIDevice *dev, Error
> **errp)
>      /* initialize ISA irqs */
>      isa_bus_irqs(isa_bus, s->isa);
>  
> +    /* DMA */
> +    i8257_dma_init(isa_bus, 0);
> +
>      piix4_dev = dev;
>  }
>  
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index e499b7a6bb..df247177ca 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -28,7 +28,6 @@
>  #include "cpu.h"
>  #include "hw/i386/pc.h"
>  #include "hw/isa/superio.h"
> -#include "hw/dma/i8257.h"
>  #include "hw/char/serial.h"
>  #include "net/net.h"
>  #include "hw/boards.h"
> @@ -1430,7 +1429,6 @@ void mips_malta_init(MachineState *machine)
>      smbus = piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
>                            isa_get_irq(NULL, 9), NULL, 0, NULL);
>      pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
> -    i8257_dma_init(isa_bus, 0);
>      mc146818_rtc_init(isa_bus, 2000, NULL);
>  
>      /* generate SPD EEPROM data */
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>


