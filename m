Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D629C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B3220789
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ8WSyRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B3220789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zBy-00032s-L2
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7zBQ-0002bZ-2M
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7zBO-0004Ny-Fc
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597747773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rigvjFA6Z4mgyvbZvTD+Hd53z1o7YmSUzcWcA1lR64M=;
 b=KZ8WSyRYyk7bQiIaVaD9bq6DWT7bylw/rkBtUFoYegUnkleiH15YhjYP2naJbdcjV/rbKf
 HUe8ykrPhpC/zAWSa2oJe4fEv2ybE7Dd9pib4x8PExBuKgFT1P1x2gZcl0aJ+v873gbqC/
 ZBvc9AQ6po218uVienQhxcYuqRICU04=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-qJudokazN42XE3IYPyZvlw-1; Tue, 18 Aug 2020 06:49:31 -0400
X-MC-Unique: qJudokazN42XE3IYPyZvlw-1
Received: by mail-wr1-f70.google.com with SMTP id t3so8091868wrr.5
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rigvjFA6Z4mgyvbZvTD+Hd53z1o7YmSUzcWcA1lR64M=;
 b=RNZ9IeqXfJ5Lrn8XBJy23gI3Pc6rcHHaTmJ4f8FEHPdRmx8ZLfvDJbfs3W9/XqSVQW
 6PBL+BiICferVwMgBC5N5xNjnBcBuFvW/PPpQKxPxngwO888MrV2yGX9x+WFBcUxJgyL
 a2Y11Aq5huEXu3g7n2Cncqr7EfvFWumSJdNPka+QuqixS/6p+vOGFMIkNMfWd5mWpbiW
 YO36bCyakbjIgAGgSzFQv+2NV1ZkTAObIVBTfcsJZ66BKY/OIuU4FA5Kzyboq3Lz3SY7
 ftqWaR4nyV8q9+bo5G7BrqmYjGskCJUPKcp0S8sun+QYx8o0XqWKmNof1bZNmgJDGVOr
 cWZw==
X-Gm-Message-State: AOAM530NjACPY4+HdkrubSCwVe53jPr8OUTEGBc9mPG8rgQfMQADHBD4
 Zs346+o0wHropQR6hbGu4buN+HWbWuKH2xDohXdvooeLODfaeOq5EbJ28zzrQVnAQlCsT34HmZV
 KIabJ8jy+7ULkb7g=
X-Received: by 2002:a7b:c084:: with SMTP id r4mr18479542wmh.23.1597747770345; 
 Tue, 18 Aug 2020 03:49:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiHjnXa1vO9sF8f+b0qbMYV/tQpbK6BhSyF05jYps8QEFVhtGPDgArlgavMjCUhGK7Kx6dxQ==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr18479533wmh.23.1597747770167; 
 Tue, 18 Aug 2020 03:49:30 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id a10sm36524675wrh.36.2020.08.18.03.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:49:29 -0700 (PDT)
Subject: Re: [PATCH 092/150] meson: convert hw/vfio
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200817143723.343284-1-pbonzini@redhat.com>
 <20200817143723.343284-93-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <946042aa-bd39-2dad-70c6-0387ba68bf5e@redhat.com>
Date: Tue, 18 Aug 2020 12:49:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817143723.343284-93-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 4:36 PM, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/Makefile.objs      |  1 -
>  hw/meson.build        |  1 +
>  hw/vfio/Makefile.objs |  8 --------
>  hw/vfio/meson.build   | 18 ++++++++++++++++++
>  4 files changed, 19 insertions(+), 9 deletions(-)
>  delete mode 100644 hw/vfio/Makefile.objs
>  create mode 100644 hw/vfio/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index a1cfb99334..f6e08f6660 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -31,7 +31,6 @@ devices-dirs-y += ssi/
>  devices-dirs-y += timer/
>  devices-dirs-$(CONFIG_TPM) += tpm/
>  devices-dirs-y += usb/
> -devices-dirs-$(CONFIG_VFIO) += vfio/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/meson.build b/hw/meson.build
> index 8338fc4408..4dafc8a08e 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -3,6 +3,7 @@ subdir('mem')
>  subdir('nubus')
>  subdir('semihosting')
>  subdir('smbios')
> +subdir('vfio')
>  subdir('virtio')
>  subdir('watchdog')
>  subdir('xen')
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> deleted file mode 100644
> index 9bb1c09e84..0000000000
> --- a/hw/vfio/Makefile.objs
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -obj-y += common.o spapr.o
> -obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
> -obj-$(CONFIG_VFIO_CCW) += ccw.o
> -obj-$(CONFIG_VFIO_PLATFORM) += platform.o
> -obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
> -obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
> -obj-$(CONFIG_VFIO_AP) += ap.o
> -obj-$(CONFIG_VFIO_IGD) += igd.o
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> new file mode 100644
> index 0000000000..37efa74018
> --- /dev/null
> +++ b/hw/vfio/meson.build
> @@ -0,0 +1,18 @@
> +vfio_ss = ss.source_set()
> +vfio_ss.add(files(
> +  'common.c',
> +  'spapr.c',
> +))
> +vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
> +  'display.c',
> +  'pci-quirks.c',
> +  'pci.c',
> +))
> +vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
> +vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
> +vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
> +vfio_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
> +vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
> +vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))

Not sorted :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
> +specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
> 


