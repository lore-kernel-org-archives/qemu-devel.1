Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1FC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B718B2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpWDTkQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B718B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiOl-00037p-LH
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFiNN-0002My-58
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:29:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFiNL-00005t-Hm
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599589791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zcQDwEDAfJy2VvKVHY8NiipUKgWBECsQb13TEVuPqdA=;
 b=QpWDTkQes9obBeBHrPuVUihWcfILKcUcnpdNTvtN4x4KkBz2fcyfn14zaEmy9j0PO5P5I2
 ZNQ0WYwD9LG4RMwLwJVRNfUebTOKU3w+0xKfIWhyuBUNj0UDGYv4WXtSWp6xIPOeq4ImHX
 e5ONQXjFS4Kf9LhHnfxauza9kJUPs7s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-6FofK80_ME-h78W1QiWRfA-1; Tue, 08 Sep 2020 14:29:47 -0400
X-MC-Unique: 6FofK80_ME-h78W1QiWRfA-1
Received: by mail-wm1-f71.google.com with SMTP id s24so86673wmh.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zcQDwEDAfJy2VvKVHY8NiipUKgWBECsQb13TEVuPqdA=;
 b=kL7CfoCr+YmiLKMSzm4udhIZ5xJqhz417jzegv2C6yOfBwKvST59DQGDUT4Djxq61G
 +5FuYf7DWsqB7KIi2v9ZiQjqddG8zJ9ruea8sNqmtbrZ22U20Vx745huKVhVjt/p3tgD
 PPtZS8sYG0lIjhDHpK3OU/fCHBamkeAyJXg+xzRK3B3pnCHb6kLKMtsU4kzQcGhfP3/i
 5kGaKhexhewXy7hF4sLcTdqQ0BbSAp8Nz4zj1HAaIWf0pKhiS1jLFcbJ5TliRZ3uX3HV
 OgZ3wS1+G2Qc7y6I1eHw3DJjcWUdzcw2MAKblGJUfJPNnKVFTIaFpjFLJPi8VMD6AzhI
 VuoA==
X-Gm-Message-State: AOAM532WKr5vK2Act5AyScI5knDVaXtT8BRxroCMXzBehlzS7aMWEsue
 xUDfS91HsKKdEBNw3Q9l5uUoinxHgYicdqeucpESC32rvXOiPi4wiBVyG0j22WMpH7z0xWNUeki
 NQjFzkx6mL0MYVBM=
X-Received: by 2002:adf:d845:: with SMTP id k5mr837235wrl.285.1599589785899;
 Tue, 08 Sep 2020 11:29:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZu8EKaFz8w2EWFl6bM0s8J64wio0eTGpPPzEq5m5lIntuZOfxd/bHQDC3XSQ47da5IJ4kCA==
X-Received: by 2002:adf:d845:: with SMTP id k5mr837204wrl.285.1599589785642;
 Tue, 08 Sep 2020 11:29:45 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l10sm299332wmh.27.2020.09.08.11.29.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 11:29:45 -0700 (PDT)
Subject: Re: [PATCH 4/5] hw/smbios: use qapi for SMBIOS entry point type enum
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200908165438.1008942-1-berrange@redhat.com>
 <20200908165438.1008942-5-berrange@redhat.com>
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
Message-ID: <d450186c-f0e6-19e8-fd27-99ef70b06d47@redhat.com>
Date: Tue, 8 Sep 2020 20:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908165438.1008942-5-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 6:54 PM, Daniel P. Berrangé wrote:
> This refactoring prepares for exposing the SMBIOS entry point type as a
> machine property on x86.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/arm/virt.c                |  2 +-
>  hw/i386/pc_piix.c            |  2 +-
>  hw/i386/pc_q35.c             |  2 +-
>  hw/smbios/smbios.c           |  9 +++++----
>  include/hw/firmware/smbios.h |  9 ++-------
>  qapi/machine.json            | 12 ++++++++++++
>  6 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index acf9bfbece..fd32b10f75 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1450,7 +1450,7 @@ static void virt_build_smbios(VirtMachineState *vms)
>  
>      smbios_set_defaults("QEMU", product,
>                          vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
> -                        true, SMBIOS_ENTRY_POINT_30);
> +                        true, SMBIOS_ENTRY_POINT_TYPE_3_0);
>  
>      smbios_get_tables(MACHINE(vms), NULL, 0, &smbios_tables, &smbios_tables_len,
>                        &smbios_anchor, &smbios_anchor_len);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 32b1453e6a..1c5bc6ae6e 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -179,7 +179,7 @@ static void pc_init1(MachineState *machine,
>          smbios_set_defaults("QEMU", "Standard PC (i440FX + PIIX, 1996)",
>                              mc->name, pcmc->smbios_legacy_mode,
>                              pcmc->smbios_uuid_encoded,
> -                            SMBIOS_ENTRY_POINT_21);
> +                            SMBIOS_ENTRY_POINT_TYPE_2_1);
>      }
>  
>      /* allocate ram and load rom/bios */
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 0cb9c18cd4..cc202407c7 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -204,7 +204,7 @@ static void pc_q35_init(MachineState *machine)
>          smbios_set_defaults("QEMU", "Standard PC (Q35 + ICH9, 2009)",
>                              mc->name, pcmc->smbios_legacy_mode,
>                              pcmc->smbios_uuid_encoded,
> -                            SMBIOS_ENTRY_POINT_21);
> +                            SMBIOS_ENTRY_POINT_TYPE_2_1);
>      }
>  
>      /* allocate ram and load rom/bios */
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 3c87be6c91..c99c9b01ae 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -61,7 +61,7 @@ uint8_t *smbios_tables;
>  size_t smbios_tables_len;
>  unsigned smbios_table_max;
>  unsigned smbios_table_cnt;
> -static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_21;
> +static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_2_1;
>  
>  static SmbiosEntryPoint ep;
>  
> @@ -383,7 +383,7 @@ static void smbios_validate_table(MachineState *ms)
>          exit(1);
>      }
>  
> -    if (smbios_ep_type == SMBIOS_ENTRY_POINT_21 &&
> +    if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_2_1 &&
>          smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
>          error_report("SMBIOS 2.1 table length %zu exceeds %d",
>                       smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
> @@ -831,7 +831,7 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
>  static void smbios_entry_point_setup(void)
>  {
>      switch (smbios_ep_type) {
> -    case SMBIOS_ENTRY_POINT_21:
> +    case SMBIOS_ENTRY_POINT_TYPE_2_1:
>          memcpy(ep.ep21.anchor_string, "_SM_", 4);
>          memcpy(ep.ep21.intermediate_anchor_string, "_DMI_", 5);
>          ep.ep21.length = sizeof(struct smbios_21_entry_point);
> @@ -854,7 +854,7 @@ static void smbios_entry_point_setup(void)
>          ep.ep21.structure_table_address = cpu_to_le32(0);
>  
>          break;
> -    case SMBIOS_ENTRY_POINT_30:
> +    case SMBIOS_ENTRY_POINT_TYPE_3_0:
>          memcpy(ep.ep30.anchor_string, "_SM3_", 5);
>          ep.ep30.length = sizeof(struct smbios_30_entry_point);
>          ep.ep30.entry_point_revision = 1;
> @@ -939,6 +939,7 @@ void smbios_get_tables(MachineState *ms,
>      *tables = smbios_tables;
>      *tables_len = smbios_tables_len;
>      *anchor = (uint8_t *)&ep;
> +    g_printerr("Total len %zu\n", smbios_tables_len);

This seems to belong to patch 2 of this series:
"hw/smbios: report error if table size is too large"

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>      /* calculate length based on anchor string */
>      if (!strncmp((char *)&ep, "_SM_", 4)) {
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index 02a0ced0a0..cb1299ad7a 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -1,6 +1,8 @@
>  #ifndef QEMU_SMBIOS_H
>  #define QEMU_SMBIOS_H
>  
> +#include "qapi/qapi-types-machine.h"
> +
>  /*
>   * SMBIOS Support
>   *
> @@ -23,13 +25,6 @@ struct smbios_phys_mem_area {
>      uint64_t length;
>  };
>  
> -/*
> - * SMBIOS spec defined tables
> - */
> -typedef enum SmbiosEntryPointType {
> -    SMBIOS_ENTRY_POINT_21,
> -    SMBIOS_ENTRY_POINT_30,
> -} SmbiosEntryPointType;
>  
>  /* SMBIOS Entry Point
>   * There are two types of entry points defined in the SMBIOS specification
> diff --git a/qapi/machine.json b/qapi/machine.json
> index abc6fd0477..a58cf2694f 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -937,3 +937,15 @@
>    'data': 'NumaOptions',
>    'allow-preconfig': true
>  }
> +
> +##
> +# @SmbiosEntryPointType:
> +#
> +# @2_1: SMBIOS version 2.1
> +#
> +# @3_0: SMBIOS version 3.0
> +#
> +# Since: 5.2
> +##
> +{ 'enum': 'SmbiosEntryPointType',
> +  'data': [ '2_1', '3_0' ] }
> 


