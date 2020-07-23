Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A40C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F04D20709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTeKr63i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F04D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jybGS-0002Zs-IC
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jybFG-0001u8-Vu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:26:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1jybFF-00059b-6f
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595510804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsuW2IYAm7iG04hVrqoIjBWeUpa8M0SwjPjdtwCzwqw=;
 b=ZTeKr63iKlURpXtbUlxBUatwbTe2emu55C7FCHOu/hOesb7wQ9O/H2+IKxQNKg6tG/HiH6
 xVVhjbB6bHzZi+K1rvL/YkJHPg5+w9PK2eDTfzV7JbsIlLR6U9GqnW8l6QdE3CXYcaqT6W
 4o3TAIUKFLO+ioIXF9TteGxALlLr2t8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-q-boJGTwNK6eIf5VLHn_mQ-1; Thu, 23 Jul 2020 09:26:42 -0400
X-MC-Unique: q-boJGTwNK6eIf5VLHn_mQ-1
Received: by mail-ej1-f69.google.com with SMTP id e7so2405543ejj.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 06:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hsuW2IYAm7iG04hVrqoIjBWeUpa8M0SwjPjdtwCzwqw=;
 b=NWUzOiYKGZK3cMYHveuzb/8sqTICmMvYGDJYU+HB3EPmeyi0nucURuD/ljraGGZbPi
 phup4XtHGWqlQjQNBlAJ+c+vUCib+4EkPhYKHUlouUCXY9TUUERYux/n9qtJvJqI0bW+
 6n6wp6l9RSFrqJrNOTJn3O7YSuL0VlTmGY7TmiWqQnnYfFUnrIuvuYlhLSNbGvloSyzG
 qb4W3lYoqFZt4cq1zRXDUVBlKpFOX+XS7FK7/u6jt8WMKSO4x+5izDFys+/WroAXPeFT
 vthRycqverG8OvzlSOQm65OOnQWYya7gGfUHZd0yKb66TUIOo2FHImJhjJHYrtbhnWhC
 Smbw==
X-Gm-Message-State: AOAM531/oau/4cwO0BGxKfygctXB70pO/asFVgxRlG9yJPwlFZsvFZjQ
 16Qwbz/iaWdT6FqUvvM8eJsATswmSCO7+pduDaWXtJto48BpXBucqPfHAm+gdX7QnbfAk2sMg5e
 zQNYTfs0sL08pJOs=
X-Received: by 2002:a17:906:57c5:: with SMTP id
 u5mr4220145ejr.311.1595510801143; 
 Thu, 23 Jul 2020 06:26:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbNCU0Lf8cTRG+yBJJKgTwwc9rj7NjUyQIScNzypoGX/XIRpSJ+i3e5JFFXc+5YV8K25OYNQ==
X-Received: by 2002:a17:906:57c5:: with SMTP id
 u5mr4220127ejr.311.1595510800904; 
 Thu, 23 Jul 2020 06:26:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id f17sm2021875ejr.71.2020.07.23.06.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 06:26:40 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: 5.1.0-rc1 regression: reset fails with kvm and -cpu host
In-Reply-To: <60af679d-8c7d-cc37-344b-79aa193df166@siemens.com>
References: <bf007af9-f81e-3542-0237-5ea467f34377@siemens.com>
 <20200722173513.GO1274972@habkost.net>
 <7be95bd6-dfc6-2c22-85a1-a1c932d07fdd@siemens.com>
 <20200722204731.GP1274972@habkost.net> <20200722212159.GQ1274972@habkost.net>
 <20200723084026.GB2622@work-vm>
 <3eba2f87-5527-bd7c-2eb7-ce67cb32d9ef@redhat.com>
 <87pn8mo20i.fsf@vitty.brq.redhat.com> <20200723125223.GI2621@work-vm>
 <60af679d-8c7d-cc37-344b-79aa193df166@siemens.com>
Date: Thu, 23 Jul 2020 15:26:39 +0200
Message-ID: <87mu3qnz00.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 23.07.20 14:52, Dr. David Alan Gilbert wrote:
>> * Vitaly Kuznetsov (vkuznets@redhat.com) wrote:
>>> Philippe Mathieu-DaudÃ© <philmd@redhat.com> writes:
>>>
>>>> +Vitaly
>>>>
>>>> On 7/23/20 10:40 AM, Dr. David Alan Gilbert wrote:
>>>>> * Eduardo Habkost (ehabkost@redhat.com) wrote:
>>>>>> On Wed, Jul 22, 2020 at 04:47:32PM -0400, Eduardo Habkost wrote:
>>>>>>> On Wed, Jul 22, 2020 at 08:05:01PM +0200, Jan Kiszka wrote:
>>>>>>>> On 22.07.20 19:35, Eduardo Habkost wrote:
>>>>>>>>> Hi Jan,
>>>>>>>>>
>>>>>>>>> What was the last version where it worked for you?  Does using
>>>>>>>>> "-cpu host,-vmx" help?
>>>>>>>>
>>>>>>>> Yeah, -vmx does indeed help.
>>>>>>>>
>>>>>>>> I didn't have the time to bisect yet. Just check my reflog, picked
>>>>>>>> eb6490f544, and that works.
>>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>> I could reproduce it locally[1], I will bisect it.
>>>>>>>
>>>>>>> The good news is that "-cpu host,+vmx" still works, on commit
>>>>>>> eb6490f544.
>>>>>>>
>>>>>>> [1] Linux 5.6.19-300.fc32.x86_64, Intel Core i7-8665U CPU.
>>>>>>
>>>>>> Bisected to:
>>>>>>
>>>>>> commit b16c0e20c74218f2d69710cedad11da7dd4d2190
>>>>>> Author: Paolo Bonzini <pbonzini@redhat.com>
>>>>>> Date:   Wed May 20 10:49:22 2020 -0400
>>>>>>
>>>>>>      KVM: add support for AMD nested live migration
>>>>>>
>>>>>>      Support for nested guest live migration is part of Linux 5.8, add the
>>>>>>      corresponding code to QEMU.  The migration format consists of a few
>>>>>>      flags, is an opaque 4k blob.
>>>>>>
>>>>>>      The blob is in VMCB format (the control area represents the L1 VMCB
>>>>>>      control fields, the save area represents the pre-vmentry state; KVM does
>>>>>>      not use the host save area since the AMD manual allows that) but QEMU
>>>>>>      does not really care about that.  However, the flags need to be
>>>>>>      copied to hflags/hflags2 and back.
>>>>>>
>>>>>>      In addition, support for retrieving and setting the AMD nested virtualization
>>>>>>      states allows the L1 guest to be reset while running a nested guest, but
>>>>>>      a small bug in CPU reset needs to be fixed for that to work.
>>>>>>
>>>>>>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>>
>>>>> Guesswork led me to try reverting the chunk in kvm_put_nested_state;
>>>>> without it the reset seems to work; I can't explain that code though.
>>>>>
>>>
>>> (sorry, missed the beginning of the discussion)
>>>
>>> So one does:
>>>
>>> (qemu) system_reset
>>>
>>> on Intel wiht '-cpu host' and the result is:
>>>
>>> (qemu) KVM: entry failed, hardware error 0x80000021
>> 
>> Interesting; I hadn't seen that error - I just see a hard hung guest
>> rather than a reset one.
>
> I've seen it once or twice, maybe that was also with a more complex 
> command line. The point is that an invalid state is very likely loaded 
> on reset. Not all invalid states cause KVM to complain, though. Some 
> just lock up the guest.

This depends on whether the guest has performed VMXON or not I believe.

Anyways, I *think* the fix will be:

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2b6b744..75c2e68 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3883,7 +3883,7 @@ static int kvm_put_nested_state(X86CPU *cpu)
     } else {
         env->nested_state->flags &= ~KVM_STATE_NESTED_GUEST_MODE;
     }
-    if (env->hflags2 & HF2_GIF_MASK) {
+    if (cpu_has_svm(env) && (env->hflags2 & HF2_GIF_MASK)) {
         env->nested_state->flags |= KVM_STATE_NESTED_GIF_SET;
     } else {
         env->nested_state->flags &= ~KVM_STATE_NESTED_GIF_SET;

As "KVM_STATE_NESTED_GIF_SET" is not relevant to nVMX, this works for me
but let me explore kernel side of this a bit more.

-- 
Vitaly


