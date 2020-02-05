Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AA6C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3C821741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWy0f6bZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3C821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izO8d-0003Nm-Q8
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izO6p-0001Tr-FN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izO6n-0003PO-GT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:05:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48366
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izO6n-0003Lb-9v
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580922300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yd/jhEUd1j9qzAH4ivPNsvj2GD9Ypk8jOVY4BN+/cuU=;
 b=GWy0f6bZPNg6ilttr28JSlBMc2uoi9ST+AoC9dboZC5IaEckuYfraWZnW0G3CaQBKb03+f
 ReQ3jg0emhiH+emzUCqMekZRsecr/g3IY8KPeINT6cf+JmMSWpaToxX1gW1/GrDYE9ThBb
 Oc/tg62ZrZFRHvBNZOaVu9anWI7UiaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-NTja_AliNdCUbfJNpw_0Fw-1; Wed, 05 Feb 2020 12:04:19 -0500
X-MC-Unique: NTja_AliNdCUbfJNpw_0Fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C9F7801A0B;
 Wed,  5 Feb 2020 17:04:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-184.ams2.redhat.com
 [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3B9D19C7F;
 Wed,  5 Feb 2020 17:04:16 +0000 (UTC)
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <d5340381-8d5e-e8f9-2eb1-60bcfbb28186@redhat.com>
 <8574b42d-479e-ef72-ecab-4546b364adb6@redhat.com>
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
Message-ID: <5141ea4b-a7c2-e9a3-045e-91dc088785c7@redhat.com>
Date: Wed, 5 Feb 2020 18:04:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8574b42d-479e-ef72-ecab-4546b364adb6@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bbrfyNICn9TlPH6BTZk6DQFFOVCPfjFjH"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bbrfyNICn9TlPH6BTZk6DQFFOVCPfjFjH
Content-Type: multipart/mixed; boundary="T5hFsJSifO0Diy6vsKmN6X5a11m4DYhkp"

--T5hFsJSifO0Diy6vsKmN6X5a11m4DYhkp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.02.20 19:53, Eric Blake wrote:
> On 2/4/20 11:32 AM, Max Reitz wrote:
>> On 31.01.20 18:44, Eric Blake wrote:
>>> Based-on: <20200124103458.1525982-2-david.edmondson@oracle.com>
>>> ([PATCH v2 1/2] qemu-img: Add --target-is-zero to convert)
>>>
>>> I'm working on adding an NBD extension that reports whether an image
>>> is already all zero when the client first connects.=C2=A0 I initially
>>> thought I could write the NBD code to just call bdrv_has_zero_init(),
>>> but that turned out to be a bad assumption that instead resulted in
>>> this patch series.=C2=A0 The NBD patch will come later (and cross-poste=
d to
>>> the NBD protocol, libnbd, nbdkit, and qemu, as it will affect all four
>>> repositories).
>>
>> We had a discussion about this on IRC, and as far as I remember I wasn=
=E2=80=99t
>> quite sold on the =E2=80=9Cwhy=E2=80=9D.=C2=A0 So, again, I wonder why t=
his is needed.
>>
>> I mean, it does make intuitive sense to want to know whether an image is
>> fully zero, but if I continue thinking about it I don=E2=80=99t know any=
 case
>> where we would need to figure it out and where we could accept =E2=80=9C=
We don=E2=80=99t
>> know=E2=80=9D as an answer.=C2=A0 So I=E2=80=99m looking for use cases, =
but this cover letter
>> doesn=E2=80=99t mention any.=C2=A0 (And from a quick glance I don=E2=80=
=99t see this series
>> using the flag, actually.)
>=20
> Patch 10/17 has:
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index e60217e6c382..c8519a74f738 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1985,10 +1985,12 @@ static int convert_do_copy(ImgConvertState *s)
> =C2=A0=C2=A0=C2=A0=C2=A0 int64_t sector_num =3D 0;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Check whether we have zero initialisation or =
can get it
> efficiently */
> -=C2=A0=C2=A0=C2=A0 if (!s->has_zero_init && s->target_is_new && s->min_s=
parse &&
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !s->target_has_backing) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->has_zero_init =3D !!(bdrv_=
known_zeroes(blk_bs(s->target)) &
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_ZERO_CREATE);
> +=C2=A0=C2=A0=C2=A0 if (!s->has_zero_init && s->min_sparse && !s->target_=
has_backing) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_known_zeroes(blk=
_bs(s->target));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret & BDRV_ZERO_OPEN ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (s->t=
arget_is_new && ret & BDRV_ZERO_CREATE)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->ha=
s_zero_init =3D true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }

OK, I expected users to come in a separate patch.

> That's the use case: when copying into a destination file, it's useful
> to know if the destination already reads as all zeroes, before
> attempting a fallback to bdrv_make_zero(BDRV_REQ_NO_FALLBACK) or calls
> to block status checking for holes.

But that was my point on IRC.  Is it really more useful if
bdrv_make_zero() is just as quick?  (And the fact that NBD doesn=E2=80=99t =
have
an implementation looks more like a problem with NBD to me.)

(Considering that at least the code we discussed on IRC didn=E2=80=99t work=
 for
preallocated images, which was the one point where we actually have a
problem in practice.)

>> (We have a use case with convert -n to freshly created image files, but
>> my position on this on IRC was that we want the --target-is-zero flag
>> for that anyway: Auto-detection may always break, our preferred default
>> behavior may always change, so if you want convert -n not to touch the
>> target image except to write non-zero data from the source, we need a
>> --target-is-zero flag and users need to use it.=C2=A0 Well, management
>> layers, because I don=E2=80=99t think users would use convert -n anyway.
>>
>> And with --target-is-zero and users effectively having to use it, I
>> don=E2=80=99t think that=E2=80=99s a good example of a use case.)
>=20
> Yes, there will still be cases where you have to use --target-is-zero
> because the image itself couldn't report that it already reads as
> zeroes, but there are also enough cases where the destination is already
> known to read zeroes and it's a shame to tell the user that 'you have to
> add --target-is-zero to get faster copying even though we could have
> inferred it on your behalf'.

How is it a shame?  I think only management tools would use convert -n.
 Management tools want reliable behavior.  If you want reliable
behavior, you have to use --target-is-zero anyway.  So I don=E2=80=99t see =
the
actual benefit for qemu-img convert.

>> I suppose there is the point of blockdev-create + blockdev-mirror: This
>> has exactly the same problem as convert -n.=C2=A0 But again, if you real=
ly
>> want blockdev-mirror not just to force-zero the image, you probably need
>> to tell it so explicitly (i.e., with a --target-is-zero flag for
>> blockdev-mirror).
>>
>> (Well, I suppose we could save us a target-is-zero for mirror if we took
>> this series and had a filter driver that force-reports BDRV_ZERO_OPEN.
>> But, well, please no.)
>>
>> But maybe I=E2=80=99m just an idiot and there is no reason not to take t=
his
>> series and make blockdev-create + blockdev-mirror do the sensible thing
>> by default in most cases. *shrug*
>=20
> My argument for taking the series _is_ that the common case can be made
> more efficient without user effort.

The thing is, I don=E2=80=99t see the user effort.  I don=E2=80=99t think u=
sers use
convert -n or backup manually.  And for management tools, it isn=E2=80=99t
really effort to add another switch.

> Yes, we still need the knob for
> when the common case isn't already smart enough,

But the user can=E2=80=99t know when qemu isn=E2=80=99t smart enough.  So u=
sers who care
have to always give the flag.

> but the difference in
> avoiding a pre-zeroing pass is noticeable when copying images around

I=E2=80=99m sure it is, but the question I ask is whether in practice we
wouldn=E2=80=99t get --target-is-zero in all of these cases anyway.


So I=E2=80=99m not sold on =E2=80=9Cit works most of the time=E2=80=9D, bec=
ause if it=E2=80=99s just
most of the time, then we=E2=80=99ll likely see --target-is-zero all of the=
 time.

OTOH, I suppose that with the new qcow2 extension, it would always work
for the following case:
(1) Create a qcow2 file,
(2) Immediately (with the next qemu-img/QMP invocation) use it as a
target of convert -n or mirror or anything similar.

If so, that means it works reliably all of the time for a common case.
I guess that=E2=80=99d be enough for me.

Max

> (and more than just for qcow2 - my followup series to improve NBD is
> similarly useful given how much work has already been invested in
> mapping NBD into storage access over https in the upper layers like ovirt=
).
>=20



--T5hFsJSifO0Diy6vsKmN6X5a11m4DYhkp--

--bbrfyNICn9TlPH6BTZk6DQFFOVCPfjFjH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl469Y4ACgkQ9AfbAGHV
z0CQZgf/ZCOUt8PZcxpSuSjY58jEkTGMoFGb9eURBf3Q1cNrO/ZiAlx9ASjkgaBq
ENJzqNpH4M9f0yu0iFYfbTEFVcq4+pSdWzS6kGYDgbe86/4hmaSC5SvSPu7C0M77
kk79PFqK9BeuKg5gI5JxxvSlnUZZP4RMvPfXAGRz1kU59WBVj4BguvBsM9NUysbl
SdBuzbmvsZj3+y0ctpjfxdNhDAkaxkpdBcj7MFoBKBL6yeWlXqq/8x4zgwGRkISH
+rlHXaz2+HjrOuLtqeMzdVZ6D5tK9fcrCtXPxHefhnshjE3a23DM9e0UT2DiiScU
e06OkU4org/zfexUyUtEhN3UIM5R3A==
=CY8O
-----END PGP SIGNATURE-----

--bbrfyNICn9TlPH6BTZk6DQFFOVCPfjFjH--


