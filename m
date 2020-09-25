Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55657C4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A5823718
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VF0O0Zix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A5823718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnbK-0006Pu-Sm
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLnQd-0000lK-5D
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLnQZ-0003Cg-Jp
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:06:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601039178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MwXAmNRB1Co8TdGPipWygP+bRRe4cN+Goexbeuex3y0=;
 b=VF0O0Zix31qGjTw9oaj/MmwDAJ9ITdLXlOdYmg1d/tpHIrJz6UYkjb0+0rsBql91GoeXDC
 6AuqafNF9e2/FFqeSli+mVO1oWEkngBNMv2AX67CkOss+O3Ar+H0QAUZvjGexbZd1TCjS4
 RFYW8VjZ0xbWVKc9LH+7ecrCowxOPvo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-spoae6S8OzueGaOR-oQwCg-1; Fri, 25 Sep 2020 09:06:15 -0400
X-MC-Unique: spoae6S8OzueGaOR-oQwCg-1
Received: by mail-wr1-f70.google.com with SMTP id v12so1055787wrm.9
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 06:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MwXAmNRB1Co8TdGPipWygP+bRRe4cN+Goexbeuex3y0=;
 b=KrixJQFygTmF48m+oKVjN4HmWWqY87cj7orOlxSnp1VQvgORqsrE5nM6AXh9Lnd2Kd
 lJMdCAwApJrV33koRE5WMDb3g0rhNuWJnVN3vXiBCzSfUo9gL54uA+19aSwkntUzoHnN
 2+xn4WIInEtE46KpkDpaHR/C+11tGNGMKHvBYdtj9eEvPk5YnuW2d8RDoghTxk1u0v6n
 szV0IeUYL6t8NxrDpUaHcARVh126i2WjCOkhyr+JA7+GKURVd2fjtjKeIwAMt5WMhtCZ
 SKiYWzoaulEKuMBdP7MV2tMU6AW2pMFDtpB/CQv8C/1wonqlBd8HnHB4v4p7neuZHp/u
 xWXA==
X-Gm-Message-State: AOAM530RFtr1FYGbRR7bBLVmP8tvnFZNNBCWyle9rt9+LaZB36i5c9vC
 HEe0p45dosHqWSs4wrifTJ1bYJw+9n4t4croRquDQxBOpdojEm24i3jMGaK2/tikUeHmhXtzCEb
 cMB75w1SdmFN1Qxg=
X-Received: by 2002:adf:ab46:: with SMTP id r6mr4646706wrc.360.1601039174335; 
 Fri, 25 Sep 2020 06:06:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNoPp3VY6SwFP5eJ4NTpWSDA53srsZ703MXtix9A48VwFvstWfzQqPetx7mwSAy4n9ShIZFA==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr4646666wrc.360.1601039174085; 
 Fri, 25 Sep 2020 06:06:14 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id i16sm2796785wrq.73.2020.09.25.06.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 06:06:13 -0700 (PDT)
Subject: Re: [RFC PATCH 05/19] virtio-pci: add notification trace points
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
References: <20200925125147.26943-1-alex.bennee@linaro.org>
 <20200925125147.26943-6-alex.bennee@linaro.org>
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
Message-ID: <33175aac-62c1-ee9a-c156-dde663737100@redhat.com>
Date: Fri, 25 Sep 2020 15:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925125147.26943-6-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 takahiro.akashi@linaro.org, virtualization@lists.linuxfoundation.org,
 arnd@linaro.org, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 2:51 PM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  hw/virtio/virtio-pci.c | 3 +++
>  hw/virtio/trace-events | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 507cb57c410f..33a40e31d955 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -36,6 +36,7 @@
>  #include "qemu/range.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "qapi/visitor.h"
> +#include "trace.h"
>  
>  #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
>  
> @@ -1340,6 +1341,7 @@ static void virtio_pci_notify_write(void *opaque, hwaddr addr,
>      unsigned queue = addr / virtio_pci_queue_mem_mult(proxy);
>  
>      if (vdev != NULL && queue < VIRTIO_QUEUE_MAX) {
> +        trace_virtio_pci_notify_write(addr, val, size);
>          virtio_queue_notify(vdev, queue);
>      }
>  }
> @@ -1353,6 +1355,7 @@ static void virtio_pci_notify_write_pio(void *opaque, hwaddr addr,
>      unsigned queue = val;
>  
>      if (vdev != NULL && queue < VIRTIO_QUEUE_MAX) {
> +        trace_virtio_pci_notify_write_pio(addr, val, size);
>          virtio_queue_notify(vdev, queue);
>      }
>  }
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 845200bf109d..189972b9213a 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -55,7 +55,12 @@ virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 "
>  virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue write 0x%" PRIx64 " max %d"
>  virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
>  
> -# virtio-iommu.c
> +# virtio-pci.c
> +virtio_pci_notify(uint16_t vector) "virtio_pci_notify vec 0x%x"

Not used.

> +virtio_pci_notify_write(uint64_t addr, uint64_t val, unsigned int size) "0x%" PRIx64" = 0x%" PRIx64 " (%d)"
> +virtio_pci_notify_write_pio(uint64_t addr, uint64_t val, unsigned int size) "0x%" PRIx64" = 0x%" PRIx64 " (%d)"
> +
> +# hw/virtio/virtio-iommu.c

Probably left-over from automatic rename from patch #3
"move virtio-pci.h into shared include space", but please
keep the local name 'virtio-iommu.c'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  virtio_iommu_device_reset(void) "reset!"
>  virtio_iommu_get_features(uint64_t features) "device supports features=0x%"PRIx64
>  virtio_iommu_device_status(uint8_t status) "driver status = %d"
> 


