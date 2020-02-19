Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFECC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D638208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dq5/VtgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D638208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4NGo-0007P2-N3
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 06:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4NFJ-0005s6-QE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4NFH-00017p-W7
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:10:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4NFH-00017a-R3
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582110623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5F4ja9Ge1P2G2N8sIsne9EpirIS4NHPHOezZeimu2Ew=;
 b=Dq5/VtgQRo4Y0904Wy3gzXRCOiaBi8GjmmWbx1cxZe3DzhcXgn30GHsOpwWjnfVaGn7DbP
 Vd9Q8cCPKc0unXPzNUhzhuL0R00rEhlv56TcfpuSqYMj+ZaZNHdU6IuWA4LLL3BHHXB+BM
 bB/TpdaAMcR81Fs02EoNHqcd98Zufa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-Hzjz_dulOauSe_ZPQjktmg-1; Wed, 19 Feb 2020 06:10:19 -0500
X-MC-Unique: Hzjz_dulOauSe_ZPQjktmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E7E813E2;
 Wed, 19 Feb 2020 11:10:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-152.ams2.redhat.com
 [10.36.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5F7562660;
 Wed, 19 Feb 2020 11:10:11 +0000 (UTC)
Subject: Re: Cross-project NBD extension proposal: NBD_INFO_INIT_STATE
To: Eric Blake <eblake@redhat.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>, QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
 <1b3741aa-7841-9062-ecca-73c38e599e05@redhat.com>
 <c47d277e-35f8-9837-1f1d-eab4bb6d5840@redhat.com>
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
Message-ID: <4cd75cc7-eff2-70f0-9d07-2dbb1165afeb@redhat.com>
Date: Wed, 19 Feb 2020 12:10:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c47d277e-35f8-9837-1f1d-eab4bb6d5840@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ns7l1aiAlSoZlIe2Vk5jxtQw2v16S2lrE"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, "Richard W.M. Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ns7l1aiAlSoZlIe2Vk5jxtQw2v16S2lrE
Content-Type: multipart/mixed; boundary="1Uefh1q387S2ByzHJO1pCirTgMpeIlQXo"

--1Uefh1q387S2ByzHJO1pCirTgMpeIlQXo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.02.20 21:55, Eric Blake wrote:
> On 2/17/20 9:13 AM, Max Reitz wrote:
>> Hi,
>>
>> It=E2=80=99s my understanding that without some is_zero infrastructure f=
or QEMU,
>> it=E2=80=99s impossible to implement this flag in qemu=E2=80=99s NBD ser=
ver.
>=20
> You're right that we may need some more infrastructure before being able
> to decide when to report this bit in all cases.=C2=A0 But for raw files, =
that
> infrastructure already exists: does block_status at offset 0 and the
> entire image as length return status that the entire file is a hole.

Hm, except that only works if the file is just completely unallocated.
Calling that existing infrastructure is a bit of a stretch, I think.

Or are you saying that bdrv_co_block_status(..., 0, bdrv_getlength(),
...) is our existing infrastructure?  Actually, why not.  Can we make
block drivers catch that special case?  (Or might the generic block code
somehow truncate such requests?)

> And
> for qcow2 files, it would not be that hard to teach a similar
> block_status request to report the entire image as a hole based on my
> proposed qcow2 autoclear bit tracking that the image still reads as zero.
>=20
>>
>> At the same time, I still haven=E2=80=99t understood what we need the fl=
ag for.
>>
>> As far as I understood in our discussion on your qemu series, there is
>> no case where anyone would need to know whether an image is zero.=C2=A0 =
All
>> > practical cases involve someone having to ensure that some image is
>> zero.=C2=A0 Knowing whether an image is zero can help with that, but tha=
t can
>> be an implementation detail.
>>
>> For qcow2, the idea would be that there is some flag that remains true
>> as long as the image is guaranteed to be zero.=C2=A0 Then we=E2=80=99d h=
ave some
>> bdrv_make_zero function, and qcow2=E2=80=99s implementation would use th=
is
>> information to gauge whether there=E2=80=99s something to do as all.
>>
>> For NBD, we cannot use this idea directly because to implement such a
>> flag (as you=E2=80=99re describing in this mail), we=E2=80=99d need sepa=
rate is_zero
>> infrastructure, and that kind of makes the point of =E2=80=9Cdrivers=E2=
=80=99
>> bdrv_make_zero() implementations do the right thing by themselves=E2=80=
=9D moot.
>=20
> We don't necessarily need a separate is_zero infrastructure if we can
> instead teach the existing block_status infrastructure to report that
> the entire image reads as zero.=C2=A0 You're right that clients that need=
 to
> force an entire image to be zero won't need to directly call
> block_status (they can just call bdrv_make_zero, and let that worry
> about whether a block status call makes sense among its list of steps to
> try).=C2=A0 But since block_status can report all-zero status for some ca=
ses,
> it's not hard to use that for feeding the NBD bit.

OK.  I=E2=80=99m not 100% sure there=E2=80=99s nothing that would bite us i=
n the butt
here, but I seem to remember you made all block_status things 64-bit, so
I suppose you know. :)

> However, there's a difference between qemu's block status (which is
> already typed correctly to return a 64-bit answer, even if it may need a
> few tweaks for clients that currently don't expect it to request more
> than 32 bits) and NBD's block status (which can only report 32 bits
> barring a new extension to the protocol), and where a single all-zero
> bit at NBD_OPT_GO is just as easy of an extension as a way to report a
> 64-bit all-zero response to NBD_CMD_BLOCK_STATUS.

Agreed.

>> OTOH, we wouldn=E2=80=99t need such a flag for the implementation, becau=
se we
>> could just send a 64-bit discard/make_zero over the whole block device
>> length to the NBD server, and then the server internally does the right
>> thing(TM).=C2=A0 AFAIU discard and write_zeroes currently have only 32 b=
it
>> length fields, but there were plans for adding support for 64 bit
>> versions anyway.=C2=A0 From my na=C3=AFve outsider perspective, doing th=
at doesn=E2=80=99t
>> seem a more complicated protocol addition than adding some way to tell
>> whether an NBD export is zero.
>=20
> Adding 64-bit commands to NBD is more invasive than adding a single
> startup status bit.

True.  But if we/you want 64-bit commands anyway, then it doesn=E2=80=99t r=
eally
matter what=E2=80=99s more invasive.

> Both ideas can be done - doing one does not
> preclude the other.

Absolutely.  It=E2=80=99s just that if you do one anyway and it supersedes =
the
other, than we don=E2=80=99t have to do both.  Hence me wondering whether o=
ne
does supersede the other.

> But at the same time, not all servers will
> implement both ideas - if one is easy to implement while the other is
> hard, it is not unlikely that qemu will still encounter NBD servers that
> advertise startup state but not support 64-bit make_zero (even if qemu
> as NBD server starts supporting 64-bit make zero) or even 64-bit block
> status results.

Hm.  You know better than me whether that=E2=80=99s a good argument, becaus=
e it
mostly depends on how many NBD server implementations there are;
specifically whether there are any that are decidedly not feature-complete.

> Another thing to think about here is timing.=C2=A0 With the proposed NBD
> addition, it is the server telling the client that "the image you are
> connecting to started zero", prior to the point that the client even has
> a chance to request "can you make the image all zero in a quick manner
> (and if not, I'll fall back to writing zeroes as I go)".=C2=A0 And even i=
f
> NBD gains a 64-bit block status and/or make zero command, it is still
> less network traffic for the server to advertise up-front that the image
> is all zero than it is for the client to have to issue command requests
> of the server (network traffic is not always the bottleneck, but it can
> be a consideration).

I suppose one 64-bit discard/write_zeroes to the whole image wouldn=E2=80=
=99t be
too bad, regardless of the network speed.

>> So I=E2=80=99m still wondering whether there are actually cases where we=
 need to
>> tell whether some image or NBD export is zero that do not involve making
>> it zero if it isn=E2=80=99t.
>=20
> Just because we don't think that qemu-img has such a case does not mean
> that other NBD clients will not be able to come up with some use for
> knowing if an image starts all zero.

Sure, but implementing a feature on the basis of =E2=80=9CSomebody may come=
 up
with a use for it=E2=80=9D sounds fishy to me.

OTOH, you completely convinced me with the fact that we can start by
letting qemu=E2=80=99s NBD server just invoke a block-status call over the =
whole
image, and then (potentially later) letting various block drivers
recognize that case.  But I suppose that means we no longer need a
dedicated has_zero_open() function, right?

>> (I keep asking because it seems to me that if all we ever really want to
>> do is to ensure that some images/exports are zero, we should implement
>> that.)
>=20
> The problem is WHERE do you implement it.=C2=A0 Is it more efficient to
> implement make_zero in the NBD server (the client merely requests to
> make zero, but lets the server do all the work) or in the NBD client
> (the client learns whether the server is already zero, and not hearing
> yes, the client proceeds to do all the work to write zeroes).=C2=A0 From =
the
> qemu perspective, qemu-img convert needs the image to be zero, and
> bdrv_make_zero will report back either "yes I quickly made it zero,
> possibly by doing nothing" or "no, making it zero now is no more
> efficient than you just writing zeroes as you go".=C2=A0 But although the
> code in qemu-img is the same whether bdrv_make_zero is able to request
> the work be done in the server or whether the work has to be done in the
> client, the code in the block layer that implements bdrv_make_zero may
> itself care about knowing whether the NBD server started all zero.

If we have both 64-bit write_zeroes and a zero flag in the NBD protocol,
then I don=E2=80=99t think there=E2=80=99s much difference in terms of effi=
ciency.

However, if we had to decide between which of the features is more
important for efficiency, then the difference that appears to me is that:
- With just a flag but no 64-bit write_zeroes, zeroing a non-zero image
will be inefficient.
- With just a 64-bit write_zeroes but no flag, the client has to issue a
NOP whole-image write_zeroes call for images that are zero already, but
I don=E2=80=99t really see that as an issue.

So *if* we had to decide, it appears to me that 64-bit write_zeroes
would be more important.

Max


--1Uefh1q387S2ByzHJO1pCirTgMpeIlQXo--

--ns7l1aiAlSoZlIe2Vk5jxtQw2v16S2lrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5NF5IACgkQ9AfbAGHV
z0DUOwgAm+yJkACf+fQNyO3gPEfNmhpVWzTYMuyoZWEwzCWxAfpdnRpLBxcEX1oG
0fOnLclQstgscAFD8H5TlIgcNv/thSMPIcavMPJNyCtBrVAC+8A9zwjqkkj+nmiT
K/AiyzUWqA49fXqaq+0iCHSqTBBEenB6Lt7Lsw7T8xlFnOA6W7La/E4/eKKlT0Qn
2SsfM2ophX9O2geHgmOhwIit1hl1kSGrS+Wr+6IdINcjf9FrHJw/c0XQquK9e2HK
Gc0N+a0SNzfYnOvdV1+KU8ZUs09ANfOCZX1LfqT2Bt3vbpmY9Pzh56HsH578yqIJ
u9F2/5ZoOFzEB32SOun4Co1X803MDg==
=vUvq
-----END PGP SIGNATURE-----

--ns7l1aiAlSoZlIe2Vk5jxtQw2v16S2lrE--


