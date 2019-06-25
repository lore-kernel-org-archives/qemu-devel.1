Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C355CC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B93720665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF0ieVG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B93720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hffdF-0007YL-Q4
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59866)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <atar4qemu@gmail.com>) id 1hffao-0005Gq-KI
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <atar4qemu@gmail.com>) id 1hffam-0004s1-JG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:10:14 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hffaj-0004mS-MC
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:10:11 -0400
Received: by mail-io1-xd43.google.com with SMTP id u19so828909ior.9
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e5yEapvPey+GUZkFY5pyU+anmO8AXON9ahw0k3Xk3iY=;
 b=TF0ieVG2WVvM4tXqZf+dBNbHJzZtdvuV8xQayqAeu+Lp3kZJuOV1bnXE3TJN8/k604
 flXDaL0Uaz4N1XYflSx9BAccz+kftHhc9UhQIIc56RLOPRmPe9UOD+/oBqQNUF37V9VS
 LMxgv3GQ3HYhXXsdoDnWhUCQHIMFHwzMnr7mL6Q/alYxpMNrITbH19qpBLyExEKMcVl2
 Gu9+Tlo7sN26i+PwZf7trbnB2V6fBjSnV9AeC3nnjcy7b1A2vNwgL9ORwwN0L18hobx6
 H73zs9LerxH6yHsIsX/7/jFUZ8MOClxyM2QA3J6URCAKIb5GO7jqCm+uDSka8wyHBFCz
 N0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e5yEapvPey+GUZkFY5pyU+anmO8AXON9ahw0k3Xk3iY=;
 b=m/4NJGBoiDk+bzgf3geWgHTvfmfAG/e3FRPEF/uaH1cX7/PQc3K0Rdi0djeoIHT9H2
 c+8pvC+9lvgMgASS7WWIHVsn6X+oJJY1gJ0otdEw36lil9fSEtC36pCtieidozosX0WM
 p4RWWNLwWstpO4ugD8IgsJs+pfLJs8UQFOFMmbN9sbjHDkmHl3HMyCEQz1UOLvUvawDB
 qgO+/0m3d1IHIW8TlhRz9q9a7J++X9mQzUblF/N4GDDexbCOYr8m8uXMgOpbsJttPYeq
 HKbol4thp7zrOnNawlq2XMgzIySmvpUP+ll4wGTr1N4kjPeHxvIcTAPgP2RzGKVPrBi5
 0CVA==
X-Gm-Message-State: APjAAAUXdhy2JbrfWyb9GwmJx8F6h9zZKppAnJYl2j+Gkvi9aaBmbQix
 N7Ek3UCRuvzNECIxxXrB6DvJKEx9pj6/cPlj6c8=
X-Google-Smtp-Source: APXvYqzORdEPcuIHNW7/pEHGlzCATK4zMB00c6iBafuI7lU2A6lqCW3iAGGNjhpw2/4IX/3AhRGwQ7aQv4xYomYKZsU=
X-Received: by 2002:a6b:6012:: with SMTP id r18mr4368716iog.241.1561446608756; 
 Tue, 25 Jun 2019 00:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190624220056.25861-1-f4bug@amsat.org>
 <20190624220056.25861-2-f4bug@amsat.org>
In-Reply-To: <20190624220056.25861-2-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 25 Jun 2019 09:09:58 +0200
Message-ID: <CACXAS8Au+qyMgFUhZAT6oOnLinSkT0JF4Ut0ZTw-9vUxs3cQhQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH 1/9] hw/misc: Move the 'empty_slot' device
 to hw/misc/
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 12:01 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  include/hw/empty_slot.h        |  7 -------
>  include/hw/misc/empty_slot.h   | 32 ++++++++++++++++++++++++++++++++
>  hw/mips/mips_malta.c           |  2 +-
>  hw/{core =3D> misc}/empty_slot.c |  2 +-
>  hw/sparc/sun4m.c               |  2 +-
>  hw/core/Makefile.objs          |  1 -
>  hw/misc/Makefile.objs          |  1 +
>  7 files changed, 36 insertions(+), 11 deletions(-)
>  delete mode 100644 include/hw/empty_slot.h
>  create mode 100644 include/hw/misc/empty_slot.h
>  rename hw/{core =3D> misc}/empty_slot.c (98%)
>
> diff --git a/include/hw/empty_slot.h b/include/hw/empty_slot.h
> deleted file mode 100644
> index 123a9f8989..0000000000
> --- a/include/hw/empty_slot.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#ifndef HW_EMPTY_SLOT_H
> -#define HW_EMPTY_SLOT_H
> -
> -/* empty_slot.c */
> -void empty_slot_init(hwaddr addr, uint64_t slot_size);
> -
> -#endif
> diff --git a/include/hw/misc/empty_slot.h b/include/hw/misc/empty_slot.h
> new file mode 100644
> index 0000000000..46483f24c3
> --- /dev/null
> +++ b/include/hw/misc/empty_slot.h
> @@ -0,0 +1,32 @@
> +/*
> + * QEMU Empty Slot
> + *
> + * The empty_slot device emulates known to a bus but not connected devic=
es.
> + *
> + * Copyright (c) 2010 Artyom Tarasenko
> + *
> + * This code is licensed under the GNU GPL v2 or (at your option) any la=
ter
> + * version.
> + */
> +
> +#ifndef HW_EMPTY_SLOT_H
> +#define HW_EMPTY_SLOT_H
> +
> +/**
> + * empty_slot_init: create and map a RAZ/WI device
> + * @base: base address of the device's MMIO region
> + * @size: size of the device's MMIO region
> + *
> + * This utility function creates and maps an instance of empty slot,
> + * which is a dummy device which simply read as zero, and ignore writes.
> + * An empty slot sit on a bus, and no bus errors are generated when it i=
s
> + * accessed.
> + * Guest accesses can be traced, using the '-trace empty_slot\*' command
> + * line argument.
> + * The device is mapped at priority -10000, which means that you can
> + * use it to cover a large region and then map other devices on top of i=
t
> + * if necessary.
> + */
> +void empty_slot_init(hwaddr addr, uint64_t slot_size);
> +
> +#endif
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 37ec89b07e..7008be2e5b 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -53,7 +53,7 @@
>  #include "sysemu/qtest.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> -#include "hw/empty_slot.h"
> +#include "hw/misc/empty_slot.h"
>  #include "sysemu/kvm.h"
>  #include "hw/semihosting/semihost.h"
>  #include "hw/mips/cps.h"
> diff --git a/hw/core/empty_slot.c b/hw/misc/empty_slot.c
> similarity index 98%
> rename from hw/core/empty_slot.c
> rename to hw/misc/empty_slot.c
> index c694532046..0adf7a26dc 100644
> --- a/hw/core/empty_slot.c
> +++ b/hw/misc/empty_slot.c
> @@ -13,7 +13,7 @@
>  #include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "qemu/module.h"
> -#include "hw/empty_slot.h"
> +#include "hw/misc/empty_slot.h"
>
>  //#define DEBUG_EMPTY_SLOT
>
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 7e4f61fc3e..cc85598d5b 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -41,7 +41,7 @@
>  #include "hw/nvram/chrp_nvram.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "hw/char/escc.h"
> -#include "hw/empty_slot.h"
> +#include "hw/misc/empty_slot.h"
>  #include "hw/loader.h"
>  #include "elf.h"
>  #include "trace.h"
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index a799c83815..5122a28a3b 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -8,7 +8,6 @@ common-obj-y +=3D irq.o
>  common-obj-y +=3D hotplug.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
>
> -common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
>  common-obj-$(CONFIG_XILINX_AXI) +=3D stream.o
>  common-obj-$(CONFIG_PTIMER) +=3D ptimer.o
>  common-obj-$(CONFIG_SOFTMMU) +=3D sysbus.o
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 77b9df9796..8ed900f9f5 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -10,6 +10,7 @@ common-obj-$(CONFIG_EDU) +=3D edu.o
>  common-obj-$(CONFIG_PCA9552) +=3D pca9552.o
>
>  common-obj-y +=3D unimp.o
> +common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
>  common-obj-$(CONFIG_FW_CFG_DMA) +=3D vmcoreinfo.o
>
>  # ARM devices
> --
> 2.19.1
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

