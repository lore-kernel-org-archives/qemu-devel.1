Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C317C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E6120768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fq+qH5pD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E6120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcwY-0004o1-AI
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOcvd-0003TI-EP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOcvc-0001Br-C8
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:57:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOcvc-0001Bh-99
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586937467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eYuvCiL/23zuhvAxbcMksUPrPrAlbfxMjOADBqURdw=;
 b=Fq+qH5pDX/YlgM2Ir6E2aDV0aNO823gLcuP50iuve/s/hbTy6+wU6InBwbNYQmAA150Mfx
 iNdg+oZBMgQ7SMnvXRmvm20+ryVpH0TCsgSzNTxLwhDKSSc8upyqpqKyPkLNpoJHTL2GCz
 MXp1HHIeMKnxcI4Ak27RwrOZRD5NzI4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-R6hlQnsAOiqcc4Um9cq_xA-1; Wed, 15 Apr 2020 03:57:46 -0400
X-MC-Unique: R6hlQnsAOiqcc4Um9cq_xA-1
Received: by mail-ed1-f69.google.com with SMTP id ba30so2226581edb.6
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eg1Lr78SplYlmQo3U/sTEwRgRUCiEHaD9dZT8igdzLM=;
 b=UFSE4li64kHc24h6vuadOdaOeGLTVIyZU/xIKhWBn0IwNh6unL3roIq7xZMjz+YPkJ
 PE/36EqXA7vw0b5RI7NSFNjPIXZbirCn1QSTzhVA2quTsvdm7uPSRZoqS0ADFbaCCD5T
 yAKJdl3g/zUe8wyAY93jTSA4oLGSvB2SQBKGk2Ql/fjK3KWF7Yroo1sPHxnd1rZaetyy
 Wy8sBwyP/Cx5iA1mwxwxYPsNaVoBA5gT+a6jkYJJB///kcyE3CzI8Dvg8yRzOkP8AboF
 kUbV/LFGWmFDHQzegmiawTUSdAY8AZ40kDNX7XsmGv/CBivM0CTUdqbwxyRB8wH1HUyo
 xfbw==
X-Gm-Message-State: AGi0PuZXHkYxiHM4ExtEHFRBnrCGjaqxh5xxqXjBw0qnbO54JW1DzdJR
 mtfIGt1VE1n/s6rOLj0fHSH6zWm9KoXp02Nec6ce1J2lXP7+RRuh7QRiVIWxlr51FIcAfPqrPS9
 U/K8TXyNZkLyICkM=
X-Received: by 2002:a05:6402:1f6:: with SMTP id
 i22mr1264769edy.271.1586937465089; 
 Wed, 15 Apr 2020 00:57:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ7mg/2IjNvvdGt8U4KXrLib3ZZKs83OQlYNEamFCofCh9MRPl1oL2gnlQ+0SN/nK6kqEYhcg==
X-Received: by 2002:a05:6402:1f6:: with SMTP id
 i22mr1264760edy.271.1586937464846; 
 Wed, 15 Apr 2020 00:57:44 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id bu4sm1070564edb.90.2020.04.15.00.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:57:44 -0700 (PDT)
Subject: Re: [PATCH] block/nvme: Remove memory leak
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20200414151727.17012-1-philmd@redhat.com>
 <20200415074636.pu66tqyaqvecnqk7@steredhat>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <119d001c-026b-c1e3-f1a3-4d18f39e85b9@redhat.com>
Date: Wed, 15 Apr 2020 09:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415074636.pu66tqyaqvecnqk7@steredhat>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 4/15/20 9:46 AM, Stefano Garzarella wrote:
> On Tue, Apr 14, 2020 at 05:17:26PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Fixes: bdd6a90a9 ("Add VFIO based NVMe driver")
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   block/nvme.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index 7b7c0cc5d6..9f3c7ab819 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -163,6 +163,7 @@ static void nvme_init_queue(BlockDriverState *bs, NV=
MeQueue *q,
>>       }
>>       r =3D qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova)=
;
>>       if (r) {
>> +        qemu_vfree(q->queue);
>>           error_setg(errp, "Cannot map queue");
>>       }
>>   }
>> --=20
>> 2.21.1
>>
>>
>=20
> Are we adding a double free with this change?
>=20
> IIUC when nvme_init_queue() fails in the nvme_create_queue_pair() we
> already call the nvme_free_queue_pair() that frees sq.queue and
> cq.queue.

Argh you are right, I missed that...

>=20
> I think your patch make the code cleaner, freeing the buffer near the
> allocation during an error, maybe we can also set q->queue to NULL
> after the qemu_vfree().
>=20
> Thanks,
> Stefano
>=20


