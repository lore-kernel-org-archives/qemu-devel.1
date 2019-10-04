Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18CDC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882E62133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882E62133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGOS6-0004rI-EW
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 10:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGOQv-0003xu-UX
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGOQu-00052q-Nm
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:19:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36109)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGOQq-00050w-Uf; Fri, 04 Oct 2019 10:19:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30FAA306729D;
 Fri,  4 Oct 2019 14:19:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 230F95D6A5;
 Fri,  4 Oct 2019 14:19:37 +0000 (UTC)
Subject: Re: [PATCH v15 5/5] block/backup: use backup-top instead of write
 notifiers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191001131409.14202-1-vsementsov@virtuozzo.com>
 <20191001131409.14202-6-vsementsov@virtuozzo.com>
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
Message-ID: <35155e37-df08-4774-2e9c-7c786b9e52b5@redhat.com>
Date: Fri, 4 Oct 2019 16:19:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001131409.14202-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="30x2PE5I7aqpL3u2h2kuTa4ArcPDGDEUU"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 04 Oct 2019 14:19:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 qemu-devel@nongnu.org, armbru@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--30x2PE5I7aqpL3u2h2kuTa4ArcPDGDEUU
Content-Type: multipart/mixed; boundary="G0CnP07CsOaaTCj6r4hzjYNVGNESdvecz"

--G0CnP07CsOaaTCj6r4hzjYNVGNESdvecz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.10.19 15:14, Vladimir Sementsov-Ogievskiy wrote:
> Drop write notifiers and use filter node instead.
>=20
> =3D Changes =3D
>=20
> 1. Add filter-node-name argument for backup qmp api. We have to do it
> in this commit, as 257 needs to be fixed.
>=20
> 2. There are no more write notifiers here, so is_write_notifier
> parameter is dropped from block-copy paths.
>=20
> 3. To sync with in-flight requests at job finish we now have drained
> removing of the filter, we don't need rw-lock.
>=20
> 4. Block-copy is now using BdrvChildren instead of BlockBackends
>=20
> 5. As backup-top owns these children, we also move block-copy state
> into backup-top's ownership.
>=20
> =3D Iotest changes =3D
>=20
> 56: op-blocker doesn't shoot now, as we set it on source, but then
> check on filter, when trying to start second backup.
> To keep the test we instead can catch another collision: both jobs will=

> get 'drive0' job-id, as job-id parameter is unspecified. To prevent
> interleaving with file-posix locks (as they are dependent on config)
> let's use another target for second backup.
>=20
> Also, it's obvious now that we'd like to drop this op-blocker at all
> and add a test-case for two backups from one node (to different
> destinations) actually works. But not in these series.
>=20
> 141: Output changed: prepatch, "Node is in use" comes from bdrv_has_blk=

> check inside qmp_blockdev_del. But we've dropped block-copy blk
> objects, so no more blk objects on source bs (job blk is on backup-top
> filter bs). New message is from op-blocker, which is the next check in
> qmp_blockdev_add.
>=20
> 257: The test wants to emulate guest write during backup. They should
> go to filter node, not to original source node, of course. Therefore we=

> need to specify filter node name and use it.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json       |   8 +-
>  include/block/block-copy.h |  14 +-
>  include/block/block_int.h  |   1 +
>  block/backup-top.c         |  21 +--
>  block/backup.c             |  73 +++------
>  block/block-copy.c         |  81 +++-------
>  block/replication.c        |   2 +-
>  blockdev.c                 |   1 +
>  tests/qemu-iotests/056     |   8 +-
>  tests/qemu-iotests/141.out |   2 +-
>  tests/qemu-iotests/257     |   7 +-
>  tests/qemu-iotests/257.out | 306 ++++++++++++++++++-------------------=

>  12 files changed, 237 insertions(+), 287 deletions(-)

[...]

> diff --git a/block/block-copy.c b/block/block-copy.c
> index fcb112da14..5404bc921d 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c

[...]

> @@ -218,8 +183,8 @@ static int coroutine_fn block_copy_with_offload(Blo=
ckCopyState *s,
>      nr_clusters =3D DIV_ROUND_UP(nbytes, s->cluster_size);
>      bdrv_reset_dirty_bitmap(s->copy_bitmap, start,
>                              s->cluster_size * nr_clusters);
> -    ret =3D blk_co_copy_range(s->source, start, s->target, start, nbyt=
es,
> -                            read_flags, s->write_flags);
> +    ret =3D bdrv_co_copy_range(s->source, start, s->target, start, nby=
tes,
> +                            0, s->write_flags);

The indentation=E2=80=99s off here.  I=E2=80=99ll fix it.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--G0CnP07CsOaaTCj6r4hzjYNVGNESdvecz--

--30x2PE5I7aqpL3u2h2kuTa4ArcPDGDEUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XVPgACgkQ9AfbAGHV
z0B12Qf/cEbtuuzOfqg0b0Ru+6v2U3oKrpXonL7SsvLwm0Aiw1TehObSIBC8ZWNj
fEmw2PQfc0w6OLL17IMpBGnH0I9OC7UYhFaMvFt9KjiwF4GMaB4v9jLsRDgDMb3f
3om48QVkCtBBW5NOID/ls+8rdU/FwVwTDePbGnFFBli3vm+wJCS2nddT7GihWsyJ
3r3N7Im+J7Sa6iidgr+D7tzVWn1eheEYeo2wfYTPMXiEVvrjgyzGtiK5/usTdGuD
/C0OSVkHp5hcA0giY9RTZ6PeTLOcwbRIxBRwi3KYWgRXVMfX3sJO3cL8RsVD4dJO
WwVJZ2mrO2P5VpnYHp/Dqu5tkv4n8A==
=brh+
-----END PGP SIGNATURE-----

--30x2PE5I7aqpL3u2h2kuTa4ArcPDGDEUU--

