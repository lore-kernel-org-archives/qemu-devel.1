Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB11C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8D4206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cafTwg2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8D4206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdDu-000655-4H
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izdDE-0005XU-Ke
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izdDC-0006JJ-QN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:12:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izdDC-0006I2-LL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580980358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ktf2IQHi8et3iqS0E77MLuvJ+pFZRnWeyaNaNIYSmMs=;
 b=cafTwg2O7jcKNhW60Scijaw/PvncekfOWZFb9zFSWiIynDEUGtQLJa1n/8L9dF2HZOn9lc
 RfRMq2XucrcGnx6FzadMdKSFTotD2ZA+X/Jfco1nJY4ZhJkxG6WY7oPsT4EhJ8VyZy+u1J
 dT8vTPrq2qo3Sw72j9q/uATWRHxFswI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-dVkVBzboO6O1Z3b62HzfiA-1; Thu, 06 Feb 2020 04:12:33 -0500
X-MC-Unique: dVkVBzboO6O1Z3b62HzfiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64346107B279;
 Thu,  6 Feb 2020 09:12:32 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEBD610016DA;
 Thu,  6 Feb 2020 09:12:28 +0000 (UTC)
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <d5340381-8d5e-e8f9-2eb1-60bcfbb28186@redhat.com>
 <8574b42d-479e-ef72-ecab-4546b364adb6@redhat.com>
 <5141ea4b-a7c2-e9a3-045e-91dc088785c7@redhat.com>
 <59ba95c5-4c8b-a059-2332-3bafdc90dd2e@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <93a925d7-e0d7-ba5a-66df-35fe59f36412@redhat.com>
Date: Thu, 6 Feb 2020 10:12:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <59ba95c5-4c8b-a059-2332-3bafdc90dd2e@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W887hKopffdRGeWjowqbI6UM6jNuHBJmX"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W887hKopffdRGeWjowqbI6UM6jNuHBJmX
Content-Type: multipart/mixed; boundary="9pKRlTkoRjk7mi2rDhrpIgVMiy1PhozmR"

--9pKRlTkoRjk7mi2rDhrpIgVMiy1PhozmR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 20:21, Eric Blake wrote:
> On 2/5/20 11:04 AM, Max Reitz wrote:
>> OK, I expected users to come in a separate patch.
>=20
> I can refactor that better in v2.
>=20
>>
>>> That's the use case: when copying into a destination file, it's useful
>>> to know if the destination already reads as all zeroes, before
>>> attempting a fallback to bdrv_make_zero(BDRV_REQ_NO_FALLBACK) or calls
>>> to block status checking for holes.
>>
>> But that was my point on IRC.=C2=A0 Is it really more useful if
>> bdrv_make_zero() is just as quick?=C2=A0 (And the fact that NBD doesn=E2=
=80=99t have
>> an implementation looks more like a problem with NBD to me.)
>=20
> That is indeed a thought - why should qemu-img even TRY to call
> bdrv_has_init_zero; it should instead call bdrv_make_zero(), which
> should be as fast as possible (see my latest reply on 9/17 exploring
> that idea more).=C2=A0 Under the hood, we can then make bdrv_make_zero() =
use
> whatever tricks it needs, whether keeping the driver's
> .bdrv_has_zero_init/_truncate callbacks, adding another callback, making
> write_zeroes faster, or whatever, but instead of making qemu-img sort
> through multiple ideas, the burden would now be hidden in the block layer=
.

I didn=E2=80=99t even think of that.  More on that at the very bottom of th=
is mail.

>> (Considering that at least the code we discussed on IRC didn=E2=80=99t w=
ork for
>> preallocated images, which was the one point where we actually have a
>> problem in practice.)
>=20
> And this series DOES improve the case for preallocated qcow2 images, by
> virtue of a new qcow2 autoclear bit.=C2=A0 But again, that may be somethi=
ng
> we want to hide in the driver callback interfaces, while qemu-img just
> blindly calls bdrv_make_zero() and gets success (the image now reads as
> zeroes, either because it was already that way or we did something
> quick) or failure (it is a waste of time to prezero, whether by
> write_zeroes or by trim or by truncate, so just manually write zeroes as
> part of your image copying).

Oh, yes, indeed.  Sorry.

>>>> (We have a use case with convert -n to freshly created image files, bu=
t
>>>> my position on this on IRC was that we want the --target-is-zero flag
>>>> for that anyway: Auto-detection may always break, our preferred defaul=
t
>>>> behavior may always change, so if you want convert -n not to touch the
>>>> target image except to write non-zero data from the source, we need a
>>>> --target-is-zero flag and users need to use it.=C2=A0 Well, management
>>>> layers, because I don=E2=80=99t think users would use convert -n anywa=
y.
>>>>
>>>> And with --target-is-zero and users effectively having to use it, I
>>>> don=E2=80=99t think that=E2=80=99s a good example of a use case.)
>>>
>>> Yes, there will still be cases where you have to use --target-is-zero
>>> because the image itself couldn't report that it already reads as
>>> zeroes, but there are also enough cases where the destination is alread=
y
>>> known to read zeroes and it's a shame to tell the user that 'you have t=
o
>>> add --target-is-zero to get faster copying even though we could have
>>> inferred it on your behalf'.
>>
>> How is it a shame?=C2=A0 I think only management tools would use convert=
 -n.
>> =C2=A0 Management tools want reliable behavior.=C2=A0 If you want reliab=
le
>> behavior, you have to use --target-is-zero anyway.=C2=A0 So I don=E2=80=
=99t see the
>> actual benefit for qemu-img convert.
>=20
> qemu-img convert to an NBD destination cannot create the destination, so
> it ALWAYS has to use -n.=C2=A0 I don't know how often users are likely to
> wire up a command line for qemu-img convert with NBD as the destination,
> or whether you are correct that it will be a management app able to
> supply -n (and thus able to supply --target-is-zero).=C2=A0 But at the sa=
me
> time, can a management app learn whether it is safe to supply
> --target-is-zero?=C2=A0 With my upcoming NBD patches, 'qemu-img --list' w=
ill
> show whether the NBD target is known to start life all zero, and a
> management app could use mechanism to decide when to pass
> --target-is-zero (whether a management app would actually fork qemu-img
> --list, or just be an NBD client itself to do the same thing qemu-img
> would do, is beside the point).
>=20
> Similarly, this series includes enhancements to 'qemu-img info' on qcow2
> images known to currently read as zero; again, that sort of information
> is necessary somewhere in the chain, whether it be because qemu-img
> consumes the information itself, or because the management app consumes
> the information in order to pass the --target-is-zero option to
> qemu-img, either way, the information needs to be available for
> consumption.

I simply assumed that management applications will just assume that a
newly created image is zero.

I=E2=80=99m aware that may be wrong, but then again, that hasn=E2=80=99t st=
opped them in
the past or they would have asked for qemu to deliver this information
earlier...  (That doesn=E2=80=99t mean that at some point maybe they will s=
tart
to care and ask for it.)

One problem with delivering this information of course is that it=E2=80=99s
useless.  If qemu knows the image to be zero, then it will do the right
thing by itself, and then the management application doesn=E2=80=99t need t=
o
pass --target-is-zero anymore.

>>>> I suppose there is the point of blockdev-create + blockdev-mirror: Thi=
s
>>>> has exactly the same problem as convert -n.=C2=A0 But again, if you re=
ally
>>>> want blockdev-mirror not just to force-zero the image, you probably
>>>> need
>>>> to tell it so explicitly (i.e., with a --target-is-zero flag for
>>>> blockdev-mirror).
>>>>
>>>> (Well, I suppose we could save us a target-is-zero for mirror if we
>>>> took
>>>> this series and had a filter driver that force-reports BDRV_ZERO_OPEN.
>>>> But, well, please no.)
>>>>
>>>> But maybe I=E2=80=99m just an idiot and there is no reason not to take=
 this
>>>> series and make blockdev-create + blockdev-mirror do the sensible thin=
g
>>>> by default in most cases. *shrug*
>>>
>>> My argument for taking the series _is_ that the common case can be made
>>> more efficient without user effort.
>>
>> The thing is, I don=E2=80=99t see the user effort.=C2=A0 I don=E2=80=99t=
 think users use
>> convert -n or backup manually.=C2=A0 And for management tools, it isn=E2=
=80=99t
>> really effort to add another switch.
>=20
> Maybe, but it is just shifting the burden between who consumes the
> information that an image is all zero, and how the consumption of that
> information is passed to qemu-img.

Sure, but the question is who can take the burden the easiest.

The management layer creates the image and then uses it, so it can
easily retain this information.

When qemu creates an image and then uses it in a separate step, it
cannot retain this information.  It has to be stored somewhere
persistently and we have to fetch it.  In the case of qcow2, that works
with a flag.  In other cases...  Well, in any case it isn=E2=80=99t as triv=
ial
as in a management application.

>>> Yes, we still need the knob for
>>> when the common case isn't already smart enough,
>>
>> But the user can=E2=80=99t know when qemu isn=E2=80=99t smart enough.=C2=
=A0 So users who care
>> have to always give the flag.
>>
>>> but the difference in
>>> avoiding a pre-zeroing pass is noticeable when copying images around
>>
>> I=E2=80=99m sure it is, but the question I ask is whether in practice we
>> wouldn=E2=80=99t get --target-is-zero in all of these cases anyway.
>>
>>
>> So I=E2=80=99m not sold on =E2=80=9Cit works most of the time=E2=80=9D, =
because if it=E2=80=99s just
>> most of the time, then we=E2=80=99ll likely see --target-is-zero all of =
the time.
>>
>> OTOH, I suppose that with the new qcow2 extension, it would always work
>> for the following case:
>> (1) Create a qcow2 file,
>> (2) Immediately (with the next qemu-img/QMP invocation) use it as a
>> target of convert -n or mirror or anything similar.
>=20
> Yes, that is one of the immediately obvious fallouts from this series -
> you can now create a preallocated qcow2 image in one process, and the
> next process using that image can readily tell that it is still
> just-created.

And it=E2=80=99s a common case with blockdev-create.

>> If so, that means it works reliably all of the time for a common case.
>> I guess that=E2=80=99d be enough for me.
>>
>> Max
>>
>>> (and more than just for qcow2 - my followup series to improve NBD is
>>> similarly useful given how much work has already been invested in
>>> mapping NBD into storage access over https in the upper layers like
>>> ovirt).
>>>
>>
>>
>=20
> At any rate, I think you've convinced me to rethink how I present v2
> (maybe not by refactoring bdrv_known_zeroes usage, but instead
> refactoring bdrv_make_zero), but that the qcow2 autoclear bit is still a
> useful feature to have.

Hm.  So you mean there isn=E2=80=99t any caller that actually cares about
whether an image is zero, only that it is zero.  That is, they are all
=E2=80=9Cif (!is_zero()) { make_zero(); }=E2=80=9D =E2=80=93 which is funct=
ionally the same as
=E2=80=9Cmake_zero();=E2=80=9D alone.  make_zero in turn could and should b=
e a no-op
when the image is known to be zero already.

I actually didn=E2=80=99t think of that.  Sounds good.

Max


--9pKRlTkoRjk7mi2rDhrpIgVMiy1PhozmR--

--W887hKopffdRGeWjowqbI6UM6jNuHBJmX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl472HoACgkQ9AfbAGHV
z0BEzAf/VihSuBnFtfgXOe9mXve9Mg9nX3mCmqL/dlY4XJu2Ebd9XVgqUG7DeXwU
g6kG87zU8mQOKFM5p1ch19PSp1GVVM+Ogu9Ycj0u1RxprJrtU/ND179jKzTS+Szo
j7ngw2gFz3lkKrkFypxdWt/803rEnb6Cf2tadCvEfbRwLLSghb5rJHy5uNuGBS9h
8F516rwmNwmvR1U3m3RfKIXHiyFOnhiU/a2V18KLHrq5tJ5Eom9xQGjL0LMaR6/2
tWzseB8seSKVAJ/0+66AI0rcXIIuLk9JIPiZjWAfNUYhoyxZVWdB8ZbWqDlWt0yg
pwS0BWIVDMTrGhKZOHvMmii2cEpXug==
=976L
-----END PGP SIGNATURE-----

--W887hKopffdRGeWjowqbI6UM6jNuHBJmX--


