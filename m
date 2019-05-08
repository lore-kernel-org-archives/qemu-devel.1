Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23713C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDCE821019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCE821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35179 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKks-0007AG-7N
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:28:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKdV-0001Kf-Ul
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKdU-0007Sg-JW
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:21:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKdU-0007Rr-CY
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:21:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so11386635wro.10
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=OSkIv40KGNgEnH+eUeMOVT6Y1cBfn7KPAxfBLJYU9Q4=;
	b=biJW6mnbHYDjpkTqyc8fyVVQohs1lFJvFzchYmj7YNcLPLIC4LueuGUian0OpyqPNJ
	718/ees0E9Tbsts6RJSLqvSlNp+lSCxn97WyDzU79NEJsCAIQjCli6u8KczBYqa2DBlB
	TlYLv4hIWcElQ95i8cm0XxlehaxkOH8CAuDw5VibzSXdK3XZfq+MRL5Ehsl4nHEKa6C5
	gDrrRs9UFuyoob/uK9zdEoyw75Ow+T8Ng5Foo5TKI+G84TenhzmabtxQHe4VPqQeQcgg
	zLWaJtNPsAZ6KJH4O7ypX4RvZab1xHv1gTURqq0UWW56a5LeptA9mB2ZfB9rz0H1npiV
	yAAw==
X-Gm-Message-State: APjAAAUoiflliaIKwhXHFvEKnD0fpAl/gwMjQ2xIxwdaqIY3bfxIwgD9
	z1eeL5x/Ca4wFmcIelaCPMd3Kg==
X-Google-Smtp-Source: APXvYqzZ5HjaZl5n8dJogc9vkTmgZIKijkupsBbtaCnDRTouUGNyOkdYNgq2DvOtpjd5IGxtg9os2w==
X-Received: by 2002:adf:e546:: with SMTP id z6mr20803268wrm.287.1557314479439; 
	Wed, 08 May 2019 04:21:19 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id a5sm3364716wrt.10.2019.05.08.04.21.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:21:18 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-16-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2029e72-f8dc-caee-4db9-277041fba5f1@redhat.com>
Date: Wed, 8 May 2019 13:21:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-16-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 15/16] hw/arm/mps2: Use
 object_initialize_child for correct reference counting
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
> This patch was generated using the following Coccinelle script:
> 
>  @use_sysbus_init_child_obj_missing_parent@
>  expression child_ptr;
>  expression child_type;
>  expression child_size;
>  @@
>  -   object_initialize(child_ptr, child_size, child_type);
>      ...
>  -   qdev_set_parent_bus(DEVICE(child_ptr), sysbus_get_default());
>      ...
>  ?-  object_unref(OBJECT(child_ptr));
>  +   sysbus_init_child_obj(OBJECT(PARENT_OBJ), "CHILD_NAME", child_ptr,
>  +                         child_size, child_type);
> 
> We let the MPS2 boards adopt the cpu core, the FPGA and the SCC children.
> 
> While the object_initialize() function doesn't take an
> 'Error *errp' argument, the object_initialize_child() does.
> Since this code is used when a machine is created (and is not
> yet running), we deliberately choose to use the &error_abort
> argument instead of ignoring errors if an object creation failed.
> This choice also matches when using sysbus_init_child_obj(),
> since its code is:
> 
>   void sysbus_init_child_obj(Object *parent,
>                              const char *childname, void *child,
>                              size_t childsize, const char *childtype)
>   {
>       object_initialize_child(parent, childname, child, childsize,
>                               childtype, &error_abort, NULL);
> 
>       qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
>   }
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/mps2-tz.c | 8 ++++----
>  hw/arm/mps2.c    | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index 7832408bb70..82dce1a7b38 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -214,9 +214,9 @@ static MemoryRegion *make_scc(MPS2TZMachineState *mms, void *opaque,
>      DeviceState *sccdev;
>      MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_GET_CLASS(mms);
>  
> -    object_initialize(scc, sizeof(mms->scc), TYPE_MPS2_SCC);
> +    sysbus_init_child_obj(OBJECT(mms), "scc", scc,
> +                          sizeof(mms->scc), TYPE_MPS2_SCC);
>      sccdev = DEVICE(scc);
> -    qdev_set_parent_bus(sccdev, sysbus_get_default());
>      qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
>      qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
>      qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
> @@ -229,8 +229,8 @@ static MemoryRegion *make_fpgaio(MPS2TZMachineState *mms, void *opaque,
>  {
>      MPS2FPGAIO *fpgaio = opaque;
>  
> -    object_initialize(fpgaio, sizeof(mms->fpgaio), TYPE_MPS2_FPGAIO);
> -    qdev_set_parent_bus(DEVICE(fpgaio), sysbus_get_default());
> +    sysbus_init_child_obj(OBJECT(mms), "fpgaio", fpgaio,
> +                          sizeof(mms->fpgaio), TYPE_MPS2_FPGAIO);
>      object_property_set_bool(OBJECT(fpgaio), true, "realized", &error_fatal);
>      return sysbus_mmio_get_region(SYS_BUS_DEVICE(fpgaio), 0);
>  }
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index 54b7395849f..ecb8ae3c14c 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -174,9 +174,9 @@ static void mps2_common_init(MachineState *machine)
>          g_assert_not_reached();
>      }
>  
> -    object_initialize(&mms->armv7m, sizeof(mms->armv7m), TYPE_ARMV7M);
> +    sysbus_init_child_obj(OBJECT(mms), "armv7m", &mms->armv7m,
> +                          sizeof(mms->armv7m), TYPE_ARMV7M);
>      armv7m = DEVICE(&mms->armv7m);
> -    qdev_set_parent_bus(armv7m, sysbus_get_default());
>      switch (mmc->fpga_type) {
>      case FPGA_AN385:
>          qdev_prop_set_uint32(armv7m, "num-irq", 32);
> @@ -308,9 +308,9 @@ static void mps2_common_init(MachineState *machine)
>                         qdev_get_gpio_in(armv7m, 10));
>      sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
>  
> -    object_initialize(&mms->scc, sizeof(mms->scc), TYPE_MPS2_SCC);
> +    sysbus_init_child_obj(OBJECT(mms), "scc", &mms->scc,
> +                          sizeof(mms->scc), TYPE_MPS2_SCC);
>      sccdev = DEVICE(&mms->scc);
> -    qdev_set_parent_bus(sccdev, sysbus_get_default());
>      qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
>      qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
>      qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

