Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E987C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2367A20578
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBU1UbV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2367A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ytE-0008GH-Ae
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7ys6-0006nT-BZ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:29:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7ys4-0001J5-JW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597746576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hV3tEa7sRQ5F1ZpwDSMsmpAIT5FMpVCO8VHY0g1ONGw=;
 b=LBU1UbV+FwtFzsntUQHtjvZRX/vmQMFpEqvG/gBPnxbDqbxAAZQ+GsjG1G79oEX6uMsWAE
 NM+zz7nXyZshBvBT//WbpQArYL1iwRV2w+MqoRkjddx1oPFMqa6b3LlXuG0N3uuoj3ru7g
 YUqgRTkVVtAOkVETDkIoG98s4AkWWr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-H18pewmhMeik8tWA5CPfcQ-1; Tue, 18 Aug 2020 06:29:34 -0400
X-MC-Unique: H18pewmhMeik8tWA5CPfcQ-1
Received: by mail-wr1-f70.google.com with SMTP id l14so8087223wrp.9
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hV3tEa7sRQ5F1ZpwDSMsmpAIT5FMpVCO8VHY0g1ONGw=;
 b=tly4DIdNeHL2BE9Hoo5pjKGM9cpQPzcTz0WigVwzaFBRQnjCsT3Rz+4II7cdtFM406
 h1yu7pgIQ8ZvMeEA7TbbyERBmxtbFVo9DDElH30JNAjw4Nj8JQbXjFxmTNtR/95YgoiS
 /0fp8b545M65v65Cs4Lg/Ka1AcN1lRSc+aecummItsRjLFBURgkbTs4eIdGkDxpCDD25
 xpMLsIZgRzfZ1YNv+JKpPkDQz+fl0yoBN++LUljET2EsXgQlAZCn+cv9cn7zq6C5nxLy
 o8Ja7/0EIq5pg/AJ1PFaQrWfA/3DwZ6AYVpz2bGBeU6qMXAhP7qslibFHHnFxBBUuUQL
 9Hrg==
X-Gm-Message-State: AOAM533/VxV1/u+QsnBbaoQe7nxBB0VoSapgHe6Uz0Pu1O7OfOEYBIAJ
 wzpcIDfpak9ZHAZ62eefHr6xFC/fe/ljGkOqd0/ijwtpFHMDbI46nrao4rT65bo9DYnpsgqUrra
 IVI4Hcu0GvIoINFM=
X-Received: by 2002:adf:8186:: with SMTP id 6mr19148366wra.62.1597746573147;
 Tue, 18 Aug 2020 03:29:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc5RjOKr1LQqogBwAqRvyBOGqRZ23/IZjB8zFz8KbsIeWJJabzFMh0br9Ev+B6hwpG1gjZFg==
X-Received: by 2002:adf:8186:: with SMTP id 6mr19148346wra.62.1597746572896;
 Tue, 18 Aug 2020 03:29:32 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id q6sm34045362wma.22.2020.08.18.03.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:29:32 -0700 (PDT)
Subject: Re: [PATCH 104/150] meson: convert hw/nvram
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200817143723.343284-1-pbonzini@redhat.com>
 <20200817144053.345107-9-pbonzini@redhat.com>
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
Message-ID: <d309d906-a4aa-b6b0-5e09-b4568f53087a@redhat.com>
Date: Tue, 18 Aug 2020 12:29:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817144053.345107-9-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:19:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 8/17/20 4:40 PM, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/Makefile.objs       | 1 -
>  hw/meson.build         | 1 +
>  hw/nvram/Makefile.objs | 8 --------
>  hw/nvram/meson.build   | 9 +++++++++
>  4 files changed, 10 insertions(+), 9 deletions(-)
>  delete mode 100644 hw/nvram/Makefile.objs
>  create mode 100644 hw/nvram/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 20832841d2..78860ae9c7 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -20,7 +20,6 @@ devices-dirs-y += isa/
>  devices-dirs-y += misc/
>  devices-dirs-y += net/
>  devices-dirs-y += rdma/
> -devices-dirs-y += nvram/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/meson.build b/hw/meson.build
> index 53c347c395..0bdd6a2613 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -1,6 +1,7 @@
>  subdir('core')
>  subdir('mem')
>  subdir('nubus')
> +subdir('nvram')
>  subdir('pci')
>  subdir('pci-bridge')
>  subdir('pci-host')
> diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
> deleted file mode 100644
> index f3ad921382..0000000000
> --- a/hw/nvram/Makefile.objs
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -common-obj-$(CONFIG_DS1225Y) += ds1225y.o
> -common-obj-$(CONFIG_NMC93XX_EEPROM) += eeprom93xx.o
> -common-obj-$(CONFIG_AT24C) += eeprom_at24c.o
> -common-obj-y += fw_cfg.o
> -common-obj-$(CONFIG_CHRP_NVRAM) += chrp_nvram.o
> -common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
> -common-obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
> -obj-$(CONFIG_PSERIES) += spapr_nvram.o
> diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
> new file mode 100644
> index 0000000000..ba214558ac
> --- /dev/null
> +++ b/hw/nvram/meson.build
> @@ -0,0 +1,9 @@
> +softmmu_ss.add(files('fw_cfg.c'))
> +softmmu_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
> +softmmu_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
> +softmmu_ss.add(when: 'CONFIG_NMC93XX_EEPROM', if_true: files('eeprom93xx.c'))
> +softmmu_ss.add(when: 'CONFIG_AT24C', if_true: files('eeprom_at24c.c'))
> +softmmu_ss.add(when: 'CONFIG_MAC_NVRAM', if_true: files('mac_nvram.c'))
> +softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_nvm.c'))
> +
> +specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


