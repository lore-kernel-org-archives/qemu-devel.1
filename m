Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF650CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8713620659
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqilZaBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8713620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRdt2-00059m-Jf
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRdrW-0004cG-9p
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRdrU-0007I1-4p
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:01:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52019
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRdrS-0007H3-9D
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572879701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yD2h/UoyEUVniUqaos8Kk3enCI1cb8xW822YXo4OdV4=;
 b=WqilZaBvrotBiaf6VfgFTiOu/rDA/mLXEtxcK1wLMAFYdzg90Q/mRXpUouxyweJibID1bq
 hZy6DZRLXsAJuKjquRCsR3iCuOK4Ip18w3QZnIk7x8eE4CeIy2/vPgH7giSF1PdqrZBNZr
 zY5inXWkyD5oG4X4v0Yi/mMY6mlYdUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-gnzJs2eyPveLgMXpNgjUCw-1; Mon, 04 Nov 2019 10:01:37 -0500
X-MC-Unique: gnzJs2eyPveLgMXpNgjUCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEBA7800C73;
 Mon,  4 Nov 2019 15:01:35 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D9B219C68;
 Mon,  4 Nov 2019 15:01:34 +0000 (UTC)
Subject: Re: [RFC PATCH v2 11/26] qcow2: Add qcow2_get_subcluster_type()
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <b497a6d5d5876f68a7320f58dad56806bab95cde.1572125022.git.berto@igalia.com>
 <7d2238bf-1c8d-5d5d-a0d3-c700725dc44d@redhat.com>
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
Message-ID: <06567def-1c50-f2f5-4157-edc260a9b353@redhat.com>
Date: Mon, 4 Nov 2019 16:01:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7d2238bf-1c8d-5d5d-a0d3-c700725dc44d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="J9ecwNKENCZQuBVYmksQK07xL0ybHKC6g"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J9ecwNKENCZQuBVYmksQK07xL0ybHKC6g
Content-Type: multipart/mixed; boundary="4SXzK5BlBeIuGVcVGYyLjPTlEums7ZT83"

--4SXzK5BlBeIuGVcVGYyLjPTlEums7ZT83
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.11.19 13:35, Max Reitz wrote:
> On 26.10.19 23:25, Alberto Garcia wrote:
>> This function returns the type of an individual subcluster. If an
>> image does not have subclusters then this returns the exact same value
>> as qcow2_get_cluster_type().
>>
>> The information in standard and extended L2 entries is encoded in a
>> slightly different way, but all existing QCow2ClusterType values are
>> also valid for subclusters and have the same meanings (although they
>> typically only apply to the requested subcluster).
>>
>> There are two important exceptions to this:
>>
>>   a) QCOW2_CLUSTER_COMPRESSED means that the whole cluster is
>>      compressed. We do not support compression at the subcluster
>>      level.
>>
>>   b) QCOW2_CLUSTER_UNALLOCATED means that the cluster is unallocated,
>>      that is, the offset field of the L2 entry does not point to a
>>      host cluster. All subclusters are obviously unallocated too but
>>      any of them could be of type QCOW2_CLUSTER_ZERO_PLAIN.
>>
>> In addition to that, extended L2 entries allow one new scenario where
>> the cluster is normally allocated but an individual subcluster is not.
>> This is very different from (b) and because of that this patch adds a
>> new value called QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER.
>>
>> As a last thing, this patch adds QCOW2_CLUSTER_INVALID to detect the
>> cases where an L2 entry has a value that violates the spec. The caller
>> is responsible for handling these situations.
>>
>> To prevent compatibility problems with images that have invalid values
>> but are currently being read by QEMU without causing side effects,
>> QCOW2_CLUSTER_INVALID is only returned for images with extended L2
>> entries.
>>
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2.h | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 62 insertions(+)
>=20
> [...]
>=20
>> +        case QCOW2_CLUSTER_ZERO_PLAIN:
>> +        case QCOW2_CLUSTER_ZERO_ALLOC:
>> +            return QCOW2_CLUSTER_INVALID;
>=20
> The spec doesn=E2=80=99t say anything about this, though.

It does, I just forgot. O:-)

Max


--4SXzK5BlBeIuGVcVGYyLjPTlEums7ZT83--

--J9ecwNKENCZQuBVYmksQK07xL0ybHKC6g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3APUwACgkQ9AfbAGHV
z0AZ6Af+PsEBKbcbYskexbsl06SHzi8CKvmvGtu53llzj2WSriMv+4C4Aa6lKf3A
upwYhMPyVRS2tWudwrz3VhaVVFqukaYDBwAD8nbchXa1+GjhqaAD9GjFPIVKrwOL
sdX5cruETv7vR8ZTFpYDXNZg1ofV4kusbsdceeh6ElHl/aAKC58bdVAXhtLF/ZK3
NnVAhosVZaBSEbb3BdceLI85X9xjKJPkjFcqXgG5tIMZcxvL8lUF0JRzpymNCxKy
LhC630mPIgSOIODtdpl3jXSO9P6eKMu0Z+GkImqKsuyZoS4SqR2YkMhuI3+lUnNo
XpsFGKOrKMh+KOOjcVoaI6FXH8G2hA==
=kRNz
-----END PGP SIGNATURE-----

--J9ecwNKENCZQuBVYmksQK07xL0ybHKC6g--


