Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63403C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A020620789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 12:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8kDGE1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A020620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ8tL-0003uc-7R
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 08:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ8sh-0003Up-9O
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQ8sd-0008Um-9F
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 08:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602074953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tghQrHH2fhtLbUQP+PlVdX1g8hTOuOwm3jkUIl+9iLw=;
 b=R8kDGE1pBHbw1+NjdvyUURQj6CoA19VnYi4/lqPLmPK8c6IhNxlGIe3tIOg5jdgOce1W0K
 Zti/hpAQl3Qjz5nA8aKeqlY3FxVrGxEDCh8EuO0guJa2nDUPCRrDeP4yhXBBRgaN/qtpHF
 BCcuMUn/0ahq/DBzeMIjZuVf9bJEbF4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-qxuiPjlKNGuRa17fPkKm7g-1; Wed, 07 Oct 2020 08:49:11 -0400
X-MC-Unique: qxuiPjlKNGuRa17fPkKm7g-1
Received: by mail-wm1-f70.google.com with SMTP id p17so468582wmi.7
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 05:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tghQrHH2fhtLbUQP+PlVdX1g8hTOuOwm3jkUIl+9iLw=;
 b=X7jfKnqcbaC7oyz9fYvCRWiOsXwHGTrwQV6Hh+1FHMvpTTSz42iOjGtC0VcooaYzWa
 K3a0ZTlL4iC55cJ7Vv5fGvQ0gNHwvsj0c/MzkbbTFMy1qHEJq16+bHRDkt1zt+xR2oud
 GBJmYI0JKA5MlCV0EH6X4KRsMh++AAGjxjCBtd/x9+8T7J49FNAIdGS7FEPEINuq8Njr
 Igi7o3Br9avWqbVbFkvkYpGzLm3qPSTxNWQp2OlkedcMupDnFJuB0xN5476Y6jdT697+
 4lZkYZYMYb3L5n66FTfA5EQSHWqT3WGuhsLa3bpfWG0JazyQ+fEyqfY29ZdRxnF74khr
 tWZg==
X-Gm-Message-State: AOAM531SNLae1ITpg/btqDZGKc2RDECvKXMmHUnU5kGF/gbTlKa/kQly
 7DR42o93Jj+0sllfeNns92ilsK+x4+C2is9n/eiA9zLjZmwce3VfeKq/DXcW/V77Va3x6aUMUjl
 Sq+oYoMkYT5ct5Fo=
X-Received: by 2002:adf:f34a:: with SMTP id e10mr3337640wrp.91.1602074950452; 
 Wed, 07 Oct 2020 05:49:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDA2p0pXLolJKs/Ir62xtUk9VHEZcyEr3XPoXyEW5Eg6Sa6+Nq/VPDHCcnivbVRQmR4UEcAA==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr3337618wrp.91.1602074950213; 
 Wed, 07 Oct 2020 05:49:10 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j206sm2758411wmj.5.2020.10.07.05.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 05:49:09 -0700 (PDT)
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
Message-ID: <c5e6f7ea-93c4-a46a-dfee-7699c08c1060@redhat.com>
Date: Wed, 7 Oct 2020 14:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d86c9425-dcb2-7fa7-1f6f-bd7b8dab53c1@ispras.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 2:20 PM, Pavel Dovgalyuk wrote:
> On 07.10.2020 14:22, Alex Bennée wrote:
>>
>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>
>>> On 10/7/20 10:51 AM, Pavel Dovgalyuk wrote:
>>>> On 07.10.2020 11:23, Thomas Huth wrote:
>>>>> On 07/10/2020 09.13, Philippe Mathieu-Daudé wrote:
>>>>> Thanks, that was helpful. ... and the winner is:
>>>>>
>>>>>       commit   55adb3c45620c31f29978f209e2a44a08d34e2da
>>>>>       Author:  John Snow <jsnow@redhat.com>
>>>>>       Date:    Fri Jul 24 01:23:00 2020 -0400
>>>>>       Subject: ide: cancel pending callbacks on SRST
>>>>>
>>>>> ... starting with this commit, the tests starts failing. John, any
>>>>> idea what
>>>>> might be causing this?
>>>>
>>>> This patch includes the following lines:
>>>>
>>>> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>>>> +                                ide_bus_perform_srst, bus);
>>>>
>>>> replay_bh_schedule_oneshot_event should be used instead of this
>>>> function, because it synchronizes non-deterministic BHs.
>>>
>>> Why do we have 2 different functions? BH are already complex
>>> enough, and we need to also think about the replay API...
>>>
>>> What about the other cases such vhost-user (blk/net), virtio-blk?
>>
>> This does seem like something that should be wrapped up inside
>> aio_bh_schedule_oneshot itself or maybe we need a
>> aio_bh_schedule_transaction_oneshot to distinguish it from the other
>> uses the function has.
>>
> 
> Maybe there should be two functions:
> - one for the guest modification

aio_bh_schedule_oneshot_deterministic()?

> - one for internal qemu things

Not sure why there is a difference, BH are used to
avoid delaying the guest, so there always something
related to "guest modification".

> 
> The first one may be implemented though the rr+second one.
> Maybe replay_ prefix is confusing and the whole BH interface should look
> like that?

Yes, but it would be safer/clearer if we don't need to use
a replay_ API.

Can we embed these functions?

- replay_bh_schedule_event
- replay_bh_schedule_oneshot_event

If compiled without rr, events_enabled=false and
compiler can optimize:

-- >8 --
diff --git a/util/async.c b/util/async.c
index f758354c6a..376b6d4e27 100644
--- a/util/async.c
+++ b/util/async.c
@@ -109,14 +109,19 @@ static QEMUBH *aio_bh_dequeue(BHList *head,
unsigned *flags)

 void aio_bh_schedule_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
 {
-    QEMUBH *bh;
-    bh = g_new(QEMUBH, 1);
-    *bh = (QEMUBH){
-        .ctx = ctx,
-        .cb = cb,
-        .opaque = opaque,
-    };
-    aio_bh_enqueue(bh, BH_SCHEDULED | BH_ONESHOT);
+    if (events_enabled) {
+        replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb,
+                         opaque, replay_get_current_icount());
+    } else {
+        QEMUBH *bh;
+        bh = g_new(QEMUBH, 1);
+        *bh = (QEMUBH){
+            .ctx = ctx,
+            .cb = cb,
+            .opaque = opaque,
+        };
+        aio_bh_enqueue(bh, BH_SCHEDULED | BH_ONESHOT);
+    }
 }

 QEMUBH *aio_bh_new(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
@@ -178,7 +183,12 @@ void qemu_bh_schedule_idle(QEMUBH *bh)

 void qemu_bh_schedule(QEMUBH *bh)
 {
-    aio_bh_enqueue(bh, BH_SCHEDULED);
+    if (events_enabled) {
+        replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL,
+                         replay_get_current_icount());
+    } else {
+        aio_bh_enqueue(bh, BH_SCHEDULED);
+    }
 }

---

> 
> 
> Pavel Dovgalyuk
> 


