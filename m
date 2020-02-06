Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003BDC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADEF206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6iMF8GU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADEF206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeN7-0007eu-UE
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izeLb-0006bT-V6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izeLa-0001nk-Mn
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:25:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izeLa-0001kc-Gl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580984721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fg3UxzO0XfgQ5hIi2m6KdYSLc9bai1SK1YwOcIJcGwM=;
 b=O6iMF8GU3B+I6bQeCWUBHwLGC/LHm3SVO4m2ibQBTpv7qbJeMNLzTAwSSbThJlRq08xTHX
 VQNSHpkOJ/nCFAQT01JEGnyFDhMXwc2HB42j/EN2OMcy6c7V5c6AG2GcnZ4+KwhWJunni+
 v4uPxACqqajD8/k8tVH4Q1BAfYaOvo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-M1QxIKAQPeWa6RP4ZeQD0A-1; Thu, 06 Feb 2020 05:25:17 -0500
X-MC-Unique: M1QxIKAQPeWa6RP4ZeQD0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A6C100551A;
 Thu,  6 Feb 2020 10:25:16 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 337125C1D8;
 Thu,  6 Feb 2020 10:25:15 +0000 (UTC)
Subject: Re: [PATCH v2 01/33] block: Add BlockDriver.is_format
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-2-mreitz@redhat.com>
 <b7d80192-bc07-c1d4-2aa8-c729894cd183@redhat.com>
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
Message-ID: <7cedb1e0-026d-39e2-706f-a6fc5bc642bd@redhat.com>
Date: Thu, 6 Feb 2020 11:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b7d80192-bc07-c1d4-2aa8-c729894cd183@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cC2ii6zptZkBaW8EpMAB9ZzZrONZhV9vm"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cC2ii6zptZkBaW8EpMAB9ZzZrONZhV9vm
Content-Type: multipart/mixed; boundary="VvJydpI1RUoqOBY5uClsHXDHSdMP6wU6T"

--VvJydpI1RUoqOBY5uClsHXDHSdMP6wU6T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 14:51, Eric Blake wrote:
> On 2/4/20 11:08 AM, Max Reitz wrote:
>> We want to unify child_format and child_file at some point.=C2=A0 One of=
 the
>> important things that set format drivers apart from other drivers is
>> that they do not expect other format nodes under them (except in the
>> backing chain).=C2=A0 That means we need something on which to distingui=
sh
>> format drivers from others, and hence this flag.
>=20
> It _is_ possible to set up a format node on top of another;

Sure, but format nodes don=E2=80=99t =E2=80=9Cexpect=E2=80=9D that.  That i=
s, it isn=E2=80=99t what we
should strive to do by default.

(Trying to do format probing inside of an already probed format would be
a security risk, actually.)

> in fact, our
> testsuite does that in at least iotest 072.=C2=A0 I agree that setups lik=
e
> 'qcow2 - qcow2 - file' are uncommon, but the setup 'qcow2 - raw - file'
> may be useful for extracting a partition of a raw disk when it is known
> that the partition in that disk itself contains qcow2 data.
>=20
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>=20
>> +++ b/include/block/block_int.h
>> @@ -94,6 +94,13 @@ struct BlockDriver {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must implement them and return -E=
NOTSUP.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool is_filter;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Set to true if the BlockDriver is a format d=
river.=C2=A0 Format nodes
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * generally do not expect their children to be=
 other format nodes
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * (except for backing files), and so format pr=
obing is disabled
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * on those children.
>=20
> Aha - nested formats ARE still allowed when you explicitly request it
> (which is what iotest 72 does) - what you are stating here is that
> implicit probing of is forbidden for a parent declared as a format
> driver.=C2=A0 That makes more sense.
>=20
> I'm not sure if the commit message needs a tweak, but the patch itself
> is sane as-is.

I=E2=80=99m not sure either.  I think =E2=80=9Cexpect=E2=80=9D is OK as-is.=
  I suppose I could
add a sentence like =E2=80=9C... they do not expect other format nodes unde=
r
them (...).  That is, we must not probe formats inside of formats.=E2=80=9D

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks for reviewing!

Max


--VvJydpI1RUoqOBY5uClsHXDHSdMP6wU6T--

--cC2ii6zptZkBaW8EpMAB9ZzZrONZhV9vm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl476YkACgkQ9AfbAGHV
z0ApqQf+ITx+GkhKTXAkKtQNPHRDeMvZR0IsDd6YwFLl/MZKJVRkWIWsZgLdGjKi
Z+SLoqgv5nJs+ZtcfcDigM3Y7nbr80NiarDEfHUz2ksjbHcc04w9IOYu1TW7sPlk
6V4EXeEk+CXYeuhMNoDOpCH+LR7OIPI4aJuLfH1ca/nViVf2QueNzX1Z/IhM7M6Q
GwsA6Z8bT4KrfVYoEpGcpLjG3qMTijU9aFxGRCedBQwTQoXLjvdUK7t66sY2HZ/W
8T5S8HDPhQijwNSb2BoQH6PA/1EhD/RgYfnPGpzUixumqTuVK48d4pHi5MrtDa8M
J+nOQh/5B2GpwKZhMOC4bsh+rf0WqA==
=ccPy
-----END PGP SIGNATURE-----

--cC2ii6zptZkBaW8EpMAB9ZzZrONZhV9vm--


