Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF51ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3947F206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYGmZrn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3947F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFjA-0007zy-ON
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iI83u-000329-Ui
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iI83t-0005r1-Ga
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:15:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51694
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iI83t-0005pP-Cy
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570612512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=LnthtDy+kBjD5T6p/osgMCT9YrFI9qED9phS99dKGNY=;
 b=IYGmZrn+Y7PNDA6rC6gJxONNq4Q78YUAr6K2DMdAaez4UyhscJpUIpt/10uK4VvB3TNDmm
 VCr60vqHtszEhpg8ho+uIipGKXYBDlBpegFFll3Gcuxpvg4mDZjJSjjSVIO8lpZeWn+hkm
 dWsudNyl/97TLLDTkBfbTH0OOMXtvtw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-5-4RjutvMeWVqebn9BFteA-1; Wed, 09 Oct 2019 05:15:09 -0400
Received: by mail-wr1-f71.google.com with SMTP id f3so792752wrr.23
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 02:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d5tISs1KCHtwOyrKlMfPsxt9ttmffCaWBvnrP40d/kE=;
 b=DMbE9SuYGrY2QwbSbpnWcVr3G9ldqLmfPt4LObmS/E5iFUwMQXokw+NnWDh432lFhG
 EHhtAqFlXR+yZyaIagJH2oaJh+zPYgO7WlCiQelH+0m6IjzUmlTKZlshRGPfAAabt+z/
 jYaS//616Yn75tKhF4LfDj0qmO3WOH+6qU13HBPdtSBF4YheWQDwoDbexBxzSH/lsrig
 g6Xw48nmrVAxwAukNtlw/byDJ3Nnq9Jj7R7ZKYmJOdOXPyw0lEEArCAFCUB9GyCcRiQz
 Fym3mDcpqfVqAhmttjbqYWW8nfPee4w7ejvq8WVlH2GJsD3osa6c83VmL/wtlTUl6GgQ
 gOng==
X-Gm-Message-State: APjAAAVc7C4j1cSX522UY5snkNcEY6nPKFZoJepuK7jCLhD3QDJQrBqX
 EcthzNWLo6pyAhRTjo9vBXKbPQrdfZBeW/vBkOyfL9GOmxyLH7umSNnShP3wZNAOh8eeSVsIxFU
 mnUUAo+UijGiJsP4=
X-Received: by 2002:adf:fd46:: with SMTP id h6mr1894908wrs.243.1570612507681; 
 Wed, 09 Oct 2019 02:15:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUVHG6n1HgfZB42/8Taipbw81fl/fH5o9I75fEaObZj1lOGD8vaabkYF29hWK9BWlnfx1CCw==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr1894891wrs.243.1570612507348; 
 Wed, 09 Oct 2019 02:15:07 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 63sm2388645wri.25.2019.10.09.02.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 02:15:06 -0700 (PDT)
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
To: Jan Glauber <jglauber@marvell.com>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
 <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
 <20191007144432.GA29958@xps13.dannf>
 <065a52a9-5bb0-1259-6c73-41af60e0a05d@redhat.com> <20191009080220.GA2905@hc>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d5367b2a-84ee-1211-a2dc-7d631c94fe3f@redhat.com>
Date: Wed, 9 Oct 2019 11:15:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009080220.GA2905@hc>
Content-Language: en-US
X-MC-Unique: 5-4RjutvMeWVqebn9BFteA-1
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
 lizhengui <lizhengui@huawei.com>, dann frazier <dann.frazier@canonical.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/19 10:02, Jan Glauber wrote:
> On Mon, Oct 07, 2019 at 04:58:30PM +0200, Paolo Bonzini wrote:
>> On 07/10/19 16:44, dann frazier wrote:
>>> On Mon, Oct 07, 2019 at 01:06:20PM +0200, Paolo Bonzini wrote:
>>>> On 02/10/19 11:23, Jan Glauber wrote:
>>>>> I've looked into this on ThunderX2. The arm64 code generated for the
>>>>> atomic_[add|sub] accesses of ctx->notify_me doesn't contain any
>>>>> memory barriers. It is just plain ldaxr/stlxr.
>>>>>
>>>>> From my understanding this is not sufficient for SMP sync.
>>>>>
>>>>> If I read this comment correct:
>>>>>
>>>>>     void aio_notify(AioContext *ctx)
>>>>>     {
>>>>>         /* Write e.g. bh->scheduled before reading ctx->notify_me.  P=
airs
>>>>>          * with atomic_or in aio_ctx_prepare or atomic_add in aio_pol=
l.
>>>>>          */
>>>>>         smp_mb();
>>>>>         if (ctx->notify_me) {
>>>>>
>>>>> it points out that the smp_mb() should be paired. But as
>>>>> I said the used atomics don't generate any barriers at all.
>>>>
>>>> Based on the rest of the thread, this patch should also fix the bug:
>>>>
>>>> diff --git a/util/async.c b/util/async.c
>>>> index 47dcbfa..721ea53 100644
>>>> --- a/util/async.c
>>>> +++ b/util/async.c
>>>> @@ -249,7 +249,7 @@ aio_ctx_check(GSource *source)
>>>>      aio_notify_accept(ctx);
>>>> =20
>>>>      for (bh =3D ctx->first_bh; bh; bh =3D bh->next) {
>>>> -        if (bh->scheduled) {
>>>> +        if (atomic_mb_read(&bh->scheduled)) {
>>>>              return true;
>>>>          }
>>>>      }
>>>>
>>>>
>>>> And also the memory barrier in aio_notify can actually be replaced
>>>> with a SEQ_CST load:
>>>>
>>>> diff --git a/util/async.c b/util/async.c
>>>> index 47dcbfa..721ea53 100644
>>>> --- a/util/async.c
>>>> +++ b/util/async.c
>>>> @@ -349,11 +349,11 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx=
)
>>>> =20
>>>>  void aio_notify(AioContext *ctx)
>>>>  {
>>>> -    /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
>>>> -     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
>>>> +    /* Using atomic_mb_read ensures that e.g. bh->scheduled is writte=
n before
>>>> +     * ctx->notify_me is read.  Pairs with atomic_or in aio_ctx_prepa=
re or
>>>> +     * atomic_add in aio_poll.
>>>>       */
>>>> -    smp_mb();
>>>> -    if (ctx->notify_me) {
>>>> +    if (atomic_mb_read(&ctx->notify_me)) {
>>>>          event_notifier_set(&ctx->notifier);
>>>>          atomic_mb_set(&ctx->notified, true);
>>>>      }
>>>>
>>>>
>>>> Would you be able to test these (one by one possibly)?
>>>
>>> Paolo,
>>>   I tried them both separately and together on a Hi1620 system, each
>>> time it hung in the first iteration. Here's a backtrace of a run with
>>> both patches applied:
>>
>> Ok, not a great start...  I'll find myself an aarch64 machine and look
>> at it more closely.  I'd like the patch to be something we can
>> understand and document, since this is probably the second most-used
>> memory barrier idiom in QEMU.
>>
>> Paolo
>=20
> I'm still not sure what the actual issue is here, but could it be some ba=
d
> interaction between the notify_me and the list_lock? The are both 4 byte
> and side-by-side:
>=20
> address notify_me: 0xaaaadb528aa0  sizeof notify_me: 4
> address list_lock: 0xaaaadb528aa4  sizeof list_lock: 4
>=20
> AFAICS the generated code looks OK (all load/store exclusive done
> with 32 bit size):
>=20
>      e6c:       885ffc01        ldaxr   w1, [x0]
>      e70:       11000821        add     w1, w1, #0x2
>      e74:       8802fc01        stlxr   w2, w1, [x0]
>=20
> ...but if I bump notify_me size to uint64_t the issue goes away.

Ouch. :)  Is this with or without my patch(es)?

Also, what if you just add a dummy uint32_t after notify_me?

Thanks,

Paolo

>=20
> BTW, the image file I convert in the testcase is ~20 GB.
>=20
> --Jan
>=20
> diff --git a/include/block/aio.h b/include/block/aio.h
> index a1d6b9e24939..e8a5ea3860bb 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -83,7 +83,7 @@ struct AioContext {
>       * Instead, the aio_poll calls include both the prepare and the
>       * dispatch phase, hence a simple counter is enough for them.
>       */
> -    uint32_t notify_me;
> +    uint64_t notify_me;
> =20
>      /* A lock to protect between QEMUBH and AioHandler adders and delete=
r,
>       * and to ensure that no callbacks are removed while we're walking a=
nd
>=20


