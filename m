Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F0EC010A2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9474620869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyt6fYkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9474620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRwfB-00059D-PR
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 06:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRweF-0004Zw-Ez
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRweD-0003jg-IU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:05:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRweD-0003de-CO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572951915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QwZHpT2dn3/wY0xq+71Rk3yzxorESyHpnocHcB2gNLM=;
 b=iyt6fYklqJphv8rMjs+YAXgFcRgm6Ni06b/IXsLwQ/xTs33taIZi8J/0inI3cl56q/cZ35
 et4T7pAj1Bnm8rp/bFUffrs3Cw0DPmmFxihuWgLEi2Ei1fnSxtcXWYIkHDHHWoYyX5Da3h
 CWsy9SFsHrO77eFFv4igVUG2Zi3iBJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-ma9NEhypNUuTUtoI3tpdkA-1; Tue, 05 Nov 2019 06:05:13 -0500
X-MC-Unique: ma9NEhypNUuTUtoI3tpdkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A0711005500;
 Tue,  5 Nov 2019 11:05:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-89.ams2.redhat.com
 [10.36.117.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1E9E26FD1;
 Tue,  5 Nov 2019 11:05:04 +0000 (UTC)
Subject: Re: [RFC PATCH v2 18/26] qcow2: Add subcluster support to
 expand_zero_clusters_in_l1()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <f99f051139f84a4d34bc52696aa2c2b125d5c3fd.1572125022.git.berto@igalia.com>
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
Message-ID: <23b7a28a-22e2-25f5-3b08-438bf86e48ba@redhat.com>
Date: Tue, 5 Nov 2019 12:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f99f051139f84a4d34bc52696aa2c2b125d5c3fd.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="55qIbn5vyiX9Ss1vaAIzN6g28A2KsvfA8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--55qIbn5vyiX9Ss1vaAIzN6g28A2KsvfA8
Content-Type: multipart/mixed; boundary="W8iVnrhicyyoImRdjNDoZClAZxvlxtVDH"

--W8iVnrhicyyoImRdjNDoZClAZxvlxtVDH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> Two changes are needed in order to add subcluster support to this
> function: deallocated clusters must have their bitmaps cleared, and
> expanded clusters must have all the "subcluster allocated" bits set.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index aa3eb727a5..62f2a9fcc0 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -2036,6 +2036,7 @@ static int expand_zero_clusters_in_l1(BlockDriverSt=
ate *bs, uint64_t *l1_table,
>                          /* not backed; therefore we can simply deallocat=
e the
>                           * cluster */
>                          set_l2_entry(s, l2_slice, j, 0);
> +                        set_l2_bitmap(s, l2_slice, j, 0);
>                          l2_dirty =3D true;
>                          continue;
>                      }
> @@ -2102,6 +2103,7 @@ static int expand_zero_clusters_in_l1(BlockDriverSt=
ate *bs, uint64_t *l1_table,
>                  } else {
>                      set_l2_entry(s, l2_slice, j, offset);
>                  }
> +                set_l2_bitmap(s, l2_slice, j, QCOW_L2_BITMAP_ALL_ALLOC);
>                  l2_dirty =3D true;
>              }

Technically this isn=E2=80=99t needed because this function is only called =
when
downgrading v3 to v2 images (which can=E2=80=99t have subclusters), but of
course it won=E2=80=99t hurt.

Max


--W8iVnrhicyyoImRdjNDoZClAZxvlxtVDH--

--55qIbn5vyiX9Ss1vaAIzN6g28A2KsvfA8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3BV14ACgkQ9AfbAGHV
z0B6Fwf/cQ3Dzl27xToE6wQR4FM1VLFYG2dxvY9dsPuKHvzLat6IMvFlynt+WIJn
LLq+9MqDYL6dn1r8ZaKxjs6MDVOtabWAFAh5zPn2IsyuTCubDMIWLhNesRqSYYJV
/lks4NQiJmCDTIke+nTq4Ordw93bw8LKh4w4FRTh/ZsRIsQblhM4m5e2jJqcIvb6
376utJjRVGWKN8fXZ31KB+bELSPlkw82L9+XHaM6vQgOoPinMyYQPeepAlxHi3J2
MZYBYTQKMBfiIk8N5PUilSoWbULIpSNf6cm+rhJgm4G+lHI8yZFD44NcfhTXRRST
KHbkFpb3EloOJ18Y4ma3RPrYPuUpWg==
=rJZx
-----END PGP SIGNATURE-----

--55qIbn5vyiX9Ss1vaAIzN6g28A2KsvfA8--


