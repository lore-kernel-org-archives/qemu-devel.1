Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3ADC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B8020674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0OfBcFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B8020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiH7-0000lF-HJ
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaiDK-0002e1-Mg
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:02:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46476
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaiDH-0002nX-Qb
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589817717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bS19v5tdAy3g9Ui/BquZkkvAMv9fm0mGoX2aNGwMSG4=;
 b=M0OfBcFE1dABaeu0aE8r97Gk9TvBDO8U33sVW0gfTBrbbQiAjBPqPgPezzEB+zm6RHaVMO
 TNj71O880eC3oNKKwrojwinPgOWOJfr6Sc4dnKg8suGP8CpOdTnnI8HbM9fCLlNlRycoAJ
 8lYKkaNWKfeV+LUxbWZNrSeJSs/yXak=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-yhuAoxPlOfmRmQkcNKp3Ng-1; Mon, 18 May 2020 12:01:48 -0400
X-MC-Unique: yhuAoxPlOfmRmQkcNKp3Ng-1
Received: by mail-wm1-f69.google.com with SMTP id n124so20662wma.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bS19v5tdAy3g9Ui/BquZkkvAMv9fm0mGoX2aNGwMSG4=;
 b=phOgsF4IazDu/dbPUD/SlI0w+DJIPl/ckRi/E1Hm+Lx7IsFWH4v/T7bOJI6/7qvMBw
 bRY1JR1i7yi6eQzHUXg8l+s8gO65DTqYTyxnC25LuNYSFG9YHZkU7C1RXgLZkgabgXfb
 ER3iBG9ftbIO4r9cjw/OJ4r3JGH13Wtz1R3uIVuC87ywKN47FA/5d7NhmcAEJQnM/FvY
 pEu4fHTUXUzlZs0NMCAtfpaaMYIfgl5txsPawhzDkhXbykMSsYuxCMgS4rRvZHRnb/IN
 Oxl1kXkF56CcziIa8eOyMS/kG7Hj8YWt8TBDl5Oc9njp2z0DG8YbkBcdOVlWXpWI6hg1
 KHag==
X-Gm-Message-State: AOAM533PzQnycD2fR/wmT0amQzdLmPa6QxIe4baPxJpLXSSN2e34Oe2J
 s+Qe8SiVK5lNXm/8rfYseoffp9HCSMb/oc2yiin2ynV82o8C5lSIFx0x7iKoOyeDU8ac+NDzI7C
 tUEUWa8DInpkqFHU=
X-Received: by 2002:a05:600c:2146:: with SMTP id
 v6mr80891wml.142.1589817704139; 
 Mon, 18 May 2020 09:01:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygiWG7vkn+Drz3AQQ+HMDhfeVjWWLBTH74oKHXmSaeJfsAw58O+Wipw5t+yIB/ksDwPv8+iQ==
X-Received: by 2002:a05:600c:2146:: with SMTP id
 v6mr80856wml.142.1589817703885; 
 Mon, 18 May 2020 09:01:43 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r11sm17903310wro.15.2020.05.18.09.01.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:01:43 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] virtio-balloon: unref the iothread when unrealizing
To: David Hildenbrand <david@redhat.com>,
 Alexander Duyck <alexander.duyck@gmail.com>
References: <20200518083704.52646-1-david@redhat.com>
 <20200518083704.52646-4-david@redhat.com>
 <CAKgT0UfNdU9quX75MrV0EQk-v0EP4w8g6UVFj2k2qRO=VUvRCQ@mail.gmail.com>
 <299d4475-bfd4-34b7-749f-ed11076d23c3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8454c9a5-63c2-e145-574c-606abb2d9475@redhat.com>
Date: Mon, 18 May 2020 18:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <299d4475-bfd4-34b7-749f-ed11076d23c3@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Stefan/Paolo in case they have a better clue.

On 5/18/20 5:41 PM, David Hildenbrand wrote:
> On 18.05.20 17:35, Alexander Duyck wrote:
>> On Mon, May 18, 2020 at 1:37 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> We took a reference when realizing, so let's drop that reference when
>>> unrealizing.
>>>
>>> Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
>>> Cc: Wei Wang <wei.w.wang@intel.com>
>>> Cc: Alexander Duyck <alexander.duyck@gmail.com>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   hw/virtio/virtio-balloon.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>> index a4fcf2d777..3f8fc50be0 100644
>>> --- a/hw/virtio/virtio-balloon.c
>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -820,6 +820,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
>>>
>>>       if (s->free_page_bh) {
>>>           qemu_bh_delete(s->free_page_bh);
>>> +        object_unref(OBJECT(s->iothread));
>>>           virtio_balloon_free_page_stop(s);
>>>           precopy_remove_notifier(&s->free_page_report_notify);
>>>       }
>>
>> I'm not entirely sure about this order of operations. It seems like it
>> would make more sense to remove the notifier, stop the hinting, delete
>> the bh, and then release the IO thread.
> 
> This is the reverse order of the steps in
> virtio_balloon_device_realize(). And I guess it should be fine. The
> notifier cannot really be active/trigger while we are removing devices
> (cannot happen with concurrent migration). After qemu_bh_delete(), the
> iothread is effectively unused.
> 
> I am unsure about many things regarding free page hinting (e.g., if the
> virtio_balloon_free_page_stop() is of any use while we are ripping out
> the device and it will be gone in a second).
> 


