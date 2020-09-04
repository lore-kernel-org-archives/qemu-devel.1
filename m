Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99443C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577AB2074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebXY4IWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577AB2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEKy-00041I-GA
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEEJu-0002Zf-CJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:12:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEEJs-0004Ai-RQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599235928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qjqdrRhIjdRnzKBlTXsJfKwx7t7nRdldovrccNIKRus=;
 b=ebXY4IWV1Z9kqBe3iMZ+qS3Uv6riWK8jKUMd4PN86UJJyLeNj5mkJ/Ttq3dl/wTuCSk0r7
 S/vAcZME4vSJ5edQY9hYaWoUePR2oJKoLf1VwOYZJ/O+PiFYEKQt6FYN6+vtFV/0TAoGSh
 KwwJ6ZR4SdpPbslKwLU2Moo6QBT+XhA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-4CG3X1TPMq-ubsPdONUz4Q-1; Fri, 04 Sep 2020 12:12:06 -0400
X-MC-Unique: 4CG3X1TPMq-ubsPdONUz4Q-1
Received: by mail-wr1-f70.google.com with SMTP id a12so2483133wrg.13
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=qjqdrRhIjdRnzKBlTXsJfKwx7t7nRdldovrccNIKRus=;
 b=SPZBQg44oWEiv3bthTzLWs0FPueKvT6keyU559Y64P1Wyo7F/ZLrN4P6CYrrwpdSmo
 qSK+ELLdYt9TzKC/T+IvBe1yFK6MQL5Or5zGHvcXjpzrhbQOOBjophARS1IpMtgXfkcw
 A9xglCefsvRkdMOld+FYtCnrZIBjIB8rSbd5dD42ZbxAoCRtUiIVYhyyYrw8oJGJB/Na
 PLuQF3TpCif/6i+gmYcp/oIUmw0rwDNgxQRybscr4HmDDkBc8mWR7BWZtlnotTbu6FWO
 tuyagNvPu/BpRl4IbtCCAO8ers1pKzqVwzZIRF554knMHr/dUpXFrpfKGb10vt8S25ys
 H/fg==
X-Gm-Message-State: AOAM5315JbDYONXfZcRWfcUKVVW3R6xZAKFCMwyXHxg8gZKz01lSNvAu
 8fdRL1hqMLXYFw/FVAIb3lnit8o789jijXvg01c1p6/DRtraDfJdQAbXdotBDhBjFD0QNYNCSJo
 iVjosJfEVvykw0r4=
X-Received: by 2002:adf:f042:: with SMTP id t2mr8035570wro.385.1599235925361; 
 Fri, 04 Sep 2020 09:12:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtsToybDKzKmCXY3pLhIfvp5annE6fSiMPynoRU/cRWx33IfeI08r5GdtTa+Cg70iQ/6SKbg==
X-Received: by 2002:adf:f042:: with SMTP id t2mr8035552wro.385.1599235925168; 
 Fri, 04 Sep 2020 09:12:05 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 70sm13440862wme.15.2020.09.04.09.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 09:12:04 -0700 (PDT)
Subject: Re: [PATCH 00/17] hw/block/nvme: multiple namespaces support
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20200904141956.576630-1-its@irrelevant.dk>
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
Message-ID: <b44b738e-db6f-e820-11ef-ad9c7615f9a3@redhat.com>
Date: Fri, 4 Sep 2020 18:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904141956.576630-1-its@irrelevant.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 11:45:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On 9/4/20 4:19 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> This is the next round of my patches for the nvme device.
> 
> This includes a bit of cleanup and three new features:
> 
>   * refactored aio submission
>     This also adds support for multiple parallel AIOs per request which is in
>     preparation for DULBE, ZNS and metadata support. If it is found
>     controversial, it can easily be dropped from this series.
> 
>   * support for scatter/gather lists
> 
>   * multiple namespaces support through a new nvme-ns device
> 
> Finally, the series ends with changing the PCI vendor and device ID to get rid
> of the internal Intel id and as a side-effect get rid of some Linux kernel
> quirks that no longer applies.
> 
> "pci: pass along the return value of dma_memory_rw" has already been posted by
> Philippe in another series, but since it is not applied yet, I am including it
> here.
> 
> Gollu Appalanaidu (1):
>   hw/block/nvme: add support for sgl bit bucket descriptor
> 
> Klaus Jensen (16):
>   pci: pass along the return value of dma_memory_rw
>   hw/block/nvme: handle dma errors
>   hw/block/nvme: commonize nvme_rw error handling
>   hw/block/nvme: alignment style fixes
>   hw/block/nvme: add a lba to bytes helper
>   hw/block/nvme: fix endian conversion
>   hw/block/nvme: add symbolic command name to trace events
>   hw/block/nvme: refactor aio submission
>   hw/block/nvme: default request status to success
>   hw/block/nvme: support multiple parallel aios per request
>   hw/block/nvme: harden cmb access
>   hw/block/nvme: add support for scatter gather lists
>   hw/block/nvme: refactor identify active namespace id list
>   hw/block/nvme: support multiple namespaces
>   pci: allocate pci id for nvme
>   hw/block/nvme: change controller pci id
> 
>  MAINTAINERS            |   1 +
>  docs/specs/nvme.txt    |  23 +
>  docs/specs/pci-ids.txt |   1 +
>  hw/block/meson.build   |   2 +-
>  hw/block/nvme-ns.c     | 185 +++++++++
>  hw/block/nvme-ns.h     |  74 ++++
>  hw/block/nvme.c        | 923 +++++++++++++++++++++++++++++++----------
>  hw/block/nvme.h        | 126 +++++-
>  hw/block/trace-events  |  21 +-
>  hw/core/machine.c      |   1 +
>  include/block/nvme.h   |   8 +-
>  include/hw/pci/pci.h   |   4 +-

To ease the review, consider setup'ing scripts/git.orderfile,
as it avoid reviewers to scroll patches in their email client.

Thanks,

Phil.


