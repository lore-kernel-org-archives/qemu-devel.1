Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B6DC43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4FD22574
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTjCFmuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4FD22574
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKO7h-0007mb-Qi
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKO6A-0006bS-Cq
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKO68-0000LG-Q2
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600703484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yfP6IX08TWKfMy3rcKkazc6MgmIyX21iVT00s54ymNo=;
 b=HTjCFmuhQ50WVYUZCOYobBqlJcyIVq0Fms01XrNSAEpiNvftmcYrALgcHi11NvGfEXJ3QN
 eZrBzIS5yR19iXn7Iplusv/94QDSEm1b9++K+N/YQRRR4Jtb5Mzgg12yyHVjH99GjNZM8j
 NlFWHMruk9FuihO9L9coerPz+aj7sM8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-L_Pz1oFmNCitLgJd4f7sGg-1; Mon, 21 Sep 2020 11:51:20 -0400
X-MC-Unique: L_Pz1oFmNCitLgJd4f7sGg-1
Received: by mail-wm1-f72.google.com with SMTP id t8so2663598wmj.6
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 08:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yfP6IX08TWKfMy3rcKkazc6MgmIyX21iVT00s54ymNo=;
 b=XCh4vEsFtNYLVXTw+3tl2BQJ8HF+lEpBNrbJAciOY1hzMKk8nw37o0M+rQZ54ysYtg
 vHAejQTOz5LrUTvcb13XKRamiJpiCcfwrSkIaUzDxIz3jE4JtNXP9Ax459gnnrOl/eIv
 GKRBkxbXg2ni0mQzHvqCGQ+xZX607N4MooddOkUQITHtdB12msoDIpdUnaNuUxXa/XYv
 ieCSwWk1tFTrkd0EAzqSG9v9ZKlXqsOsxrt30yIVeR9ZcnriS3kNXb8JnQ1JGypK6w3t
 Q6z85MneoP0mtp/Q6gk0aswqSNu3ILIiqI4+kGlabAjYCbjJ3LB2NPeVdcQ7c4I3jA00
 3tSw==
X-Gm-Message-State: AOAM532BwlYHaZtyeitpi2BrbUlPUvwllT4CI43ZhhqTFn5Hhf7KMbWo
 HSaP26ArRyWXQnLsnjUqW4p/TC51omS9tAmmo40Bv4Wo4t/9QMZnNbpBBSYKq3Hm6mUwJkY4qgl
 iKDOZ+YWHHPHQyyM=
X-Received: by 2002:adf:84c3:: with SMTP id 61mr399489wrg.131.1600703478756;
 Mon, 21 Sep 2020 08:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzBvB0uLMgh3vcyAxcxdhvPiohfPsF+AFwh81K+2Ea+oA1pUTC9MoybAlpY6FCIpXr7He2nQ==
X-Received: by 2002:adf:84c3:: with SMTP id 61mr399472wrg.131.1600703478598;
 Mon, 21 Sep 2020 08:51:18 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c4sm22283634wrp.85.2020.09.21.08.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 08:51:18 -0700 (PDT)
Subject: Re: [PATCH v2 07/17] hw/block/nvme: fix endian conversion
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org
References: <20200918203621.602915-1-its@irrelevant.dk>
 <20200918203621.602915-8-its@irrelevant.dk>
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
Message-ID: <9066b0ce-0a66-cc83-7fb8-88da66bf5192@redhat.com>
Date: Mon, 21 Sep 2020 17:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918203621.602915-8-its@irrelevant.dk>
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
> The raw NLB field is a 16 bit value, so use le16_to_cpu instead of
> le32_to_cpu and cast to uint32_t before incrementing the value to not
> wrap around.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/block/nvme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 62db87460413..32267a3e4782 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -645,7 +645,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
>      NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
>      NvmeNamespace *ns = req->ns;
>      uint64_t slba = le64_to_cpu(rw->slba);
> -    uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
> +    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
>      uint64_t offset = nvme_l2b(ns, slba);
>      uint32_t count = nvme_l2b(ns, nlb);
>      uint16_t status;
> @@ -669,7 +669,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
>  {
>      NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
>      NvmeNamespace *ns = req->ns;
> -    uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
> +    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
>      uint64_t slba = le64_to_cpu(rw->slba);
>  
>      uint64_t data_size = nvme_l2b(ns, nlb);
> 


