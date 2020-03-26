Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5349C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8046720719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TChAy4y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8046720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHXEm-0001qN-Kj
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 14:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHXDx-000153-9E
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHXDv-0002x3-4W
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:27:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:34555)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHXDu-0002w0-O7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585247241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wd+Wa71uTGKZJFeWCrqDj97TiA4DwHCn0PvYsSkBlfk=;
 b=TChAy4y5TCGBDBqoHOkAFeCcn6nRAqLwzA9KQQmg3CAa/PwrTMQm3aMr0JJlcUHfYelIMZ
 WBUpAZB1Ig0gz2oE6PdR3EiP2RI9OLFGb6mjwqzp2rC+J9bYJveSVy6QjDuvHaMyPDveH9
 7WHer/iHns8nJo9rMBmqJHoWIk+btU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-npXt21bkNKWszIHhh3yR3w-1; Thu, 26 Mar 2020 14:27:19 -0400
X-MC-Unique: npXt21bkNKWszIHhh3yR3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7CA7107ACC7;
 Thu, 26 Mar 2020 18:27:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-132.ams2.redhat.com
 [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F41F65C1BA;
 Thu, 26 Mar 2020 18:27:16 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mirror: Wait only for in-flight operations
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200326153628.4869-1-kwolf@redhat.com>
 <20200326153628.4869-3-kwolf@redhat.com>
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
Message-ID: <09eee5b4-71aa-97a2-1ea9-c6bfc313e77f@redhat.com>
Date: Thu, 26 Mar 2020 19:27:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326153628.4869-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4gpxe1jZ0NdxBSHrOB4EGz9PM7xrs4S89"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4gpxe1jZ0NdxBSHrOB4EGz9PM7xrs4S89
Content-Type: multipart/mixed; boundary="DclIpgKjNjBUOL36CsYxCFtuAaHGOyICh"

--DclIpgKjNjBUOL36CsYxCFtuAaHGOyICh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.03.20 16:36, Kevin Wolf wrote:
> mirror_wait_for_free_in_flight_slot() just picks a random operation to
> wait for. However, a MirrorOp is already in s->ops_in_flight when
> mirror_co_read() waits for free slots, so if not enough slots are
> immediately available, an operation can end up waiting for itself, or
> two or more operations can wait for each other to complete, which
> results in a hang.
>=20
> Fix this by adding a flag to MirrorOp that tells us if the request is
> already in flight (and therefore occupies slots that it will later
> free), and picking only such operations for waiting.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1794692
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 393131b135..88414d1653 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c

[...]

> @@ -1318,6 +1324,7 @@ static MirrorOp *coroutine_fn active_write_prepare(=
MirrorBlockJob *s,
>          .offset             =3D offset,
>          .bytes              =3D bytes,
>          .is_active_write    =3D true,
> +        .is_in_flight       =3D true,
>      };
>      qemu_co_queue_init(&op->waiting_requests);
>      QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
>=20

There is a mirror_wait_on_conflicts() call after this.  I was a bit
worried about dependencies there.  But I don=E2=80=99t think there=E2=80=99=
s any
problem, because mirror_wait_for_any_operation() is only called by:

(1) mirror_wait_for_free_in_flight_slot(), which makes it look for
non-active operations only, and

(2) mirror_run(), which specifically waits for all active operations to
settle, so it makes sense to wait for all of them, even when they are
still doing their own dependency-waiting.

But still, I=E2=80=99m not sure whether this is conceptually the best thing=
 to
do.  I think what we actually want is for
mirror_wait_for_free_in_flight_slot() to only wait for in-flight
operations; but the call in mirror_run() that waits for active-mirror
operations wants to wait for all active-mirror operations, not just the
ones that are in flight.

So I think conceptually it would make more sense to set is_in_flight
only after mirror_wait_on_conflicts(), and ensure that the
mirror_wait_for_any_operation() call from mirror_run() ignores
is_in_flight.  E.g. by having another parameter =E2=80=9Cbool in_flight=E2=
=80=9D for
mirror_wait_for_any_operation() that chooses whether to check
is_in_flight or whether to ignore it.

In practice, @in_flight would always be the same as @active, but they
are different things.  But that would mean we would always ignore
is_in_flight for active-mirror operations.

In practice, there=E2=80=99s no difference to what this patch does, i.e. to=
 just
let active-mirror operations have is_in_flight to be always true and let
mirror_wait_for_any_operation() check is_in_flight unconditionally.

So I don=E2=80=99t know.  Maybe this is a start:

Functionally-reviewed-by: Max Reitz <mreitz@redhat.com>

Max


--DclIpgKjNjBUOL36CsYxCFtuAaHGOyICh--

--4gpxe1jZ0NdxBSHrOB4EGz9PM7xrs4S89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl589AIACgkQ9AfbAGHV
z0B4qgf9HWlSoHmqH4XEip7iGk6NA3kZHD54I/+5NATNEamZkY5IjG4wNDARGhlF
ezjhf6i6PlzRsHJ0Idx+6OhkWF2XkJqy1mB0A62F9uKx+Xk6ZLvAcEy/jGym6fi4
7jXuKRIA1ysiXWP3mvOH3IH5VPACi2KaYeq903iIs9gcH89Xm+158evT+4ZkAvFA
NMOPe5K0E142whGV78qXv6tjqLiSPFAiZGR35KVmB9W5nWEvx2bpVPQJuIbzLiBb
a6bjhwhGSPm/F8BPPRucdkRzaK7iePMisiYGb8tSkikAnNQKg3Iip+6faC0AUtc4
CZlPoNhlwMDZj9RTm5fHbR94C085OQ==
=op5Y
-----END PGP SIGNATURE-----

--4gpxe1jZ0NdxBSHrOB4EGz9PM7xrs4S89--


