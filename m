Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B58FC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F4524659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqf+Hsa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F4524659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFaC-0000sp-GU
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1idEak-0005xc-Qh
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1idEai-00077m-FD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:28:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1idEai-0006za-8h
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdFKK2D/fl5jWJGqYyo+KYqGwUGNXkUYr1F7LSEI+FE=;
 b=dqf+Hsa3sq/ZyvyyJKFHcfVAk8LBQQgp7T+6Cj72kr1yg/sYCWqCUDB7stDGfZ64Xxc9v0
 EmXVgoPyAdjbHt6F1feGkFA574CXIULmlb0FtLUv/6DA5+cSt8ThJh8zbEoqqayK6/phEO
 5+yQjO6lLJ4N/+Vh7bjKVnauY/b0lxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-FJyFQC_9OKqGmLIkrIt-eA-1; Fri, 06 Dec 2019 03:26:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA03F800D5A;
 Fri,  6 Dec 2019 08:26:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60C1E6014C;
 Fri,  6 Dec 2019 08:26:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C89421138606; Fri,  6 Dec 2019 09:26:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6] hw/core/qdev: cleanup Error ** variables
References: <20191127192025.21594-1-vsementsov@virtuozzo.com>
 <87a78fz045.fsf@dusky.pond.sub.org>
 <6d311ad1-528c-5787-64d0-779d6dcbadef@virtuozzo.com>
 <61df02c1-2be4-a2fc-e320-c88666b673fc@redhat.com>
Date: Fri, 06 Dec 2019 09:26:22 +0100
In-Reply-To: <61df02c1-2be4-a2fc-e320-c88666b673fc@redhat.com> (Eric Blake's
 message of "Thu, 5 Dec 2019 10:45:26 -0600")
Message-ID: <8736dxn9ld.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FJyFQC_9OKqGmLIkrIt-eA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 12/5/19 8:48 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>> @@ -918,27 +917,26 @@ static void device_set_realized(Object *obj, boo=
l value, Error **errp)
>>>>           }
>>>>           } else if (!value && dev->realized) {
>>>> -        Error **local_errp =3D NULL;
>>>> +        /* We want local_err to track only the first error */
>>>>            QLIST_FOREACH(bus, &dev->child_bus, sibling) {
>>>> -            local_errp =3D local_err ? NULL : &local_err;
>>>>                object_property_set_bool(OBJECT(bus), false, "realized"=
,
>>>> -                                     local_errp);
>>>> +                                     local_err ? NULL : &local_err);
>>>>            }
>>>
>>> This is a rather unusual way to keep the first error of several.
>
> It may be unusual, but has the benefit of avoiding error_propagate...

Non-issue if the error_propagate() gets replaced by
ERRP_AUTO_PROPAGATE(), isn't it?

>>> qapi/error.h advises:
>>>
>>>    * Receive and accumulate multiple errors (first one wins):
>>>    *     Error *err =3D NULL, *local_err =3D NULL;
>>>    *     foo(arg, &err);
>>>    *     bar(arg, &local_err);
>>>    *     error_propagate(&err, local_err);
>>>    *     if (err) {
>>>    *         handle the error...
>>>    *     }
>>
>> Hmm, honestly, I like more what I've written:
>>
>> 1. less code
>> 2. logic is more clean: we store first error to local_err, and after fir=
st error
>>      pass NULL as a parameter. No propagation or extra error variables.
>> 3. more efficient (no propagation, no extra allocation for errors which =
we'll drop
>>      anyway) (I understand that efficiency of error path is not thing to=
 care about,
>>      so it's at third place)
>>
>> Also, propagation which you propose is also unusual thing (it proposed i=
n comment,
>> but who reads it :). I've never seen it before, and I've to go and check=
 that
>> error_propagate works correctly when first argument is already set.

When you think you can improve on the common, documented pattern, you're
invited to update the documentation and the existing uses of the
pattern.

If everybody "improved" on common, documented patterns locally, the code
would become needlessly hard to read for developers with experience in
the pattern's area.

>> So, I'd prefer to keep now this patch as is, and to convert later if we =
really need it.

I want this to match the common, documented pattern.  Whether we make it
match before or after your ERRP_AUTO_PROPAGATE() work doesn't matter to
me.

>>> If replacing this by the usual way is too troublesome now, we can do it
>>> after the ERRP_AUTO_PROPAGATE() conversion.  Your choice.
>
> ...and after conversion to use ERRP_AUTO_PROPATATE(), the use of
> error_propagate() should NOT occur in any code _except_ for the macro
> definition (any other use of the function points out a place where we
> failed to use the macro to get rid of boilerplate).

I figure we still need it in the (rare) cases where we want to ignore
some of a function's errors, as we do in fit_load_fdt().  If that
bothers us, we can try to find a solution that avoids the boilerplate.


