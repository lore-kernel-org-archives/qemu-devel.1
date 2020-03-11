Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99D9C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C37320575
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFUSrBoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C37320575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2Yq-00022a-QK
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jC2Y0-0001TA-FF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jC2Xx-0000KQ-8c
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:41:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jC2Xx-0000JA-58
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583937678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eg2CZjPbTX8SjRwNDnoDsSdouoJltA9NNOsfHqNxAuU=;
 b=gFUSrBoEMhYKZoZylkVEKkKpImw4UyBPGVlozUqJZd4UrGKJaZCy3VKBQ008y+zZPKtkCc
 rLVOFQ3/beCetjZ79aZrLcMB/0i2LNLkCN/fou51RiiZwGfRYQPLeO4nyc+mDB6yMKCx+I
 h1ZMW6taLqxrDZRovlOrmXlGZNZEIhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-5WOfSgRnO7u9pEUtHmUJ6g-1; Wed, 11 Mar 2020 10:41:15 -0400
X-MC-Unique: 5WOfSgRnO7u9pEUtHmUJ6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0810A800EBC;
 Wed, 11 Mar 2020 14:41:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E33A9CA3;
 Wed, 11 Mar 2020 14:41:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99B5711386A6; Wed, 11 Mar 2020 15:41:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <fda76f8a-bb62-d867-d7b4-7cf8caf0489e@virtuozzo.com>
 <87a74ngriw.fsf@dusky.pond.sub.org>
 <71ada30b-c72b-6251-cc38-877ddd4156a8@virtuozzo.com>
Date: Wed, 11 Mar 2020 15:41:05 +0100
In-Reply-To: <71ada30b-c72b-6251-cc38-877ddd4156a8@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 11 Mar 2020 17:05:24 +0300")
Message-ID: <87h7yvx8ce.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 11.03.2020 12:38, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> 09.03.2020 12:56, Markus Armbruster wrote:
>>>> Suggest
>>>>
>>>>       scripts: Coccinelle script to use auto-propagated errp
>>>>
>>>> or
>>>>
>>>>       scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>>>>
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>> [...]
>>>>> +// Note, that we update everything related to matched by rule1 funct=
ion name
>>>>> +// and local_err name. We may match something not related to the pat=
tern
>>>>> +// matched by rule1. For example, local_err may be defined with the =
same name
>>>>> +// in different blocks inside one function, and in one block follow =
the
>>>>> +// propagation pattern and in other block doesn't. Or we may have se=
veral
>>>>> +// functions with the same name (for different configurations).
>>>>
>>>> Context: rule1 matches functions that have all three of
>>>>
>>>> * an Error **errp parameter
>>>>
>>>> * an Error *local_err =3D NULL variable declaration
>>>>
>>>> * an error_propagate(errp, local_err) or error_propagate_prepend(errp,
>>>>     local_err, ...) expression, where @errp is the parameter and
>>>>     @local_err is the variable.
>>>>
>>>> If I understand you correctly, you're pointing out two potential issue=
s:
>>>>
>>>> 1. This rule can match functions rule1 does not match if there is
>>>> another function with the same name that rule1 does match.
>>>>
>>>> 2. This rule matches in the entire function matched by rule1, even whe=
n
>>>> parts of that function use a different @errp or @local_err.
>>>>
>>>> I figure these apply to all rules with identifier rule1.fn, not just
>>>> this one.  Correct?
>>>>
>>>> Regarding 1.  There must be a better way to chain rules together, but =
I
>>>> don't know it.
>>>
>>> Hmm, what about something like this:
>>>
>>> @rule1 disable optional_qualifier exists@
>>> identifier fn, local_err;
>>> symbol errp;
>>> @@
>>>
>>>   fn(..., Error **
>>> - errp
>>> + ___errp_coccinelle_updating___
>>>      , ...)
>>>   {
>>>       ...
>>>       Error *local_err =3D NULL;
>>>       ...
>>> (
>>>      error_propagate_prepend(errp, local_err, ...);
>>> |
>>>      error_propagate(errp, local_err);
>>> )
>>>       ...
>>>   }
>>>
>>>
>>> [..]
>>>
>>> match symbol ___errp_coccinelle_updating___ in following rules in funct=
ion header
>>>
>>> [..]
>>>
>>>
>>> @ disable optional_qualifier@
>>> identifier fn, local_err;
>>> symbol errp;
>>> @@
>>>
>>>   fn(..., Error **
>>> - ___errp_coccinelle_updating___
>>> + errp
>>>      , ...)
>>>   {
>>>       ...
>>>   }
>>>
>>>
>>> - hacky, but seems not more hacky than python detection, and should wor=
k better
>>
>> As simple, forceful and unsubtle as a sledgehammer.  I like it :)
>>
>
>
> Hmm, not so simple.
>
> It leads to reindenting of function header, which is bad.

Because ___errp_coccinelle_updating___ is longer than errp, I guess.
Try ____?

> Possible solution is instead
>
> fn(...)
> {
> +   ___errp_coccinelle_updating___();
>
>
> but this slow down coccinelle. For example, on block.c from ~3s to 1m16s.
>
> .
>
> So, I'm returning to just a warning.
>
> I think something simple like
>
> @@
> identifier rule1.fn;
> position p !=3D rule1.p;
> @@
>
> fn@p(...) {...}
>
> @ script:python@
>
> <print warning>
>
> should work.

Up to you.


