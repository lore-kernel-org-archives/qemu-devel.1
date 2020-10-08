Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCCEC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E212076B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIwQKBBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E212076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQT9W-0005xe-3b
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQT89-0005SM-HJ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQT87-0004q3-IP
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602152794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1hLMHN41PaGUgFOpE7FF0RqDGPi65Qm2MmKQKQ+wURQ=;
 b=ZIwQKBBh8Bcdd11ClEuCEe2OH7loUTy32SXr5p4DO7JuJFeo0uS3H0mEMyN5dg2luRbXVL
 Db63d+0tPQRuDONo5Wbdt+fo7Fgxly9vyUj+sRpDkGDCHuJh9Dk3Z91VqueVlOrbdOAZiM
 otPZbk+Qh3U3xbe/pbdMNpwKVvHmI14=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-OPu-PJVXONOqCOgRA3qEEA-1; Thu, 08 Oct 2020 06:26:31 -0400
X-MC-Unique: OPu-PJVXONOqCOgRA3qEEA-1
Received: by mail-wm1-f72.google.com with SMTP id b20so3872045wmj.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1hLMHN41PaGUgFOpE7FF0RqDGPi65Qm2MmKQKQ+wURQ=;
 b=JxjlhlCMzVLiJ0to3rAmDRWZ5J8sdxtzXvRMBV+6/25IvHgKEcYd3ZY5gCsRXsA1oJ
 g1p24qqoutxEbMqysRVNj7h1DkFYnXwDN5wtC8N1zHQhj1k2SgFdVzuYRUDQGJmNWnRu
 GCimaO/I1uvjs1UgtG0ofYZYWixAd/7kApIjPvQeWoermpLvietWtpkE3HAz9iU+OQZG
 TO1bpBSle1chhdgDoL5SGswMtBncXkGVzeIFK0+LxVnMlZgr2+6ZZF7Qgxe+hgXo8ZHN
 7V/oe7Xm02rXWYalESPLYTyKf+eBn/l/KOU9oySw9sToRzmYv97laPJ3whaJHNN6tmV9
 QBjA==
X-Gm-Message-State: AOAM533lvpJaOsg2dv8fy008qPjdzTPE7PJif+QyaInAlrYZf5ese9Pk
 uawARBH0GwWKt7o+lUOwjniCy2vNOfH7RByqIEn0zPkWIMfWoDJWjGkgEnQnXGBzk37dYsgcJEY
 9GGIUmm2RgjDHcz4=
X-Received: by 2002:adf:a455:: with SMTP id e21mr9313249wra.158.1602152790519; 
 Thu, 08 Oct 2020 03:26:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+h5eie61RF2KI6KGM2LpNi7msP5ADZ/dtgzftwT5AbsSuBjO29YN24egCXWqUNZ/nM0GzFg==
X-Received: by 2002:adf:a455:: with SMTP id e21mr9313213wra.158.1602152790201; 
 Thu, 08 Oct 2020 03:26:30 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q6sm6206294wma.0.2020.10.08.03.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 03:26:29 -0700 (PDT)
Subject: Re: acceptance-system-fedora failures
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <f9e09f0b-3915-382c-d670-8d33d164ad7b@redhat.com>
 <4e191372-c332-8f69-85e2-1ff6ead0f40d@redhat.com>
 <59d2a787-bcd4-7283-693b-09ea04c16dc6@redhat.com>
 <6068346f-b034-9321-0eea-29233c23a300@redhat.com>
 <78ce9ac1-d2a1-9dc0-bf38-f9ac34b2f203@ispras.ru>
 <14ee7cc6-42ca-fd86-241b-ed85e26693f7@redhat.com> <878sci1dt0.fsf@linaro.org>
 <d86c9425-dcb2-7fa7-1f6f-bd7b8dab53c1@ispras.ru>
 <c5e6f7ea-93c4-a46a-dfee-7699c08c1060@redhat.com>
 <4f4eee5e-e8cd-0595-cccc-8b648773c9ba@ispras.ru>
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
Message-ID: <43eac2fb-7325-9e9f-ce13-d0774638753f@redhat.com>
Date: Thu, 8 Oct 2020 12:26:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4f4eee5e-e8cd-0595-cccc-8b648773c9ba@ispras.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 3:11 PM, Pavel Dovgalyuk wrote:
> On 07.10.2020 15:49, Philippe Mathieu-Daudé wrote:
>> On 10/7/20 2:20 PM, Pavel Dovgalyuk wrote:
>>> On 07.10.2020 14:22, Alex Bennée wrote:
>>>>
>>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>>
>>>>> On 10/7/20 10:51 AM, Pavel Dovgalyuk wrote:
>>>>>> On 07.10.2020 11:23, Thomas Huth wrote:
>>>>>>> On 07/10/2020 09.13, Philippe Mathieu-Daudé wrote:
>>>>>>> Thanks, that was helpful. ... and the winner is:
>>>>>>>
>>>>>>>        commit   55adb3c45620c31f29978f209e2a44a08d34e2da
>>>>>>>        Author:  John Snow <jsnow@redhat.com>
>>>>>>>        Date:    Fri Jul 24 01:23:00 2020 -0400
>>>>>>>        Subject: ide: cancel pending callbacks on SRST
>>>>>>>
>>>>>>> ... starting with this commit, the tests starts failing. John, any
>>>>>>> idea what
>>>>>>> might be causing this?
>>>>>>
>>>>>> This patch includes the following lines:
>>>>>>
>>>>>> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>>>>> +                                ide_bus_perform_srst, bus);
>>>>>>
>>>>>> replay_bh_schedule_oneshot_event should be used instead of this
>>>>>> function, because it synchronizes non-deterministic BHs.
>>>>>
>>>>> Why do we have 2 different functions? BH are already complex
>>>>> enough, and we need to also think about the replay API...
>>>>>
>>>>> What about the other cases such vhost-user (blk/net), virtio-blk?
>>>>
>>>> This does seem like something that should be wrapped up inside
>>>> aio_bh_schedule_oneshot itself or maybe we need a
>>>> aio_bh_schedule_transaction_oneshot to distinguish it from the other
>>>> uses the function has.
>>>>
>>>
>>> Maybe there should be two functions:
>>> - one for the guest modification
>>
>> aio_bh_schedule_oneshot_deterministic()?
>>
>>> - one for internal qemu things
>>
>> Not sure why there is a difference, BH are used to
>> avoid delaying the guest, so there always something
>> related to "guest modification".
> 
> Not exactly. At least there is one non-related-to-guest case
> in monitor_init_qmp:
>         /*
>          * We can't call qemu_chr_fe_set_handlers() directly here
>          * since chardev might be running in the monitor I/O
>          * thread.  Schedule a bottom half.
>          */
>         aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
>                                 monitor_qmp_setup_handlers_bh, mon);

I don't understand the documentation in docs/devel/replay.txt:

---
Bottom halves
=============

Bottom half callbacks, that affect the guest state, should be invoked
through
replay_bh_schedule_event or replay_bh_schedule_oneshot_event functions.
Their invocations are saved in record mode and synchronized with the
existing
log in replay mode.
---

But then it is only used in block drivers, which are not
related to guest state:

$ git grep replay_bh_schedule_oneshot_event
block/block-backend.c:1385:
replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
block/block-backend.c:1450:
replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
block/io.c:371:
replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
block/iscsi.c:286:
replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
block/nfs.c:262:
replay_bh_schedule_oneshot_event(task->client->aio_context,
block/null.c:183:
replay_bh_schedule_oneshot_event(bdrv_get_aio_context(bs),
block/nvme.c:323:        replay_bh_schedule_oneshot_event(q->aio_context,
block/nvme.c:1075:    replay_bh_schedule_oneshot_event(data->ctx,
nvme_rw_cb_bh, data);
block/rbd.c:865:
replay_bh_schedule_oneshot_event(bdrv_get_aio_context(acb->common.bs),
docs/devel/replay.txt:25:replay_bh_schedule_event or
replay_bh_schedule_oneshot_event functions.
include/sysemu/replay.h:178:void
replay_bh_schedule_oneshot_event(AioContext *ctx,
replay/replay-events.c:141:void
replay_bh_schedule_oneshot_event(AioContext *ctx,
stubs/replay-user.c:5:void replay_bh_schedule_oneshot_event(AioContext *ctx,

Is replay_bh_schedule_oneshot_event ever used by replay?
Maybe we can remove it and use aio_bh_schedule_oneshot()
in place?

Else the documentation need to be clarified please.

> 
> 
>>
>>>
>>> The first one may be implemented though the rr+second one.
>>> Maybe replay_ prefix is confusing and the whole BH interface should look
>>> like that?
>>
>> Yes, but it would be safer/clearer if we don't need to use
>> a replay_ API.
>>
>> Can we embed these functions?
>>
>> - replay_bh_schedule_event
>> - replay_bh_schedule_oneshot_event
>>
>> If compiled without rr, events_enabled=false and
>> compiler can optimize:
>>
>> -- >8 --
>> diff --git a/util/async.c b/util/async.c
>> index f758354c6a..376b6d4e27 100644
>> --- a/util/async.c
>> +++ b/util/async.c
>> @@ -109,14 +109,19 @@ static QEMUBH *aio_bh_dequeue(BHList *head,
>> unsigned *flags)
>>
>>   void aio_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void
>> *opaque)
>>   {
>> -    QEMUBH *bh;
>> -    bh = g_new(QEMUBH, 1);
>> -    *bh = (QEMUBH){
>> -        .ctx = ctx,
>> -        .cb = cb,
>> -        .opaque = opaque,
>> -    };
>> -    aio_bh_enqueue(bh, BH_SCHEDULED | BH_ONESHOT);
>> +    if (events_enabled) {
>> +        replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb,
>> +                         opaque, replay_get_current_icount());
>> +    } else {
>> +        QEMUBH *bh;
>> +        bh = g_new(QEMUBH, 1);
>> +        *bh = (QEMUBH){
>> +            .ctx = ctx,
>> +            .cb = cb,
>> +            .opaque = opaque,
>> +        };
>> +        aio_bh_enqueue(bh, BH_SCHEDULED | BH_ONESHOT);
>> +    }
>>   }
>>
>>   QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
>> @@ -178,7 +183,12 @@ void qemu_bh_schedule_idle(QEMUBH *bh)
>>
>>   void qemu_bh_schedule(QEMUBH *bh)
> 
> qemu_bh_schedule is even worse.
> Many modules use it (e.g., loadvm_postcopy_handle_run), and there is no
> need to use replay version there. In such cases QEMU will halt if trying
> to call replay_bh_schedule_event.
> 
>>   {
>> -    aio_bh_enqueue(bh, BH_SCHEDULED);
>> +    if (events_enabled) {
>> +        replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL,
>> +                         replay_get_current_icount());
>> +    } else {
>> +        aio_bh_enqueue(bh, BH_SCHEDULED);
>> +    }
>>   }
>>
> 


