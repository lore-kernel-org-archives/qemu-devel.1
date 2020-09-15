Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD4C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D8421D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4ZzfeTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D8421D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIF18-00007E-BV
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIEmS-0005Ho-Oq
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIEmQ-0004k2-Ii
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600191009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1LcT5BzyLP6uosH2WFbN7+xsz8nuKLNH3xU2MY3Wp2s=;
 b=T4ZzfeTE0zZlbu5QsoiGbjthykh9Ot1l9quEKOL6+IwGmXq/rs3vo5m6JljQNufjkgvqit
 eT9gJ2hk4qZ3EESSLhk4UDC2EoN+FOdSEEpGFJqkerAQTMBuFSsJe57I0oi9PVX+FamUQU
 DDQZNikcGu8AYfnsclOn7gQ40GULEyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-6MOqvpGmNAmVEMWv5M_Pyg-1; Tue, 15 Sep 2020 13:30:04 -0400
X-MC-Unique: 6MOqvpGmNAmVEMWv5M_Pyg-1
Received: by mail-wm1-f70.google.com with SMTP id a7so82515wmc.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1LcT5BzyLP6uosH2WFbN7+xsz8nuKLNH3xU2MY3Wp2s=;
 b=KpP7pfvWyweuRibxGQykCzVsot0igUxmYryBe8gbNEgF/StPGJdK6hO1KbpGZW9ii6
 m65lflU6HRCh5cvgSFLrcp5WeMG6hsAZxqCWYQiZAd6BtuMCxmelGtYaAxZeKJ/Vn83P
 qO46SlU8q+wAeCA2R25x9OVzFc4P/KHjenqwOAXYXETGRJmZJHxH/NQNzn7jFRgdtFoa
 EePRLrr3EAh6rKDLAUh1M7/h2Ovjk9HkZPoQvvFuXCUVGrsVKSirtUoRsQreg1PfU5Jc
 BCN1IlhVEQTPaV5TN9JiDO0DJDMd44wz3GFPYkDMhpIIWyu6yj2liqbyPUUDzLTDSZJC
 3U0A==
X-Gm-Message-State: AOAM532WeoSMUINae+9k04Kg8ojHG65uxGDg3pd0LbC35Dij6+V0E9Dg
 lSkfl+4ZUC3n1Xfl65eFpL9/rZTOcOgU4iX/s92Jv7AeTAuiKuU03VGIpsynay17yJHfIAqJERt
 LqION4eFkp/9zDUc=
X-Received: by 2002:adf:f04c:: with SMTP id t12mr23012340wro.121.1600191002708; 
 Tue, 15 Sep 2020 10:30:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoJ5xgRu3cVHCiepHLa3BxF6jAEf4vvcQInO1g83a7v0bI/tOgNb9cdI5kINEzqoInAxvocA==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr23012322wro.121.1600191002502; 
 Tue, 15 Sep 2020 10:30:02 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m185sm482793wmf.5.2020.09.15.10.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:30:02 -0700 (PDT)
Subject: Re: [PATCH 0/3] pci: Let PCI DMA API functions propagate a MemTxResult
To: qemu-devel@nongnu.org
References: <20200904162620.657726-1-philmd@redhat.com>
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
Message-ID: <00303be5-8ddb-be84-0d15-3ea537f275e2@redhat.com>
Date: Tue, 15 Sep 2020 19:30:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904162620.657726-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 11:54:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 6:26 PM, Philippe Mathieu-Daudé wrote:
> The DMA API propagates MemTxResult:
> - MEMTX_OK,
> - MEMTX_device_ERROR,
> - MEMTX_DECODE_ERROR.
> 
> Let the PCI DMA API propagate them, as they are
> clearer than an undocumented 'int'.
> 
> Based-on: <20200904154439.643272-1-philmd@redhat.com>
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02048.html
> 
> Philippe Mathieu-Daudé (3):
>   pci: Let pci_dma_rw() propagate MemTxResult
>   pci: Let pci_dma_read() propagate MemTxResult
>   pci: Let pci_dma_write() propagate MemTxResult
> 
>  include/hw/pci/pci.h | 50 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 6 deletions(-)
> 

This series is fully review.

Paolo, if you take the DMA series on which this one
is based, could you take this too?

Thanks :)


