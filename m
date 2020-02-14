Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7930EC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A096206CC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBKjbS2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A096206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2gHB-0005KF-Fv
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2gFw-0004GQ-Vr
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2gFv-00018J-Q8
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:04:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25671
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2gFv-000181-LQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581707043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoYzL2LEOco4e9zwEZfYWZWZLFtuQtc0d93sSkeSnUQ=;
 b=YBKjbS2Q561PE6IptacOWg/VCcrTpzpTXY0mynTVTCiHXfM7xIvT2vID117+52fP8FdIn8
 wkv1geJHHbS3302BxHwUvQW6qDC3X4QvijLnvaeCwWwFOq+Mgc09yUy3yNJ5QdlLjJzmjZ
 MmcqEmWANEs+2iwnYLtTFqiQsYv39C8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Cc3zS65lNSS3AcT6NluV3Q-1; Fri, 14 Feb 2020 14:04:01 -0500
Received: by mail-wm1-f72.google.com with SMTP id q125so4391991wme.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J/U3bvGjjbtRQR1Rj9D8e9HMzhFD3rb3ej8UVO46KKg=;
 b=T2CFp/FhCKIsUYuBN7akxmTAQ5HXC3wP0Ll2ThhWJYdRl1VrD+TQnyWWHmvDnrA3DP
 vOwOSY3y8jnFBTjzdXnr4XgsSCO/i3SRbXDDjUt7w0Lv4KdTx4ougD/z3X6fmt8rjWAZ
 qIKysfP+LClD/XXdbMjbwTEEMExNJ2uMl+DRaK088mDFUqHTKKAJ0pSo47QXBY3DLDA6
 GW1T+AMAPKsVAei+F1WtVgRQS6RGSd0AGooUnZpU6TMrrVB4gz5hZFDwAVHwPvSiqnU3
 6Hcuei60MHifAgxdW7kWLtnhWLAW2xfeRPKpQ8D9Ev1GTDQlN5DaOG33Zc6uI5Wo6XtN
 ggxQ==
X-Gm-Message-State: APjAAAX9IVyGJrMtsAtgQW8LENmY38e2eV691kCWEhM3MTr6wdVXCSXB
 G7vMvTGv9Fm22NbPDE2cHeEBYnhiFCbUp8DkyMrUGaAqkdBJn/PvN8JLkBCaU/BT/hjzXLqaKFE
 hE4CXPK/5jSFUdF8=
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr5911783wme.28.1581707040183; 
 Fri, 14 Feb 2020 11:04:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzY5rbNvAseCj+/xQQN6L/XHt73RtQRHTpmftjXn0c5PNM2AF2keEZtpXoPZTVmcYJ3wsjB0Q==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr5911763wme.28.1581707039927; 
 Fri, 14 Feb 2020 11:03:59 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id m9sm8129977wrx.55.2020.02.14.11.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 11:03:59 -0800 (PST)
Subject: Re: [RFC v2 4/6] tpm: Separate TPM_TIS and TPM_TIS_ISA configs
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 stefanb@linux.ibm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-5-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d53d213-0135-6b9f-7684-39c4d6ae1321@redhat.com>
Date: Fri, 14 Feb 2020 20:03:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214183704.14389-5-eric.auger@redhat.com>
Content-Language: en-US
X-MC-Unique: Cc3zS65lNSS3AcT6NluV3Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 7:37 PM, Eric Auger wrote:
> Let's separate the compilation of tpm_tis_common.c from
> the compilation of tpm_tis_isa.c
>=20
> The common part will be also compiled along with the
> tpm_tis_sysbus device.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   default-configs/i386-softmmu.mak | 2 +-
>   hw/i386/Kconfig                  | 2 +-
>   hw/tpm/Kconfig                   | 7 ++++++-
>   hw/tpm/Makefile.objs             | 3 ++-
>   tests/qtest/Makefile.include     | 4 ++--
>   5 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
> index 4cc64dafa2..84d1a2487c 100644
> --- a/default-configs/i386-softmmu.mak
> +++ b/default-configs/i386-softmmu.mak
> @@ -20,7 +20,7 @@
>   #CONFIG_SGA=3Dn
>   #CONFIG_TEST_DEVICES=3Dn
>   #CONFIG_TPM_CRB=3Dn
> -#CONFIG_TPM_TIS=3Dn
> +#CONFIG_TPM_TIS_ISA=3Dn
>   #CONFIG_VTD=3Dn
>  =20
>   # Boards:
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index cdc851598c..c93f32f657 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -20,7 +20,7 @@ config PC
>       imply SGA
>       imply TEST_DEVICES
>       imply TPM_CRB
> -    imply TPM_TIS
> +    imply TPM_TIS_ISA
>       imply VGA_PCI
>       imply VIRTIO_VGA
>       select FDC
> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> index 9e67d990e8..686f8206bb 100644
> --- a/hw/tpm/Kconfig
> +++ b/hw/tpm/Kconfig
> @@ -2,9 +2,14 @@ config TPMDEV
>       bool
>       depends on TPM
>  =20
> -config TPM_TIS
> +config TPM_TIS_ISA
>       bool
>       depends on TPM && ISA_BUS

Maybe you can relax to "depends on ISA_BUS" ...

> +    select TPM_TIS
> +
> +config TPM_TIS
> +    bool
> +    depends on TPM

... since TPM_TIS depends on TPM.

>       select TPMDEV
>  =20
>   config TPM_CRB
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index fcc4c2f27c..3ef2036cca 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,6 +1,7 @@
>   common-obj-$(CONFIG_TPM) +=3D tpm_util.o
>   obj-$(call lor,$(CONFIG_TPM_TIS),$(CONFIG_TPM_CRB)) +=3D tpm_ppi.o
> -common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis_isa.o tpm_tis_common.o
> +common-obj-$(CONFIG_TPM_TIS_ISA) +=3D tpm_tis_isa.o
> +common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis_common.o
>   common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>   common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
>   common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> index eb0f23b108..33dd3c89cc 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -54,8 +54,8 @@ check-qtest-i386-y +=3D q35-test
>   check-qtest-i386-y +=3D vmgenid-test
>   check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-swtpm-test
>   check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-test
> -check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-swtpm-test
> -check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-test
> +check-qtest-i386-$(CONFIG_TPM_TIS_ISA) +=3D tpm-tis-swtpm-test
> +check-qtest-i386-$(CONFIG_TPM_TIS_ISA) +=3D tpm-tis-test
>   check-qtest-i386-$(CONFIG_SLIRP) +=3D test-netfilter
>   check-qtest-i386-$(CONFIG_POSIX) +=3D test-filter-mirror
>   check-qtest-i386-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirector
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


