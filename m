Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92454C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EABB20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAZHvTsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EABB20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3xf-0007UU-D9
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jH3wr-00070K-Nx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jH3wp-00087B-4I
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:11:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48561)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jH3wo-00086R-Vx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585134706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1HHMpFzQ4x4Zqjc3VSRrSRBpk8NVTiTtW2F01j5l4mE=;
 b=fAZHvTsX6cHuHyIzge8SgXoFhcVeeqIWDmhMP7ws/5SmFT1RgTEd2guiQXKJkwKUWpSXlC
 9j1/jDKKURegvK8ITGERuTJNt2xOnCawE1EZtTYirgJrsCG9ExNkRNc+LMPOa8ovLR3Hbp
 bAVvmB1hgfQO3tBlwROmalYgJmlyMmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-n0Xsf9PIMR-piNcqLwRXow-1; Wed, 25 Mar 2020 07:11:42 -0400
X-MC-Unique: n0Xsf9PIMR-piNcqLwRXow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 104A7189F765;
 Wed, 25 Mar 2020 11:11:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-115-33.ams2.redhat.com
 [10.36.115.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1423F6266E;
 Wed, 25 Mar 2020 11:11:34 +0000 (UTC)
Subject: Re: [PATCH 2/6] block/mirror: fix use after free of local_err
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-3-vsementsov@virtuozzo.com>
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
Message-ID: <8cb2bda7-55f5-2646-3c35-d901089ccde5@redhat.com>
Date: Wed, 25 Mar 2020 12:11:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324153630.11882-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JWgvyY9ZM437gPLC0XGWPRF3x91cgKQan"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 mdroth@linux.vnet.ibm.com, den@openvz.org, marcandre.lureau@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JWgvyY9ZM437gPLC0XGWPRF3x91cgKQan
Content-Type: multipart/mixed; boundary="KOZzYSWz4cZrYNAQ792GVEsbL5G1LBLRk"

--KOZzYSWz4cZrYNAQ792GVEsbL5G1LBLRk
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.03.20 16:36, Vladimir Sementsov-Ogievskiy wrote:
> local_err is used again in mirror_exit_common() after
> bdrv_set_backing_hd(), so we must zero it. Otherwise try to set
> non-NULL local_err will crash.

OK, but wouldn=92t it be better hygiene to set it to NULL every time it is
freed?  (There is a second instance of error_report_err() in this
function.  I=92m a bit worried we might introduce another local_err use
after that one at some point in the future, and forget to run the cocci
script then.)

Are the cocci scripts run regularly by someone?  E.g. as part of a pull
to master?

Max

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/mirror.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 447051dbc6..6203e5946e 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -678,6 +678,7 @@ static int mirror_exit_common(Job *job)
>              bdrv_set_backing_hd(target_bs, backing, &local_err);
>              if (local_err) {
>                  error_report_err(local_err);
> +                local_err =3D NULL;
>                  ret =3D -EPERM;
>              }
>          }
>=20



--KOZzYSWz4cZrYNAQ792GVEsbL5G1LBLRk--

--JWgvyY9ZM437gPLC0XGWPRF3x91cgKQan
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl57PGQACgkQ9AfbAGHV
z0CSBgf/Xn+k1IbGoYhr3CQlHRlXQId12pJQ1Rxpzhxl6tDShexfMy//IRG54369
QnDgTc7VVIOxShWgupNhDTeQyRjFA5ePzyhDyhptbjZxPFdeRMbS/6u3azruYuEI
gRPPKJmuAA/avInAUpnsbGE+6iTFKghu9kGyhJrR5eHIrU67OEgrid71Kljkpu/b
SJvvP85QGdhe+YihBupZgi8iB18B34gEFpToAhRNaApttIq0T0TY9KAaaOEOAC/8
AGDW+z+xe3AzGZYihgzb499WV9jvmFry1fKMb+uOkCUHhBFwtMYKD+KtGTQ0DAGe
zrmNMgvRqV355NU7CAaDPeuJ9db7QQ==
=oH5h
-----END PGP SIGNATURE-----

--JWgvyY9ZM437gPLC0XGWPRF3x91cgKQan--


