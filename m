Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF5EC83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2D3208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJ0rqpaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2D3208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlKW-0004fn-5N
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTlJl-0003V1-4y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTlJk-0003sZ-3o
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:55:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22917
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTlJj-0003sA-LI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588161354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UQz370grafddptGtLkewNdd9s8rkpUvcsD8gZ5x3pxo=;
 b=SJ0rqpaWZmEWFNwnWkSInBM+DHQPnKF6vgkp9SLJ1G9BuarxipnIgrMVaFyi4ER0I8NJKn
 A6FblKjlJkXJExfO5L8p0U5+hGCvnz2Zb9XeKqX0vIG5nSOLLx0SI3a3UWhV3hdwBW1/vj
 lctIPhmYWEKgF7PLgncF0Wbn4icTRgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-fyHpPMGaMxqIK8Af3SgMcw-1; Wed, 29 Apr 2020 07:55:52 -0400
X-MC-Unique: fyHpPMGaMxqIK8Af3SgMcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8954108BD1E;
 Wed, 29 Apr 2020 11:55:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 686795C465;
 Wed, 29 Apr 2020 11:55:50 +0000 (UTC)
Subject: Re: [PATCH v3 5/5] block/block-copy: use aio-task-pool API
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200429061039.12687-1-vsementsov@virtuozzo.com>
 <20200429061039.12687-6-vsementsov@virtuozzo.com>
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
Message-ID: <1abe2617-4cc6-85c5-8c81-e2fa1fe4b5dc@redhat.com>
Date: Wed, 29 Apr 2020 13:55:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429061039.12687-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n4OpOIvQ3d0Nu44LxdAdxAgWclW2F8rbu"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n4OpOIvQ3d0Nu44LxdAdxAgWclW2F8rbu
Content-Type: multipart/mixed; boundary="RDM2R2pTHdPqfBkwBIX3GI7l4KB5v9kOc"

--RDM2R2pTHdPqfBkwBIX3GI7l4KB5v9kOc
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.04.20 08:10, Vladimir Sementsov-Ogievskiy wrote:
> Run block_copy iterations in parallel in aio tasks.
>=20
> Changes:
>   - BlockCopyTask becomes aio task structure. Add zeroes field to pass
>     it to block_copy_do_copy
>   - add call state - it's a state of one call of block_copy(), shared
>     between parallel tasks. For now used only to keep information about
>     first error: is it read or not.
>   - convert block_copy_dirty_clusters to aio-task loop.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 104 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 91 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 5cf032c4d8..f5ef91f292 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c

[...]

> @@ -261,6 +278,30 @@ void block_copy_set_progress_meter(BlockCopyState *s=
, ProgressMeter *pm)
>      s->progress =3D pm;
>  }
> =20
> +/* Takes ownership on @task */

Still *of

> +static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
> +                                            BlockCopyTask *task)
> +{
> +    if (!pool) {
> +        int ret =3D task->task.func(&task->task);
> +
> +        g_free(task);
> +        return ret;
> +    }
> +
> +    aio_task_pool_wait_slot(pool);
> +    if (aio_task_pool_status(pool) < 0) {
> +        co_put_to_shres(task->s->mem, task->bytes);
> +        block_copy_task_end(task, -EAGAIN);

It looks like you may have missed my nit picks on v2 regarding this
patch, so I=92m going to ask again whether -ECANCELED might be better here
(even though it still doesn=92t really matter).

> +        g_free(task);
> +        return aio_task_pool_status(pool);

And whether it may be better to return a constant like -ECANCELED here,
because how a previous task failed shouldn=92t really concern this task
(or its error code).

> +    }
> +
> +    aio_task_pool_start_task(pool, &task->task);
> +
> +    return 0;
> +}
> +
>  /*
>   * block_copy_do_copy
>   *

[...]

> @@ -525,25 +590,38 @@ static int coroutine_fn block_copy_dirty_clusters(B=
lockCopyState *s,

[...]

> +out:
> +    if (aio) {
> +        aio_task_pool_wait_all(aio);
> +        if (ret =3D=3D 0) {
> +            ret =3D aio_task_pool_status(aio);
> +        }
> +        g_free(aio);

I=92d still prefer aio_task_pool_free().

Max


--RDM2R2pTHdPqfBkwBIX3GI7l4KB5v9kOc--

--n4OpOIvQ3d0Nu44LxdAdxAgWclW2F8rbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6paz8ACgkQ9AfbAGHV
z0CwJQf/cZHBp42QxXkEjs6S0wQIlPMZkivWsZqadXiBQrWqu/zOmPpE071BsJ8i
juggvwVm4nXf1cme4+tnM+FxHcL7kJeWhPfHQ7Uv9bdv9HqtuXOVC2HfwXXbEUMH
A/m+hxJCdkHWjNSxR15SavDbEMvHfj8oeTyC3Or56EFEFSfPTG9EV7xl1Mo7bUoV
41t3Dof3g/VsEKuVxIZPFEWJaf3wiWVYuBGJzO2wbw5i/58d6LmHH39Q8c2FfEEL
IIKngWkAkEkE/42YbNAf/FDzcEAuwRIqeesou25NFj38jME+DHUWOTSFjtbUJaVn
AQcyhO03DV6ddrNPgOL2ji2eOVd6EQ==
=MJ/I
-----END PGP SIGNATURE-----

--n4OpOIvQ3d0Nu44LxdAdxAgWclW2F8rbu--


