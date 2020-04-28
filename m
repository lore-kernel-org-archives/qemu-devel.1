Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A08C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0179206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBNziWcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0179206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTPnX-00045U-Tn
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 08:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTPmO-0003DV-Vy
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTPlm-0008E5-Or
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:56:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38463
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTPlm-0008Dk-8v
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588078524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oHmFHT6deNKGYvXY2T+WDWS9954OZh0fAnqKyrFUdpw=;
 b=cBNziWcFf9gdU2la7ogFttrAXPUIjhdLswRHHiiEkFK+TUqYgcoXabycNxztwBtaV0evDD
 4bENTWiYsL+RWVeB9vQ53y+5N7WFVl0pv0GlWFpXsrgjU6wS/AXf+u762Q+RQAraWvbnEJ
 mAtJpajiOwie7m5UxBd4hRqiVgbnbRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-CtdRJ1YUPYOACXcgKbL8SA-1; Tue, 28 Apr 2020 08:55:21 -0400
X-MC-Unique: CtdRJ1YUPYOACXcgKbL8SA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA08C802EB0;
 Tue, 28 Apr 2020 12:55:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F47C50C20;
 Tue, 28 Apr 2020 12:55:17 +0000 (UTC)
Subject: Re: [PATCH v20 4/4] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-5-dplotnikov@virtuozzo.com>
 <c0fdc097-dabd-4661-fce9-a63a24a8d792@redhat.com>
 <64471c60-6bdd-fc7a-2dec-ff480137fec8@virtuozzo.com>
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
Message-ID: <f96f8020-2c39-3676-3bff-d35038f6e3df@redhat.com>
Date: Tue, 28 Apr 2020 14:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <64471c60-6bdd-fc7a-2dec-ff480137fec8@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fxl4LJAcBVqGMHY5CvxbK1UTDqNtMLAmg"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fxl4LJAcBVqGMHY5CvxbK1UTDqNtMLAmg
Content-Type: multipart/mixed; boundary="lIMUERPs6fJjZaWXYprjAEfvAsih3Cdyd"

--lIMUERPs6fJjZaWXYprjAEfvAsih3Cdyd
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 13:41, Denis Plotnikov wrote:
>=20
>=20
> On 27.04.2020 16:29, Max Reitz wrote:
>> On 21.04.20 10:11, Denis Plotnikov wrote:
>>> The test checks fulfilling qcow2 requirements for the compression
>>> type feature and zstd compression type operability.
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> ---
>>> =A0 tests/qemu-iotests/287=A0=A0=A0=A0 | 146 ++++++++++++++++++++++++++=
+++++++++++
>>> =A0 tests/qemu-iotests/287.out |=A0 67 +++++++++++++++++
>>> =A0 tests/qemu-iotests/group=A0=A0 |=A0=A0 1 +
>>> =A0 3 files changed, 214 insertions(+)
>>> =A0 create mode 100755 tests/qemu-iotests/287
>>> =A0 create mode 100644 tests/qemu-iotests/287.out
>>>
>>> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
>>> new file mode 100755
>>> index 0000000000..156acc40ad
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/287
>>> @@ -0,0 +1,146 @@
>>> +#!/usr/bin/env bash
>>> +#
>>> +# Test case for an image using zstd compression
>>> +#
>>> +# Copyright (c) 2020 Virtuozzo International GmbH
>>> +#
>>> +# This program is free software; you can redistribute it and/or modify
>>> +# it under the terms of the GNU General Public License as published by
>>> +# the Free Software Foundation; either version 2 of the License, or
>>> +# (at your option) any later version.
>>> +#
>>> +# This program is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the
>>> +# GNU General Public License for more details.
>>> +#
>>> +# You should have received a copy of the GNU General Public License
>>> +# along with this program.=A0 If not, see <http://www.gnu.org/licenses=
/>.
>>> +#
>>> +
>>> +# creator
>>> +owner=3Ddplotnikov@virtuozzo.com
>>> +
>>> +seq=3D"$(basename $0)"
>>> +echo "QA output created by $seq"
>>> +
>>> +status=3D1=A0=A0=A0 # failure is the default!
>>> +
>>> +# standard environment
>>> +. ./common.rc
>>> +. ./common.filter
>>> +
>>> +# This tests qocw2-specific low-level functionality
>>> +_supported_fmt qcow2
>>> +_supported_proto file
>>> +_supported_os Linux
>> This test doesn=92t work with compat=3D0.10 (because we can=92t store a
>> non-default compression type there) or data_file (because those don=92t
>> support compression), so those options should be marked as unsupported.
>>
>> (It does seem to work with any refcount_bits, though.)
>=20
> Could I ask how to achieve that?
> I can't find any _supported_* related.


It=92s _unsupported_imgopts.

Max


--lIMUERPs6fJjZaWXYprjAEfvAsih3Cdyd--

--Fxl4LJAcBVqGMHY5CvxbK1UTDqNtMLAmg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6oJ7MACgkQ9AfbAGHV
z0A4eAf+JbEkJmtrBThd7degz3ICgUzhAwxVr1kC3UMsep23EmfNJvyIXvMST2Sp
LLaaql76QDNBniy6oN47ScJ5NPV53GE5LHPrs+RM8k5P8jtTzEk346lZ/7YMM8BE
/hswxl4wX2P2Hw/5qZYlPV4xk8OVZX9W3rwOAEapnNS7o+uRSED9A8dw+C97wBom
N/j5Xj1zG1m8Lh+IdHU7xow731QBx5knwcrL1HQDQjcTC6pSd9B4U7/n5MKlK3/Q
/+YPAGTpNhkRjOuqc+ntHerrKwZ8De455aNzfSfsYx3+UDNK/sFnlhC84VtPhIih
a6Yc9QaSQlFM2fxkX3dvrCk7ikDJGQ==
=znfy
-----END PGP SIGNATURE-----

--Fxl4LJAcBVqGMHY5CvxbK1UTDqNtMLAmg--


