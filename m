Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464EDECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB7D206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyJfKe+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB7D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHUTm-00048N-5D
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iHUT2-0003cB-PO
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iHUT1-0007UT-KF
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:58:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iHUT1-0007U0-Fd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570460311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=tKZ33DSZsGqjTRY3gdqK/IVj5yNkikr/SyCxI8liW68=;
 b=iyJfKe+gY20XQ/WirMZn7Flj+XwP3qCcmvjyMFR6RFdmloq8gxwMQI1wA0Bg2N7e8zKwSD
 JqYkDfmKM1FWOT1hsOocFc4nkCQ+LKlziUa/yMzvWDZFPulDQ0g6xuxU5Wu5+V/XedK1W9
 Hzt6BYPdSB8P6PHBqaR6U0f/SMDtwkU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-jRut0YsOPOiiMdLWv19hLg-1; Mon, 07 Oct 2019 10:58:29 -0400
Received: by mail-wm1-f72.google.com with SMTP id q9so6316781wmj.9
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 07:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=opDJaK1LOGeNR0h+y8//yRChbBH/T0RfjhSqu/HvGUY=;
 b=iw7eC0qJE077r4zocLPsC+Gd8Q9hXK/xYwWlHNNrL8C80mgoJwkOUQ3hWpm+Z0q0Xd
 X519fMnbDZhPP6R7vBzrBelvQhkccrXbpS1PgxTS89z+NTiTWeq17R2eU/3GxiELiDej
 PC9nzR5woTuRlhwvD0we3TkMVoA8SfhAmTcMf3MhOkZyhQTnqMVHFlbSRTG3Pp3FlfGw
 dOQO69vMdtMSqKu27x/29RwzArvXEp2WyjvjDfVKUUyqOV/oB9UzVSqTTUtK0bu7uvpy
 HFYdTPsrz6qVHDWW3mUzsRl9e3QhCtDFSd8dnP9bsurMFPsDXiPi6Q8ire1IQN1iddEM
 vC8w==
X-Gm-Message-State: APjAAAUawxzOQyHXgCBw/qVFsdMibjmFuJAL9BUE64FAl0GbekpM97Zk
 WJ6Y58c4ftCt0ssJ97TrkWBFKaNW2yN/8i3Dd5Phwt+hjhx0IE+qoewCh8IRSWLOP7lfgIb5x4C
 VeqQW/ZP/f9Sxc+E=
X-Received: by 2002:a5d:660c:: with SMTP id n12mr23865418wru.286.1570460307924; 
 Mon, 07 Oct 2019 07:58:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYuZcDCJJT0zavvKiFPf1mDtotJSHk//Q8VZi8pb7sN/m710RQIGZOUODlG1mvrQENHa2mJA==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr23865393wru.286.1570460307616; 
 Mon, 07 Oct 2019 07:58:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2?
 ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
 by smtp.gmail.com with ESMTPSA id q10sm43364861wrd.39.2019.10.07.07.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 07:58:26 -0700 (PDT)
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
To: dann frazier <dann.frazier@canonical.com>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
 <20191007144432.GA29958@xps13.dannf>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <065a52a9-5bb0-1259-6c73-41af60e0a05d@redhat.com>
Date: Mon, 7 Oct 2019 16:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191007144432.GA29958@xps13.dannf>
Content-Language: en-US
X-MC-Unique: jRut0YsOPOiiMdLWv19hLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 lizhengui <lizhengui@huawei.com>, Jan Glauber <jglauber@marvell.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/19 16:44, dann frazier wrote:
> On Mon, Oct 07, 2019 at 01:06:20PM +0200, Paolo Bonzini wrote:
>> On 02/10/19 11:23, Jan Glauber wrote:
>>> I've looked into this on ThunderX2. The arm64 code generated for the
>>> atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
>>> memory barriers. It is just plain ldaxr/stlxr.
>>>
>>> From my understanding this is not sufficient for SMP sync.
>>>
>>> If I read this comment correct:
>>>
>>>     void aio_notify(AioContext *ctx)
>>>     {
>>>         /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pai=
rs
>>>          * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
>>>          */
>>>         smp_mb();
>>>         if (ctx->notify_me) {
>>>
>>> it points out that the smp_mb() should be paired. But as
>>> I said the used atomics don't generate any barriers at all.
>>
>> Based on the rest of the thread, this patch should also fix the bug:
>>
>> diff --git a/util/async.c b/util/async.c
>> index 47dcbfa..721ea53 100644
>> --- a/util/async.c
>> +++ b/util/async.c
>> @@ -249,7 +249,7 @@ aio_ctx_check(GSource *source)
>>      aio_notify_accept(ctx);
>> =20
>>      for (bh =3D ctx->first_bh; bh; bh =3D bh->next) {
>> -        if (bh->scheduled) {
>> +        if (atomic_mb_read(&bh->scheduled)) {
>>              return true;
>>          }
>>      }
>>
>>
>> And also the memory barrier in aio_notify can actually be replaced
>> with a SEQ_CST load:
>>
>> diff --git a/util/async.c b/util/async.c
>> index 47dcbfa..721ea53 100644
>> --- a/util/async.c
>> +++ b/util/async.c
>> @@ -349,11 +349,11 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
>> =20
>>  void aio_notify(AioContext *ctx)
>>  {
>> -    /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
>> -     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
>> +    /* Using atomic_mb_read ensures that e.g. bh->scheduled is written =
before
>> +     * ctx->notify_me is read.  Pairs with atomic_or in aio_ctx_prepare=
 or
>> +     * atomic_add in aio_poll.
>>       */
>> -    smp_mb();
>> -    if (ctx->notify_me) {
>> +    if (atomic_mb_read(&ctx->notify_me)) {
>>          event_notifier_set(&ctx->notifier);
>>          atomic_mb_set(&ctx->notified, true);
>>      }
>>
>>
>> Would you be able to test these (one by one possibly)?
>=20
> Paolo,
>   I tried them both separately and together on a Hi1620 system, each
> time it hung in the first iteration. Here's a backtrace of a run with
> both patches applied:

Ok, not a great start...  I'll find myself an aarch64 machine and look
at it more closely.  I'd like the patch to be something we can
understand and document, since this is probably the second most-used
memory barrier idiom in QEMU.

Paolo


