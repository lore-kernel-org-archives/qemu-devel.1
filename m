Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96023C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E50324672
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SX8LkI+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E50324672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4pXc-0004rf-Kj
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4pWw-0004Du-CT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4pWs-0003Hd-IV
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:22:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49606
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4pWs-0003Eh-DW
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582219345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Su2R4dlClQW1B/w2OuzCGw1HIW/nioyaiE5OOwgYqlg=;
 b=SX8LkI+uWdLUcWMaByVhqxoU/OVIrBZNFoxd+1kHfPTx0Aq7cl7f+3fhGe0J0KkQFGQD09
 V0ngRLVWOHyZJQcnadI+ynnWbtBVlLeTw4WQHEcPpVSYgn2XD/VVhdGg/NOY5IYbqSfQkO
 PgF+poMCzYAmdHck88eUsukxmfiYCHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-9vsJyhOwNfaTrQ3vuMSJvQ-1; Thu, 20 Feb 2020 12:22:21 -0500
X-MC-Unique: 9vsJyhOwNfaTrQ3vuMSJvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EBA88014D0;
 Thu, 20 Feb 2020 17:22:19 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA21160BE2;
 Thu, 20 Feb 2020 17:21:43 +0000 (UTC)
Subject: Re: [RFC PATCH v3 11/27] qcow2: Add QCow2SubclusterType and
 qcow2_get_subcluster_type()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <124dca3e5be368048346209754fec38dff404990.1577014346.git.berto@igalia.com>
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
Message-ID: <80213b27-539f-0ab1-9983-16b5bb16d666@redhat.com>
Date: Thu, 20 Feb 2020 18:21:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <124dca3e5be368048346209754fec38dff404990.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0wlkcUsGiWYusKYA4hNv9jk7lR0r8FKbF"
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
--0wlkcUsGiWYusKYA4hNv9jk7lR0r8FKbF
Content-Type: multipart/mixed; boundary="vHYRoq7rADxc9SQdLmel59xFgeGT55DzV"

--vHYRoq7rADxc9SQdLmel59xFgeGT55DzV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.19 12:36, Alberto Garcia wrote:
> This patch adds QCow2SubclusterType, which is the subcluster-level
> version of QCow2ClusterType. All QCOW2_SUBCLUSTER_* values have the
> the same meaning as their QCOW2_CLUSTER_* equivalents (when they
> exist). See below for details and caveats.
>=20
> In images without extended L2 entries clusters are treated as having
> exactly one subcluster so it is possible to replace one data type with
> the other while keeping the exact same semantics.
>=20
> With extended L2 entries there are new possible values, and every
> subcluster in the same cluster can obviously have a different
> QCow2SubclusterType so functions need to be adapted to work on the
> subcluster level.
>=20
> There are several things that have to be taken into account:
>=20
>   a) QCOW2_SUBCLUSTER_COMPRESSED means that the whole cluster is
>      compressed. We do not support compression at the subcluster
>      level.
>=20
>   b) There are two different values for unallocated subclusters:
>      QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN which means that the whole
>      cluster is unallocated, and QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
>      which means that the cluster is allocated but the subcluster is
>      not. The latter can only happen in images with extended L2
>      entries.
>=20
>   c) QCOW2_SUBCLUSTER_INVALID is used to detect the cases where an L2
>      entry has a value that violates the specification. The caller is
>      responsible for handling these situations.
>=20
>      To prevent compatibility problems with images that have invalid
>      values but are currently being read by QEMU without causing side
>      effects, QCOW2_SUBCLUSTER_INVALID is only returned for images
>      with extended L2 entries.
>=20
> qcow2_cluster_to_subcluster_type() is added as a separate function
> from qcow2_get_subcluster_type(), but this is only temporary and both
> will be merged in a subsequent patch.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.h | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)

With the comment style fixed as now required by the coding style (/* and
*/ on separate lines), and regardless of the bit ordering:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--vHYRoq7rADxc9SQdLmel59xFgeGT55DzV--

--0wlkcUsGiWYusKYA4hNv9jk7lR0r8FKbF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5OwCIACgkQ9AfbAGHV
z0DKFwgAo7jqyvORkt42xU20+EL7iC3NFFN6ZisakGpSEi1n0sbLRbXblmkcZbYJ
kJPWV92Kx7Nmhsyp5oF9lH+5OkOxW1cCQCOr6B6GIG8E9p077TfTdwvdIt7IgjVW
xHuXkCyNF6fKbU4nOa3rJBFeS5cq0d59ltS/ZsQvmP4I3uAJ/IugAcXfqV0Rh81r
Cx5kBgQU2sCmpPNjoA1iRWHyPy1jt8jEXZ2p7eEi+YCS6UKssDou1M8+5M93j9I2
GUAwtrBzwzv+5zs/JVtEtgWkEj6HaRLPMrTco9XMsTX14AsRHn4OIwxPgDS7Dztj
e17ah/Fc2Ev0+cd5apupcvmm2vjRyA==
=jbWO
-----END PGP SIGNATURE-----

--0wlkcUsGiWYusKYA4hNv9jk7lR0r8FKbF--


