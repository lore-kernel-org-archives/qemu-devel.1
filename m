Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116DBC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED3320656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXLpWD4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED3320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioloH-0003NK-1O
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iolfU-0005fr-OL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iolfT-0001od-7V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:00:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20142
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iolfT-0001oO-4D
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0+oOCvbb5nwR/XvdmQTSW4cL8ivro+H9deOhwV6uu4=;
 b=iXLpWD4RI5mfc5tiOiH42Wi3pqYy4YIF2c4z4eMfITOWu/qAx4a62PAUkqaUIsiDuaISbj
 Y79ZpoSUxrApeWiAvkcH29u3MNnQti1xvVvFHY/D91PKWgd0sw7voV/1VAXlMExYWlTFd/
 tTJZEGAys7tByjAKmB0MdCDWFAzAmWw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-sOAbI94bOBy90hq_BXSU_w-1; Tue, 07 Jan 2020 05:00:13 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so3031839wmi.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 02:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uWUxbTkoXTIZUi9pzN1L2Ym2+wbf7V1tU4wwBL/sKwY=;
 b=khCcBfJsq1SAWgfmNZ2yHEk9HnKhZb41t3lF1X8lDEYfTtz4DRaXlXSiZBvz9WBvS3
 BTD/HDMKBQAqWvRVKOmeB/YMKrSYhrDUCSqWZIQew5/jSZPC4mPYNwwdYasdwPwnqoCB
 UBncnatci9tB3LkxkIzCCM2uKZNY4/hozFYihstddg6OGB91BxCdfcjA/fMT71bFQwRQ
 D0kyWNU65k+7q/pAb1NvppNqGUVd2pj0lG9byAlq2NrCB+kqKDKYy5eSLQ4YhXCqrinx
 PpaEyv6zYx5N2oL8Jp/QynWGGY6dA3CWbxNSAiwkFxad1AM3AqfoHKFviOQjoNlSLm4b
 8RRQ==
X-Gm-Message-State: APjAAAUe3/p5ATGRljyPHniUKdtAUS0LF5LhmYP8iz1ifT+M7XI0CynW
 blg/zqAQnbetvxtYdaPLtzaux5rJfpBNyiTAzmgCq+UbpmgrFYbhTRMYNsYU4XjSJIBFryJcYH1
 cyIKOk0sftCOjODY=
X-Received: by 2002:a05:600c:211:: with SMTP id
 17mr38894844wmi.60.1578391212233; 
 Tue, 07 Jan 2020 02:00:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9bpInLQR6P+sWVvNl0/c4pes/VRsUb8WDDhIhHYCPnTJ1E+K0QXaeK5ejiQdN7iB3dmeNeg==
X-Received: by 2002:a05:600c:211:: with SMTP id
 17mr38894816wmi.60.1578391212013; 
 Tue, 07 Jan 2020 02:00:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id d8sm74548656wrx.71.2020.01.07.02.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 02:00:11 -0800 (PST)
Subject: Re: [PATCH 03/14] hw/i386/Kconfig: Let the MicroVM machine select the
 SERIAL_ISA config
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-4-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf08bcf8-d0f2-e3ac-c4b4-946f268d8fa1@redhat.com>
Date: Tue, 7 Jan 2020 11:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191231183216.6781-4-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: sOAbI94bOBy90hq_BXSU_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/12/19 19:32, Philippe Mathieu-Daud=C3=A9 wrote:
> When configured with --without-default-devices, the build fails:
>=20
>      LINK    x86_64-softmmu/qemu-system-x86_64
>   /usr/bin/ld: hw/i386/microvm.o: in function `microvm_devices_init':
>   hw/i386/microvm.c:157: undefined reference to `serial_hds_isa_init'
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
>   make: *** [Makefile:483: x86_64-softmmu/all] Error 2
>=20
> While the MicroVM machine only uses the ISA serial port when the
> MICROVM_MACHINE_ISA_SERIAL property is set, it has to be linked
> with it. Replace the 'imply' Kconfig rule by a 'select'.

I added a comment "# for serial_hds_isa_init()" here.

Paolo

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Sergio Lopez <slp@redhat.com>
> ---
>  hw/i386/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index e428322a2c..cbcfb1ce81 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -96,7 +96,7 @@ config Q35
> =20
>  config MICROVM
>      bool
> -    imply SERIAL_ISA
> +    select SERIAL_ISA
>      select ISA_BUS
>      select APIC
>      select IOAPIC
>=20


