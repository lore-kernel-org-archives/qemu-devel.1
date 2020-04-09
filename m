Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36813C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0160A20692
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXJ+pGyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0160A20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYhO-00039r-6C
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jMYgS-0002YZ-Qz
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jMYgR-0005vu-R5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:01:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48379
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jMYgR-0005vR-Nc
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586444495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RGA/owjDbrySdOBoMEaK9eZIVZHVzvRj7zbOKQMiUxg=;
 b=VXJ+pGyGCt6abzZHr1VtMDHULTWPCeGN31hSkl4mib49k8gZEokNCvnhUIPs2jaVV8bqVo
 82wTBXm6LYkeJC2pcjZjKVi3yusmevmiR4p9bNOCNaQU3An5b/L0mts2vet+VQAqZmcRlb
 pSY3btL3da1DHQ0VaFjitDYP7ckdfz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-mZT38qcyNIaXypb69vzvHQ-1; Thu, 09 Apr 2020 11:01:31 -0400
X-MC-Unique: mZT38qcyNIaXypb69vzvHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CCDE149C4;
 Thu,  9 Apr 2020 15:01:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-98.ams2.redhat.com
 [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C4721195AD;
 Thu,  9 Apr 2020 15:01:26 +0000 (UTC)
Subject: Re: qcow2: Zero-initialization of external data files
To: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <db0b4b5c-d564-f003-bbbc-9afdcac07cc4@redhat.com>
 <50080252-ff22-78ed-0002-1742c694471b@redhat.com>
 <8b4bc264-7bce-c9c1-1905-a22b4c61cae4@redhat.com>
 <ad2542f0-1faf-88eb-9dac-36d87a2a795f@redhat.com>
 <ff515dc1-0ac1-08c6-b636-cd50c09cab7d@redhat.com>
 <e91aa2c9-5709-ee1c-d8e9-45f12493613e@redhat.com>
 <cc17fee7-3349-063c-3531-f6239676dc50@redhat.com>
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
Message-ID: <713d39ff-29f6-f9e0-bbbc-c9b26ffd28a0@redhat.com>
Date: Thu, 9 Apr 2020 17:01:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cc17fee7-3349-063c-3531-f6239676dc50@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0akCmnqqclApdG8I6NOYgGfo9Q1puGe3W"
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
--0akCmnqqclApdG8I6NOYgGfo9Q1puGe3W
Content-Type: multipart/mixed; boundary="QsRABDBkwrxcfcIHMAIvkfD2J0HhuSSQO"

--QsRABDBkwrxcfcIHMAIvkfD2J0HhuSSQO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.04.20 16:32, Eric Blake wrote:
> On 4/9/20 9:10 AM, Max Reitz wrote:
>=20
>>>
>>> What happens when an operation attempts to unmap things?=C2=A0 Do we re=
ject
>>> all unmap operations when data-file-raw is set (thus leaving a cluster
>>> marked as allocated at all times, if we can first guarantee that
>>> preallocation set things up that way)?
>> No, unmap operations currently work.=C2=A0 qcow2_free_any_clusters() pas=
ses
>> them through to the external data file.
>>
>> The problem is that the unmap also zeroes the L2 entry, so if you then
>> write data to the raw file, it won=E2=80=99t be visible from the qcow2 s=
ide of
>> things.=C2=A0 However, I=E2=80=99m not sure whether we support modificat=
ions of a raw
>> file when it is already =E2=80=9Cin use=E2=80=9D by a qcow2 image, so ma=
ybe that=E2=80=99s fine.
>=20
> We don't support concurrent modification. But if the guest is running
> and unmaps things, then shuts off, then we edit the raw file offline,
> then we restart the guest, the guest should see the results of those
> offline edits.

Should it?  The specification doesn=E2=80=99t say anything about that.

In fact, I think we have always said we explicitly discourage that
because this might lead to outdated metadata; even though we usually
meant =E2=80=9Cdirty bitmaps=E2=80=9D by that.

Max


--QsRABDBkwrxcfcIHMAIvkfD2J0HhuSSQO--

--0akCmnqqclApdG8I6NOYgGfo9Q1puGe3W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6POMQACgkQ9AfbAGHV
z0Atvgf+OqRJixMQXYS0XBJfQ7p+BKDSixMSg4mqTRLIBSuQ65H/MjWaNo2ERg54
TMHCh2Z58r4emVF/puLEax6cYIv78KTUdsUuKsxcz8ewPMaBHyvG4tO0u1St23D0
fsR1K65Htufrwu79e7fytReSe+Zk3rsfxuI+sXXdWmQPU5c/mjQqgdInXTXlDoK2
cdvalj77vXctjtbcBjaVd10ndw2Q3UdOjNePRqB4thucOYiHBQO0Tcq4U4cRX0m9
Ynx+tsEB6fkwmm47BKCRJUrEz864yFISoT2QNNNjBljSV75fpg6VUPk43LRQpvl7
9uuVgDdfrfQbHENoqZwSer6q6puAgQ==
=SIWP
-----END PGP SIGNATURE-----

--0akCmnqqclApdG8I6NOYgGfo9Q1puGe3W--


