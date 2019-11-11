Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A4AC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 08:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEECA20656
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 08:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRRO3Ksw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEECA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU5Jn-0002jR-Uv
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 03:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iU5Ir-0002Ay-0B
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 03:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iU5Io-0004Dg-Lq
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 03:44:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iU5Io-0004DC-Dx
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 03:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573461841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Pbfi4Suks0YP5m1BsLmgV7Au9PO7ZphT3IKGe15hhJ0=;
 b=RRRO3KswbBvfOov+74QTS+uqAea1zCRgJByuefpbrBPYZSJmBFkAkvRjA6RaLjEXWVZjf5
 xFXf8+pZ2GLs3kCSsO9fGO1ly4Lca31b388A5tFXUzhzvbBO2TaJ5euoww8MMaEpr71uXe
 f4e36GHP0qvdypiUaKXef3USl08Au1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Qblj-b2fMvSYTX-1WFFnaw-1; Mon, 11 Nov 2019 03:42:50 -0500
X-MC-Unique: Qblj-b2fMvSYTX-1WFFnaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA5E801E5F;
 Mon, 11 Nov 2019 08:42:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-116.ams2.redhat.com
 [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E359C60192;
 Mon, 11 Nov 2019 08:42:43 +0000 (UTC)
Subject: Re: [RFC PATCH v2 14/26] qcow2: Add subcluster support to
 qcow2_get_cluster_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <6932c2ddfe19a564cad7c54246290e166525fc46.1572125022.git.berto@igalia.com>
 <673d72da-bf8c-3ffb-a324-79e93f88a140@redhat.com>
 <w51ftiys7bv.fsf@maestria.local.igalia.com>
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
Message-ID: <e1a91584-ff67-e918-20e7-f96bad5b745b@redhat.com>
Date: Mon, 11 Nov 2019 09:42:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <w51ftiys7bv.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FbCymjLmEURSjMRkyp8tkEEvcY6bQpAgt"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FbCymjLmEURSjMRkyp8tkEEvcY6bQpAgt
Content-Type: multipart/mixed; boundary="fh3pW6BmduHJZsWAby7WxUBi74RQokH1J"

--fh3pW6BmduHJZsWAby7WxUBi74RQokH1J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.11.19 16:42, Alberto Garcia wrote:
> On Mon 04 Nov 2019 03:58:57 PM CET, Max Reitz wrote:

[...]

>>> @@ -514,8 +499,8 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, =
uint64_t offset,
>>
>> I suppose this is get_subcluster_offset now.
>=20
> Hmmm no, this returns the actual host cluster offset, then the caller
> uses offset_into_cluster() to get the final value (which doesn't need to
> be subcluster-aligned anyway).

It still returns the subcluster type, though.  Which makes the whole
thing kind of a weird chimera...  Maybe it would work better if the
subcluster type would be stored in a pointer parameter, so it=E2=80=99d be =
clear?

But does it have actually have any advantages to on one hand return a
cluster-aligned host offset and on the other return a bytes count that
starts at the mid-cluster offset?  That=E2=80=99s weird already.  Maybe the
offset that=E2=80=99s returned should just not be cluster-aligned and the w=
hole
function be called qcow2_get_host_offset().

I suppose one reason (maybe the only one?) to return aligned offsets is
for compressed clusters.  It would be another kind of magic to return
aligned offsets only for them.  But maybe it=E2=80=99s worth it?  (Judging =
from
a quick glance, it doesn=E2=80=99t look too difficult to me to modify the
callers to accept a mid-cluster host offset.)

(Another thing I just noticed is that the comment above
qcow2_get_cluster_offset() needs some fixing, because it still refers to
whole clusters.)

Max


--fh3pW6BmduHJZsWAby7WxUBi74RQokH1J--

--FbCymjLmEURSjMRkyp8tkEEvcY6bQpAgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3JHwEACgkQ9AfbAGHV
z0AVegf+JA0gnScPG16YBiGp1Ny/BuWZ6Ey2ZI0vwe59TzSQkyqzDop5BzTrkMFL
xnkfdI6D3ek200sb9j0OrbLBj/ZlsSNvLjiHKsFuQQr0ocCQk44BaCdzYCearHzv
1KP9y2isEivvln9TsL71OFVTVKlzVKqvARO/GK+Dsm/DoVJHvg8EqRNe8q+KBq2V
vaa58ZPStzCyvp8a4zmb+R3YU9sVJdAPkfzNF/1SS6YHhTrEJbfY22aLh61RqkTV
iuj5kVudr2FLJwF0gI4T3utl06iCUAKlIwRKWNdoRcmyIIyOk6lbEBqDRfNanxH/
9oeJ7B38H5z52fozq1Nnj0u55oOAdA==
=qtLg
-----END PGP SIGNATURE-----

--FbCymjLmEURSjMRkyp8tkEEvcY6bQpAgt--


