Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4EEC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6937624650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huuo3Sjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6937624650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j59kw-00082Y-LK
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j59kM-0007YX-GI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j59kL-0002J4-BU
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:57:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j59kL-0002Io-5o
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582297060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vW0KcORnuogWHnRRB0z5ksqwyHf49fdO1r0vDzkhqS4=;
 b=huuo3Sjoh8QQXxIw9J9wX5Lw4R5MOFnbw41A2gKs9ko9X6m08mHhUtqAtmV+S4Id3vgCaR
 BFeKjdCzi8qCjGcmwkYG+pyoFSTefrmzO08xqwOFIFB/txOfBSQ+FvaZ4WqC8PqMA7iLn1
 VABzVWMGAcpsoc0STAqWWe33RQ4ROBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-PzB40AVjNb-ZoY87NAzmUg-1; Fri, 21 Feb 2020 09:57:34 -0500
X-MC-Unique: PzB40AVjNb-ZoY87NAzmUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2910D477;
 Fri, 21 Feb 2020 14:57:33 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FC9127096;
 Fri, 21 Feb 2020 14:57:29 +0000 (UTC)
Subject: Re: [RFC PATCH v3 19/27] qcow2: Add subcluster support to
 expand_zero_clusters_in_l1()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <d7c9c2d54c7be83eda854db37e54dd7aabb1a1e1.1577014346.git.berto@igalia.com>
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
Message-ID: <194970c2-07a5-41f5-bd3c-7153d6f5e1b7@redhat.com>
Date: Fri, 21 Feb 2020 15:57:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d7c9c2d54c7be83eda854db37e54dd7aabb1a1e1.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="43sYYBk9zGVCAZHsAJUhHFGV58qeHaTKv"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--43sYYBk9zGVCAZHsAJUhHFGV58qeHaTKv
Content-Type: multipart/mixed; boundary="HpoAMQDNJ8occlhCzD1Kp5y3N3OULRc0l"

--HpoAMQDNJ8occlhCzD1Kp5y3N3OULRc0l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.19 12:37, Alberto Garcia wrote:
> Two changes are needed in order to add subcluster support to this
> function: deallocated clusters must have their bitmaps cleared, and
> expanded clusters must have all the "subcluster allocated" bits set.

Not really, to have real subcluster support it would need to be
expand_zero_subclusters_in_l1().  Right now it can only deal with full
zero clusters, which will actually never happen for images with subclusters=
.

As noted in v2, this function is only called when downgrading qcow2
images to v2.  It kind of made sense to just call set_l2_bitmap() in v2,
but now with the if () conditional...  I suppose it may make more sense
to assert that the image does not have subclusters at the beginning of
the function and be done with it.

OTOH, well, this does make ensuring that we have subcluster =E2=80=9Csuppor=
t=E2=80=9D
everywhere a bit easier because this way all set_l2_entry() calls are
accompanied by an =E2=80=9Cif (subclusters) { set_l2_bitmap() }=E2=80=9D pa=
rt.

But it is dead code.

Max

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 207f670c94..ede75138d2 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -2054,6 +2054,9 @@ static int expand_zero_clusters_in_l1(BlockDriverSt=
ate *bs, uint64_t *l1_table,
>                          /* not backed; therefore we can simply deallocat=
e the
>                           * cluster */
>                          set_l2_entry(s, l2_slice, j, 0);
> +                        if (has_subclusters(s)) {
> +                            set_l2_bitmap(s, l2_slice, j, 0);
> +                        }
>                          l2_dirty =3D true;
>                          continue;
>                      }
> @@ -2120,6 +2123,9 @@ static int expand_zero_clusters_in_l1(BlockDriverSt=
ate *bs, uint64_t *l1_table,
>                  } else {
>                      set_l2_entry(s, l2_slice, j, offset);
>                  }
> +                if (has_subclusters(s)) {
> +                    set_l2_bitmap(s, l2_slice, j, QCOW_L2_BITMAP_ALL_ALL=
OC);
> +                }
>                  l2_dirty =3D true;
>              }
> =20
>=20



--HpoAMQDNJ8occlhCzD1Kp5y3N3OULRc0l--

--43sYYBk9zGVCAZHsAJUhHFGV58qeHaTKv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5P79cACgkQ9AfbAGHV
z0BVBQgAocBfBUjHqDW5Mz061i1FYjpTrk32deggelVXupuiR2oeV1lJnILkW9ix
VN6Fa9wHhzCDxfJbCYV2dYgz79GKQ97o2Iwo9csWi08ZCizD5/ZsT4iguuyqvtPR
OhpeStkgi/BY14ZGqggDnxJZ9x+jTr6fl2hHDRNpT0Fov4PBxt/A3bXTnQ6n82Bw
vkJsSEz6xSx+hQYYdH9gWn1GabLnvFmT2n7tTJYC0OkIlnVvrd08Gg6R8/kgc7ZX
ezeFuo8dpENXf2RJLWdq+YhPnX2ikfhgG2faYlxE/V4gnR71fkYz3Zo+y1wLTFzv
9NIALnQwHtPx2jqPbwEhg9xTqbeLeA==
=9yaw
-----END PGP SIGNATURE-----

--43sYYBk9zGVCAZHsAJUhHFGV58qeHaTKv--


