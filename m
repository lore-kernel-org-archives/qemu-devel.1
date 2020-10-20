Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1F3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BC92098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+Ehu8z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BC92098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpxy-0005Sz-0r
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpri-0007q0-Tl
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUprh-00029M-3Y
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603193500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZPg+9SwHgJaxjULwqana2tbErHK4Vnsy6eyIE1guVE=;
 b=L+Ehu8z4LO5XnvOuLwFUMTDjigJNUc8T98fQpq24tS9DTZgEllLDxWeNjddQofxMLIi+Kk
 yPQ5+d/95HEsYv36bnhA4bFpiFF+Cocui+t6+OvvNrJtP7VnUJK0CTUnelaIoT4/ERJL2D
 Y7YroSwK6FxIIa0Af6/E8sblPzomrYA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-jOJEpvmmO22XWo4gA0f-Xw-1; Tue, 20 Oct 2020 07:31:36 -0400
X-MC-Unique: jOJEpvmmO22XWo4gA0f-Xw-1
Received: by mail-wr1-f69.google.com with SMTP id j15so689218wrd.16
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 04:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TZPg+9SwHgJaxjULwqana2tbErHK4Vnsy6eyIE1guVE=;
 b=o6ZzoUbvo/LX5fYg8JMgFM7wbPMMzlUU+YuWbaYieVyH4zrPTXTNT2+08Ug8DknjKW
 gAsckBpDYf126ql5jPSUIlpkFvCp9rpwa+2Ki0dSjmu2S/cR9AdIalP2kyqx5RPe9HS0
 KdAHfGZ9Tm/XCFN1uZdbPA1WGKwxY/49TdXOh8ABgsjjITbHV4DiYBMT33bwUt6CACnZ
 OquJpUs3KYZAAHRkCb2G+zVjrgMhvoHhThcv8qjSDPK/NNPiJWHE/C8kq4Zk93PAUwFG
 4Iyb9j/NESxFrF5f1vnUAt3ikuQp5/uZh2qkOmGmZQ0HGAg4QzHbyqeFhGpNjx83eb4J
 pSqw==
X-Gm-Message-State: AOAM533Vob4Nt5XZml4nYD4HuV7Z8IqDjlYis1QdyQn4jC519tHaCsYv
 bwgXIYUhd50BWhIBc7rd3gQX3D/8SPUVEeOCaob9cvWJShxL1HPH5nynbxkOITlb8NbDSfBoWP0
 QCAO7jPj20vx+kSQ=
X-Received: by 2002:a5d:490c:: with SMTP id x12mr2982172wrq.193.1603193495582; 
 Tue, 20 Oct 2020 04:31:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh00huWt/CjPDxtdThS+1uYWG8VoRRMhvPM1yGfQ+4M/rr5AzghZ366IGinkG6GBLq1PEoWw==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr2982150wrq.193.1603193495368; 
 Tue, 20 Oct 2020 04:31:35 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id j7sm2551488wrn.81.2020.10.20.04.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 04:31:34 -0700 (PDT)
Subject: Re: [RFC 2/5] block/nvme: Change size and alignment of IDENTIFY
 response buffer
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, alex.williamson@redhat.com
References: <20201015115252.15582-1-eric.auger@redhat.com>
 <20201015115252.15582-3-eric.auger@redhat.com>
 <5fae4be4-2d62-7fa3-acbd-7da3154fbc47@redhat.com>
Message-ID: <47caa2b4-05e1-87e2-f7d9-038815b3e9db@redhat.com>
Date: Tue, 20 Oct 2020 13:31:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5fae4be4-2d62-7fa3-acbd-7da3154fbc47@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 12:59 PM, Philippe Mathieu-Daudé wrote:
> On 10/15/20 1:52 PM, Eric Auger wrote:
>> In preparation of 64kB host page support, let's change the size
>> and alignment of the IDENTIFY command response buffer so that
>> the VFIO DMA MAP succeeds. We align on the host page size.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   block/nvme.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index e3d96f20d0..088ff1825a 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -513,19 +513,21 @@ static void nvme_identify(BlockDriverState *bs, 
>> int namespace, Error **errp)
>>           .opcode = NVME_ADM_CMD_IDENTIFY,
>>           .cdw10 = cpu_to_le32(0x1),
>>       };
>> +    size_t id_size = QEMU_ALIGN_UP(sizeof(*id), 
>> qemu_real_host_page_size);
> 
> Do we really need to ALIGN_UP if we then call qemu_try_memalign()?

Ah, we need to ALIGN_UP for qemu_vfio_dma_map(), OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>> -    id = qemu_try_memalign(s->page_size, sizeof(*id));
>> +    id = qemu_try_memalign(qemu_real_host_page_size, id_size);
>>       if (!id) {
>>           error_setg(errp, "Cannot allocate buffer for identify 
>> response");
>>           goto out;
>>       }
>> -    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova);
>> +    r = qemu_vfio_dma_map(s->vfio, id, id_size, true, &iova);
>>       if (r) {
>>           error_setg(errp, "Cannot map buffer for DMA");
>>           goto out;
>>       }
>> -    memset(id, 0, sizeof(*id));
>> +    memset(id, 0, id_size);
>> +
>>       cmd.dptr.prp1 = cpu_to_le64(iova);
>>       if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>>           error_setg(errp, "Failed to identify controller");
>> @@ -547,7 +549,7 @@ static void nvme_identify(BlockDriverState *bs, 
>> int namespace, Error **errp)
>>       s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROES);
>>       s->supports_discard = !!(oncs & NVME_ONCS_DSM);
>> -    memset(id, 0, sizeof(*id));
>> +    memset(id, 0, id_size);
>>       cmd.cdw10 = 0;
>>       cmd.nsid = cpu_to_le32(namespace);
>>       if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>>
> 


