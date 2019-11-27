Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1A0C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8418620665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSbILYVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8418620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0ZB-0002bI-Ro
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 11:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ia0Vj-0000tY-R5
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ia0Vh-0006YZ-72
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:49:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ia0Vh-0006YB-3V
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574873388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eR5hK0LW9HT9JsH4nTj9oQIaegcsR+8XdB2c7vENheY=;
 b=DSbILYVtCoVPSOFBy/W8/0FE9skP5oG9uAlJ8qIo/ZUp7ulH66hcKmHS1RLJs5CtkoYvLT
 vdgiSp0yn3adXurRQWys3iAjiz3Ij2+4s1lxzhLvbciECddl0aScVyiKTZhI6kE6zfqg4m
 epsz1CQRMPlQ9Sowke5lDyWjBAYnoxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-xAXLI-JBNVScgO8jkbu3bw-1; Wed, 27 Nov 2019 11:49:43 -0500
X-MC-Unique: xAXLI-JBNVScgO8jkbu3bw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA1B107BAAC;
 Wed, 27 Nov 2019 16:49:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-186.brq.redhat.com
 [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A20EB5D6D6;
 Wed, 27 Nov 2019 16:49:38 +0000 (UTC)
Subject: Re: [PATCH v4 3/5] blockdev: unify qmp_blockdev_backup and
 blockdev-backup transaction paths
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191121135759.101655-1-slp@redhat.com>
 <20191121135759.101655-4-slp@redhat.com>
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
Message-ID: <24cd8940-4754-ff97-167b-44a236c539e8@redhat.com>
Date: Wed, 27 Nov 2019 17:49:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121135759.101655-4-slp@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="J86pn1HWjfNMauCA9euc6SF6wwZ5tbU83"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J86pn1HWjfNMauCA9euc6SF6wwZ5tbU83
Content-Type: multipart/mixed; boundary="dwuk35duwGVMhDVkRTK3YDVAmBY9Da8yO"

--dwuk35duwGVMhDVkRTK3YDVAmBY9Da8yO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.11.19 14:57, Sergio Lopez wrote:
> Issuing a blockdev-backup from qmp_blockdev_backup takes a slightly
> different path than when it's issued from a transaction. In the code,
> this is manifested as some redundancy between do_blockdev_backup() and
> blockdev_backup_prepare().
>=20
> This change unifies both paths, merging do_blockdev_backup() and
> blockdev_backup_prepare(), and changing qmp_blockdev_backup() to
> create a transaction instead of calling do_backup_common() direcly.
>=20
> As a side-effect, now qmp_blockdev_backup() is executed inside a
> drained section, as it happens when creating a blockdev-backup
> transaction. This change is visible from the user's perspective, as
> the job gets paused and immediately resumed before starting the actual
> work.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  blockdev.c | 60 ++++++++++++------------------------------------------
>  1 file changed, 13 insertions(+), 47 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 5e85fc042e..152a0f7454 100644
> --- a/blockdev.c
> +++ b/blockdev.c

[...]

>  static void blockdev_backup_prepare(BlkActionState *common, Error **errp=
)
>  {
>      BlockdevBackupState *state =3D DO_UPCAST(BlockdevBackupState, common=
, common);
>      BlockdevBackup *backup;
> -    BlockDriverState *bs, *target;
> +    BlockDriverState *bs;
> +    BlockDriverState *target_bs;

The diff stat could have been a bit smaller by keeping this as it was,
but either way:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>      AioContext *aio_context;
> -    Error *local_err =3D NULL;
> =20
>      assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_=
BACKUP);
>      backup =3D common->action->u.blockdev_backup.data;
> @@ -1959,8 +1956,8 @@ static void blockdev_backup_prepare(BlkActionState =
*common, Error **errp)
>          return;
>      }
> =20
> -    target =3D bdrv_lookup_bs(backup->target, backup->target, errp);
> -    if (!target) {
> +    target_bs =3D bdrv_lookup_bs(backup->target, backup->target, errp);
> +    if (!target_bs) {
>          return;
>      }
> =20


--dwuk35duwGVMhDVkRTK3YDVAmBY9Da8yO--

--J86pn1HWjfNMauCA9euc6SF6wwZ5tbU83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3eqSAACgkQ9AfbAGHV
z0D6rAf/RDTMD3loWlODXYgFHHoNvyafKTNw+nlrtPtFu+p52tbm1q6+i+QaxRc8
ze1+S3d1WjxxIe8MqqEzT+w1pcMIrgggT7frNxkFMuiJpSijP74UGGBx0XNF0jkT
TuOa4yRstTlPr4Nun6GLG9WofFDc7HiUf/ln1XsuJB/rN4Dt22o/cGifvz4q+gKA
UQuEL7QjOOBgMnDn9MZF7gpj68vXzDNG6Ff4157Uh38broeCPhn5j8zvae6toAuO
JCNbSPD94M4CGvu+oekzNr/DooMhB3kg1QrKrMfq4cgFXVV5lY753e43iH57Pmhr
d9132ups0rkRgKP4iBl3hYb/s9648A==
=e1Tg
-----END PGP SIGNATURE-----

--J86pn1HWjfNMauCA9euc6SF6wwZ5tbU83--


