Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E85DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3C02078D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 12:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eACeHCn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3C02078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonlI-0008Ky-8e
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 08:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jonjt-0006hq-NS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:45:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35058
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jonjr-0003yB-WC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 08:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593175550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2+D0UVkLJ0evD1GIZmpHDqPsq6zMGALoN556+t57m8E=;
 b=eACeHCn4Wm/Q0RGGBku2knobrCP1syqfAIU+M4RC93ZlVQPhUVCmqRXa4+mjbcMsIBrs3+
 vTHgkeA8nJS3USlT0scSK97x8XN0HyqnLp1TYhPtzLmhMoDj6Xu1/SVIsMYfJN/kidGF3r
 AybBrPch0eo9AJhNVYDfv0p5P1+x7+c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-_QQYH9s5NLioZuf2nZiW8Q-1; Fri, 26 Jun 2020 08:45:49 -0400
X-MC-Unique: _QQYH9s5NLioZuf2nZiW8Q-1
Received: by mail-wr1-f70.google.com with SMTP id i12so10629140wrx.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 05:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=VANejHRbGBgY/Xc4lXaWDqiG7lfOXGQhHth4wXyM0P4=;
 b=PzueJomzxgbfSa3keshp5TgZ1AM+5OZBwF2t6wJP6WDOqqxdRh/IOL/nz988+H9oCK
 G5sCOfv4vOjVILATF5ohs8hN/kS4HHMbkfmor1TXv49XkhfFalJx7HavvQViCZIiWbE5
 N1OdJDHoucaKygchQ03QrjolVN+RszMeIpgWgIGoYKpnO7QimGoohQh/0eJ8KRO1X2tc
 bte8RIhzTGo4Sn9w52EQXZIQqmvx0MHCQyGC9T/Bm1koT3JqT21nxtfPnxbCd68ymbpy
 2BYAbDxlakERKEWpUBbFHHz1gGkF3wb9T/OYoyhwk0RG+HOWKQMpDwNGLUNj7KSPCaue
 aJ5Q==
X-Gm-Message-State: AOAM530ejUbllNd6iJZeJhdorsifHvNs8aSaHtI5ANag7Phh6iZTXrfk
 H9Az4pgOB/pKsR5wN89AiBNc3xzRlgYqVINpbalhQjtf2saysrlbE6f0ECOe7niyCfx6xgi8Yd6
 eml+BqZ61ZnwVV2E=
X-Received: by 2002:a1c:9ad8:: with SMTP id c207mr3119052wme.45.1593175547965; 
 Fri, 26 Jun 2020 05:45:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOjcLZmx9rPqHo7acNxil0zGdSF0AETnLWZh4pQxwlFY084HcxKmi6bNxDfqz32oxjZqr8cQ==
X-Received: by 2002:a1c:9ad8:: with SMTP id c207mr3119027wme.45.1593175547693; 
 Fri, 26 Jun 2020 05:45:47 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k185sm14220080wmk.47.2020.06.26.05.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 05:45:47 -0700 (PDT)
Subject: Re: [PATCH 04/17] block/nvme: Be explicit we share NvmeIdCtrl /
 NvmeIdNs structures
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-5-philmd@redhat.com>
 <20200626111905.GK281902@stefanha-x1.localdomain>
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
Message-ID: <cf603d70-1aee-5973-afd2-962ba8707169@redhat.com>
Date: Fri, 26 Jun 2020 14:45:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626111905.GK281902@stefanha-x1.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 02:19:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 1:19 PM, Stefan Hajnoczi wrote:
> On Thu, Jun 25, 2020 at 08:48:25PM +0200, Philippe Mathieu-Daudé wrote:
>> We allocate an unique chunk of memory then use it for two
>> different structures. Introduce the 'idsz_max' variable to
>> hold the maximum size, to make it clearer the size is enough
>> to hold the two structures.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> FIXME: reword with something that makes more sense...
>> ---
>>  block/nvme.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index 71f8cf27a8..ffda804a8e 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -438,6 +438,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>>      BDRVNVMeState *s = bs->opaque;
>>      NvmeIdCtrl *idctrl;
>>      NvmeIdNs *idns;
>> +    size_t idsz_max;
>>      NvmeLBAF *lbaf;
>>      uint8_t *resp;
>>      uint16_t oncs;
>> @@ -448,14 +449,15 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>>          .cdw10 = cpu_to_le32(0x1),
>>      };
>>  
>> -    resp = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
>> +    idsz_max = MAX_CONST(sizeof(NvmeIdCtrl), sizeof(NvmeIdNs));
>> +    resp = qemu_try_blockalign0(bs, idsz_max);
>>      if (!resp) {
>>          error_setg(errp, "Cannot allocate buffer for identify response");
>>          goto out;
>>      }
>>      idctrl = (NvmeIdCtrl *)resp;
>>      idns = (NvmeIdNs *)resp;
>> -    r = qemu_vfio_dma_map(s->vfio, resp, sizeof(NvmeIdCtrl), true, &iova);
>> +    r = qemu_vfio_dma_map(s->vfio, resp, idsz_max, true, &iova);
> 
> _nvme_check_size() has compile-time asserts that check
> sizeof(NvmeIdCtrl) == sizeof(NvmeIdNs) == 4096.
> 
> I suggest the following cleanup:
> 
>   union {
>       NvmeIdCtrl ctrl;
>       NvmeIdNs ns;
>   } *id;
>   ...
>   id = qemu_try_blockalign0(bs, sizeof(*id));
>   ...
>   r = qemu_vfio_dma_map(s->vfio, resp, sizeof(*id), true, &iova);
> 
> and accesses to idctl are replaced with id->ctrl and idns with id->ns.
> 
> This eliminates the casts, makes it clear that this data is overlapping,
> and avoids the need for idsz_max.

Clever idea, thanks!


