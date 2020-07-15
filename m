Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A6BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 06:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857402067D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 06:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOxyWCXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857402067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvbL7-0005xX-Do
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 02:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvbKA-0005QH-Hv
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 02:55:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvbK7-0004cx-Jy
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 02:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594796122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zhvNyBK7YavCNuG4CekFqC4TX4vYoquq7vpojd5EjCc=;
 b=HOxyWCXVewD0KmAn4+rihz5oNYVoIaUjSObx1Ol8QknZG8WmqiDngzrueqY9Cyjp+7p21x
 Z86B8gBEiEqlA3JlyxBW2gwSA3ahuJu5OpBrxfuqeVGdbc6doHTV/RC/YxAzlOddgiqp0V
 xtg5unOv/v7/lZpQ75/v2UYX4rIzthE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-hhQ5bbtKPnCl7BymHy1z_Q-1; Wed, 15 Jul 2020 02:55:20 -0400
X-MC-Unique: hhQ5bbtKPnCl7BymHy1z_Q-1
Received: by mail-wm1-f71.google.com with SMTP id 65so252408wmd.8
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 23:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zhvNyBK7YavCNuG4CekFqC4TX4vYoquq7vpojd5EjCc=;
 b=nrPWIMfGaObKLVAKHtKnJBg9Zw4mlJpe9HljrfAhjZg0cVeM6Rcuz0I2uI76P7CUZe
 DUIKee/++Z+n1dMthORQ96rwbcjzetfief5IHZZIeLGs2YAwi5RnNuwI6BoBF7qWoUCV
 60IMY2Fy6Eet70vjr301qALBeHqp2c/m2uACrkCkWN2oEIehQfJZlwpuejIcUgWrilJo
 NKYg7fh3265qXNx+aJ8JYLqhG0+d7qisDGexKBMGyLJItPQFm+EzfYgIvNj5/LC0XIbI
 cDVGGU40wi5xvNzNf+afzTAQe9Ck34WkXUgyoSfr+10keI/+xAlo1B9AEwCZS6bDmEZr
 ULeA==
X-Gm-Message-State: AOAM530mVPPENSHMZiZO+pWCtgpMfCkkQE+LDbSWMudBqI3AEGewKqqt
 SDIrAvojV2yJYeXs774kbeziAbtJmunQyC9tbvDPvpwofdyuKwFPn2XpEaRCG4i50la80XnaQEX
 uHS+XoFthjYpfVsU=
X-Received: by 2002:a5d:634e:: with SMTP id b14mr10123363wrw.423.1594796119053; 
 Tue, 14 Jul 2020 23:55:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/aAg6+/WrQ08ze+n5daRKOYT2JCLjaCnFamZRmlwAI4fRTCWqzupZ9kRd/3Ha876Tp6CrUA==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr10123344wrw.423.1594796118848; 
 Tue, 14 Jul 2020 23:55:18 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d81sm10802470wmc.0.2020.07.14.23.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 23:55:18 -0700 (PDT)
Subject: Re: [PATCH] ppc/spapr: Fix 32 bit logical memory block size
 assumptions
To: Anton Blanchard <anton@ozlabs.org>, david@gibson.dropbear.id.au,
 groug@kaod.org, aik@ozlabs.ru, nathanl@linux.ibm.com
References: <20200715004228.1262681-1-anton@ozlabs.org>
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
Message-ID: <2ff9d50c-21cd-4b89-adee-7f681fe590fd@redhat.com>
Date: Wed, 15 Jul 2020 08:55:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200715004228.1262681-1-anton@ozlabs.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Anton,

On 7/15/20 2:42 AM, Anton Blanchard wrote:
> When testing large LMB sizes (eg 4GB), I found a couple of places
> that assume they are 32bit in size.
> 
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> ---
>  hw/ppc/spapr.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a1b06defe6..0ba2526215 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -558,7 +558,8 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
>      int nb_numa_nodes = machine->numa_state->num_nodes;
>      int ret, i, offset;
>      uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
> -    uint32_t prop_lmb_size[] = {0, cpu_to_be32(lmb_size)};
> +    uint32_t prop_lmb_size[] = {cpu_to_be32(lmb_size >> 32),
> +                                cpu_to_be32(lmb_size & 0xffffffff)};

This looks simpler:

-- >8 --
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -557,8 +557,7 @@ static int
spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
     MachineState *machine = MACHINE(spapr);
     int nb_numa_nodes = machine->numa_state->num_nodes;
     int ret, i, offset;
-    uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
-    uint32_t prop_lmb_size[] = {0, cpu_to_be32(lmb_size)};
+    uint64_t lmb_size = cpu_to_be64(SPAPR_MEMORY_BLOCK_SIZE);
     uint32_t *int_buf, *cur_index, buf_len;
     int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
     MemoryDeviceInfoList *dimms = NULL;
@@ -572,8 +571,7 @@ static int
spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,

     offset = fdt_add_subnode(fdt, 0, "ibm,dynamic-reconfiguration-memory");

-    ret = fdt_setprop(fdt, offset, "ibm,lmb-size", prop_lmb_size,
-                    sizeof(prop_lmb_size));
+    ret = fdt_setprop(fdt, offset, "ibm,lmb-size", lmb_size,
sizeof(lmb_size));
     if (ret < 0) {
         return ret;
     }
---

>      uint32_t *int_buf, *cur_index, buf_len;
>      int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
>      MemoryDeviceInfoList *dimms = NULL;
> @@ -899,7 +900,8 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>      uint32_t lrdr_capacity[] = {
>          cpu_to_be32(max_device_addr >> 32),
>          cpu_to_be32(max_device_addr & 0xffffffff),
> -        0, cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE),
> +        cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE >> 32),
> +        cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
>          cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
>      };
>      uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
> 


