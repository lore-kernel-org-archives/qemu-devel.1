Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9910C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DFF204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5aBY8a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DFF204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3eW-0000P5-IU
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 10:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb3b0-0004NC-BR
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:51:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jb3az-0002sY-AG
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589899909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2HT3iuIDb/WnSbojIPYZzdgqCWoPdJ29Fuyn5y7QP4=;
 b=C5aBY8a2Cnp+r8wrfW1WCsMAbkkcM5sByUsm1yzqN923otJxWqmPOCPjIjmSuBBtb57tX+
 yRuhIb/ak3x/KZtNWvNroqXxlZrbdktEYkaMc3SpCFlXC5iJw4QA6ZquR904bisAJPqX88
 /GE4Nm5HSz0y8Q7FsYYT2X9Iq1Qq/QM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-Vmx7BW1QOCmIVvnD7x0HFg-1; Tue, 19 May 2020 10:51:48 -0400
X-MC-Unique: Vmx7BW1QOCmIVvnD7x0HFg-1
Received: by mail-wr1-f72.google.com with SMTP id g10so7390673wrr.10
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 07:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G2HT3iuIDb/WnSbojIPYZzdgqCWoPdJ29Fuyn5y7QP4=;
 b=Lsx4XFpm0AyIuxfIYLSJOaIA/eyPsAIMJO9tVrzwJ23nxhbtbUzB+HfW8KP3iR26vk
 UF3M3q7rAch5MNCLUkltQt1sjm8Q6NE/t6oheqxqMJvfqWTdvfC6EUnyWO9q003QcvN7
 c8RHXd4cZeNR3aADNuW2pYWna5ybxtn3l+tVh+PifBae0CjoMpwZvllMoZ3Vuu04i4ur
 lEeCEy7JzZiM47hKmp6wj/N2WWz8j5Qc+kg9HGGe/w3r+shRr0EiORpoIO3hhKCCL4CB
 /9zKqEEwOw2/vuwP4TcxIc6n0huzrsb74tGmihKdNJ7Mvi6wygvVkchtFjZFMRLyWPbC
 2ktQ==
X-Gm-Message-State: AOAM5303TXlVXM9m+Wv4dhqsfL6rD+tMqzdflQExf4K2SiNA+doSj45v
 pCcbxh8+U7+fSFV5jKrG9Yl7xzYsUGQOo4iNZnz5eMHq5BQECaMsUDpKnn52iTQkAB+w/nJdr5m
 JbzQePBvHkZuhtMA=
X-Received: by 2002:a05:600c:2146:: with SMTP id
 v6mr6076727wml.142.1589899907160; 
 Tue, 19 May 2020 07:51:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYBNiBxKtAOym+hrndmcP11sMZn1LY/tGJzFyQQ211YSxJFB0iSjle+68We+3SBRVSUqR92Q==
X-Received: by 2002:a05:600c:2146:: with SMTP id
 v6mr6076701wml.142.1589899906985; 
 Tue, 19 May 2020 07:51:46 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c80sm4417530wme.15.2020.05.19.07.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 07:51:46 -0700 (PDT)
Subject: Re: [PATCH v6 10/16] floppy: move cmos_get_fd_drive_type() from pc
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200515150421.25479-1-kraxel@redhat.com>
 <20200515150421.25479-11-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c3d5c81-fc38-e1c1-b83a-3c3d8f781dd8@redhat.com>
Date: Tue, 19 May 2020 16:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200515150421.25479-11-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missing "Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>",
otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

On 5/15/20 5:04 PM, Gerd Hoffmann wrote:
> ---
>   include/hw/block/fdc.h |  1 +
>   include/hw/i386/pc.h   |  1 -
>   hw/block/fdc.c         | 26 +++++++++++++++++++++++++-
>   hw/i386/pc.c           | 25 -------------------------
>   4 files changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
> index 5d71cf972268..479cebc0a330 100644
> --- a/include/hw/block/fdc.h
> +++ b/include/hw/block/fdc.h
> @@ -16,5 +16,6 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
>                          DriveInfo **fds, qemu_irq *fdc_tc);
>   
>   FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
> +int cmos_get_fd_drive_type(FloppyDriveType fd0);
>   
>   #endif
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 8d764f965cd3..5e3b19ab78fc 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -176,7 +176,6 @@ typedef void (*cpu_set_smm_t)(int smm, void *arg);
>   void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
>   
>   ISADevice *pc_find_fdc0(void);
> -int cmos_get_fd_drive_type(FloppyDriveType fd0);
>   
>   /* port92.c */
>   #define PORT92_A20_LINE "a20"
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 8024c822cea3..ea0fb8ee15b9 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -32,7 +32,6 @@
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/timer.h"
> -#include "hw/i386/pc.h"
>   #include "hw/acpi/aml-build.h"
>   #include "hw/irq.h"
>   #include "hw/isa/isa.h"
> @@ -2809,6 +2808,31 @@ static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
>       return dev;
>   }
>   
> +int cmos_get_fd_drive_type(FloppyDriveType fd0)
> +{
> +    int val;
> +
> +    switch (fd0) {
> +    case FLOPPY_DRIVE_TYPE_144:
> +        /* 1.44 Mb 3"5 drive */
> +        val = 4;
> +        break;
> +    case FLOPPY_DRIVE_TYPE_288:
> +        /* 2.88 Mb 3"5 drive */
> +        val = 5;
> +        break;
> +    case FLOPPY_DRIVE_TYPE_120:
> +        /* 1.2 Mb 5"5 drive */
> +        val = 2;
> +        break;
> +    case FLOPPY_DRIVE_TYPE_NONE:
> +    default:
> +        val = 0;
> +        break;
> +    }
> +    return val;
> +}
> +
>   static void fdc_isa_build_aml(ISADevice *isadev, Aml *scope)
>   {
>       Aml *dev;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2128f3d6fe8b..c5db7be6d8b1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -385,31 +385,6 @@ static uint64_t ioportF0_read(void *opaque, hwaddr addr, unsigned size)
>   
>   #define REG_EQUIPMENT_BYTE          0x14
>   
> -int cmos_get_fd_drive_type(FloppyDriveType fd0)
> -{
> -    int val;
> -
> -    switch (fd0) {
> -    case FLOPPY_DRIVE_TYPE_144:
> -        /* 1.44 Mb 3"5 drive */
> -        val = 4;
> -        break;
> -    case FLOPPY_DRIVE_TYPE_288:
> -        /* 2.88 Mb 3"5 drive */
> -        val = 5;
> -        break;
> -    case FLOPPY_DRIVE_TYPE_120:
> -        /* 1.2 Mb 5"5 drive */
> -        val = 2;
> -        break;
> -    case FLOPPY_DRIVE_TYPE_NONE:
> -    default:
> -        val = 0;
> -        break;
> -    }
> -    return val;
> -}
> -
>   static void cmos_init_hd(ISADevice *s, int type_ofs, int info_ofs,
>                            int16_t cylinders, int8_t heads, int8_t sectors)
>   {
> 


