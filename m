Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEA6FC6197
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 22:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AED214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 22:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLSO52VX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AED214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTCsL-00064a-SU
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 17:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iTCrQ-0005ba-AW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 17:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iTCrL-0004u3-1O
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 17:36:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iTCrJ-0004qd-2z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 17:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573252558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moAtDuigkwzcvqoNRU08CvZ+sgnZEt6hznktzbeR3JY=;
 b=hLSO52VXbzL46WpByezjUdmskQGUMCtAT+6COfw1rP6ztHq5rpsYIR2301/8MKhxCABl8Q
 yQRqsCRKg68hwK5SHbb8WvGBc+HSVPET57MNiboUhkNTNUk5APN5AaDsV193/uACjmzS+5
 +lHPdnvM+7J3hkBQHCep37Pcw1HLEgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-TR8Uf5IcPgO2UsMssSGZWQ-1; Fri, 08 Nov 2019 17:35:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0A0C8017DE;
 Fri,  8 Nov 2019 22:35:53 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14B541A7E4;
 Fri,  8 Nov 2019 22:35:50 +0000 (UTC)
Subject: Re: [PULL 1/3] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191023020126.24991-1-eblake@redhat.com>
 <20191023020126.24991-2-eblake@redhat.com>
 <CAFEAcA_YYfyg4P6OXUo=w7ibM4pp-zbWT5ne+Eda3e7KfYFq+Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6c03d0c7-9b79-1933-5700-84282aa4b32e@redhat.com>
Date: Fri, 8 Nov 2019 16:35:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YYfyg4P6OXUo=w7ibM4pp-zbWT5ne+Eda3e7KfYFq+Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TR8Uf5IcPgO2UsMssSGZWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 12:42 PM, Peter Maydell wrote:
> On Wed, 23 Oct 2019 at 03:04, Eric Blake <eblake@redhat.com> wrote:
>>
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Introduce a function to gracefully wake a coroutine sleeping in
>> qemu_co_sleep_ns().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20191009084158.15614-2-vsementsov@virtuozzo.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Hi; Coverity reports an issue in this patch (CID 1406474):
>=20

>>=20
>> - * Yield the coroutine for a given duration
>> + * Yield the coroutine for a given duration. During this yield, @sleep_=
state
>> + * (if not NULL) is set to an opaque pointer, which may be used for
>> + * qemu_co_sleep_wake(). Be careful, the pointer is set back to zero wh=
en the
>> + * timer fires. Don't save the obtained value to other variables and do=
n't call
>> + * qemu_co_sleep_wake from another aio context.
>>   */
>> -void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);

Here, we document the rules on what will happen to *sleep_state (in=20
particular, since we store a stack local variable into it, the caller=20
must not leak it further, and it will be reclaimed back to zero before=20
this function finally finishes).

>> -void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
>> +void coroutine_fn qemu_co_sleep_ns_wakeable(QEMUClockType type, int64_t=
 ns,
>> +                                            QemuCoSleepState **sleep_st=
ate)
>>   {
>>       AioContext *ctx =3D qemu_get_current_aio_context();
>> -    QEMUTimer *ts;
>> -    Coroutine *co =3D qemu_coroutine_self();
>> +    QemuCoSleepState state =3D {
>> +        .co =3D qemu_coroutine_self(),
>> +        .ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &state)=
,
>> +        .user_state_pointer =3D sleep_state,
>> +    };
>=20
> Here 'state' is a variable on the stack...
>=20
>> -    const char *scheduled =3D atomic_cmpxchg(&co->scheduled, NULL, __fu=
nc__);
>> +    const char *scheduled =3D atomic_cmpxchg(&state.co->scheduled, NULL=
,
>> +                                           qemu_co_sleep_ns__scheduled)=
;
>>       if (scheduled) {
>>           fprintf(stderr,
>>                   "%s: Co-routine was already scheduled in '%s'\n",
>>                   __func__, scheduled);
>>           abort();
>>       }
>> -    ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, co);
>> -    timer_mod(ts, qemu_clock_get_ns(type) + ns);
>> +
>> +    if (sleep_state) {
>> +        *sleep_state =3D &state;
>=20
> ...here we save a pointer to it into *sleep_state which was
> passed to us by the caller...
>=20
>> +    }
>> +    timer_mod(state.ts, qemu_clock_get_ns(type) + ns);
>>       qemu_coroutine_yield();

And here is where we yield, which is the only point at which the caller=20
will see a non-zero value in *sleep_state in the first place, at which=20
point the caller must follow the rules we document.

>> -    timer_del(ts);
>> -    timer_free(ts);
>> +    timer_free(state.ts);
>=20
> ...and here we return from this function, which means 'state'
> is no longer in valid memory, but the caller has still been
> given a pointer to it.
>=20
>>   }
>=20
> Is this just Coverity getting confused by our coroutine code?
> (I certainly find it confusing...)

Yes, Coverity is unable to see that we require that the caller MUST obey=20
rules with the use of it's access to sleep_state. However, it might be=20
possible after the yield to assert(!sleep_state || *sleep_state =3D=3D NULL=
)=20
to prove that the caller's use of our temporary leak of a stack variable=20
was solely to get this coroutine to resume from yield, and that the=20
resumption cleared it, so that the end of the function is not leaking=20
anything.

I guess it's worth experimenting to see if such a patch would silence=20
Coverity without breaking the code...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


