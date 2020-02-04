Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5988DC3524B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1CD222C2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdu2M37e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1CD222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz2ES-0007Mz-EO
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz2Do-0006op-EW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz2Dl-0003Np-JC
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:42:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz2Dl-0003M0-DL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580838164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DEm19mnb0zETrVhKkiZTdA2iaJw9BBWEAASJ78guoFI=;
 b=hdu2M37eRjAKcL3SJFvJmXwRXaNjaPSVuL7riMEcMnfPPZ8T5Pum/zVqDOFbx/2EXnZGT/
 Tx1++rzTJ5fY05m4kCRezXV1ogkjU2oc/Uy/8FYQ675lj2Ya+A1S5Hcy7s+NtI7yF4DFn1
 AvYhYwYOzbaN+WUyCJj8jBGHH6ba4yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-f7n5jp8pN4aWEzARuCnrhg-1; Tue, 04 Feb 2020 12:42:42 -0500
X-MC-Unique: f7n5jp8pN4aWEzARuCnrhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19F2A8C0373;
 Tue,  4 Feb 2020 17:42:40 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-98.ams2.redhat.com
 [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4651760BF4;
 Tue,  4 Feb 2020 17:42:29 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
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
Message-ID: <62078ab7-b46f-cb70-ffb1-5e84c7e1bee5@redhat.com>
Date: Tue, 4 Feb 2020 18:42:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <339f0a60-1e4f-286c-6594-1153bf284082@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PFkSDciiVByunOTp7J81h18f4JboJlQnN"
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
--PFkSDciiVByunOTp7J81h18f4JboJlQnN
Content-Type: multipart/mixed; boundary="5wchGUj0lWjstJkMcvJC2jVzaEx4Wh5Yd"

--5wchGUj0lWjstJkMcvJC2jVzaEx4Wh5Yd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.02.20 16:35, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2020 20:44, Eric Blake wrote:
>> Having two slightly-different function names for related purposes is
>> unwieldy, especially since I envision adding yet another notion of
>> zero support in an upcoming patch.=C2=A0 It doesn't help that
>> bdrv_has_zero_init() is a misleading name (I originally thought that a
>> driver could only return 1 when opening an already-existing image
>> known to be all zeroes; but in reality many drivers always return 1
>> because it only applies to a just-created image).=C2=A0 Refactor all use=
s
>> to instead have a single function that returns multiple bits of
>> information, with better naming and documentation.
>=20
> Sounds good
>=20
>>
>> No semantic change, although some of the changes (such as to qcow2.c)
>> require a careful reading to see how it remains the same.
>>
>=20
> ...
>=20
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 6cd566324d95..a6a227f50678 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>=20
> Hmm, header file in the middle of the patch, possibly you don't use
> [diff]
> =C2=A0=C2=A0=C2=A0 orderFile =3D scripts/git.orderfile
>=20
> in git config.. Or it is broken.
>=20
>> @@ -85,6 +85,28 @@ typedef enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x3ff,
>> =C2=A0 } BdrvRequestFlags;
>>
>> +typedef enum {
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this bit =
if the contents of
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * a freshly-created image with no backing file=
 reads as all
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * zeroes without any additional effort.=C2=A0 =
If .bdrv_co_truncate is
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * set, then this must be clear if BDRV_ZERO_TR=
UNCATE is clear.
>=20
> I understand that this is preexisting logic, but could I ask: why?
> What's wrong
> if driver can guarantee that created file is all-zero, but is not sure
> about
> file resizing? I agree that it's normal for these flags to have the same
> value,
> but what is the reason for this restriction?..

If areas added by truncation (or growth, rather) are always zero, then
the file can always be created with size 0 and grown from there.  Thus,
images where truncation adds zeroed areas will generally always be zero
after creation.

> So, the only possible combination of flags, when they differs, is
> create=3D0 and
> truncate=3D1.. How is it possible?

For preallocated qcow2 images, it depends on the storage whether they
are actually 0 after creation.  Hence qcow2_has_zero_init() then defers
to bdrv_has_zero_init() of s->data_file->bs.

But when you truncate them (with PREALLOC_MODE_OFF, as
BlockDriver.bdrv_has_zero_init_truncate()=E2=80=99s comment explains), the =
new
area is always going to be 0, regardless of initial preallocation.


I just noticed a bug there, though: Encrypted qcow2 images will not see
areas added through growth as 0.  Hence, qcow2=E2=80=99s
bdrv_has_zero_init_truncate() implementation should not return true
unconditionally, but only for unencrypted images.

Max


--5wchGUj0lWjstJkMcvJC2jVzaEx4Wh5Yd--

--PFkSDciiVByunOTp7J81h18f4JboJlQnN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl45rQMACgkQ9AfbAGHV
z0AhUgf7BXPMYMsDabZZLLiI4T7Nev5QGO7VPFq1dEk8toWTtQO/1KLPo7PQZyw4
qlaaYIsZONA+jnV8DNu+OYj7qy3SWQRajfZs4j+VPxLmsI3+9UZMAV7MzOKjWCg0
NgnqJ1NyxVP29V7/drJQ0UgCsnGUAUE99WGTGfe9i/MbKjf0VjIvWQlCKpmDhJvu
Dmw+RR06b/g0ycT04klIBr1/UkTK7jacppFHxxvfT+YvS1pnyKxZzg4UcBd15GnV
/c4VJHhouQsq/8gO5+pU8gjIXvmrZCm4mNG64XWMoCgGgIY1a0MtTEUhe56GtZbs
E+qV5HNsVLTLExyDb0XXtrv2kyHjQQ==
=yh34
-----END PGP SIGNATURE-----

--PFkSDciiVByunOTp7J81h18f4JboJlQnN--


