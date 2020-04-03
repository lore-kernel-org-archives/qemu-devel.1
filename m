Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2375F206F5
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gz/0S2Ox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2375F206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKGT2-0002I9-8i
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jKGSN-0001rT-UA
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jKGSM-0007LI-5L
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:09:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54046
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jKGSL-0007Ia-Vq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585897772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jhtCOwt5am9z+PHZtAPPvk/K/7tKyqoyZeiFIAO1V5w=;
 b=Gz/0S2OxE0eV3uZoYOSLYL4mQbVWBdIsJBIIAUgJUmoNxT+4JBaimOPGDsMGqsp2B/cUjH
 Ul/hooMv9Of0580pp0MPmvH7wuWq8MPM241vDgiOBwUOnxUUsE9bG5tYW3ohX1HuQkOwYk
 DpQA1z+8bQ6Y5y/e8qnGdCSsSnaK9ZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-IJuazVP6N1-rJUAJYkHK9A-1; Fri, 03 Apr 2020 03:09:31 -0400
X-MC-Unique: IJuazVP6N1-rJUAJYkHK9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB61613F6;
 Fri,  3 Apr 2020 07:09:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86F8494960;
 Fri,  3 Apr 2020 07:09:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E234611385E2; Fri,  3 Apr 2020 09:09:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <a3ca8c60-dd83-ea7b-c268-0c94e441bb52@virtuozzo.com>
 <alpine.BSF.2.22.395.2004021132270.75834@zero.eik.bme.hu>
 <53df0069-8a7a-9de8-29cb-21362d88bb4e@virtuozzo.com>
 <87pncq0xdt.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2004021716130.78264@zero.eik.bme.hu>
Date: Fri, 03 Apr 2020 09:09:27 +0200
In-Reply-To: <alpine.BSF.2.22.395.2004021716130.78264@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Thu, 2 Apr 2020 17:28:15 +0200 (CEST)")
Message-ID: <875zeht594.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Thu, 2 Apr 2020, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>> 02.04.2020 12:36, BALATON Zoltan wrote:
[...]
>>>> Not much better. Could it be something like:
[...]
>>>>  =C2=A0=C2=A0=C2=A0 ERRP_RET(object_property_set_link(cpuobj, OBJECT(&=
s->cpu_container[i]),
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "memory", errp));
>>>>  =C2=A0=C2=A0=C2=A0 ERRP_RET(object_property_set_link(cpuobj, OBJECT(s=
), "idau", errp));
>>>>  =C2=A0=C2=A0=C2=A0 ERRP_RET(object_property_set_bool(cpuobj, true, "r=
ealized", errp));
>>>>
>>>
>>> and turn all
>>>
>>> ret =3D func(...);
>>> if (ret < 0) {
>>>     return ret;
>>> }
>>>
>>> into
>>>
>>> FAIL_RET(func(...))
>>>
>>> ?
>>>
>>> Not a problem to make such macro.. But I think it's a bad idea to turn =
all the code
>>> into sequence of macro invocations. It's hard to debug and follow.
>>
>> Yes.  Hiding control flow in macros is almost always too much magic.
>> There are exceptions, but this doesn't look like one.
>
> I did't like this idea of mine too much either so I agree but I see no
> other easy way to simplify this. If you propose changing function
> return values maybe these should return errp instead of passing it as
> a func parameter? Could that result in simpler code and less macro
> magic needed?

I don't think so.  Let's compare a few error handling patterns from
error.h.

 * Call a function and receive an error from it:
 *     Error *err =3D NULL;
 *     foo(arg, &err);
 *     if (err) {
 *         handle the error...
 *     }

Making foo() return the error object instead of void looks like an
obvious win:

       if (foo(arg)) {
           handle the error...
       }

Except it does not work, because surely a use of @err is hiding in
"handle the error" (or else we'd leak it).  So you actually need

       err =3D foo(arg)
       if (err) {
           handle the error...
       }

All this saves you is initializing @err.

You can save a bit more

       if ((err =3D foo(arg))) {
           handle the error...
       }

We generally frown upon assignemnts within if controlling expressions.

Next:

 * Receive an error and pass it on to the caller:
 [...]
 * But when all you do with the error is pass it on, please use
 *     foo(arg, errp);
 * for readability.

The obvious conversion

       *errp =3D foo(arg);

is wrong for !errp, errp =3D=3D &error_fatal, and errp =3D=3D &error_abort.
You'd need

       err =3D foo(arg);
       error_propagate(errp, err);

or, if you're so inclined

       error_propagate(errp, foo(arg));

Less legible, and it creates and destroys error objects where the
current method doesn't.

Returning the error object is even less attractive for functions that
now return values.


