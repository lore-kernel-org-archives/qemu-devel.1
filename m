Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91C1C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0DAF2220C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPIqGEBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DAF2220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKO62-0006Cq-PF
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKO4D-00054y-VS
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKO48-0008Oz-Uy
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600703359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YEnQ9qkpab5C1FksAdclDeZjkYfmDkEp6In4EjwgMUo=;
 b=RPIqGEBt1WQ+i/M2IUPIJHlfr2dHdIsxUjS4YBZxnX5fr/jhD9C9E6IvWN1+OWP/RRifRY
 YXt7qXDjwASWpRxSQ8uzT6akITxcMyezS7ve7okcH3IwnKxCaNoqYK5svQwxhZMeMzM4mJ
 098jzATQo+MKG27gu2TnpQpVmp6wOeU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-rSgF3Kx2MD6cQH2nYXanZA-1; Mon, 21 Sep 2020 11:49:17 -0400
X-MC-Unique: rSgF3Kx2MD6cQH2nYXanZA-1
Received: by mail-wr1-f70.google.com with SMTP id o6so6036408wrp.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 08:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YEnQ9qkpab5C1FksAdclDeZjkYfmDkEp6In4EjwgMUo=;
 b=encbtam5P6ZFvKFPZOZzUA9B0TbEjIVL6Bp/Pj+iLaI3YuWvqUFyLssAvrIdNp54oQ
 ui/7AOoyah/Fh0/oeBhG9K0k1q5oWCCKXpb1beoxA91l+Bu6GCXVtTShNrkTBehHgdbe
 K/H2XNylJtDJmXeWP1CbQ8JHkrFm7LNOKXAIkmWTB3mCJM9P4VhyJyPRVqJEHfTJvpAz
 BP2uI7q6Jz+178dHKdpKyQkEM+nDyo7fQptLK+0tuWNwp3dzacrxlw2K0m5Wa44s5kEy
 RxwP/Q4kw+QfGIM+TF0wXNdNVOjlH2B3UJdML1QyXuZbYrTA3moLkgbWOnEgQPuK9glP
 GVQg==
X-Gm-Message-State: AOAM531+Z+BGHYpIbWzSVCkmlgZgD5Mmj9UpkM2e8zMneQfTjzW4YEKo
 wSwUv+PrUktGVmHkni5SkqbfvLo8Z9H+uxQNeZsRW6HANAt4opSlXXfa0b4YbJCdZjg54k2kJ/U
 dWijdvdVDwdpWhs0=
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr447644wrt.84.1600703356098;
 Mon, 21 Sep 2020 08:49:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg+CsiY1I3RL15inTqQD+hGTyv7isxtFLpkG/UnnZ4XLNmSjL63X7QcL5HexIN56aK50RDiQ==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr447615wrt.84.1600703355789;
 Mon, 21 Sep 2020 08:49:15 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d2sm21503003wro.34.2020.09.21.08.49.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 08:49:15 -0700 (PDT)
Subject: Re: [PATCH v2 01/17] hw/block/nvme: fix typo in trace event
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20200918203621.602915-1-its@irrelevant.dk>
 <20200918203621.602915-2-its@irrelevant.dk>
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
Message-ID: <7c4f5fd7-951d-45d7-b98c-e964eb67f0be@redhat.com>
Date: Mon, 21 Sep 2020 17:49:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918203621.602915-2-its@irrelevant.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 9/18/20 10:36 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Fix a typo in the sq doorbell trace event.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index ec94c56a4165..8ff4cbc4932c 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -70,7 +70,7 @@ pci_nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "c
>  pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
>  pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
>  pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
> -pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_tail %"PRIu16""
> +pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "sqid %"PRIu16" new_tail %"PRIu16""

Oops.
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
>  pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
> 


