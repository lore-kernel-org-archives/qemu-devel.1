Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BA6C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F072085B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9K5Q+0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F072085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdux-0004UY-GG
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdrU-0001va-J6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdrS-0000Bs-MA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600764077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4lLGOuww1rRtoTZ3UUufasD43FB7b//7+t/UFKJssuI=;
 b=N9K5Q+0ONw8zWi8C9C+ZKQe9i1s05c0Y1AYw6Mq+CXeowmOnR6VBYm76AaT8crilm61aeC
 firioQ3u21+S3eJ0QA1Ueq1bFC+q38sdoaLef5gB+89S3bPrO/SrJvTCBUjCaSXzX/hY9y
 Q6CuG9RSox4a3FXXvJA161SlBnpXgY8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-MLXOZtsuMeSe747Mu42_Dw-1; Tue, 22 Sep 2020 04:41:16 -0400
X-MC-Unique: MLXOZtsuMeSe747Mu42_Dw-1
Received: by mail-wm1-f72.google.com with SMTP id b20so846200wmj.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4lLGOuww1rRtoTZ3UUufasD43FB7b//7+t/UFKJssuI=;
 b=YMkR9WV+9XTlDPOqXQphA2kuU7c+dMzWPH93eCEvQJSIo6LOKcb8qU8mvvprOLY9Ha
 kTLKKPyyYH3AnulN+PAV1x+Ra1ZwgrBZ6R0uzFOIiN5TUJDTXPtBRvLlImwFienKlAc0
 Pn9EubCI4wUL2Ct5HVkpPFkVqfYs8Llw4AG7M80KCW3Jjy6Ha0qnm9RjkHVFcUc4xspw
 uQsEI0TTqTHwZS4UGLh7HIDxXiNSfIPDX4Nm8XMD1rD1YN+0o57a7299R1hvOC4Zc/yu
 zehJhoJcpitnE3YhAUx+148BmMkSV7XmOgy2yg+h0zHW/4QeyeFRGQVLS4QIoyH447DC
 SXVQ==
X-Gm-Message-State: AOAM530erjHKYWFtcrc2W4siVCRE2zaR8x+7GYjUIREgjdfpzksZ0Ryc
 PRFjlQbgfwlCowYMIsrlf5yNGihW7jq9Fa82rhRgsPk0GNzOcxef9ZGmAOK+feg8LY+fF5Kr1gM
 WaItsLiOLe0JhYYg=
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr4368723wrm.229.1600764074793; 
 Tue, 22 Sep 2020 01:41:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMtCUBSsIU91jsmIEYu+2X801+TVHCgMXSaPULo9p9jq3HE1Oveti6gpuQck8twmJzfjnRnQ==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr4368701wrm.229.1600764074550; 
 Tue, 22 Sep 2020 01:41:14 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d19sm3529712wmd.0.2020.09.22.01.41.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 01:41:13 -0700 (PDT)
Subject: Re: [PATCH 2/6] block/nvme: Map doorbells pages write-only
To: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
References: <20200921162949.553863-1-philmd@redhat.com>
 <20200921162949.553863-3-philmd@redhat.com>
 <6ea4b96862a0dac22205592b6c8d9e21ab57189a.camel@euphon.net>
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
Message-ID: <22dab788-06f1-3686-51f3-24ee7ce77fda@redhat.com>
Date: Tue, 22 Sep 2020 10:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6ea4b96862a0dac22205592b6c8d9e21ab57189a.camel@euphon.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Fam,

+Paolo?

On 9/22/20 10:18 AM, Fam Zheng wrote:
> On Mon, 2020-09-21 at 18:29 +0200, Philippe Mathieu-Daudé wrote:
>> Per the datasheet sections 3.1.13/3.1.14:
>>   "The host should not read the doorbell registers."
>>
>> As we don't need read access, map the doorbells with write-only
>> permission. We keep a reference to this mapped address in the
>> BDRVNVMeState structure.
> 
> Besides looking more correct in access mode, is there any side effect
> of WO mapping?

TBH I don't have enough knowledge to answer this question.
I tested successfully on X86. I'm writing more tests.

> 
> Fam
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  block/nvme.c | 29 +++++++++++++++++++----------
>>  1 file changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/nvme.c b/block/nvme.c
>> index 5a4dc6a722a..3c834da8fec 100644
>> --- a/block/nvme.c
>> +++ b/block/nvme.c
>> @@ -31,7 +31,7 @@
>>  #define NVME_SQ_ENTRY_BYTES 64
>>  #define NVME_CQ_ENTRY_BYTES 16
>>  #define NVME_QUEUE_SIZE 128
>> -#define NVME_BAR_SIZE 8192
>> +#define NVME_DOORBELL_SIZE 4096
>>  
>>  /*
>>   * We have to leave one slot empty as that is the full queue case
>> where
>> @@ -84,10 +84,6 @@ typedef struct {
>>  /* Memory mapped registers */
>>  typedef volatile struct {
>>      NvmeBar ctrl;
>> -    struct {
>> -        uint32_t sq_tail;
>> -        uint32_t cq_head;
>> -    } doorbells[];
>>  } NVMeRegs;
>>  
>>  #define INDEX_ADMIN     0
>> @@ -103,6 +99,11 @@ struct BDRVNVMeState {
>>      AioContext *aio_context;
>>      QEMUVFIOState *vfio;
>>      NVMeRegs *regs;
>> +    /* Memory mapped registers */
>> +    volatile struct {
>> +        uint32_t sq_tail;
>> +        uint32_t cq_head;
>> +    } *doorbells;
>>      /* The submission/completion queue pairs.
>>       * [0]: admin queue.
>>       * [1..]: io queues.
>> @@ -247,14 +248,14 @@ static NVMeQueuePair
>> *nvme_create_queue_pair(BDRVNVMeState *s,
>>          error_propagate(errp, local_err);
>>          goto fail;
>>      }
>> -    q->sq.doorbell = &s->regs->doorbells[idx * s-
>>> doorbell_scale].sq_tail;
>> +    q->sq.doorbell = &s->doorbells[idx * s->doorbell_scale].sq_tail;
>>  
>>      nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES,
>> &local_err);
>>      if (local_err) {
>>          error_propagate(errp, local_err);
>>          goto fail;
>>      }
>> -    q->cq.doorbell = &s->regs->doorbells[idx * s-
>>> doorbell_scale].cq_head;
>> +    q->cq.doorbell = &s->doorbells[idx * s->doorbell_scale].cq_head;
>>  
>>      return q;
>>  fail:
>> @@ -712,13 +713,12 @@ static int nvme_init(BlockDriverState *bs,
>> const char *device, int namespace,
>>          goto out;
>>      }
>>  
>> -    s->regs = qemu_vfio_pci_map_bar(s->vfio, 0, 0, NVME_BAR_SIZE,
>> +    s->regs = qemu_vfio_pci_map_bar(s->vfio, 0, 0, sizeof(NvmeBar),
>>                                      PROT_READ | PROT_WRITE, errp);
>>      if (!s->regs) {
>>          ret = -EINVAL;
>>          goto out;
>>      }
>> -
>>      /* Perform initialize sequence as described in NVMe spec "7.6.1
>>       * Initialization". */
>>  
>> @@ -748,6 +748,13 @@ static int nvme_init(BlockDriverState *bs, const
>> char *device, int namespace,
>>          }
>>      }
>>  
>> +    s->doorbells = qemu_vfio_pci_map_bar(s->vfio, 0,
>> sizeof(NvmeBar),
>> +                                         NVME_DOORBELL_SIZE,
>> PROT_WRITE, errp);
>> +    if (!s->doorbells) {
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>>      /* Set up admin queue. */
>>      s->queues = g_new(NVMeQueuePair *, 1);
>>      s->queues[INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context,
>> 0,
>> @@ -873,7 +880,9 @@ static void nvme_close(BlockDriverState *bs)
>>                             &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
>>                             false, NULL, NULL);
>>      event_notifier_cleanup(&s->irq_notifier[MSIX_SHARED_IRQ_IDX]);
>> -    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0,
>> NVME_BAR_SIZE);
>> +    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->doorbells,
>> +                            sizeof(NvmeBar), NVME_DOORBELL_SIZE);
>> +    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0,
>> sizeof(NvmeBar));
>>      qemu_vfio_close(s->vfio);
>>  
>>      g_free(s->device);
> 


