Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D8BC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 19:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29BA2072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 19:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2ByfCKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29BA2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izQGc-0004qW-4b
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 14:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izQFH-0003hB-23
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izQFD-0001nv-VY
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:21:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59265
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izQFD-0001mi-RV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580930510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqWdqycrodNKYIeMbVyal/JqkP4USxPlM3i1E2/nWB0=;
 b=Y2ByfCKmzcLUS50M2gJysA4nj3lf5VAGilafl7/vRDnoXzwG15tFDfY+PHDSzCRkWmo+CL
 77GCg57111f97ctgmTNXtJ5mxmgNue4QrvcdxPWPeKe/rSLxBkJ7R72tQwq8le8lCTCgdA
 k676C5oiS/YRbRGGEmOOqY9K448mIfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-2SaAOdshM3m6VvqsxVLSew-1; Wed, 05 Feb 2020 14:21:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BCBE18A5500;
 Wed,  5 Feb 2020 19:21:42 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D582790C1;
 Wed,  5 Feb 2020 19:21:41 +0000 (UTC)
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <d5340381-8d5e-e8f9-2eb1-60bcfbb28186@redhat.com>
 <8574b42d-479e-ef72-ecab-4546b364adb6@redhat.com>
 <5141ea4b-a7c2-e9a3-045e-91dc088785c7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <59ba95c5-4c8b-a059-2332-3bafdc90dd2e@redhat.com>
Date: Wed, 5 Feb 2020 13:21:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5141ea4b-a7c2-e9a3-045e-91dc088785c7@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2SaAOdshM3m6VvqsxVLSew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 11:04 AM, Max Reitz wrote:
> OK, I expected users to come in a separate patch.

I can refactor that better in v2.

>=20
>> That's the use case: when copying into a destination file, it's useful
>> to know if the destination already reads as all zeroes, before
>> attempting a fallback to bdrv_make_zero(BDRV_REQ_NO_FALLBACK) or calls
>> to block status checking for holes.
>=20
> But that was my point on IRC.  Is it really more useful if
> bdrv_make_zero() is just as quick?  (And the fact that NBD doesn=E2=80=99=
t have
> an implementation looks more like a problem with NBD to me.)

That is indeed a thought - why should qemu-img even TRY to call=20
bdrv_has_init_zero; it should instead call bdrv_make_zero(), which=20
should be as fast as possible (see my latest reply on 9/17 exploring=20
that idea more).  Under the hood, we can then make bdrv_make_zero() use=20
whatever tricks it needs, whether keeping the driver's=20
.bdrv_has_zero_init/_truncate callbacks, adding another callback, making=20
write_zeroes faster, or whatever, but instead of making qemu-img sort=20
through multiple ideas, the burden would now be hidden in the block layer.

>=20
> (Considering that at least the code we discussed on IRC didn=E2=80=99t wo=
rk for
> preallocated images, which was the one point where we actually have a
> problem in practice.)

And this series DOES improve the case for preallocated qcow2 images, by=20
virtue of a new qcow2 autoclear bit.  But again, that may be something=20
we want to hide in the driver callback interfaces, while qemu-img just=20
blindly calls bdrv_make_zero() and gets success (the image now reads as=20
zeroes, either because it was already that way or we did something=20
quick) or failure (it is a waste of time to prezero, whether by=20
write_zeroes or by trim or by truncate, so just manually write zeroes as=20
part of your image copying).

>=20
>>> (We have a use case with convert -n to freshly created image files, but
>>> my position on this on IRC was that we want the --target-is-zero flag
>>> for that anyway: Auto-detection may always break, our preferred default
>>> behavior may always change, so if you want convert -n not to touch the
>>> target image except to write non-zero data from the source, we need a
>>> --target-is-zero flag and users need to use it.=C2=A0 Well, management
>>> layers, because I don=E2=80=99t think users would use convert -n anyway=
.
>>>
>>> And with --target-is-zero and users effectively having to use it, I
>>> don=E2=80=99t think that=E2=80=99s a good example of a use case.)
>>
>> Yes, there will still be cases where you have to use --target-is-zero
>> because the image itself couldn't report that it already reads as
>> zeroes, but there are also enough cases where the destination is already
>> known to read zeroes and it's a shame to tell the user that 'you have to
>> add --target-is-zero to get faster copying even though we could have
>> inferred it on your behalf'.
>=20
> How is it a shame?  I think only management tools would use convert -n.
>   Management tools want reliable behavior.  If you want reliable
> behavior, you have to use --target-is-zero anyway.  So I don=E2=80=99t se=
e the
> actual benefit for qemu-img convert.

qemu-img convert to an NBD destination cannot create the destination, so=20
it ALWAYS has to use -n.  I don't know how often users are likely to=20
wire up a command line for qemu-img convert with NBD as the destination,=20
or whether you are correct that it will be a management app able to=20
supply -n (and thus able to supply --target-is-zero).  But at the same=20
time, can a management app learn whether it is safe to supply=20
--target-is-zero?  With my upcoming NBD patches, 'qemu-img --list' will=20
show whether the NBD target is known to start life all zero, and a=20
management app could use mechanism to decide when to pass=20
--target-is-zero (whether a management app would actually fork qemu-img=20
--list, or just be an NBD client itself to do the same thing qemu-img=20
would do, is beside the point).

Similarly, this series includes enhancements to 'qemu-img info' on qcow2=20
images known to currently read as zero; again, that sort of information=20
is necessary somewhere in the chain, whether it be because qemu-img=20
consumes the information itself, or because the management app consumes=20
the information in order to pass the --target-is-zero option to=20
qemu-img, either way, the information needs to be available for consumption=
.

>=20
>>> I suppose there is the point of blockdev-create + blockdev-mirror: This
>>> has exactly the same problem as convert -n.=C2=A0 But again, if you rea=
lly
>>> want blockdev-mirror not just to force-zero the image, you probably nee=
d
>>> to tell it so explicitly (i.e., with a --target-is-zero flag for
>>> blockdev-mirror).
>>>
>>> (Well, I suppose we could save us a target-is-zero for mirror if we too=
k
>>> this series and had a filter driver that force-reports BDRV_ZERO_OPEN.
>>> But, well, please no.)
>>>
>>> But maybe I=E2=80=99m just an idiot and there is no reason not to take =
this
>>> series and make blockdev-create + blockdev-mirror do the sensible thing
>>> by default in most cases. *shrug*
>>
>> My argument for taking the series _is_ that the common case can be made
>> more efficient without user effort.
>=20
> The thing is, I don=E2=80=99t see the user effort.  I don=E2=80=99t think=
 users use
> convert -n or backup manually.  And for management tools, it isn=E2=80=99=
t
> really effort to add another switch.

Maybe, but it is just shifting the burden between who consumes the=20
information that an image is all zero, and how the consumption of that=20
information is passed to qemu-img.

>=20
>> Yes, we still need the knob for
>> when the common case isn't already smart enough,
>=20
> But the user can=E2=80=99t know when qemu isn=E2=80=99t smart enough.  So=
 users who care
> have to always give the flag.
>=20
>> but the difference in
>> avoiding a pre-zeroing pass is noticeable when copying images around
>=20
> I=E2=80=99m sure it is, but the question I ask is whether in practice we
> wouldn=E2=80=99t get --target-is-zero in all of these cases anyway.
>=20
>=20
> So I=E2=80=99m not sold on =E2=80=9Cit works most of the time=E2=80=9D, b=
ecause if it=E2=80=99s just
> most of the time, then we=E2=80=99ll likely see --target-is-zero all of t=
he time.
>=20
> OTOH, I suppose that with the new qcow2 extension, it would always work
> for the following case:
> (1) Create a qcow2 file,
> (2) Immediately (with the next qemu-img/QMP invocation) use it as a
> target of convert -n or mirror or anything similar.

Yes, that is one of the immediately obvious fallouts from this series -=20
you can now create a preallocated qcow2 image in one process, and the=20
next process using that image can readily tell that it is still=20
just-created.

>=20
> If so, that means it works reliably all of the time for a common case.
> I guess that=E2=80=99d be enough for me.
>=20
> Max
>=20
>> (and more than just for qcow2 - my followup series to improve NBD is
>> similarly useful given how much work has already been invested in
>> mapping NBD into storage access over https in the upper layers like ovir=
t).
>>
>=20
>=20

At any rate, I think you've convinced me to rethink how I present v2=20
(maybe not by refactoring bdrv_known_zeroes usage, but instead=20
refactoring bdrv_make_zero), but that the qcow2 autoclear bit is still a=20
useful feature to have.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


