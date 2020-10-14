Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4EAC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8558920848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFpeDM7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8558920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSg8J-0003ak-Cr
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSg6z-0002f1-UO
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSg6y-0007UE-65
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602679350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5ia5GrGk02vweaHrEOIWaZbX3+i5e7DUz7BfY1dZ+M=;
 b=PFpeDM7PpvA8uag4PaSLoqwOSIEQS5xxbjCldFhkJPSRAmSrSPkgwUQvqFD4ic40k63ELR
 JB4TvV0fa+Dh4dTspokw3Uis9gsPnBH6CQ+uS72+6CxfezV1AqJFiLpwza8uWYAYUrwQFl
 FItDrXUhp+jTTIuotg2bk/udvOQadAQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-emNnAIUhOkaPj5VLhdKZ3g-1; Wed, 14 Oct 2020 08:42:29 -0400
X-MC-Unique: emNnAIUhOkaPj5VLhdKZ3g-1
Received: by mail-wm1-f69.google.com with SMTP id f2so491915wml.6
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 05:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y5ia5GrGk02vweaHrEOIWaZbX3+i5e7DUz7BfY1dZ+M=;
 b=VrGMBGpFWfFLEzaFOu0bs0tYpYIDSaCebzsl6d4CdENXHFvLkmxFOyafhYGLOjBHQ6
 NY/EW4QZiUjSIsORXTEp5gciqQiA8dU+/Aspw6dLT1PyStuP1ay9F6jaz1GhbdccjDE0
 N9Q1kpNx6EcH683Se0c7VlD7Lav4369dUDJHlu7+0AKe94WjPH8QQHrXc2cYtNIQQ6MS
 cjelP+pnH77AUDmRZz8UDAv+owNaY3UwWtLYWJNij8Ha883k3GPjXvPHwLqiyuUBhpde
 9jSS66cN7CFZOUHq0UpZJGEOUKYHaMdi3E2qxHEgWIhVMDYySp3teHpCMlxuV4SPJq0b
 sBsA==
X-Gm-Message-State: AOAM532HK/ALhrG+f7GSUvUmsXRmWcXhQAsw4M9Wo+Sj5+KxqFZOoLOu
 dEJTh58H+Gwk8o7tSO7hK7nNy9MYxNtHCLJzRZpAraj47O7yB3dd47AE4W4yCxoDlA6LMevfR2w
 WZF7M9Uz5s7xepKE=
X-Received: by 2002:adf:979c:: with SMTP id s28mr5382432wrb.62.1602679348099; 
 Wed, 14 Oct 2020 05:42:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPYeIaem2d/2RQSUJVHLWuO3ctxb3VgvtdFOTC0mGOHZc5bPNcXY8Xp/c3U6VdOtNZzFI1SA==
X-Received: by 2002:adf:979c:: with SMTP id s28mr5382401wrb.62.1602679347755; 
 Wed, 14 Oct 2020 05:42:27 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g14sm4826890wrx.22.2020.10.14.05.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 05:42:27 -0700 (PDT)
Subject: Re: [PATCH 3/9] util/vfio-helpers: Trace PCI BAR region info
To: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
References: <20201014115253.25276-1-philmd@redhat.com>
 <20201014115253.25276-4-philmd@redhat.com>
 <fcfd9c11764d8c8d181eb62da0e307d1143ef1b2.camel@euphon.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <739a3c0f-9fa6-1428-f2d2-52685cc9317e@redhat.com>
Date: Wed, 14 Oct 2020 14:42:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <fcfd9c11764d8c8d181eb62da0e307d1143ef1b2.camel@euphon.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 2:23 PM, Fam Zheng wrote:
> On Wed, 2020-10-14 at 13:52 +0200, Philippe Mathieu-Daudé wrote:
>> For debug purpose, trace BAR regions info.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   util/vfio-helpers.c | 8 ++++++++
>>   util/trace-events   | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>> index 1d4efafcaa4..cd6287c3a98 100644
>> --- a/util/vfio-helpers.c
>> +++ b/util/vfio-helpers.c
>> @@ -136,6 +136,7 @@ static inline void
>> assert_bar_index_valid(QEMUVFIOState *s, int index)
>>   
>>   static int qemu_vfio_pci_init_bar(QEMUVFIOState *s, int index, Error
>> **errp)
>>   {
>> +    g_autofree char *barname = NULL;

         ^^^^^^^^^^

>>       assert_bar_index_valid(s, index);
>>       s->bar_region_info[index] = (struct vfio_region_info) {
>>           .index = VFIO_PCI_BAR0_REGION_INDEX + index,
>> @@ -145,6 +146,10 @@ static int qemu_vfio_pci_init_bar(QEMUVFIOState
>> *s, int index, Error **errp)
>>           error_setg_errno(errp, errno, "Failed to get BAR region
>> info");
>>           return -errno;
>>       }
>> +    barname = g_strdup_printf("bar[%d]", index);
> 
> Where is barname freed?

Using GLib g_autofree qualifier.

> 
> Fam
> 
>> +    trace_qemu_vfio_region_info(barname, s-
>>> bar_region_info[index].offset,
>> +                                s->bar_region_info[index].size,
>> +                                s-
>>> bar_region_info[index].cap_offset);
>>   
>>       return 0;
>>   }
>> @@ -416,6 +421,9 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s,
>> const char *device,
>>           ret = -errno;
>>           goto fail;
>>       }
>> +    trace_qemu_vfio_region_info("config", s-
>>> config_region_info.offset,
>> +                                s->config_region_info.size,
>> +                                s->config_region_info.cap_offset);
>>   
>>       for (i = 0; i < ARRAY_SIZE(s->bar_region_info); i++) {
>>           ret = qemu_vfio_pci_init_bar(s, i, errp);
>> diff --git a/util/trace-events b/util/trace-events
>> index c048f85f828..4d40c74a21f 100644
>> --- a/util/trace-events
>> +++ b/util/trace-events
>> @@ -87,3 +87,4 @@ qemu_vfio_dma_map(void *s, void *host, size_t size,
>> bool temporary, uint64_t *io
>>   qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
>>   qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t
>> region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d
>> (region ofs 0x%"PRIx64" size %"PRId64")"
>>   qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t
>> region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d
>> (region ofs 0x%"PRIx64" size %"PRId64")"
>> +qemu_vfio_region_info(const char *desc, uint64_t offset, uint64_t
>> size, uint32_t cap_offset) "region '%s' ofs 0x%"PRIx64" size
>> %"PRId64" cap_ofs %"PRId32
> 


