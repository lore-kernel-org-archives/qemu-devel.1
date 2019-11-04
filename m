Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCAFCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD4D20663
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiVjuXoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD4D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iReDC-0006bH-71
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRe4U-0004E1-Gn
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRe4T-0003Cn-8Q
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:15:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56252
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRe4T-0003Bi-3H
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572880508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v+10K9yWizD1cBCDj7zY0h0lknO4j3D3hMD0yz9MHiw=;
 b=fiVjuXohm2lXqqLB3T1PlJzNN271V8BvbbSJbCzKKe56MyqYRJm0sNDiZj9NQogkKuB1pC
 JS1tfwSej0kx0+khh0jm2Qjm3FPqOMcb8hVSt4Vmg6BueCH6trFjjs62SUZVscTZeI5hSC
 mxE0EEqswFxZEaL2OctIweK0EZEN1UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-_Ia7_41lOtmXS3eiW1mBTw-1; Mon, 04 Nov 2019 10:15:04 -0500
X-MC-Unique: _Ia7_41lOtmXS3eiW1mBTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8C5F800C73;
 Mon,  4 Nov 2019 15:15:02 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A03C6600C4;
 Mon,  4 Nov 2019 15:14:58 +0000 (UTC)
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
To: Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <02291bca-67d2-ed30-ac34-17641afbe397@virtuozzo.com>
 <d1b43c24-a443-dd19-6814-11eec43e943a@virtuozzo.com>
 <0f75cbcf-e6c7-c74c-972b-22e7760a8b5c@redhat.com>
 <w51r22nspqp.fsf@maestria.local.igalia.com>
 <7ed9b8f0-2d8c-7bac-185e-9a1dd68fcce8@redhat.com>
 <w51mudbsmk7.fsf@maestria.local.igalia.com>
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
Message-ID: <5b67cf39-0ea1-d205-0e96-7b1148c7df19@redhat.com>
Date: Mon, 4 Nov 2019 16:14:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <w51mudbsmk7.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="98JCLW6VxP32iBmnGhZGOeUqxBdaySizV"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--98JCLW6VxP32iBmnGhZGOeUqxBdaySizV
Content-Type: multipart/mixed; boundary="UqOCLkW9V5lKCSQGfk8J0oJ9fn7xRCogH"

--UqOCLkW9V5lKCSQGfk8J0oJ9fn7xRCogH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.11.19 16:12, Alberto Garcia wrote:
> On Mon 04 Nov 2019 03:25:12 PM CET, Max Reitz wrote:
>>>>>> So, it's obvious that c8bb23cbdbe32f5c326 is significant for 1M
>>>>>> cluster-size, even on rotational disk, which means that previous
>>>>>> assumption about calling handle_alloc_space() only for ssd is wrong,
>>>>>> we need smarter heuristics..
>>>>>>
>>>>>> So, I'd prefer (1) or (2).
>>>>
>>>> OK.  I wonder whether that problem would go away with Berto=E2=80=99s =
subcluster
>>>> series, though.
>>>
>>> Catching up with this now. I was told about this last week at the KVM
>>> Forum, but if the problems comes with the use of fallocate() and XFS,
>>> the I don't think subclusters will solve it.
>>>
>>> handle_alloc_space() is used to fill a cluster with zeroes when there's
>>> COW, and that happens the same with subclusters, just at the subcluster
>>> level instead of course.
>>>
>>> What can happen, if the subcluster size matches the filesystem block
>>> size, is that there's no need for any COW and therefore the bug is neve=
r
>>> triggered. But that's not quite the same as a fix :-)
>>
>> No, what I meant was that the original problem that led to c8bb23cbdbe
>> would go away.
>=20
> Ah, right. Not quite, according to my numbers:
>=20
> |--------------+----------------+-----------------+-------------|
> | Cluster size | subclusters=3Don | subclusters=3Doff | fallocate() |
> |--------------+----------------+-----------------+-------------|
> |       256 KB |     10182 IOPS |        966 IOPS |  14007 IOPS |
> |       512 KB |      7919 IOPS |        563 IOPS |  13442 IOPS |
> |      1024 KB |      5050 IOPS |        465 IOPS |  13887 IOPS |
> |      2048 KB |      2465 IOPS |        271 IOPS |  13885 IOPS |
> |--------------+----------------+-----------------+-------------|
>=20
> There's obviously no backing image, and only the last column uses
> handle_alloc_space() / fallocate().

Thanks for providing some numbers!

It was my impression, too, that subclusters wouldn=E2=80=99t solve it.  But=
 it
didn=E2=80=99t seem like that big of a difference to me.  Did you run this =
with
aio=3Dnative?  (Because that=E2=80=99s where we have the XFS problem)

Max


--UqOCLkW9V5lKCSQGfk8J0oJ9fn7xRCogH--

--98JCLW6VxP32iBmnGhZGOeUqxBdaySizV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3AQHEACgkQ9AfbAGHV
z0CB7Qf/d7/3vCb4tTxpAOyEktDN7DeObB+Psu1Fonw1AW+/M1ASeQ+VARibFXXF
fDgBTu8qlO6j+No1tD/CPtk+8DNPnENYu5+SRKem4PcI+kC7nKuYNZVOvxVRkfyI
DO+DpoaZd6goYrFm3dYrOC+gQdTNSGMOue0seMX2agXr0lwlwn0cGqnFBS1HrV5G
wcmIDMiNbQw1qhisdr47vg3HSzygCNbj7OqkVPXz2AXIFSdZmIitm3OD2E6JikYm
rYIkcjE6TsAC3hzQU4g/oJ5evmWJopGF00MgQWFkwxQVK/jeoqt/FtKmf3Hvrrqq
TL5hSCFAgKKWJkz+JSj7t+5UpFbe8A==
=ITTi
-----END PGP SIGNATURE-----

--98JCLW6VxP32iBmnGhZGOeUqxBdaySizV--


