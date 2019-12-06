Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6101BC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D5C20659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHP3D0aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D5C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFsR-0005bC-Hz
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1idEin-0006gz-8v
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1idEik-0006ji-W0
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:36:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1idEik-0006iK-Ql
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OlKgljMsmEapL+eFMQYTxahgK2MUl8C8CXSYTjo/bp0=;
 b=QHP3D0aa0GduXvAXNeLwK2xN4Mau7uQo8JhUPz1MN1OjfFBRDVMxgJ/epn/a/Ohmur83j4
 0G4lQN2le1Trbk1UCcM8Ex/7YZ7nDnyTIDFD+26zy1yh3EW0enDZfdQHoGTuHfPC+qgukh
 z7WeEKg+MCKVw7LrL6NiXa9sd4JMTAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-l6rSiumjOlCIwKbcLCdphA-1; Fri, 06 Dec 2019 09:36:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5731856A9A;
 Fri,  6 Dec 2019 14:36:35 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCA1260BF4;
 Fri,  6 Dec 2019 14:36:29 +0000 (UTC)
Subject: Re: [PATCH for-4.2?] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191205193049.30666-1-vsementsov@virtuozzo.com>
 <22af83d1-91e2-ab71-2dc4-349b5b24d1d8@redhat.com>
 <990da2e0-8223-b257-254d-a27659ef1d24@redhat.com>
 <6a74ae0a-e377-0f70-c347-0307580d7981@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <36655f7a-7ea5-e80a-ebfd-5b19c90622c0@redhat.com>
Date: Fri, 6 Dec 2019 08:36:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6a74ae0a-e377-0f70-c347-0307580d7981@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: l6rSiumjOlCIwKbcLCdphA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Krempa <pkrempa@redhat.com>,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[adding in Peter Maydell, as there is now potential talk of other=20
4.2-worthy patches]

On 12/6/19 4:18 AM, Vladimir Sementsov-Ogievskiy wrote:
> 05.12.2019 23:16, John Snow wrote:
>>
>>
>> On 12/5/19 3:09 PM, Eric Blake wrote:
>>> On 12/5/19 1:30 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Here is double bug:
>>>>
>>>> First, return error but not set errp. This may lead to:
>>>> qmp block-dirty-bitmap-remove may report success when actually failed
>>>>
>>>> block-dirty-bitmap-remove used in a transaction will crash, as
>>>> qmp_transaction will think that it returned success and will cal
>>>
>>> call
>>>
>>>> block_dirty_bitmap_remove_commit which will crash, as state->bitmap is
>>>> NULL
>>>>
>>>> Second (like in anecdote), this case is not an error at all. As it is
>>>> documented in the comment above bdrv_co_remove_persistent_dirty_bitmap
>>>> definition, absence of bitmap is not an error, and similar case handle=
d
>>>> at start of qcow2_co_remove_persistent_dirty_bitmap, it returns 0 when
>>>> there is no bitmaps at all..
>>>
>>> double .
>>>
>>>>
>>>> But when there are some bitmaps, but not the requested one, it return
>>>> error with errp unset.
>>>>
>>>> Fix that.
>>>>
>>>> Fixes: b56a1e31759b750
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>
>>>> Hi all!
>>>>
>>>> Ohm, suddenly we faced this bug. It's a regression in 4.2. I'm very
>>>> sorry for introducing it, and it sad that it's found so late..
>>>>
>>>> Personally, I think that this one worth rc5, as it makes new bitmap
>>>> interfaces unusable. But the decision is yours.
>>>>
>>>> Last minute edit: hmm, actually, transaction action introduced in
>>>> 4.2, so crash is not a regression, only broken block-dirty-bitmap-remo=
ve
>>>> command is a regression... Maybe it's OK for stable.
>>>
>>> Libvirt REALLY wants to use transaction bitmap management (and require
>>> qemu 4.2) for its incremental backup patches that Peter is almost ready
>>> to merge in.=A0 I'm trying to ascertain:
>>>
>>> When exactly can this bug hit?=A0 Can you give a sequence of QMP comman=
ds
>>> that will trigger it for easy reproduction?=A0 Are there workarounds (s=
uch
>>> as checking that a bitmap exists prior to attempting to remove it)?=A0 =
If
>>> it does NOT get fixed in rc5, how will libvirt be able to probe whether
>>> the fix is in place?
>>>
>>
>> It looks like:
>>
>> - You need to have at least one bitmap
>> - You need to use transactional remove
>> - you need to misspell the bitmap name
>> - The remove will fail (return -EINVAL) but doesn't set errp
>> - The caller chokes on incomplete information, state->bitmap is NULL
>=20
>=20
> No, that would be too simple, the thing is worse. Absolutele correct remo=
ving is broken, without any misspelling
>=20
> Bug triggers when we are removing persistent bitmap that is not stored ye=
t in the image AND at least one (another) bitmap already stored in the imag=
e. So, something like:
>=20
> 1. create persistent bitmap A
> 2. shutdown vm  (bitmap A is synced)
> 3. start vm
> 4. create persistent bitmap B
> 5. remove bitmap B - it fails (and crashes if in transaction)
>=20
> =3D=3D=3D=3D
>=20
> Hmm, workaround..
>=20
> I'm afraid that the only thing is not remove persistent bitmaps, which we=
re never synced to the image. So, instead the sequence above, we need
>=20
>=20
> 1. create persistent bitmap A
> 2. shutdown vm
> 3. start vm
> 4. create persistent bitmap B
> 5. remember, that we want to remove bitmap B after vm shutdown
> ...
>    some other operations
> ...
> 6. vm shutdown
> 7. start vm in stopped mode, and remove all bitmaps marked for removing
> 8. stop vm
>=20
> But, I think that in real circumstances, vm shutdown is rare thing...

This is sounding a bit more serious. As I said earlier, it shouldn't=20
delay 4.2 on its own, but if the fix is obvious (and other than=20
comments, it is a single change from 'ret =3D -EINVAL' to 'ret =3D 0' which=
=20
fixes a definite reproducible crash), I think it rises to the level of=20
acceptable.

I've been so worried about the question of which release, that I don't=20
know if I've previously offered:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


