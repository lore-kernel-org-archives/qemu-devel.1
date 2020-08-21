Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B4EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5BE2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwVDki20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5BE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97Ef-0002SQ-HT
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k97E0-0001xP-R3
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:36:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k97Dy-0000Tg-5W
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598017012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Nmb6seJtcbLnDlX8v4Bj5V3RI+yyDCYeBEq9dFdU/Vg=;
 b=ZwVDki200corbP7V/i5I4RZ3wXlf4ATapRPITA5MThioDOFmRR2/v9nOB0QAWNaOmlqY/d
 gnd6WpnnVzeFPcVS5cCmEacDWXCoW+YB6t4ZsK2lLl7Ogkxicgsbh2NZhDjP96G26RU5o8
 sLvVtiYchrf+I9NmpGVnkEPh/n79hs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-FD-Qh-ZQOjKXk5mGDaF1WQ-1; Fri, 21 Aug 2020 09:36:50 -0400
X-MC-Unique: FD-Qh-ZQOjKXk5mGDaF1WQ-1
Received: by mail-wm1-f70.google.com with SMTP id p184so984697wmp.7
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Nmb6seJtcbLnDlX8v4Bj5V3RI+yyDCYeBEq9dFdU/Vg=;
 b=Nq5RnDZHKE69g90PrgkLk6WGaJLNC7do7B5flZa5pKv8FNGVkBMvXrLiM0sFHS1j/V
 qXHR1xwc9WPiTmiS1NcxwmDkksGETvd21aSNQvTZoP9rwy3at7ZcDZ+N7eQ36H+HrkWk
 9vhi8qt6trqEB4w0DRs25TxErnPNCvHvvD4UqRGZWhQsRlgiYkCmfG3hjrYEnhLWP9oN
 5vBkZpabEbt6ROwM7u5bQ91/dmGz8yZAd0kLZtCOxFkyR63V+gkhT39mqtG6fXqrVAfr
 MfcjuZzk6M3IhaS2D7QqHkjByMdnMcwIUXUBozvNTjxNmWvQAenf1WYltIHjze/j56Kj
 6bQg==
X-Gm-Message-State: AOAM533D3mG6tKWObIFIrbZejd5XHNxcCHHVMvy0WMjpGSAXmzPQBB7r
 ePc8+ovhs4Z488tpCtfLYyAFcvwwdEL05H3Zn0AXdCL1y/Kwr5V47cHy+KIQvQOfeARVd3WL8cp
 8aI/5XaBYch5mi0Y=
X-Received: by 2002:adf:e30e:: with SMTP id b14mr517627wrj.215.1598017009710; 
 Fri, 21 Aug 2020 06:36:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNS/p0dCOEaZYyKSIcTCO+85dzO/u9+NgHrhR+3iuYCiFwho2hEq/1ThocOF38PLUiAiEx1A==
X-Received: by 2002:adf:e30e:: with SMTP id b14mr517600wrj.215.1598017009345; 
 Fri, 21 Aug 2020 06:36:49 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l21sm4975704wmj.25.2020.08.21.06.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:36:48 -0700 (PDT)
Subject: Re: [PATCH v5 03/15] block/nvme: Let nvme_create_queue_pair() fail
 gracefully
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-4-philmd@redhat.com>
 <20200821094458.fqspisyyl4xxibas@steredhat>
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
Message-ID: <755ff4b4-1dc1-175f-f424-76c33d3de507@redhat.com>
Date: Fri, 21 Aug 2020 15:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821094458.fqspisyyl4xxibas@steredhat>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 11:44 AM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2020 at 06:58:49PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> As nvme_create_queue_pair() is allowed to fail, replace the
>> alloc() calls by try_alloc() to avoid aborting QEMU.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
>> ---
>>  block/nvme.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index 8c30a5fee28..e1893b4e792 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -213,14 +213,22 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
>>      int i, r;
>>      BDRVNVMeState *s = bs->opaque;
>>      Error *local_err = NULL;
>> -    NVMeQueuePair *q = g_new0(NVMeQueuePair, 1);
>> +    NVMeQueuePair *q;
>>      uint64_t prp_list_iova;
>>  
>> +    q = g_try_new0(NVMeQueuePair, 1);
>> +    if (!q) {
>> +        return NULL;
>> +    }
>> +    q->prp_list_pages = qemu_try_blockalign0(bs,
>> +                                          s->page_size * NVME_QUEUE_SIZE);
> 
> Here you use NVME_QUEUE_SIZE instead of NVME_NUM_REQS, is that an
> intentional change?

No... Thanks for spotting this, I missed it because git didn't
emit any warning while rebasing on top of "block/nvme: support nested
aio_poll".
This value has been changed in 1086e95da17 ("block/nvme: switch to a
NVMeRequest freelist").

Good catch!
I'll respin (after reviewing the 'nested aio_poll' changes).

> 
> Maybe is not an issue, sice NVME_QUEUE_SIZE is bigger than
> NVME_NUM_REQS, but we should mention in the commit message.
> 
> Thanks,
> Stefano
> 
>> +    if (!q->prp_list_pages) {
>> +        goto fail;
>> +    }
>>      qemu_mutex_init(&q->lock);
>>      q->s = s;
>>      q->index = idx;
>>      qemu_co_queue_init(&q->free_req_queue);
>> -    q->prp_list_pages = qemu_blockalign0(bs, s->page_size * NVME_NUM_REQS);
>>      q->completion_bh = aio_bh_new(bdrv_get_aio_context(bs),
>>                                    nvme_process_completion_bh, q);
>>      r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
>> -- 
>> 2.26.2
>>
>>
> 


