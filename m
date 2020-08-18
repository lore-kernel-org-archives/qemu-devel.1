Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A014C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC1520789
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU40XXsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC1520789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7zAV-00022z-7K
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7z9d-0001YP-BV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:47:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55308
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7z9b-0004B3-PI
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597747662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tYxVhMid//5aATv1iXr33Xwwqy+IX7yoQ+UocqcWjYM=;
 b=LU40XXsrdAyyTPbmclwUjuEfeH5AhdbsQzpJ0i9N4JX5eU4DRDqVSF3Agm5IoK/3bhAxcb
 CyjakFRWI55moVa1AVngexA5VdRtlJ0VyFWFF3efIcOZ1DIX1RkTlxUH+AQ29EE9zKopz8
 3/7OJ/eAns7pjnEiCI9XzUEnSRVU69U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-S9TnnjxlMd2Hcv2PYdoCXg-1; Tue, 18 Aug 2020 06:47:41 -0400
X-MC-Unique: S9TnnjxlMd2Hcv2PYdoCXg-1
Received: by mail-wr1-f71.google.com with SMTP id y6so2597159wrs.11
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 03:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tYxVhMid//5aATv1iXr33Xwwqy+IX7yoQ+UocqcWjYM=;
 b=uUOdN88bsaCyMu4ZASgjbHq3QH/jM9QEAB7CGVfmYWc4DDF4a/a31181eT7LNRZreH
 K9AQmjwHr14xgfEfH8hjjr/L6oHFaiwcHVHcJn3rv4CQC3vXatiUVKpNO65UjliHMb8X
 epr7SpBn889JCWx0iRifL3TcU+KKmd1R+wCBbJFh97Xp/Rgd+03Yn35n1z0Qmtt5h7Mb
 5Euip+5RrMbn6JUCOIWEj5N3L9Ldkz4afk1+OAtqhrhIpm74S9GphlS7SIXQCFKGJHUp
 lCBN9ssHZ22jWSST3u6byd9b6yXC99PmkLs4Ra4I5+1YRdT7f/4jnq+JIk5+xqZ7nT0u
 cP+Q==
X-Gm-Message-State: AOAM532PlM1PorU42e7Y8W65jKR5mRSIoeKDIRZQmrl4dl+U5X3ulDn8
 cO8XN2vU8V2Nw9sbRD4EgTt22IFRaThWZFQeu16mPEqoFzSQBuftuuTdl9ZGUXWm4SKm12Phafy
 6L6s3U/trFcNjvFk=
X-Received: by 2002:a05:600c:2888:: with SMTP id
 g8mr19550313wmd.118.1597747660333; 
 Tue, 18 Aug 2020 03:47:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZYhRf93h8LEK49hoJntd+76n+1kxf9CmFOd4n2IsmThF76NNx/ts2PCItQ1uRVI/C/cFc5Q==
X-Received: by 2002:a05:600c:2888:: with SMTP id
 g8mr19550297wmd.118.1597747660107; 
 Tue, 18 Aug 2020 03:47:40 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y203sm33533692wmc.29.2020.08.18.03.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:47:39 -0700 (PDT)
Subject: Re: [PATCH 090/150] meson: convert hw/watchdog
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200817143723.343284-1-pbonzini@redhat.com>
 <20200817143723.343284-91-pbonzini@redhat.com>
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
Message-ID: <ffc159d0-6623-3d99-d48b-602b00d2b8a7@redhat.com>
Date: Tue, 18 Aug 2020 12:47:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817143723.343284-91-pbonzini@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 06:40:33
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

On 8/17/20 4:36 PM, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/Makefile.objs          | 1 -
>  hw/meson.build            | 1 +
>  hw/watchdog/Makefile.objs | 7 -------
>  hw/watchdog/meson.build   | 7 +++++++
>  4 files changed, 8 insertions(+), 8 deletions(-)
>  delete mode 100644 hw/watchdog/Makefile.objs
>  create mode 100644 hw/watchdog/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index df72b25a64..9ebd13d7cd 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -33,7 +33,6 @@ devices-dirs-$(CONFIG_TPM) += tpm/
>  devices-dirs-y += usb/
>  devices-dirs-$(CONFIG_VFIO) += vfio/
>  devices-dirs-y += virtio/
> -devices-dirs-y += watchdog/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/meson.build b/hw/meson.build
> index 542d675618..f2209d900c 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -3,4 +3,5 @@ subdir('mem')
>  subdir('nubus')
>  subdir('semihosting')
>  subdir('smbios')
> +subdir('watchdog')
>  subdir('xen')
> diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
> deleted file mode 100644
> index 631b711d86..0000000000
> --- a/hw/watchdog/Makefile.objs
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -common-obj-y += watchdog.o
> -common-obj-$(CONFIG_CMSDK_APB_WATCHDOG) += cmsdk-apb-watchdog.o
> -common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
> -common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
> -common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
> -common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
> -common-obj-$(CONFIG_WDT_IMX2) += wdt_imx2.o
> diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
> new file mode 100644
> index 0000000000..9b8725e642
> --- /dev/null
> +++ b/hw/watchdog/meson.build
> @@ -0,0 +1,7 @@
> +softmmu_ss.add(files('watchdog.c'))
> +softmmu_ss.add(when: 'CONFIG_CMSDK_APB_WATCHDOG', if_true: files('cmsdk-apb-watchdog.c'))
> +softmmu_ss.add(when: 'CONFIG_WDT_IB6300ESB', if_true: files('wdt_i6300esb.c'))
> +softmmu_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
> +softmmu_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
> +softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
> +softmmu_ss.add(when: 'CONFIG_WDT_IMX2', if_true: files('wdt_imx2.c'))

This one is not sorted alphabetically!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


