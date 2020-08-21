Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA80CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7321D20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI2JVx+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7321D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96uZ-0005mx-Pt
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k96ts-0005GI-KG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:16:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26506
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k96to-0006kQ-NH
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598015763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=68Vs14OLWpfM2KT7WTKOPCDagHBR9xHHtWgCFQ4ivSk=;
 b=CI2JVx+nF0cflCwaphZusb6mNgE/toSigPGI+krQscqB/Fl25yd6OSuLaJbHoQGYGqMByL
 LPvSEqejbvj15XfN/U3hjxGXTRCFyQEbEU92VKHYJaJrF+vyOI+KQJJiEl/qAQlckD8Fs+
 3Fg0DwEbwzP5kI/cRzgkXhP8wBVITAc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-uYl8I969P2-9qZ5ZnT7ZvA-1; Fri, 21 Aug 2020 09:16:01 -0400
X-MC-Unique: uYl8I969P2-9qZ5ZnT7ZvA-1
Received: by mail-wr1-f70.google.com with SMTP id r14so546592wrq.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=68Vs14OLWpfM2KT7WTKOPCDagHBR9xHHtWgCFQ4ivSk=;
 b=fdweHnIRMFHlO5SJojJzZ14uIEA+MtZRheRC1DVPq5IwPoefqRM9gMhmuWX/fvCTct
 WqwrEOpRkVvqv65uvUPAXKZL+I11ZJdqNUzpMwa67jpNRQcgdzwWiIaxNmLDYk7zQ/c2
 rDhukz+BZdTQ+4MEaC3jIgMktAvBD4v7HpGLUaCJlsU+qtS5FqylBoZ6tSsY+yOAjYi+
 Q0+wwMS1JyZyifdZ1s7/WPtMYb0fvpf+AghYwmZAg4Na1HyceUAllACFvJCMlhoHjC0S
 gA8fhhgKjePZVJLFMAoDONVb6Y1nB8T/hONWZIxy8AImD3Mkyv4SrZghZKh53PI6prWk
 AEkg==
X-Gm-Message-State: AOAM530dudKLaXFpmFoVA9jKg0qNPeZGcK8n8COtaPz8j/mu/std6ngZ
 dL6bzlIxYhiLoJQzhdfE/RYcC5gOoGCV85ucmY5IGP3/xAdM3n/bOiObhfTioE0tCbR5qpI0LOd
 vN51eACDnelYVr00=
X-Received: by 2002:a5d:440e:: with SMTP id z14mr2666932wrq.422.1598015760551; 
 Fri, 21 Aug 2020 06:16:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/gReMvO0QSn/PnU0BIZ2oMPumyRiXg7aNSpVutE2ccYZJJxb4LS68A4AjrDXMre5an843TA==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr2666916wrq.422.1598015760342; 
 Fri, 21 Aug 2020 06:16:00 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r129sm4636428wmr.40.2020.08.21.06.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:15:59 -0700 (PDT)
Subject: Re: [PATCH v5 12/15] block/nvme: Replace BDRV_POLL_WHILE by
 AIO_WAIT_WHILE
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-13-philmd@redhat.com>
 <20200821101517.tgypwxqsjw2wfbxy@steredhat>
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
Message-ID: <84f6400d-1681-45e5-d271-d2311519dde7@redhat.com>
Date: Fri, 21 Aug 2020 15:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821101517.tgypwxqsjw2wfbxy@steredhat>
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 12:15 PM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2020 at 06:58:58PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> BDRV_POLL_WHILE() is defined as:
>>
>>   #define BDRV_POLL_WHILE(bs, cond) ({          \
>>       BlockDriverState *bs_ = (bs);             \
>>       AIO_WAIT_WHILE(bdrv_get_aio_context(bs_), \
>>                      cond); })
>>
>> As we will remove the BlockDriverState use in the next commit,
>> start by using the exploded version of BDRV_POLL_WHILE().
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
>> ---
>>  block/nvme.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index 5b69fc75a60..456fe61f5ea 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -493,6 +493,7 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
>>  static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
>>                           NvmeCmd *cmd)
>>  {
>> +    AioContext *aio_context = bdrv_get_aio_context(bs);
>>      NVMeRequest *req;
>>      int ret = -EINPROGRESS;
>>      req = nvme_get_free_req(q);
>> @@ -501,7 +502,7 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
>>      }
>>      nvme_submit_command(q, req, cmd, nvme_cmd_sync_cb, &ret);
>>  
>> -    BDRV_POLL_WHILE(bs, ret == -EINPROGRESS);
>> +    AIO_WAIT_WHILE(aio_context, ret == -EINPROGRESS);
> 
> Maybe I would have:
> 
>     AIO_WAIT_WHILE(bdrv_get_aio_context(bs), ret == -EINPROGRESS);

I extracted aio_context in this patch because in the following
series it is passed by the caller as an argument to nvme_cmd_sync(),
so this makes the next series simpler to review.

> 
> But it doesn't matter, LGTM:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks!

> 
>>      return ret;
>>  }
>>  
>> -- 
>> 2.26.2
>>
>>
> 


