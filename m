Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084C1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81622076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoftBUHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81622076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Uxg-000106-OV
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Uwk-0000WX-Pg
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:08:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Uwi-0000TY-GB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597154887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/s+ESoIbICEwvKweajZPdDVxK9FaWI6yx7KYh+qZV+4=;
 b=IoftBUHts2LbKLSqsXj5Xij5lqq1FOJx2Bi3pNTDXIPUnBIaWxXPFF7oUK0d11Mh1Mwakf
 aa56/CN3aLkMGAN3iCNCByy7E/4r7Nua6R63Iqr585VYHkxu2fqdfFuDUNLj6e+jBWwcWp
 WEBLVGJGB67p0nJ5K/1aLcXJUGi0l2I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-AsFpHc51N5eiPvrIdQPJkw-1; Tue, 11 Aug 2020 10:08:02 -0400
X-MC-Unique: AsFpHc51N5eiPvrIdQPJkw-1
Received: by mail-wr1-f72.google.com with SMTP id w7so5626408wre.11
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 07:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/s+ESoIbICEwvKweajZPdDVxK9FaWI6yx7KYh+qZV+4=;
 b=hl+QV231Pr15YUHRyzvyMhN+9SB/YDGaxMDvIgW17WRM3YdE3m0pS16z1FDyV/6GCP
 c3VnjMDHgmnliPdRsppDdNI55bPpACp/C+p+GGEpUWv+qi3aK8qmUl3Vc4QxrCkjF3co
 cJCu2anCpDEPuhLRA5w/8cnpR/6Mmj+LkHYotOfdXh9ZOrXlr7t773DQAnikB5DNENsl
 m5244fAq2QI6npNUp6G+AYKXlCy1e5UcVjpndHvndNCrG34sTiNYbjQO9B2ORpWDw9IQ
 3yrTZy//Y7jHeGaNSq3LcWxDka6ixLhkYKsxg58W0HJAHNdIFZUXXdp2o/C7120W1xLR
 734Q==
X-Gm-Message-State: AOAM530kaFVCXeHScKIydtFqn5y9s/TtzNe9XaBdWJXXywDbHtGVKiqp
 gxt/vFJC+TyEzEin83V0vP3uzEvcHTKzpGWptgNSx7WkH0tICO8smCJwG68PCAeJDKvUsWYBMP9
 yo7bq6/0ncoAk18Q=
X-Received: by 2002:adf:9e04:: with SMTP id u4mr31715431wre.302.1597154881572; 
 Tue, 11 Aug 2020 07:08:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrihpGJUPtTA0a61RGXU9xdBcXV1m15bycHkYmergsZ3n0cPoFYjIwe24tN0uJ++u2+0yWAw==
X-Received: by 2002:adf:9e04:: with SMTP id u4mr31715399wre.302.1597154881293; 
 Tue, 11 Aug 2020 07:08:01 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id s8sm5275966wmc.1.2020.08.11.07.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 07:08:00 -0700 (PDT)
Subject: Re: [PATCH v4 6/9] spapr_pci: add spapr msi read method
To: P J P <ppandit@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200811114133.672647-1-ppandit@redhat.com>
 <20200811114133.672647-7-ppandit@redhat.com>
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
Message-ID: <9da90cfa-71d3-b7cd-5e5b-a19db72fc405@redhat.com>
Date: Tue, 11 Aug 2020 16:07:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200811114133.672647-7-ppandit@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing PCI maintainers

On 8/11/20 1:41 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Add spapr msi mmio read method to avoid NULL pointer dereference
> issue.
> 
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ppc/spapr_pci.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> Update v4: fix multi-line comment and log guest_error
>   -> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05311.html
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 363cdb3f7b..53dfd3d8c6 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -52,6 +52,7 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
> +#include "qemu/log.h"
>  
>  /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
>  #define RTAS_QUERY_FN           0
> @@ -738,6 +739,12 @@ static PCIINTxRoute spapr_route_intx_pin_to_irq(void *opaque, int pin)
>      return route;
>  }
>  
> +static uint64_t spapr_msi_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid access\n", __func__);
> +    return 0;
> +}
> +
>  /*
>   * MSI/MSIX memory region implementation.
>   * The handler handles both MSI and MSIX.
> @@ -755,8 +762,11 @@ static void spapr_msi_write(void *opaque, hwaddr addr,
>  }
>  
>  static const MemoryRegionOps spapr_msi_ops = {
> -    /* There is no .read as the read result is undefined by PCI spec */
> -    .read = NULL,
> +    /*
> +     * .read result is undefined by PCI spec.
> +     * define .read method to avoid assert failure in memory_region_init_io
> +     */
> +    .read = spapr_msi_read,

Shouldn't this be a read_with_attrs handler returning MEMTX_ERROR
instead? Maybe we need another MemTxResult which does not yet exist.

>      .write = spapr_msi_write,
>      .endianness = DEVICE_LITTLE_ENDIAN
>  };
> 


