Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4732FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E4923D99
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgRSuGC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E4923D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpudO-0006m7-Aj
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpubu-0005rZ-HV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:18:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpubs-0005jk-6Z
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593440291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wheRM/SSsdNvONw5lhy+729M8lShBDgLLRoerkCT+ds=;
 b=LgRSuGC8TpXxmaLrZaS+mvd0w6ySteC+psZHv487fxrSBwuLvbnXeNFXjC0/wjUxvFE25v
 DC/AMrQ0dic2q3e+a5RKUY+A6JWSB5N5T807i++jJaWfmYM1esMFi5WJzjAPT/JWGn8z8g
 OqorIbCgJ6UzYWVojsHG8rTTi2GZs1g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-1KVWf59_MFahDAJ4RH-2Gw-1; Mon, 29 Jun 2020 10:18:09 -0400
X-MC-Unique: 1KVWf59_MFahDAJ4RH-2Gw-1
Received: by mail-ej1-f71.google.com with SMTP id do21so11043548ejc.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 07:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wheRM/SSsdNvONw5lhy+729M8lShBDgLLRoerkCT+ds=;
 b=q1RHf5LQyIVpTkuqjzgFpDv6vapPY3D8zodLMDNhIXe+awlaHjJTjUbb9dh5cT4fs1
 YXs8J2nvkrV5sZfUeK1LJQICQcSy97i05ii45YJnc0hTHxv7QwheOjx6gJkxcwWUK2Zx
 lgsV0GtRjFp2XMBbt/WzgPnkWtFgamBcN6ifBSG4Yy9GRD5wUe5TMMlajL2ae2NQl5yL
 XA6D28LV0jJA5uMjanVJ8lxhV4TcB5XQe+n3rI1D2Bf9Y2+x7yHT3Oe+nw5+13Eu5GwU
 N3rbdVBRTVkgXI7fuSLQ+gCIvDS+6KBQvH4J6TqDEVarrWc/iAxITL22ZXD8aTDuecQt
 wRBA==
X-Gm-Message-State: AOAM531rhe79MPYEP/6wYuShcyaZQPxoSO1jeLxITEhpHni6+tNnC/xp
 aV3rqHqUsKhFAcekjEOr275o8X5cmNRnIS/WzIVibpT4DHWC2LsHoygC7WI7Cpc/1y3JJKBKg4Q
 M8xxqHaQlC9pMJQ0=
X-Received: by 2002:a50:e3c9:: with SMTP id c9mr18490893edm.90.1593440288459; 
 Mon, 29 Jun 2020 07:18:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm/INK2Dx8p0S6iCaHNnBojYGsB6KGlfzKuikqnIHTfOcdEXpM5m9tz4rgzHc1j44v5zUYAw==
X-Received: by 2002:a50:e3c9:: with SMTP id c9mr18490870edm.90.1593440288277; 
 Mon, 29 Jun 2020 07:18:08 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o8sm16274943ejj.102.2020.06.29.07.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 07:18:07 -0700 (PDT)
Subject: Re: [PATCH 3/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-4-drjones@redhat.com>
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
Message-ID: <053462ec-0299-99fb-001b-93f31d668b0d@redhat.com>
Date: Mon, 29 Jun 2020 16:18:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200629140938.17566-4-drjones@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mst@redhat.com, shannon.zhaosl@gmail.com,
 ard.biesheuvel@arm.com, imammedo@redhat.com, lersek@redhat.com,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 4:09 PM, Andrew Jones wrote:
> The flash device is exclusively for the host-controlled firmware, so
> we should not expose it to the OS. Exposing it risks the OS messing
> with it, which could break firmware runtime services and surprise the
> OS when all its changes disappear after reboot.
> 
> As firmware needs the device and uses DT, we leave the device exposed
> there. It's up to firmware to remove the nodes from DT before sending
> it on to the OS. However, there's no need to force firmware to remove
> tables from ACPI (which it doesn't know how to do anyway), so we
> simply don't add the tables in the first place. But, as we've been
> adding the tables for quite some time and don't want to change the
> default hardware exposed to versioned machines, then we only stop
> exposing the flash device tables for 5.1 and later machine types.
> 
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/virt-acpi-build.c | 5 ++++-
>  hw/arm/virt.c            | 3 +++
>  include/hw/arm/virt.h    | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1384a2cf2ab4..91f0df7b13a3 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -749,6 +749,7 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>      Aml *scope, *dsdt;
>      MachineState *ms = MACHINE(vms);
>      const MemMapEntry *memmap = vms->memmap;
> @@ -767,7 +768,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> -    acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> +    if (vmc->acpi_expose_flash) {
> +        acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> +    }
>      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
>      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
>                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cd0834ce7faf..5adc9ff799ef 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2482,9 +2482,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
>  
>  static void virt_machine_5_0_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_5_1_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>      mc->numa_mem_supported = true;
> +    vmc->acpi_expose_flash = true;
>  }
>  DEFINE_VIRT_MACHINE(5, 0)
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 31878ddc7223..c65be5fe0bb6 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -119,6 +119,7 @@ typedef struct {
>      bool no_highmem_ecam;
>      bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
>      bool kvm_no_adjvtime;
> +    bool acpi_expose_flash;
>  } VirtMachineClass;
>  
>  typedef struct {
> 


