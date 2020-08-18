Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5619C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBFD20674
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQfwSBYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBFD20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7yqD-0003dY-HV
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7yor-000271-0M
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7yop-00011Y-69
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597746374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BMJKTM6pUo8Mz9tUOtDtFydWnxlyaAxxtwZAfbnkqZY=;
 b=IQfwSBYDdyYaNCdcdbNWUpxZATSvKRPzo4nZmifWwIu6RIhYPgWlg5RFYffIfR9T2+WhEX
 rgD5udHZrz2oMKd0ZYEmOwPXjCyYBoiPL/DdU7Ls7B4EAiVsORZX5eWQ7pKTP6Msj9kbVd
 yQGIw5KC6FonSj1xE86aYT8Kuai6wXw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-dPkBPXULPOa-Ctf57nus0w-1; Tue, 18 Aug 2020 06:26:12 -0400
X-MC-Unique: dPkBPXULPOa-Ctf57nus0w-1
Received: by mail-wm1-f70.google.com with SMTP id z1so7222848wmf.9
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BMJKTM6pUo8Mz9tUOtDtFydWnxlyaAxxtwZAfbnkqZY=;
 b=uUDx/iDNZHWMuC17gY2ny3yDn+K925OjK+ieERZWX4qDFMogECctHJXFwmeMsjtFhR
 7xfsb9ah22KftsFRuTzbtABjzmBh5RG44P5e/d3WmPIMWq3GoPJGt/DHUxIbkN4R/txt
 EsgMfsmnBqV2U5URp2H4z+hWxF8hHsvySr3VfRxZvXq9xP6+tzxJ6bvNDAip+fs5v1MM
 KaCRJ3osRcfmOqPrBPu6ZVE44reRyzr5RF62Eoz3ify2h5/F+ZHEELHknYue4jBUfKQ+
 SDG+ZsRoXTTSZrKYUB78GdY9NkNbYLkk/twL0FtufdWn9QnmNiNK3fEGHxdrA589Icn4
 TyeA==
X-Gm-Message-State: AOAM533mg5FtFwzbg5/LYcAAxsqflsESP3rwlE0BZcisWz8uxLaopRtK
 xkAdsO/HCww5jZ1xcBobU2B+0nx4lZn82ZzjFdyc5MOUX4f8fAYQXQk2ACIKq7NKvN/lEKJenBu
 LQOKj1YDPgErNKdk=
X-Received: by 2002:a1c:b145:: with SMTP id a66mr19728472wmf.133.1597746371406; 
 Tue, 18 Aug 2020 03:26:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM+mjKi15NUXsAD4I5hSusKs4t0qJRzpCafyspIhAw/P9taMsat5uFN3hLBMJ/zaVDqqcwNg==
X-Received: by 2002:a1c:b145:: with SMTP id a66mr19728461wmf.133.1597746371160; 
 Tue, 18 Aug 2020 03:26:11 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m126sm33396283wmf.3.2020.08.18.03.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:26:10 -0700 (PDT)
Subject: Re: [PATCH 123/150] meson: convert hw/adc
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200817143723.343284-1-pbonzini@redhat.com>
 <20200817144053.345107-28-pbonzini@redhat.com>
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
Message-ID: <b8f5195e-a755-8550-d49c-3261b33ae9e3@redhat.com>
Date: Tue, 18 Aug 2020 12:26:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817144053.345107-28-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
>  hw/Makefile.objs     | 1 -
>  hw/adc/Makefile.objs | 1 -
>  hw/adc/meson.build   | 1 +
>  hw/meson.build       | 1 +
>  4 files changed, 2 insertions(+), 2 deletions(-)
>  delete mode 100644 hw/adc/Makefile.objs
>  create mode 100644 hw/adc/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index c0cbc0f132..4bdb674ef0 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -1,7 +1,6 @@
>  ifeq ($(CONFIG_SOFTMMU), y)
>  devices-dirs-$(call lor,$(CONFIG_VIRTIO_9P),$(call land,$(CONFIG_VIRTFS),$(CONFIG_XEN))) += 9pfs/
>  devices-dirs-y += acpi/
> -devices-dirs-y += adc/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/adc/Makefile.objs b/hw/adc/Makefile.objs
> deleted file mode 100644
> index 2b9dc36c7f..0000000000
> --- a/hw/adc/Makefile.objs
> +++ /dev/null
> @@ -1 +0,0 @@
> -common-obj-$(CONFIG_STM32F2XX_ADC) += stm32f2xx_adc.o
> diff --git a/hw/adc/meson.build b/hw/adc/meson.build
> new file mode 100644
> index 0000000000..0d62ae96ae
> --- /dev/null
> +++ b/hw/adc/meson.build
> @@ -0,0 +1 @@
> +softmmu_ss.add(when: 'CONFIG_STM32F2XX_ADC', if_true: files('stm32f2xx_adc.c'))
> diff --git a/hw/meson.build b/hw/meson.build
> index 624335be90..ffa3f06dc0 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -1,3 +1,4 @@
> +subdir('adc')
>  subdir('audio')
>  subdir('block')
>  subdir('char')
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


