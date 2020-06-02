Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0090CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31A9206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8H0VaMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31A9206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9Rs-0003Ku-3O
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg9R6-0002On-4z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:06:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg9R5-0003Fg-Ef
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 12:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591114002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hapFSYeZljYAU16BNcRk5LyShRv6/DgJw3Jg4Cy3FlI=;
 b=X8H0VaMPjToIDfwXzHgOj/moCrd1rvuYqAbbtqIev/U8OhMsWr+r4WLKOW4lxIw3HnYCEg
 /rk6G1n3NM+NKgIKD+NDCGWLiqoNzuyQqQuHQS0lKF0wwjOLLRyEZJrp5NoERbeX6ptqo3
 7CqfaQ0apTuHSyFQh2c1J6obQGS/7x0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-3OlgjAa0M2up0NXWiZEDRw-1; Tue, 02 Jun 2020 12:06:17 -0400
X-MC-Unique: 3OlgjAa0M2up0NXWiZEDRw-1
Received: by mail-wr1-f70.google.com with SMTP id d6so1568884wrn.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 09:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hapFSYeZljYAU16BNcRk5LyShRv6/DgJw3Jg4Cy3FlI=;
 b=r8Kn2Q8EGRBdrJCTWgp1f+EBFwrKqJVJBgQtyjFRW3tPvqvupJGV2fOjavcI5NVDc2
 XOeFSNaD2ojhiHEFoGVNdMygLIrzJCdxJms6LxabcayhuMjDiRPsmTLVazVUaK709VUU
 tUFwSNGBQfkNDUyuz3U1mHgtZ4ye74tdLqc9sflC7de5n8YEozSv/e5toyRubhsma/Tl
 +ZF5j0N3nomE9BlZulHTwwxyVJRhTY7ujnpU4QGFeIYGhAe3D/VhcYR+RdDqNU6VItoU
 od/NLwPBp05PHB9cU8oa/Kv3cjFty7ST49NemtnSs8U+1H9yWGlZ+sT704BdzsPBQkBd
 yiDw==
X-Gm-Message-State: AOAM5330T8DaHcGf4voyNRfcirVI+ZcfTOMHIwmBaP68dAZOGRcjKtY9
 tRxAa0y1KsIO/r+dMKdGufBdF8h4DFaQRZ/X7TzYeYsS0hQGubjKTNOSWunaWMMtnAk/nP+xINO
 p+p8QsP1YBM5k6uU=
X-Received: by 2002:a1c:2503:: with SMTP id l3mr4551796wml.44.1591113975951;
 Tue, 02 Jun 2020 09:06:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhae7HMz0S8f3Fthz7emZOWC+OFJ1/SVkEnClG6iWWVjZIXJXzd91x+7R0qE1iECzUrGrAaA==
X-Received: by 2002:a1c:2503:: with SMTP id l3mr4551763wml.44.1591113975644;
 Tue, 02 Jun 2020 09:06:15 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a3sm4411253wrp.91.2020.06.02.09.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 09:06:15 -0700 (PDT)
Subject: Re: [PATCH v6 08/20] hw/block/nvme: allow use of any valid msix vector
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200514044611.734782-1-its@irrelevant.dk>
 <20200514044611.734782-9-its@irrelevant.dk>
 <6b607877-a45f-6c44-45ae-180ce0100fed@redhat.com>
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
Message-ID: <09d7c46b-0958-001d-895b-4dc6aeebbbae@redhat.com>
Date: Tue, 2 Jun 2020 18:06:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6b607877-a45f-6c44-45ae-180ce0100fed@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 5:44 PM, Philippe Mathieu-Daudé wrote:
> On 5/14/20 6:45 AM, Klaus Jensen wrote:
>> From: Klaus Jensen <k.jensen@samsung.com>
>>
>> If the device uses MSI-X, any of the 2048 MSI-X interrupt vectors are
>> valid. If the device is not using MSI-X, vector will and can only be
>> zero at this point.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>> ---
>>  hw/block/nvme.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>> index c9d10df1f763..a2e6734c7a25 100644
>> --- a/hw/block/nvme.c
>> +++ b/hw/block/nvme.c
>> @@ -657,7 +657,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
>>          trace_pci_nvme_err_invalid_create_cq_vector(vector);
>>          return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
>>      }
>> -    if (unlikely(vector > n->params.num_queues)) {
>> +    if (unlikely(vector > PCI_MSIX_FLAGS_QSIZE)) {
>>          trace_pci_nvme_err_invalid_create_cq_vector(vector);
>>          return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
>>      }
>>
> 
> Is it worth adding this?
> 
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -613,6 +613,8 @@ static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
>  static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
>      uint16_t cqid, uint16_t vector, uint16_t size, uint16_t irq_enabled)
>  {
> +    int ret;
> +
>      cq->ctrl = n;
>      cq->cqid = cqid;
>      cq->size = size;
> @@ -623,7 +625,8 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl
> *n, uint64_t dma_addr,
>      cq->head = cq->tail = 0;
>      QTAILQ_INIT(&cq->req_list);
>      QTAILQ_INIT(&cq->sq_list);
> -    msix_vector_use(&n->parent_obj, cq->vector);
> +    ret = msix_vector_use(&n->parent_obj, cq->vector);
> +    assert(ret == 0);
>      n->cq[cqid] = cq;
>      cq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
>  }

FYI snippet sent as new patch:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00404.html


