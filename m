Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B983C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D46214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGGBDegc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D46214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU329-0007ru-EC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 02:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU30E-0006ek-TK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2zv-0001L5-Ls
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:48:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU2zv-0001Kw-9N
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588229318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUyxu2lw8DFvW52p6ISZ/jwlNXlRofB9TbTss6th9oM=;
 b=WGGBDegcYvhx5cpBrlUYcPlvqxwk1kCLtdmRLDlIHHSe711AFNn3+KIDc4qLNl/IPpdgB5
 m6BydL1UcmPfypUidBctFSkCgBZW2X427QNtJxXC5xayvbv7ElHBdSv1lBV+WR75HAnMwA
 B65q91lZmasQPT48I1+yVm2/lqNMQ4o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-I0ZKJ97dMiyuR2tEnyS_Jw-1; Thu, 30 Apr 2020 02:48:34 -0400
X-MC-Unique: I0ZKJ97dMiyuR2tEnyS_Jw-1
Received: by mail-wr1-f72.google.com with SMTP id f2so3385789wrm.9
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 23:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cUyxu2lw8DFvW52p6ISZ/jwlNXlRofB9TbTss6th9oM=;
 b=aOY+PsUhSdNM9F1E7YJ/OmtZQIPm4XXrQW9G08jdRXJ/5w1Nfk/tdml1Gr3cS/1yCL
 GU9++VJm9/1zAImoXjv81eAZHlwwGJRydGCiOtfOAfpKc6Vuaul690ZxCsPCdSqhFW/M
 R61PTYBJbyISSq/zMys9aVOv7i18E4o+OUiT9ukssw4ca+2y2bwoUf18Tj5qykYvntww
 Gfmu7aPM5fWLH3tGLJ4WRA0o1s06IV9FyTSwceO2ED9TWXzdKohPGfLXwYgQiYcPXIUJ
 t1yogkK5DJ67Fni5BO7BtkgIfGh2wzYfy49ul0Cs3i4zOIgG1Hbf+zZ/6FNTB96GsNQz
 Txyw==
X-Gm-Message-State: AGi0Pubd7PmrQN+K0QEUQwr0zkt0TbR/qmMJ84MbH/hejfgxNB34tkT2
 x0YCWGOp84pL5/21TRIat740jGUH6m1RsGjOns76rFO9F5vwprasEyHKtyFk7SOti0srtSCuPI6
 GWa2vXRdmM+01evA=
X-Received: by 2002:adf:fe51:: with SMTP id m17mr2027520wrs.414.1588229313649; 
 Wed, 29 Apr 2020 23:48:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypI4EJGMsBk33CPw1CbptVOR3DFMp9swuba8MrRWCBA9cXLUIvs/iibv9GTRJ4bMwYH8mldIow==
X-Received: by 2002:adf:fe51:: with SMTP id m17mr2027487wrs.414.1588229313399; 
 Wed, 29 Apr 2020 23:48:33 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id 36sm2622028wrc.35.2020.04.29.23.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 23:48:32 -0700 (PDT)
Subject: Re: [PATCH v3 15/15] acpi: simplify build_isa_devices_aml()
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-16-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64d04e82-c516-c85d-be6a-19a1eb9b8c1f@redhat.com>
Date: Thu, 30 Apr 2020 08:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429140003.7336-16-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Corey Minyard <minyard@acm.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing IPMI maintainer.

On 4/29/20 4:00 PM, Gerd Hoffmann wrote:
> x86 machines can have a single ISA bus only.

I disagree with the comment.
Machines can have multiple ISA bus.
However the PCI IO space can have a single ISA bus.
This patch is about PCI0.

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/i386/acpi-build.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index a8b790021974..98b3fd1cdb14 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1055,19 +1055,14 @@ static void build_hpet_aml(Aml *table)
>   static void build_isa_devices_aml(Aml *table)
>   {
>       bool ambiguous;
> -
> -    Aml *scope = aml_scope("_SB.PCI0.ISA");
>       Object *obj = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
> +    Aml *scope;
>   
> -    if (ambiguous) {
> -        error_report("Multiple ISA busses, unable to define IPMI ACPI data");
> -    } else if (!obj) {
> -        error_report("No ISA bus, unable to define IPMI ACPI data");
> -    } else {
> -        build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
> -        isa_build_aml(ISA_BUS(obj), scope);
> -    }
> +    assert(obj && !ambiguous);
>   
> +    scope = aml_scope("_SB.PCI0.ISA");
> +    build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
> +    isa_build_aml(ISA_BUS(obj), scope);
>       aml_append(table, scope);
>   }
>   
> 


