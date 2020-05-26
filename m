Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECB7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0749B20663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh/zPoi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0749B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdY9o-0005oK-7A
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdY7n-00035x-Mk
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:52:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdY7l-0004tv-Hn
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590493919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6uCMRBInzcIPwPUYwSXpuY+zyISeW8yjlQu38QDh/mo=;
 b=Zh/zPoi1DK9Qi5EirDTseQmY1MtsotiUFDK9334WSRny69mQ6am/eGKm9iJSfBju1K8ndV
 KwQUQnLhZE6XsICiikCrKS3yrEkjvYLEyMQak1Eq+OQf9XQCqXvNiPA9F6IY+7KNeUf96O
 jK36roKxaGoMALmrWF9++n0z5nqrQ24=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-bSYRjldONOCfv6ozLoUI6Q-1; Tue, 26 May 2020 07:51:58 -0400
X-MC-Unique: bSYRjldONOCfv6ozLoUI6Q-1
Received: by mail-ej1-f72.google.com with SMTP id j14so1549701ejx.23
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 04:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6uCMRBInzcIPwPUYwSXpuY+zyISeW8yjlQu38QDh/mo=;
 b=AbQpdt0zTSk95NiB0CgNR7k+Q2IvaDaKdrYLPc3TEFPC3CcYqAAqDyUe45Jrx18CNv
 OOPCc4SFW9V9mPrZZTdUnX/HwJWrrvRGTVWGTh7ROms4VcMG96Xhcvt/2jcfv9lxpQb6
 +gi21R7O4ULFBo4/IpTW2Jx0SUJ8/ipL51bMGHNiXjwS2fl92xN3jbHq37A81Zo8cLYE
 Y7uAmHGUXXzt9z95UE4lgoab65FcruF3JPeVhiLLdKJQXW8bzsywslwzMErsTK/lbS82
 J52yaJoYGtJW4ynbxqMZhL31CQ0DND2mWukAedXaEQDlJSRgOdru8y2VpSMY7/fZGEDU
 +QhA==
X-Gm-Message-State: AOAM531WY5i1+EnactU/OgaA8ao/4J8QxuovzZyBe03AfEZQjni8Hrpg
 NUviE4vetysfj3qj3eaMOPZC+Gl4PZ6dMPdXzo3spK7ZioK6BegDk6eFqswdVvZbfTSIoz8iDs7
 UINbJaloRaA8SyuM=
X-Received: by 2002:a17:906:dbef:: with SMTP id
 yd15mr740397ejb.5.1590493916927; 
 Tue, 26 May 2020 04:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdRhTwL7htgsaWd+9FqOEh6Jv6JGtiUzqWv8oZ9cGny5tQbZtW58kxTvqKLH90VyQBiF4AVg==
X-Received: by 2002:a17:906:dbef:: with SMTP id
 yd15mr740383ejb.5.1590493916729; 
 Tue, 26 May 2020 04:51:56 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id d11sm7032353edp.26.2020.05.26.04.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 04:51:56 -0700 (PDT)
Subject: Re: [PATCH 33/55] qom: Tidy up a few object_initialize_child() calls
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-34-armbru@redhat.com>
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
Message-ID: <cdb66b7c-0dea-b21a-5417-f043a6981ef1@redhat.com>
Date: Tue, 26 May 2020 13:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-34-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 00:48:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 4:55 PM, Markus Armbruster wrote:
> The callers of object_initialize_child() commonly  pass either
> &child, sizeof(child), or pchild, sizeof(*pchild).  Tidy up the few
> that don't, mostly to keep the next commit simpler.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/aspeed.c                 | 2 +-
>  hw/microblaze/xlnx-zynqmp-pmu.c | 3 +--
>  hw/pci-host/pnv_phb4.c          | 2 +-
>  hw/riscv/riscv_hart.c           | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index adbfbbd6b4..eaf50da8df 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -267,7 +267,7 @@ static void aspeed_machine_init(MachineState *machine)
>      memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
>  
>      object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
> -                            (sizeof(bmc->soc)), amc->soc_name, &error_abort,
> +                            sizeof(bmc->soc), amc->soc_name, &error_abort,
>                              NULL);
>  
>      sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 028f31894d..aa90b9d1be 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -174,8 +174,7 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>                                  pmu_ram);
>  
>      /* Create the PMU device */
> -    object_initialize_child(OBJECT(machine), "pmu", pmu,
> -                            sizeof(XlnxZynqMPPMUSoCState),
> +    object_initialize_child(OBJECT(machine), "pmu", pmu, sizeof(*pmu),
>                              TYPE_XLNX_ZYNQMP_PMU_SOC, &error_abort, NULL);
>      object_property_set_bool(OBJECT(pmu), true, "realized", &error_fatal);
>  
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index e30ae9ad5b..aba710fd1f 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1155,7 +1155,7 @@ static void pnv_phb4_instance_init(Object *obj)
>      QLIST_INIT(&phb->dma_spaces);
>  
>      /* XIVE interrupt source object */
> -    object_initialize_child(obj, "source", &phb->xsrc, sizeof(XiveSource),
> +    object_initialize_child(obj, "source", &phb->xsrc, sizeof(phb->xsrc),
>                              TYPE_XIVE_SOURCE, &error_abort, NULL);
>  
>      /* Root Port */
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 276a9baca0..61e88e2e37 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -46,7 +46,7 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
>      Error *err = NULL;
>  
>      object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
> -                            sizeof(RISCVCPU), cpu_type,
> +                            sizeof(s->harts[idx]), cpu_type,
>                              &error_abort, NULL);
>      s->harts[idx].env.mhartid = s->hartid_base + idx;
>      qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


