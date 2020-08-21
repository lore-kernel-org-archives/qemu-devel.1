Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F0CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F74207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7otPvKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F74207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96oI-0001ZE-8V
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k96nN-0000oV-7S
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:09:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42259
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k96nK-0005hS-E5
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598015357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W9c4pC1304fdegqgrPgL8Yz6rc3to2WCr4OYGH89j+Y=;
 b=O7otPvKCxUqfCJ29foawKQ3kEh4q2KoDwocvVNv4/QwKQr5O6JEWlb7+5UchocyyhHMuVM
 rtgg72PtxSinSDumlOSLknT1ovzrUIHWWwj8dt6Ae3Z5/XPJGn12f+3fxczsUmAbBEwBPH
 urNHJXmfXQ8IEGjBaL8a7fs7c3OGgrk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-GVwdUC25O8epKqZujH3P2A-1; Fri, 21 Aug 2020 09:09:16 -0400
X-MC-Unique: GVwdUC25O8epKqZujH3P2A-1
Received: by mail-wr1-f71.google.com with SMTP id e14so534047wrr.7
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=W9c4pC1304fdegqgrPgL8Yz6rc3to2WCr4OYGH89j+Y=;
 b=KSfUZL1oFzGVSgXtgHQWnTl6JndDD2o65xItIDAitxHdhQdmJy9e5GP/PlOi3VgK1A
 YOqDzWK9qm3D3dHCVTd2xEWCalrypTIeBaTQha6eN0XoTo14dgiul765jHij8sas1Vnm
 h2rVQYH3K5iSwqjXcqfZlQKky9d+cAvC5nzd/ZovWnhyxkbSOGJlAxkctvdFvyc3xG6I
 wd71NTNQeLq8wtoGzzu8ZVizlSTb75gys0swPCSUKBcEiHU1joKEs47K4unmKFfqlBYU
 BfGAN7M5M92gTNgLDLtVL3tWNnF+NDfEVK79tyDCdihLWiFipM1Gas2ymJPr4+X7MP8J
 ZTzA==
X-Gm-Message-State: AOAM532BzJs6EwKPiocKu43FwvIwIBd+Ye/n5U6UA85XTWbuNj3lLZyd
 RK2fTzczn9xiPeNRInw1YAdah/kyeai4u68D4tPf0cLriRSPdgzRqOuFGRS0bB2qDWqNMPgSmsZ
 +xBYRg8HMdNwNjn4=
X-Received: by 2002:a1c:6083:: with SMTP id u125mr3704782wmb.161.1598015355259; 
 Fri, 21 Aug 2020 06:09:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylDTXvyXO+LOJGLBIr94AM3SpNwYLxweHWDAnMMwAR8jbXfzFMdx49iZ9yxxetNfX/uXWnfA==
X-Received: by 2002:a1c:6083:: with SMTP id u125mr3704747wmb.161.1598015354872; 
 Fri, 21 Aug 2020 06:09:14 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id z7sm4320011wmk.6.2020.08.21.06.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:09:14 -0700 (PDT)
Subject: Re: [PATCH v5 15/15] block/nvme: Use an array of EventNotifier
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
 <20200820165901.1139109-16-philmd@redhat.com>
 <20200821102937.bartqudtcfesdmzr@steredhat>
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
Message-ID: <fd1386d6-7663-04a0-f641-c44a48f821d4@redhat.com>
Date: Fri, 21 Aug 2020 15:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821102937.bartqudtcfesdmzr@steredhat>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
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

On 8/21/20 12:29 PM, Stefano Garzarella wrote:
> On Thu, Aug 20, 2020 at 06:59:01PM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> In preparation of using multiple IRQ (thus multiple eventfds)
>> make BDRVNVMeState::irq_notifier an array (for now of a single
>> element, the admin queue notifier).
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
>> ---
>>  block/nvme.c | 31 +++++++++++++++++++++----------
>>  1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index a61e86a83eb..fe8a40b7ede 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -106,6 +106,12 @@ QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
>>  #define INDEX_ADMIN     0
>>  #define INDEX_IO(n)     (1 + n)
>>  
>> +/* This driver shares a single MSIX IRQ for the admin and I/O queues */
>> +enum {
>> +    MSIX_SHARED_IRQ_IDX = 0,
>> +    MSIX_IRQ_COUNT = 1
>> +};
>> +
>>  struct BDRVNVMeState {
>>      AioContext *aio_context;
>>      QEMUVFIOState *vfio;
>> @@ -120,7 +126,7 @@ struct BDRVNVMeState {
>>      /* How many uint32_t elements does each doorbell entry take. */
>>      size_t doorbell_scale;
>>      bool write_cache_supported;
>> -    EventNotifier irq_notifier;
>> +    EventNotifier irq_notifier[MSIX_IRQ_COUNT];
>>  
>>      uint64_t nsze; /* Namespace size reported by identify command */
>>      int nsid;      /* The namespace id to read/write data. */
>> @@ -631,7 +637,8 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
>>  
>>  static void nvme_handle_event(EventNotifier *n)
>>  {
>> -    BDRVNVMeState *s = container_of(n, BDRVNVMeState, irq_notifier);
>> +    BDRVNVMeState *s = container_of(n, BDRVNVMeState,
>> +                                    irq_notifier[MSIX_SHARED_IRQ_IDX]);
>>  
>>      trace_nvme_handle_event(s);
>>      event_notifier_test_and_clear(n);
>> @@ -683,7 +690,8 @@ out_error:
>>  static bool nvme_poll_cb(void *opaque)
>>  {
>>      EventNotifier *e = opaque;
>> -    BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
>> +    BDRVNVMeState *s = container_of(e, BDRVNVMeState,
>> +                                    irq_notifier[MSIX_SHARED_IRQ_IDX]);
>>  
>>      trace_nvme_poll_cb(s);
>>      return nvme_poll_queues(s);
>> @@ -705,7 +713,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>      s->device = g_strdup(device);
>>      s->nsid = namespace;
>>      s->aio_context = bdrv_get_aio_context(bs);
>> -    ret = event_notifier_init(&s->irq_notifier, 0);
>> +    ret = event_notifier_init(&s->irq_notifier[MSIX_SHARED_IRQ_IDX], 0);
>>      if (ret) {
>>          error_setg(errp, "Failed to init event notifier");
>>          return ret;
>> @@ -784,12 +792,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>          }
>>      }
>>  
>> -    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
>> +    ret = qemu_vfio_pci_init_irq(s->vfio, s->irq_notifier,
> 
> Maybe we can use '&s->irq_notifier[MSIX_SHARED_IRQ_IDX]' to match the other
> changes.

This makes the following patch in the next series (using multiple
queues) simpler, but if you prefer I don't mind using your suggestion
here, then adding another patch to directly use the array address
(instead of the address of the 1st element in that array). As you
wish :)

> 
>>                                   VFIO_PCI_MSIX_IRQ_INDEX, errp);
>>      if (ret) {
>>          goto out;
>>      }
>> -    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
>> +    aio_set_event_notifier(bdrv_get_aio_context(bs),
>> +                           &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
>>                             false, nvme_handle_event, nvme_poll_cb);
>>  
>>      nvme_identify(bs, namespace, &local_err);
>> @@ -872,9 +881,10 @@ static void nvme_close(BlockDriverState *bs)
>>          nvme_free_queue_pair(s->queues[i]);
>>      }
>>      g_free(s->queues);
>> -    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
>> +    aio_set_event_notifier(bdrv_get_aio_context(bs),
>> +                           &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
>>                             false, NULL, NULL);
>> -    event_notifier_cleanup(&s->irq_notifier);
>> +    event_notifier_cleanup(&s->irq_notifier[MSIX_SHARED_IRQ_IDX]);
>>      qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
>>      qemu_vfio_close(s->vfio);
>>  
>> @@ -1381,7 +1391,8 @@ static void nvme_detach_aio_context(BlockDriverState *bs)
>>          q->completion_bh = NULL;
>>      }
>>  
>> -    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
>> +    aio_set_event_notifier(bdrv_get_aio_context(bs),
>> +                           &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
>>                             false, NULL, NULL);
>>  }
>>  
>> @@ -1391,7 +1402,7 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
>>      BDRVNVMeState *s = bs->opaque;
>>  
>>      s->aio_context = new_context;
>> -    aio_set_event_notifier(new_context, &s->irq_notifier,
>> +    aio_set_event_notifier(new_context, &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
>>                             false, nvme_handle_event, nvme_poll_cb);
>>  
>>      for (int i = 0; i < s->nr_queues; i++) {
>> -- 
>> 2.26.2
>>
>>
> 


