Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ADEC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E372082D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 13:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXYYAuRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E372082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMWwL-0003Wb-9L
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 09:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jMWrw-0007tp-5l
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jMWrv-0001GE-4w
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:05:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30938
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jMWrv-0001Fv-1N
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 09:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586437518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kYgqIkv7yaYP9W82/hvFPZw0xyJRvV8j0MqfERW9mk4=;
 b=PXYYAuRd1RlyaigAaTzCneosKYdL9AN27M7G7XtSblEsSSZwXvPbBPfCqXimD7V+D/TTay
 vZwYSTCdEQ0JqdSQVJQ7FjxFl/ThKvudGAGwfbHZBZfuvqcjwd5DpJoffJD0NJr5mbhG1X
 h8jQbMDy8/jw/TAqGI2iKizVAE8CZRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-dcO1czuZML6VdP68Hz9ipw-1; Thu, 09 Apr 2020 09:05:14 -0400
X-MC-Unique: dcO1czuZML6VdP68Hz9ipw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66890800D5C;
 Thu,  9 Apr 2020 13:05:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-98.ams2.redhat.com
 [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE6FB5D9E5;
 Thu,  9 Apr 2020 13:05:11 +0000 (UTC)
Subject: Re: qcow2: Zero-initialization of external data files
To: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
 <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
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
Message-ID: <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
Date: Thu, 9 Apr 2020 15:05:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MLzLY8gT8UKDqPDDIOm10T7K1kAm2Oiai"
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MLzLY8gT8UKDqPDDIOm10T7K1kAm2Oiai
Content-Type: multipart/mixed; boundary="QpP9iWVKcHdctget9Hu5tSGfQnYxNEBGn"

--QpP9iWVKcHdctget9Hu5tSGfQnYxNEBGn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.04.20 00:22, Eric Blake wrote:
> On 2/17/20 10:56 AM, Max Reitz wrote:
>> Hi,
>>
>> AFAIU, external data files with data_file_raw=3Don are supposed to retur=
n
>> the same data as the qcow2 file when read.=C2=A0 But we still use the qc=
ow2
>> metadata structures (which are by default initialized to =E2=80=9Ceveryt=
hing
>> unallocated=E2=80=9D), even though we never ensure that the external dat=
a file
>> is zero, too, so this can happen:
>>
>> $ dd if=3D/dev/urandom of=3Dfoo.raw 64M
>> [...]
>>
>> $ sudo losetup -f --show foo.raw
>> /dev/loop0
>>
>> $ sudo ./qemu-img create -f qcow2 -o \
>> =C2=A0=C2=A0=C2=A0=C2=A0 data_file=3D/dev/loop0,data_file_raw=3Don foo.q=
cow2 64M
>> [...]
>>
>> $ sudo ./qemu-io -c 'read -P 0 0 64M' foo.qcow2
>> read 67108864/67108864 bytes at offset 0
>> 64 MiB, 1 ops; 00.00 sec (25.036 GiB/sec and 400.5751 ops/sec)
>=20
> This looks like a bug (and we should fix it for 5.0 if possible)

It seems a bit difficult for 5.0 now.  (But I don=E2=80=99t think it=E2=80=
=99d be a
regression, so that shouldn=E2=80=99t be too bad.)

> read
> of a data_file_raw=3Don should not treat unallocated clusters as reading
> 0, but rather as reading whatever the raw data contains.
>=20
>>
>> $ sudo ./qemu-io -c 'read -P 0 0 64M' -f raw foo.raw
>> Pattern verification failed at offset 0, 67108864 bytes
>> read 67108864/67108864 bytes at offset 0
>> 64 MiB, 1 ops; 00.01 sec (5.547 GiB/sec and 88.7484 ops/sec)
>>
>> I suppose this behavior is fine for blockdev-create because I guess it=
=E2=80=99s
>> the user=E2=80=99s responsibility to ensure that the external data file =
is zero.
>> =C2=A0 But maybe it isn=E2=80=99t, so that=E2=80=99s my first question: =
Is it really the
>> user=E2=80=99s responsibility or should we always ensure it=E2=80=99s ze=
ro?
>=20
> I'd argue that requiring the user to pre-zero the raw data file is
> undesirable; and that we should instead fix our code to not report the
> image as reading all zeroes when creating with data_file_raw=3Don.

OK.  I think that could be achieved by just enforcing @preallocation to
be at least =E2=80=9Cmetadata=E2=80=9D whenever @data-file-raw is set.  Wou=
ld that make
sense?

Max

>> My second question is: If we decide that this is fine for
>> blockdev-create, should at least qcow2_co_create_opts() ensure the data
>> file it just created is zero?
>=20
> Having an option to make qemu force-zero the raw image during
> qcow2_co_create_opts seems reasonable, but for performance reasons, I
> don't think the flag should be on by default.
>=20



--QpP9iWVKcHdctget9Hu5tSGfQnYxNEBGn--

--MLzLY8gT8UKDqPDDIOm10T7K1kAm2Oiai
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6PHYUACgkQ9AfbAGHV
z0AyiQgAsXAmSHQpPfJME9djs9vhL7HfvsqPuzxru+D5E2A0TCOkRuAS+HXHweuI
Izv8AxyM5g8y6tW0+yGwkyEi0HaICuKPYbSkwq9+zBo9bcL+evPEx495FxMER+yt
dA8sUiIXpM/X+Y4HuBT17056uSY/D/WCgoz0zFuxhUCnW04TbCdX+I2xXSkaTshO
01c1WaZ/PMlCwTAx79iDn70EScqeiNhqWBlCIzvCOTg7RBc17930BxPzL0KEnKvt
ZVn5ILfPw5qNgi/ikRkdCeAfysqGUeeAHylcZOkU3xP5Zv4Fq3eE2XHgSqQBVcmH
cIWp+vmPa8qeykONEsQcahUnWG17xQ==
=wWe1
-----END PGP SIGNATURE-----

--MLzLY8gT8UKDqPDDIOm10T7K1kAm2Oiai--


