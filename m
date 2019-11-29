Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5991C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 20:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FC3215A5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 20:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJtCqwVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FC3215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iamYL-0003y1-Mv
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 15:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iamUs-0002C4-N0
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iamUl-0002qe-Ds
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:04:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iamUk-0002fU-Sg
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 15:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575057839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RMyPASDu52/Bk8jkd4mz7vUq+gUIrFzUrlcVphcXFs=;
 b=hJtCqwVXzdfwzKLTKYl1Ie361LNmnTua1bgEG3Wsx8399YDsMuEVH0dLKFU5h8eev04nmY
 5pEpSLZJWl3zUe8lOKEYD0GOopOdJc3VY2fDonyiUjwX2rwulfI5XCv4cNNPvpADJbG8yS
 Mo7oT0GZwaNUmHzlbDbyZcN9YJ8GAH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-pBXU41WQOqu1HVOKS2aWvQ-1; Fri, 29 Nov 2019 15:03:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AA61107ACC4;
 Fri, 29 Nov 2019 20:03:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8543860BF4;
 Fri, 29 Nov 2019 20:03:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02DF41138606; Fri, 29 Nov 2019 21:03:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] hw/core/loader-fit: fix freeing errp in fit_load_fdt
References: <20191127183016.13852-1-vsementsov@virtuozzo.com>
 <87muceeq5l.fsf@dusky.pond.sub.org>
 <4fcd8245-790e-220d-366b-ce25743dddc8@virtuozzo.com>
 <48c23c62-59ed-3da7-4803-cafd14b8fe49@virtuozzo.com>
 <87tv6mbta9.fsf@dusky.pond.sub.org>
 <988bff55-1f94-ac29-6193-7de13b2feca0@virtuozzo.com>
Date: Fri, 29 Nov 2019 21:03:54 +0100
In-Reply-To: <988bff55-1f94-ac29-6193-7de13b2feca0@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 29 Nov 2019 15:32:53 +0000")
Message-ID: <874kymv49h.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: pBXU41WQOqu1HVOKS2aWvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 29.11.2019 18:23, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>=20
>>> 29.11.2019 17:11, Vladimir Sementsov-Ogievskiy wrote:
>>>> 29.11.2019 17:03, Markus Armbruster wrote:
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> fit_load_fdt forget to check that errp is not NULL and to zero it af=
ter
>>>>>> freeing. Fix it.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>>> ---
>>>>>>  =C2=A0 hw/core/loader-fit.c | 5 ++++-
>>>>>>  =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
>>>>>> index 953b16bc82..3ee9fb2f2e 100644
>>>>>> --- a/hw/core/loader-fit.c
>>>>>> +++ b/hw/core/loader-fit.c
>>>>>> @@ -200,7 +200,10 @@ static int fit_load_fdt(const struct fit_loader=
 *ldr, const void *itb,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D fit_image_addr(itb, img_off,=
 "load", &load_addr, errp);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err =3D=3D -ENOENT) {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 load_addr =
=3D ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(*errp);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (errp) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
error_free(*errp);
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
*errp =3D NULL;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (err) {
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepen=
d(errp, "unable to read FDT load address from FIT: ");
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D err;
>>>>>
>>>>> This fixes latent bugs when fit_image_addr() fails with ENOENT:
>>>>>
>>>>> * If a caller passes a null @errp, we crash dereferencing it
>>>>>
>>>>> * Else, we pass a dangling Error * to the caller, and return success.
>>>>>  =C2=A0=C2=A0 If a caller dereferences the Error * regardless, we hav=
e a
>>>>>  =C2=A0=C2=A0 use-after-free.
>>>>>
>>>>> Not fixed:
>>>>>
>>>>> * If a caller passes &error_abort or &error_fatal, we die instead of
>>>>>  =C2=A0=C2=A0 taking the recovery path.
>>>>
>>>> No, if it is error_abort or error_fatal, we will not reach this point,=
 the execution
>>>> finished before, when error was set.
>>>
>>> Ah, that is what you mention.. Hmm. Is it bad? At least crashing on
>>> error_abort without any recovery should not be bad..
>>=20
>> Latent bugs aren't bad, but they could possibly become bad :)
>>=20
>> When you pass &err to fit_load_fdt(), where @err is a local variable,
>> the ENOENT case is not actually an error; fit_load_fdt() recovers fine
>> and succeeds.
>>=20
>> When you pass &error_fatal or &error_abort, it should likewise not be an
>> error.
>
> Ah, yes, understand now.
>
> Interesting, that auto-propageted errp will not catch this. It will only
> help with error_fatal, but not with error_abort..
>
> So, in this case we should wrap error_abort too. And it in every function=
 that
> uses error_free.
>
> And this means, that in this case we can't make error_abort crash at poin=
t where
> actual error occures. That is very sad.

If your patches improve &error_abort's backtrace except for the (few)
functions calling error_free(), then I'd call the situation "a bit sad"
at most :)

[...]


