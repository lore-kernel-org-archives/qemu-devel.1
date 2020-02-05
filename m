Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFBFC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF26217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux9n/qPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF26217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOv6-0002ZQ-UH
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izOuG-0001q4-Ko
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izOuF-0003je-5y
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:56:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izOuF-0003fm-0i
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580925366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f1IBwP8tMmLlQPqV7YeRJEiwkbWcbcQbn81ddAEGX2A=;
 b=Ux9n/qPTHKQ0hucJvCXbbfCbO/idbLwXkpYwusmdn4nH/6pxU0N1vk1iz6RczYYpVSc5Ny
 di+fmRPCMb9EVs92RbkkkhgMkCkVjMDYRj7bTBsJelTJAk4jPGOmI2xU7iDPUBVlGLfQ0J
 BK7sK2j3g2VSus0J0A2bG+oCaGYWO5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-2Sx4Im_MNrKEtOjSWCU5mA-1; Wed, 05 Feb 2020 12:56:02 -0500
X-MC-Unique: 2Sx4Im_MNrKEtOjSWCU5mA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94E291081FBC;
 Wed,  5 Feb 2020 17:56:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-184.ams2.redhat.com
 [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 185671001B08;
 Wed,  5 Feb 2020 17:55:49 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
 <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
 <8debd8e0-52bd-a962-0877-53dd0e610f1d@virtuozzo.com>
 <945a62b8-6b50-70bf-bb7e-daacc00d5e43@redhat.com>
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
Message-ID: <4f193e34-93bc-fd63-18cc-b9e0d9ee201d@redhat.com>
Date: Wed, 5 Feb 2020 18:55:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <945a62b8-6b50-70bf-bb7e-daacc00d5e43@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H2mN7ZUcEkEqJvXeA1wKUvd9iTKAV8EMI"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Liu Yuan <namei.unix@gmail.com>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H2mN7ZUcEkEqJvXeA1wKUvd9iTKAV8EMI
Content-Type: multipart/mixed; boundary="j0DTE32KOkoZG7pmiNEH12YkjRRx63rNQ"

--j0DTE32KOkoZG7pmiNEH12YkjRRx63rNQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 15:07, Eric Blake wrote:
> On 2/5/20 1:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>=20
>>>>> +typedef enum {
>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this b=
it if the contents of
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * a freshly-created image with no backing f=
ile reads as all
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zeroes without any additional effort.=C2=
=A0 If .bdrv_co_truncate is
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set, then this must be clear if BDRV_ZERO=
_TRUNCATE is clear.
>>>>
>>>> I understand that this is preexisting logic, but could I ask: why?
>>>> What's wrong
>>>> if driver can guarantee that created file is all-zero, but is not sure
>>>> about
>>>> file resizing? I agree that it's normal for these flags to have the
>>>> same
>>>> value,
>>>> but what is the reason for this restriction?..
>>>
>>> If areas added by truncation (or growth, rather) are always zero, then
>>> the file can always be created with size 0 and grown from there.=C2=A0 =
Thus,
>>> images where truncation adds zeroed areas will generally always be zero
>>> after creation.
>>
>> This means, that if truncation bit is set, than create bit should be
>> set.. But
>> here we say that if truncation is clear, than create bit must be clear.
>=20
> Max, did we get the logic backwards?

Or maybe my explanation was just wrong.

Because nobody actually forces a driver to use truncate to ensure that
an newly created file will be 0.  Hm.  And more importantly, you can=E2=80=
=99t
use truncate with PREALLOC_MODE_OFF when you want to create an image
with preallocation.

Let=E2=80=99s see.  The offending commit message says:

> No .bdrv_has_zero_init() implementation returns 1 if growing the file
> would add non-zero areas (at least with PREALLOC_MODE_OFF), so using it
> in lieu of this new function was always safe.
>=20
> But on the other hand, it is possible that growing an image that is not
> zero-initialized would still add a zero-initialized area, like when
> using nonpreallocating truncation on a preallocated image.  For callers
> that care only about truncation, not about creation with potential
> preallocation, this new function is useful.

So I suppose the explanation is just the preallocation mode alone;
has_zero_init() is for the image=E2=80=99s actual preallocation mode, where=
as
has_zero_init_truncate() is forced to PREALLOC_MODE_OFF.  As such, the
latter is less strict than the former.  So the former cannot be true
when the latter is false.

>>>> So, the only possible combination of flags, when they differs, is
>>>> create=3D0 and
>>>> truncate=3D1.. How is it possible?
>>>
>>> For preallocated qcow2 images, it depends on the storage whether they
>>> are actually 0 after creation.=C2=A0 Hence qcow2_has_zero_init() then d=
efers
>>> to bdrv_has_zero_init() of s->data_file->bs.
>>>
>>> But when you truncate them (with PREALLOC_MODE_OFF, as
>>> BlockDriver.bdrv_has_zero_init_truncate()=E2=80=99s comment explains), =
the new
>>> area is always going to be 0, regardless of initial preallocation.
>>
>> ah yes, due to qcow2 zero clusters.
>=20
> Hmm. Do we actually set the zero flag on unallocated clusters when
> resizing a qcow2 image?

No.  They are just unallocated, i.e. zero.  (Nodes with backing files
never return true for bdrv_has_zero_init_truncate anyway).

> That would be an O(n) operation (we have to
> visit the L2 entry for each added cluster, even if only to set the zero
> cluster bit).=C2=A0 Or do we instead just rely on the fact that qcow2 is
> inherently sparse, and that when you resize the guest-visible size
> without writing any new clusters, then it is only subsequent guest
> access to those addresses that finally allocate clusters, making resize
> O(1) (update the qcow2 metadata cluster, but not any L2 tables) while
> still reading 0 from the new data.=C2=A0 To some extent, that's what the
> allocation mode is supposed to control.
>=20
> What about with external data images, where a resize in guest-visible
> length requires a resize of the underlying data image?=C2=A0 There, we DO
> have to worry about whether the data image resizes with zeroes (as in
> the filesystem) or with random data (as in a block device).

Well, partially: Namely, only with data_file_raw.  Because otherwise the
clusters are still unallocated and thus read as zero.  So yes, then we
do have to worry about that.

With data_file_raw, we have an obligation to make the data file return
the same data as the qcow2 file, so, um.  I wonder whether we actually
take any care of this yet.  If you have some external data file without
zero_init(_truncate), do get zeroes when reading from the qcow2 node,
but non-zeroes when reading from the raw data file?  That would be OK
without data_file_raw, but not with it.  I suppose I=E2=80=99ll have to tes=
t it.

Max


--j0DTE32KOkoZG7pmiNEH12YkjRRx63rNQ--

--H2mN7ZUcEkEqJvXeA1wKUvd9iTKAV8EMI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl47AaQACgkQ9AfbAGHV
z0CT2Qf8DAyTuPb4kUQexgQR6XLA3zHg/+FGVUtG4o640uwxmWcnOTqF16KE7Wlw
oSJRZxsomvdJq6jg7CJxQ3PCQd2lGoTY+ZACpafE5ZaNNGtJfDLcHzbyfprmo2J7
jr177mMGbfXL84QFmMo0hhg032nooYQTAwZMswkWYiilBZ0s0GZ25QTydoEVYQ14
pyD7uc89pjGEvpnCG6lsTDuGZK+COSYr0VG9rxO9WRhwu43nOF1kliSH40LqV2FZ
ianxddUm/wiqyG1TgmMjS+vptQMGWK5K4+N5GVzANc0SOyAzesFVOeReo0j6PYJL
zYbQlRVRhB8UCQEfj/s7Rh3AHRXAGw==
=qQDx
-----END PGP SIGNATURE-----

--H2mN7ZUcEkEqJvXeA1wKUvd9iTKAV8EMI--


