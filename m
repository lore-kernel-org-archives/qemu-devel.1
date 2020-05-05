Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C3C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E487206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZoSr0WE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E487206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuDU-00045U-GR
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVuC5-0002Hj-8u
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:48:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVuC4-0003BN-IX
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588672131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1njBCj7bWLRHj0Gq8Fp6g7b06LQ45UyFkjrdFZsXVNM=;
 b=IZoSr0WEqbO916tC6zyh0FhE2nTaXGghmva8zJiqe8PTe3nQgvz5EPR9CdiRHQhDCKGJ89
 8kZq9Ys/K2v+lCf6CC+4jR3rhsDSQKoTWZHlhrQxo6BF0hpXjIOOrggFtUPm3oYlXOznh/
 sb1+eAnYuW60OaBCeadFcUMt3Xx6MlM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-94kVAtqOPKaIDgM-sE0_-A-1; Tue, 05 May 2020 05:48:49 -0400
X-MC-Unique: 94kVAtqOPKaIDgM-sE0_-A-1
Received: by mail-wm1-f70.google.com with SMTP id q5so786914wmc.9
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 02:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TtSUeTSb4ge+2IHb4/MidyAPkx4H6M2kRW/G/2DxTsY=;
 b=CIzTU/6J+FP4g2dtt1Ym19ZuxSRep2pH5Zz54tzCA9OBHKuuYM8N0NxlacXj6AP3BB
 ZHC4OJaje8Ed3xvVa2HkZ94HHU/0AXzeRMtMqMt1TdW4i+BePUbZKAy62etPKqSJrL1R
 xcVK6fFKEg+yv9+wwuNAKALSGQfDVcidYI9AUsEBlATdK6p5lg4bdKDOC/nyhEPPsJi/
 hs50EUlozBfVncKrujHqQA1a3ctT2cydFLRqPOAdDXrbLse43gTsLtrIk9WtJDYLqa5o
 NgpFVX1HsssmJnX1M2Jn5pDKXXwlxZ/LHB7+vhKyyKfdx29r9E8QLqdyMUMPwcZ08wEC
 bTtg==
X-Gm-Message-State: AGi0PubEjKTRYQx9nvZq8PwvskLjFxev6ECaBX1elwN7AT5mseDkvmVu
 fAwYxga/FmSoReTL+/uUtHMAY2X1vZgYJH2r0/CDYlL0hcPsl8Kgy99us26jz0Dt86/fNj3E6kP
 JdtXmB4vD+pP6Ssk=
X-Received: by 2002:adf:ffcd:: with SMTP id x13mr2693135wrs.11.1588672128529; 
 Tue, 05 May 2020 02:48:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKIG8E+lEYfq+TtX7awxm9k510ikZ/FDPjb0UQVxYYiD1AbGvKX/643NtQAkbQDnCgACEvvcQ==
X-Received: by 2002:adf:ffcd:: with SMTP id x13mr2693110wrs.11.1588672128283; 
 Tue, 05 May 2020 02:48:48 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id u5sm2341970wrm.35.2020.05.05.02.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 02:48:47 -0700 (PDT)
Subject: Re: [PATCH 5/6] block/nvme: Align block pages queue to host page size
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200504094641.4963-1-philmd@redhat.com>
 <20200504094641.4963-6-philmd@redhat.com>
 <5feeec39-e12f-b047-f5f3-bfac0d1af3f1@redhat.com>
 <9db49e27-c417-a280-fd4e-08bb0ad57fb3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d4f6e95-cf51-e6a6-220e-4b1fb6fa4559@redhat.com>
Date: Tue, 5 May 2020 11:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9db49e27-c417-a280-fd4e-08bb0ad57fb3@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 10:23 AM, Laurent Vivier wrote:
> On 05/05/2020 10:00, Laurent Vivier wrote:
>> On 04/05/2020 11:46, Philippe Mathieu-Daud=C3=A9 wrote:
>>> In nvme_create_queue_pair() we create a page list using
>>> qemu_blockalign(), then map it with qemu_vfio_dma_map():
>>>
>>>    q->prp_list_pages =3D qemu_blockalign0(bs, s->page_size * NVME_QUEUE=
_SIZE);
>>>    r =3D qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
>>>                          s->page_size * NVME_QUEUE_SIZE, ...);
>>>
>>> With:
>>>
>>>    s->page_size =3D MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
>>>
>>> The qemu_vfio_dma_map() documentation says "The caller need
>>> to make sure the area is aligned to page size". While we use
>>> multiple s->page_size as alignment, it might be not sufficient
>>> on some hosts. Use the qemu_real_host_page_size value to be
>>> sure the host alignment is respected.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
>>> Cc: David Gibson <david@gibson.dropbear.id.au>
>>> Cc: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>   block/nvme.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/nvme.c b/block/nvme.c
>>> index 7b7c0cc5d6..bde0d28b39 100644
>>> --- a/block/nvme.c
>>> +++ b/block/nvme.c
>>> @@ -627,7 +627,7 @@ static int nvme_init(BlockDriverState *bs, const ch=
ar *device, int namespace,
>>>  =20
>>>       s->page_size =3D MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
>>>       s->doorbell_scale =3D (4 << (((cap >> 32) & 0xF))) / sizeof(uint3=
2_t);
>>> -    bs->bl.opt_mem_alignment =3D s->page_size;
>>> +    bs->bl.opt_mem_alignment =3D MAX(qemu_real_host_page_size, s->page=
_size);
>>
>> Why don't you replace directly the "4096" in s->page_size by
>> qemu_real_host_page_size?
>>
>> I think this was the purpose of MAX(4096, ...) to align to the host page
>> size.
>=20
> oh, I see, page_size is used for a lot of things than can be broken, and
> this is what is done in bdrv_opt_mem_align() for instance, 4096 is the
> sector size not the host page size.
>=20
> BTW, you need the same change as in nvme_init() in
> nvme_refresh_limits(), I think.

nvme_init() seems OK, but you are right, I missed=20
nvme_refresh_limits()... Thanks!

>=20
> Thanks,
> Laurent
>=20
>=20


