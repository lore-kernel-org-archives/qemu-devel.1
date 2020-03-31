Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD8AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1B920781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAMF2jFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1B920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEOR-00063J-Uq
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jJENd-00055T-Lj
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jJENb-0000Kt-M2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:44:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50350
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jJENZ-0000Ja-Td
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585651461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F0I0D9QLBDVbelfIccYeYnmPXoV456iyYCQYpdBo+LE=;
 b=bAMF2jFS+oUpe+JPRdkemLH0OAeoVYtCjWGrl/AOfL2gi1Mktzk8A1gX6fvOciqFLA8Va/
 49OhfuL1ePbdV+j9wItaZUhSO/vuOAeKVfY2WcTknVCRntobPDGXix1LouASHkGILXKhDq
 oQzBH2W9bkVFaQnXnHlbZG0gEiTWmQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-SE00avBCOxWF-ZtfSN9xlQ-1; Tue, 31 Mar 2020 06:44:19 -0400
X-MC-Unique: SE00avBCOxWF-ZtfSN9xlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83F408017CC;
 Tue, 31 Mar 2020 10:44:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE38A19925;
 Tue, 31 Mar 2020 10:44:13 +0000 (UTC)
Subject: Re: [PATCH v4] qcow2: Forbid discard in qcow2 v2 images with backing
 files
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200327185930.19493-1-berto@igalia.com>
 <81e31d93-8bd6-476b-ff92-080da8a2cd67@redhat.com>
 <44971b75-3a06-3111-716e-8e615f775f0f@redhat.com>
 <w51v9mkx36x.fsf@maestria.local.igalia.com>
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
Message-ID: <efcc0408-2a60-532f-b813-7efed2e6cbb1@redhat.com>
Date: Tue, 31 Mar 2020 12:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <w51v9mkx36x.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7YsuTdw4uFHtqcNErBKEJAaNx1BozcV2P"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7YsuTdw4uFHtqcNErBKEJAaNx1BozcV2P
Content-Type: multipart/mixed; boundary="DzEw1Y38AYB4OoHwTYNuM30RhYsSD9kcu"

--DzEw1Y38AYB4OoHwTYNuM30RhYsSD9kcu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.03.20 11:51, Alberto Garcia wrote:
> On Tue 31 Mar 2020 10:57:18 AM CEST, Max Reitz wrote:
>> I=E2=80=99ll have to dequeue it again, because it breaks iotests 046 and=
 177
>> (both of which already have special handling for v2-specific discard;
>> but it needs to be adjusted now that the discard operation no longer
>> reveals the backing file contents).
>=20
> ??? None of those break for me, is that in your branch or in master?

Er, oops.  Somehow I forgot to note that they break for v2 images, so
with -o compat=3D0.10:

$ ./check -T -qcow2 -o compat=3D0.10 46 177

Max


--DzEw1Y38AYB4OoHwTYNuM30RhYsSD9kcu--

--7YsuTdw4uFHtqcNErBKEJAaNx1BozcV2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6DHvsACgkQ9AfbAGHV
z0DC3wf+M6bUiqgZeIrftdj5Ew/T48yzvEMEnRG0/vVOSKwRYsezf+Alp/AL7NzF
0juQr5bWtl7tBmxcoBVe1l883B/x3NeST0/gou2RCua3uYZ+B8WKwBEw3Y6B1YEu
3QQ4OxuW/E1TBUWj10js5KIN2sMMMOJCNRx4/Cjz0OxtH1rEXyiGwHVxi9nTpM2x
KlOpZPOjDs+pHinWJRYIbyCYzH2uThOPJqgbKDre2ZlzdPat1urn83GB3H9fwWfh
m+O1vLPFbnQboMO80lEpF/X3GlWdYm0Q4noENHjH5WwIqIpceglAwrFl45mczqsr
KaOI7ly9ArdL389NS77YG/jne1hk4g==
=4C0b
-----END PGP SIGNATURE-----

--7YsuTdw4uFHtqcNErBKEJAaNx1BozcV2P--


