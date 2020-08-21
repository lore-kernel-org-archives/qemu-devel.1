Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB259C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A931B207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWMiDIaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A931B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96ip-0005jR-0E
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k96i7-0004ry-Sk
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k96i4-00053R-U6
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598015035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BiV4Hg4sqPpe614FirJhlM0C2jC5QA8vtoOD5fUXK30=;
 b=JWMiDIaKU1/0tm2M2XH29RuB41CykvjrIvbTdf/aCtEMjzEbcr2xj3zO1wW4n+ar+Au5PL
 roG62+gxNToKsO8OJblHmh3pB5pxZqBw/PSnvcJtZk5nmStnIJX2efpeLiKijb5vwUc4up
 u/EAI3vJHhy1/wF5lx7wKiaisRak7k0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-y2IduTxqNRasBvgGtE9Hig-1; Fri, 21 Aug 2020 09:03:53 -0400
X-MC-Unique: y2IduTxqNRasBvgGtE9Hig-1
Received: by mail-wm1-f70.google.com with SMTP id v8so948330wma.6
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BiV4Hg4sqPpe614FirJhlM0C2jC5QA8vtoOD5fUXK30=;
 b=UjVvvsGSY196WQLHLacc7sOda5TTn+cm2SxRhRS/CCBAtn4Q0gUehPqbLBDKVfO6yM
 6JiwZCwjfkAD7mL0wnxsdUa2gFYTAuZH8w6IBYyvIL/TZ/uNlvcyDvv1wNAOZ4RcxIqV
 o/D5HKzUCIqgLgItMek1ua/6sGr9CSSoMvGMA6ZPCiK3K3nARMXxu4gxBpy3DSw+0e0D
 Ip+m8wr2x+Dw3vQl5Dzcwki5E36dP4ux52FKAGK713LB5MDAR8lpV2GENuWqCcr8nw1r
 Xkf5m3Scg2pXVkt1ycJiH9FaCilcnLQFu/IV/dOIrS1+Bx8fFTlnIPA/uaq0ExGxfj+Z
 yRSA==
X-Gm-Message-State: AOAM533bKhyWOxQZcbNHIqHYnBOnS4Z1kPqqWhRTJIRwXWepzeBKt16E
 WgvDznimqQ1NOMXTJjKcJUz1Ba8uSO93wqHKEHF6QfQBziyOgbTCmc4YbA/iAvW40OD+RFDSIdH
 G15bT9TFtiaL+iHs=
X-Received: by 2002:adf:ed49:: with SMTP id u9mr2634490wro.408.1598015032782; 
 Fri, 21 Aug 2020 06:03:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9HPq5mifdCioXWUtxKxRlDLi+QPO89riRghrj9hWLfoY1MiW4FI4+E7f5D0IZ8uQ3qvdngg==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr2634453wro.408.1598015032274; 
 Fri, 21 Aug 2020 06:03:52 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id q2sm4238227wro.8.2020.08.21.06.03.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:03:51 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvdimm: honor -object memory-backend-file,
 readonly=on option
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
References: <20200804101244.1283503-1-stefanha@redhat.com>
 <20200804101244.1283503-4-stefanha@redhat.com>
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
Message-ID: <db6f0cae-88ee-fba0-2d2c-82255f52e7f6@redhat.com>
Date: Fri, 21 Aug 2020 15:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804101244.1283503-4-stefanha@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 12:12 PM, Stefan Hajnoczi wrote:
> Make it possible to present read-only files to the guest as "unarmed"
> NVDIMMs. The Linux NVDIMM device (/dev/pmemX) is read-only.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/nvdimm.txt | 8 +++++++-
>  hw/mem/nvdimm.c | 4 ++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index c2c6e441b3..c0b52de111 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -17,7 +17,7 @@ following command line options:
>  
>   -machine pc,nvdimm
>   -m $RAM_SIZE,slots=$N,maxmem=$MAX_SIZE
> - -object memory-backend-file,id=mem1,share=on,mem-path=$PATH,size=$NVDIMM_SIZE
> + -object memory-backend-file,id=mem1,share=on,mem-path=$PATH,size=$NVDIMM_SIZE,readonly=off
>   -device nvdimm,id=nvdimm1,memdev=mem1
>  
>  Where,
> @@ -42,6 +42,12 @@ Where,
>     "share=off", then guest writes won't be applied to the backend
>     file and thus will be invisible to other guests.
>  
> +   "readonly=on/off" controls whether the the file $PATH is opened read-only or

Double "the the".

> +   read/write (default). "readonly=on" sets the ACPI NFIT NVDIMM Region Mapping

NFIT acronym for 'NVDIMM Firmware Interface Table', "NVDIMM" sounds
redundant but makes it easier to understand, so OK.

> +   Structure "NVDIMM State Flags" Bit 3 indicating that the device is "unarmed"
> +   and cannot accept persistent writes. Linux guest drivers set the device to
> +   read-only when this bit is present.
> +
>   - "device nvdimm,id=nvdimm1,memdev=mem1" creates a virtual NVDIMM
>     device whose storage is provided by above memory backend device.
>  
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index e1574bc07c..694223450e 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -151,6 +151,10 @@ static void nvdimm_prepare_memory_region(NVDIMMDevice *nvdimm, Error **errp)
>                               "nvdimm-memory", mr, 0, pmem_size);
>      memory_region_set_nonvolatile(nvdimm->nvdimm_mr, true);
>      nvdimm->nvdimm_mr->align = align;
> +
> +    if (memory_region_is_rom(mr)) {
> +        nvdimm->unarmed = true; /* this device is read-only */
> +    }

Can you move this hunk before the alias creation?
(Just before nvdimm->nvdimm_mr = ...).

>  }
>  
>  static MemoryRegion *nvdimm_md_get_memory_region(MemoryDeviceState *md,

I don't understand why MemoryDeviceClass::get_memory_region() implicitly
calls DeviceClass::realize()...
Anyway unrelated to this patch.

With the comments addressed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


