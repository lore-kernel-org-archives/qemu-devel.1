Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47779C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014FE206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoDC68qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014FE206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfdXJ-0006Uf-Vy
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 02:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfdWU-00062r-NQ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 02:02:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56527
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfdWS-0005dY-S1
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 02:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590991326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EHXQthVxtdtmzBStFuASy/feogRwC9FCmPuZ0PQcOEk=;
 b=eoDC68qz7YKUjNHjMvWND+VrZb3G5nqNGqttSmSXBhRaTsWWBdOe6bsfIUmbUqscynu3Pt
 0RAn4Q73qk02xq+DvdHuWkBGGbIsJaMCgw3Bf1FLhzSIiOXIhBYZ7Omkhjz2qDFlHktZ2s
 mY96J/0WRDNZRqxH5snIcMCUx6ceqAw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-syNPcmlmMju_NUI2sKkUHA-1; Mon, 01 Jun 2020 02:02:04 -0400
X-MC-Unique: syNPcmlmMju_NUI2sKkUHA-1
Received: by mail-wr1-f69.google.com with SMTP id l18so4488165wrm.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 23:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=EHXQthVxtdtmzBStFuASy/feogRwC9FCmPuZ0PQcOEk=;
 b=ZDCPN78rf4oJ++ZsqSTp/PnVvDVYntxuUoVGe3rra1q4CfYY+9f0NXnT+H3ZhGjXIi
 5WyVdrI2iHJWuDChdUHUB0UAvd4MYVeAs8m315xfUmlccceoG4oRgQ9ZFO2V3VMefFYy
 z4T9/Vp/yabsPrM8LNCo6Ma1q10atPPLCcdep9qqswk+2O9Hf/+KzVLFVGGosZCePYHR
 Tu7E7O5DzYJLWwH3thMVtjZ4NbfA1r1UUfXj61tsDeNaENQrGN2AlKqbs3C7rBnxiNLh
 VQcOQOq0VJVXYKtr2LXD/8bPK8+VSi6O5H5Vx+bwNi0Jyf6rCl4voq5/wsBYgoBUOh3P
 IBXQ==
X-Gm-Message-State: AOAM532OOzbAcOZp+tHCUJliokmsuGwbASAj1kPLK3SSyuyVS1PeS0V6
 LQU53ypW03RE7wZm8bNj0e4VYavGobZNbsKTQbg23FZlQImI2YATHjz7WMIUzq4LyOd/WJ0uJk+
 ghPjoU40CwYESDxE=
X-Received: by 2002:a05:600c:22c9:: with SMTP id
 9mr1150604wmg.68.1590991323601; 
 Sun, 31 May 2020 23:02:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWa4XWolEO6tk1y/KGcEY4FYL/tBE6Htc/rx32oSqHFAX4OcRtyUTcTaqs8LW7benzX1Qmmg==
X-Received: by 2002:a05:600c:22c9:: with SMTP id
 9mr1150579wmg.68.1590991323382; 
 Sun, 31 May 2020 23:02:03 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id h1sm11762560wme.42.2020.05.31.23.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 23:02:02 -0700 (PDT)
Subject: Re: [PATCH] msix: add valid.accepts methods to check address
To: P J P <ppandit@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20200601051454.826415-1-ppandit@redhat.com>
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
Message-ID: <729e8bd2-ee11-5e6a-4b09-86bc1c56b9d3@redhat.com>
Date: Mon, 1 Jun 2020 08:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200601051454.826415-1-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:02:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, Ren Ding <rding@gatech.edu>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 7:14 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While doing msi-x mmio operations, a guest may send an address
> that leads to an OOB access issue. Add valid.accepts methods to
> ensure that ensuing mmio r/w operation don't go beyond regions.
> 

Fixes: CVE-2020-xxxxx

> Reported-by: Ren Ding <rding@gatech.edu>
> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/pci/msix.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 29187898f2..d90d66a3b8 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -193,6 +193,15 @@ static void msix_table_mmio_write(void *opaque, hwaddr addr,
>      msix_handle_mask_update(dev, vector, was_masked);
>  }
>  
> +static bool msix_table_accepts(void *opaque, hwaddr addr, unsigned size,
> +                                    bool is_write, MemTxAttrs attrs)
> +{
> +    PCIDevice *dev = opaque;
> +    uint16_t tbl_size = dev->msix_entries_nr * PCI_MSIX_ENTRY_SIZE;
> +
> +    return dev->msix_table + addr + 4 <= dev->msix_table + tbl_size;

Can be simplified as:

       return addr + 4 <= dev->msix_entries_nr * PCI_MSIX_ENTRY_SIZE;

> +}
> +
>  static const MemoryRegionOps msix_table_mmio_ops = {
>      .read = msix_table_mmio_read,
>      .write = msix_table_mmio_write,
> @@ -200,6 +209,7 @@ static const MemoryRegionOps msix_table_mmio_ops = {
>      .valid = {
>          .min_access_size = 4,
>          .max_access_size = 4,
> +        .accepts = msix_table_accepts
>      },
>  };
>  
> @@ -221,6 +231,15 @@ static void msix_pba_mmio_write(void *opaque, hwaddr addr,
>  {
>  }
>  
> +static bool msix_pba_accepts(void *opaque, hwaddr addr, unsigned size,
> +                                    bool is_write, MemTxAttrs attrs)
> +{
> +    PCIDevice *dev = opaque;
> +    uint16_t pba_size = QEMU_ALIGN_UP(dev->msix_entries_nr, 64) / 8;
> +
> +    return dev->msix_pba + addr + 4 <= dev->msix_pba + pba_size;

Can be simplified as:

       return addr + 4 <= QEMU_ALIGN_UP(dev->msix_entries_nr, 64) / 8;

> +}
> +
>  static const MemoryRegionOps msix_pba_mmio_ops = {
>      .read = msix_pba_mmio_read,
>      .write = msix_pba_mmio_write,
> @@ -228,6 +247,7 @@ static const MemoryRegionOps msix_pba_mmio_ops = {
>      .valid = {
>          .min_access_size = 4,
>          .max_access_size = 4,
> +        .accepts = msix_pba_accepts
>      },
>  };
>  
> 


