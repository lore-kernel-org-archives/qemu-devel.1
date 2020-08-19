Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DBE2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvNYCFDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DBE2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8EYk-0004pI-Ar
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 23:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8EYC-0004On-UT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:14:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48934
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8EYB-0004UJ-5j
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597806846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KAUSjRGA2Q9BGD8XNLP2H6DG9SM8DERncEv9awtQVOk=;
 b=AvNYCFDnAC3zKNxq2jjWHQYZtB5T47QVn/+alcYU6IrJSdoONmLwDQLkwfVmzqxnZAPt7j
 vXd1d0pQt39CUbO2nPCmOFsgmqHMjXepkfjsUmQgxgQ8btE24bvHjm6pAy2UFCEVAWkINk
 +kctGHrt8W9VoRKDYXc3FJyK2eE6rxw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-zaYeASAUNjaDKtStBbD4-w-1; Tue, 18 Aug 2020 23:14:04 -0400
X-MC-Unique: zaYeASAUNjaDKtStBbD4-w-1
Received: by mail-wr1-f71.google.com with SMTP id o10so8866284wrs.21
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 20:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=KAUSjRGA2Q9BGD8XNLP2H6DG9SM8DERncEv9awtQVOk=;
 b=ZCtwppVCPuraguc/EmpTW5ZlSCkcyAxwFUPtU4z4+Grrs6uBLU8g2SzfPHNSFPo7rM
 D/i1Zj8PCoDH8MJ6EpYcGD4qHxyKy28KSbiN1yqCn093XJkPAtvZv8LZYma19MPu1y6b
 7qVQ7PYruWcCSLF53OWmHlQ1JWoe/gleQRyouWNS2s/fOFGY9SyuWRtwTFQoOUtWuPYd
 q1jkdtjGGBetqbxYW9aZucdLTczpw5QQWp/hwB/2zHPRajumM33FgOVBN7GI/SpQGzIt
 n86sQyewCLE7oTp4SgwdSSEFUlHVjCDFW90+WqgJIH+q3PBuXUKpxxdeZlOdBQQiMMQA
 1wyQ==
X-Gm-Message-State: AOAM532yFqJMdyyv7/+fcmTlM61yg181Njjnz0WJRizEI/SDj1bUW9Wl
 Oukwr32czWC+6D4niyi2ZFpVKAG3x+Y5JNuFEXxxKigBo0fG+BSOo2WsXTrd9AIS1ockRvqOxCf
 3P1Maw4TA0ICBDPM=
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr2816369wmf.49.1597806843888; 
 Tue, 18 Aug 2020 20:14:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRV1Ok1O30UmKHf+1C6JgbjJhH3f47kDD7FZOTmHibZirz1WJqGrQ1RRj/aSNYt6G/S4WXcw==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr2816351wmf.49.1597806843625; 
 Tue, 18 Aug 2020 20:14:03 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o124sm2834872wmb.2.2020.08.18.20.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 20:14:03 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/4] hw/acpi/ich9: Trace ich9_gpe_readb()/writeb()
To: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200818215227.181654-2-jusual@redhat.com>
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
Message-ID: <7220698b-3a7c-cd36-9ca5-5bb9a06a8fd6@redhat.com>
Date: Wed, 19 Aug 2020 05:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818215227.181654-2-jusual@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 22:38:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 11:52 PM, Julia Suvorova wrote:
> Add trace events similar to piix4_gpe_readb() to check gpe status.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ich9.c       | 7 ++++++-
>  hw/acpi/trace-events | 4 ++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 6a19070cec..a2a1742aa6 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -36,6 +36,7 @@
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/tco.h"
>  #include "exec/address-spaces.h"
> +#include "trace.h"
>  
>  #include "hw/i386/ich9.h"
>  #include "hw/mem/pc-dimm.h"
> @@ -59,13 +60,17 @@ static void ich9_pm_update_sci_fn(ACPIREGS *regs)
>  static uint64_t ich9_gpe_readb(void *opaque, hwaddr addr, unsigned width)
>  {
>      ICH9LPCPMRegs *pm = opaque;
> -    return acpi_gpe_ioport_readb(&pm->acpi_regs, addr);
> +    uint64_t val = acpi_gpe_ioport_readb(&pm->acpi_regs, addr);
> +
> +    trace_ich9_gpe_readb(addr, width, val);
> +    return val;
>  }
>  
>  static void ich9_gpe_writeb(void *opaque, hwaddr addr, uint64_t val,
>                              unsigned width)
>  {
>      ICH9LPCPMRegs *pm = opaque;
> +    trace_ich9_gpe_writeb(addr, width, val);
>      acpi_gpe_ioport_writeb(&pm->acpi_regs, addr, val);
>      acpi_update_sci(&pm->acpi_regs, pm->irq);
>  }
> diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
> index afbc77de1c..b9f4827afc 100644
> --- a/hw/acpi/trace-events
> +++ b/hw/acpi/trace-events
> @@ -32,6 +32,10 @@ cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
>  cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
>  cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
>  
> +# ich9.c
> +ich9_gpe_readb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d ==> 0x%" PRIx64
> +ich9_gpe_writeb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d <== 0x%" PRIx64

Nitpick, val could be uint8_t.

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
>  # pcihp.c
>  acpi_pci_eject_slot(unsigned bsel, unsigned slot) "bsel: %u slot: %u"
>  acpi_pci_unplug(int bsel, int slot) "bsel: %d slot: %d"
> 


