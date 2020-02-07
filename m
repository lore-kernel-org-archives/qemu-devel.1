Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55868C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2100B2082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cdl/B4sD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2100B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00zo-0006vp-BS
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j00xO-0003bm-Ni
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j00xN-0005gN-Hg
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:33:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j00xN-0005ey-C1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581071633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XC/uirGSwYFe9I7p9fFQf/EhoW/q3te8Lxk2LhUXG/s=;
 b=Cdl/B4sDyY3X/jsdTMZsmHHrcEPvNrYlxQ+RO4evirPqAe0gzrHJkERjNtBs9v3cjVxu/r
 N2TS0J0lQIgtHPfGtHLVAGKNUzaBv+ovdv2gkRkMx21c9n7A+TMnKdAUq+fNNJPncZ0aki
 H/MDSivwwulhDWCigeWNoxaDZkbq7SM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-FWragMplPJyCSIq9T0hQsQ-1; Fri, 07 Feb 2020 05:33:51 -0500
X-MC-Unique: FWragMplPJyCSIq9T0hQsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3FE5DB6C;
 Fri,  7 Feb 2020 10:33:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-88.ams2.redhat.com
 [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 133901FE07;
 Fri,  7 Feb 2020 10:33:47 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] qemu-img: Add --target-is-zero to convert
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 David Edmondson <david.edmondson@oracle.com>, qemu-devel@nongnu.org
References: <20200204095246.1974117-1-david.edmondson@oracle.com>
 <20200204095246.1974117-2-david.edmondson@oracle.com>
 <90f3f74b-6154-d7ce-4e0e-ba4422f7da11@redhat.com>
 <91c3d45b-4c27-d366-6dd9-5c27164cce35@virtuozzo.com>
 <92ca6082-a3a6-c116-d1cc-e9810280c0c6@redhat.com>
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
Message-ID: <38ac63ec-af49-d9d5-c1d4-e45614b71d4c@redhat.com>
Date: Fri, 7 Feb 2020 11:33:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <92ca6082-a3a6-c116-d1cc-e9810280c0c6@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AlpM2mFvtFQVWfxyWBRNnEGd42t0bOVnk"
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AlpM2mFvtFQVWfxyWBRNnEGd42t0bOVnk
Content-Type: multipart/mixed; boundary="ZyVvruXfMo4n069GRzvIq6Vu0MuXFsIlr"

--ZyVvruXfMo4n069GRzvIq6Vu0MuXFsIlr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.02.20 15:23, Eric Blake wrote:
> On 2/4/20 7:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>=20
>>> I understand that it is safer to have restrictions now and lift them
>>> later, than to allow use of the option at any time and leave room for
>>> the user to shoot themselves in the foot with no way to add safety
>>> later.=C2=A0 The argument against no backing file is somewhat
>>> understandable (technically, as long as the backing file also reads
>>> as all zeroes, then the overall image reads as all zeroes - but why
>>> have a backing file that has no content?); the argument requiring -n
>>> is a bit weaker (if I'm creating an image, I _know_ it reads as all
>>> zeroes, so the --target-is-zero argument is redundant, but it
>>> shouldn't hurt to allow it).
>>
>> I know that it reads as all zeroes, only if this format provides zero
>> initialization..
>>
>>>
>>>> +++ b/qemu-img.c
>>>
>>>> @@ -2247,6 +2256,11 @@ static int img_convert(int argc, char **argv)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("Th=
is will become an error in future QEMU
>>>> versions.");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 if (s.has_zero_init && !skip_create) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("--target-is-=
zero requires use of -n flag");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail_getopt;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> So I think we could drop this hunk with no change in behavior.
>>
>> I think, no we can't. If we allow target-is-zero, with -n, we'd better
>> to check that what we are creating is zero-initialized (format has
>> zero-init), and if not we should report error.
>>
>=20
> Good call.=C2=A0 Yes, if we allow --target-is-zero without -n, we MUST in=
sist
> that bdrv_has_zero_init() returns 1 (or, after my followup series,
> bdrv_known_zeroes() includes BDRV_ZERO_CREATE).

Why?

I could imagine a user creating a qcow2 image on some block device with
preallocation where we cannot verify that the result will be zero.  But
they want qemu not to zero the device, so they would specify
--target-is-zero.

OTOH, we can always choose to allow that behavior at a later point.

Max


--ZyVvruXfMo4n069GRzvIq6Vu0MuXFsIlr--

--AlpM2mFvtFQVWfxyWBRNnEGd42t0bOVnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl49PQoACgkQ9AfbAGHV
z0BRDAf8DE34yZ3XxPkcKvFkyMN1CWuiZ2VQETZY3qZ00EeRZ74xmiHhs9M8xA7P
p1hRkjYUjBjkFcfI1rLL26NSBBwRjP+S9cPKjgU4TSR8Ap8eD/ukMiGuygu8F4U/
9ZQMr/ZvCNzpvl7llLSM3qrV/mQ7sVelsMTXtXyQAu++cQKCop1zuMyw4cfPs9m6
iZBJxcgxxAf30oF9YEdpQP6VGiFxEyNxX8H38h28pXzBvXWOwXpQs3BSpW0PDsxE
DrRRa6DS/CAaXljChqKFDQpS9oXXZ8iudHCkcvjID/5VyZC14EXhe7VLUiKnnvHD
5jw5N6M7gVxh6x6WVq4iZLeBfqSxuA==
=iiab
-----END PGP SIGNATURE-----

--AlpM2mFvtFQVWfxyWBRNnEGd42t0bOVnk--


