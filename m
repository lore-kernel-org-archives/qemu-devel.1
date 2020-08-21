Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066F0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C434720724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQ7Joh1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C434720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k975R-0000HM-49
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k974q-0008Dt-0I
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:27:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k974l-0007yN-Sa
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598016442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=H9pUArtxAQMw8B9JTzkq/m04kcAOjmC8Ift1AnKYPMk=;
 b=WQ7Joh1QLDhmRWhOmqEQIFGJ788/VyAwSxRCBjmWAQ5bE8wjfTheJSTahl0U21i2ILr5Tp
 My8XXTeDZbLRBpXPVQQ8WzLK3SMqmexK13uZRxsVLtVIhOko6nXcT/NEavZEUbnPiYWi8L
 kTNIEvfZg/OTYAbaumKOx5V7Ki69egU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-As8RfG-rMbiSyqtgAAc6CQ-1; Fri, 21 Aug 2020 09:27:18 -0400
X-MC-Unique: As8RfG-rMbiSyqtgAAc6CQ-1
Received: by mail-wm1-f72.google.com with SMTP id q23so573233wmj.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=H9pUArtxAQMw8B9JTzkq/m04kcAOjmC8Ift1AnKYPMk=;
 b=hMt9zLeY7L4/49bT2780NipLUoJXb0O0YGMh7Sd48CKcAygj6iGuYY/NgRsaSHji1T
 aqBvXFX2plmob249MJUowtvKCiw3GTZA0boXJHCJNtZP39yrz8rUITK+028J2r2WYII0
 wjryx5Jzk6rJtWBkHKve1oYpovXzns3RmU20iSbgXnmnyi00YsUaenMe7Ci0UFpL40gm
 /ZVfB8EGTM+j7M2OUDetKnO3d9JeiO8jFevAnmqpkGg2ubw6reVjCppNscCq5ZD0IAtk
 GFvkHYWQCp7dzxHKLLihDKLc9xnZ9MiyX5PImDfoAQw2553SNq6ghQ4VHrCjme/k8vkD
 Kelg==
X-Gm-Message-State: AOAM533PtlKHMugBCJsltgRZbEIkSK/o3lphCHxJ9K8r6Gjwc5FEzLFT
 NkXv0JpYXvzPx75i6IxUlstJ59Otwf31sr6VLxUwI2y7fdsN9qtiAggCsXdcAWSJVTWIf+DUxW7
 /+2lFUvTFEJVcmig=
X-Received: by 2002:a5d:414e:: with SMTP id c14mr2974541wrq.57.1598016437344; 
 Fri, 21 Aug 2020 06:27:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4o7sandrlyAp91DcC8685BYnLFxqGu+CwG/wXHcZPcWx/7MKWJhl+p6qtvIoRm3TChznaLg==
X-Received: by 2002:a5d:414e:: with SMTP id c14mr2974507wrq.57.1598016436993; 
 Fri, 21 Aug 2020 06:27:16 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t8sm5438637wmt.35.2020.08.21.06.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:27:16 -0700 (PDT)
Subject: Re: [PATCH v5 08/15] block/nvme: Use union of NvmeIdCtrl / NvmeIdNs
 structures
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-9-philmd@redhat.com>
 <20200821100341.a6xtnv4e2dqli56a@steredhat>
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
Message-ID: <f35b9d96-1584-b627-895f-a4f0214d55a6@redhat.com>
Date: Fri, 21 Aug 2020 15:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821100341.a6xtnv4e2dqli56a@steredhat>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

On 8/21/20 12:03 PM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2020 at 06:58:54PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> We allocate an unique chunk of memory then use it for two
>> different structures. By using an union, we make it clear
>> the data is overlapping (and we can remove the casts).
>>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
>> ---
>>  block/nvme.c | 31 +++++++++++++++----------------
>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index 99822d9fd36..2bd1935f951 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -508,9 +508,10 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
>>  static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>>  {
>>      BDRVNVMeState *s = bs->opaque;
>> -    NvmeIdCtrl *idctrl;
>> -    NvmeIdNs *idns;
>> -    uint8_t *id;
>> +    union {
>> +        NvmeIdCtrl ctrl;
>> +        NvmeIdNs ns;
>> +    } *id;
> 
> What about defining a new 'NvmeId' type with this union?

I'd rather not, these are different command responses, it
just happens to make this code simpler as the same response
packet is used for the 2 requests.

See previous discussion:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg716858.html

> 
>>      NvmeLBAF *lbaf;
>>      uint16_t oncs;
>>      int r;
>> @@ -520,14 +521,12 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>>          .cdw10 = cpu_to_le32(0x1),
>>      };
>>  
>> -    id = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
>> +    id = qemu_try_blockalign0(bs, sizeof(*id));
>>      if (!id) {
>>          error_setg(errp, "Cannot allocate buffer for identify response");
>>          goto out;
>>      }
>> -    idctrl = (NvmeIdCtrl *)id;
>> -    idns = (NvmeIdNs *)id;
>> -    r = qemu_vfio_dma_map(s->vfio, id, sizeof(NvmeIdCtrl), true, &iova);
>> +    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova);
>>      if (r) {
>>          error_setg(errp, "Cannot map buffer for DMA");
>>          goto out;
>> @@ -539,22 +538,22 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>>          goto out;
>>      }
>>  
>> -    if (le32_to_cpu(idctrl->nn) < namespace) {
>> +    if (le32_to_cpu(id->ctrl.nn) < namespace) {
>>          error_setg(errp, "Invalid namespace");
>>          goto out;
>>      }
>> -    s->write_cache_supported = le32_to_cpu(idctrl->vwc) & 0x1;
>> -    s->max_transfer = (idctrl->mdts ? 1 << idctrl->mdts : 0) * s->page_size;
>> +    s->write_cache_supported = le32_to_cpu(id->ctrl.vwc) & 0x1;
>> +    s->max_transfer = (id->ctrl.mdts ? 1 << id->ctrl.mdts : 0) * s->page_size;
>>      /* For now the page list buffer per command is one page, to hold at most
>>       * s->page_size / sizeof(uint64_t) entries. */
>>      s->max_transfer = MIN_NON_ZERO(s->max_transfer,
>>                            s->page_size / sizeof(uint64_t) * s->page_size);
>>  
>> -    oncs = le16_to_cpu(idctrl->oncs);
>> +    oncs = le16_to_cpu(id->ctrl.oncs);
>>      s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
>>      s->supports_discard = !!(oncs & NVME_ONCS_DSM);
>>  
>> -    memset(id, 0, 4096);
>> +    memset(id, 0, sizeof(*id));
>>      cmd.cdw10 = 0;
>>      cmd.nsid = cpu_to_le32(namespace);
>>      if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
>> @@ -562,11 +561,11 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
>>          goto out;
>>      }
>>  
>> -    s->nsze = le64_to_cpu(idns->nsze);
>> -    lbaf = &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
>> +    s->nsze = le64_to_cpu(id->ns.nsze);
>> +    lbaf = &id->ns.lbaf[NVME_ID_NS_FLBAS_INDEX(id->ns.flbas)];
>>  
>> -    if (NVME_ID_NS_DLFEAT_WRITE_ZEROES(idns->dlfeat) &&
>> -            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(idns->dlfeat) ==
>> +    if (NVME_ID_NS_DLFEAT_WRITE_ZEROES(id->ns.dlfeat) &&
>> +            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(id->ns.dlfeat) ==
>>                      NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROES) {
>>          bs->supported_write_flags |= BDRV_REQ_MAY_UNMAP;
>>      }
>> -- 
>> 2.26.2
>>
>>
> 
> With or without the new tyoe, the patch looks good to me:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks!

Phil.


