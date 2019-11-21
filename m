Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15914C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53722071C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H32MzrN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53722071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXiKb-0006fB-0l
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iXiJo-0005xz-EJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iXiJn-0002Ys-CX
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:00:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34812
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iXiJn-0002Xk-8t
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574326802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S3EVHtfpFG0MQlc0jiPBoqUkBSP1UTYXxt6f4ALZ6fU=;
 b=H32MzrN0kxE+y89zciLddXx0CVw3Bpq6Ri3lZ8JBAD/S/B18AZhcbeD3e8/CTee9snbUcX
 lmJRs9LanHjiHtFhuniQjMSnvwXnEw5/AoNWcMkkMF3Q6WNbLvNIw7CDuUsjxjAVp13OrJ
 Nukr+mahSDtPlFPBILZ/qP2Ho5nwWFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-X9wTi3hJMcSV-yjpQ2sq2A-1; Thu, 21 Nov 2019 03:59:59 -0500
X-MC-Unique: X9wTi3hJMcSV-yjpQ2sq2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093E91005509;
 Thu, 21 Nov 2019 08:59:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-196.ams2.redhat.com
 [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2220753E19;
 Thu, 21 Nov 2019 08:59:52 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] block: truncate: Don't make backing file data
 visible
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-3-kwolf@redhat.com>
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
Message-ID: <c53f6f2d-2451-2fb3-cbf0-2a1a686cccf5@redhat.com>
Date: Thu, 21 Nov 2019 09:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120184501.28159-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NYhBkZZFlBegMCyJsGYFenQqvujgOVOE3"
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NYhBkZZFlBegMCyJsGYFenQqvujgOVOE3
Content-Type: multipart/mixed; boundary="CHnrdGmI2BKNMjhcj2vRq1ExJve6kb7rM"

--CHnrdGmI2BKNMjhcj2vRq1ExJve6kb7rM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.11.19 19:44, Kevin Wolf wrote:
> When extending the size of an image that has a backing file larger than
> its old size, make sure that the backing file data doesn't become
> visible in the guest, but the added area is properly zeroed out.
>=20
> Consider the following scenario where the overlay is shorter than its
> backing file:
>=20
>     base.qcow2:     AAAAAAAA
>     overlay.qcow2:  BBBB
>=20
> When resizing (extending) overlay.qcow2, the new blocks should not stay
> unallocated and make the additional As from base.qcow2 visible like
> before this patch, but zeros should be read.
>=20
> A similar case happens with the various variants of a commit job when an
> intermediate file is short (- for unallocated):
>=20
>     base.qcow2:     A-A-AAAA
>     mid.qcow2:      BB-B
>     top.qcow2:      C--C--C-
>=20
> After commit top.qcow2 to mid.qcow2, the following happens:
>=20
>     mid.qcow2:      CB-C00C0 (correct result)
>     mid.qcow2:      CB-C--C- (before this fix)
>=20
> Without the fix, blocks that previously read as zeros on top.qcow2
> suddenly turn into A.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Zeroing the intersection may take some time.  So is it right for QMP=E2=80=
=99s
block_resize to do this, seeing it is a synchronous operation?

As far as I can tell, jobs actually have the same problem.  I don=E2=80=99t
think mirror or commit have a pause point before truncating, so they
still block the monitor there, don=E2=80=99t they?

Max


--CHnrdGmI2BKNMjhcj2vRq1ExJve6kb7rM--

--NYhBkZZFlBegMCyJsGYFenQqvujgOVOE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3WUgcACgkQ9AfbAGHV
z0Cwuwf+OgNqEVrwZ/FgSuVxij3HQswcoHZcYOkb44uG9xH7CzjyJz6C7qfDgEp3
9oP2/ag32/Wq9lmtnreHKxRl9+tunYB2ukre2uhD2qtnGpEpX9HLvNANv1kjSidL
HbAz205MdoEJJ6Ux2eVsMfxYM7Gk9CoACT5Ddxghgu6H9p3FGoxqBD+fBSNuhemu
GZ09C8O600TxOQtub83GEYgdBTLxrti+Ac/f5X0oiy+rmjoE2gWHoDXA6+sSVYaW
3bXv6wsdgl0Bpcxm9F80bATQcUYsXuwZlc3XdDjuaf6Qypto8dRhYx25lYnPVndH
cawhkRFCC6VzWRjCwN0uEkZc/kmBcg==
=1dIf
-----END PGP SIGNATURE-----

--NYhBkZZFlBegMCyJsGYFenQqvujgOVOE3--


