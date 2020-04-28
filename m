Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F354C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48ECD20663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 10:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUJoocvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48ECD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTN53-0001CJ-3i
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 06:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTN3w-0008MF-8o
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTN3v-0004tK-Lo
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:02:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTN3t-0004sQ-UV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 06:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588068116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7YA+EDsTA2SbA8jfQxXao+GeV0jdLm9+5/1pvLocc/Y=;
 b=iUJoocvC8eKfIp7SDrJ4NwrtrWyo2bazlG92OJyMiE04IWP4yZsHRiIsVahkWpoHC4ZzUk
 Vwcy2+KUomxwu16qmVoNsBEZ2OVzwow9NqPHM0BpICT2AxgikeUxDcVup9nf/iul5WMIiZ
 2R7NOgNbn+AEHkSwMiuq7dO0eqZtbr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-L84GgLUkN2CQDChdBVgtOA-1; Tue, 28 Apr 2020 06:01:49 -0400
X-MC-Unique: L84GgLUkN2CQDChdBVgtOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52C858463A2;
 Tue, 28 Apr 2020 10:01:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B06D360C87;
 Tue, 28 Apr 2020 10:01:46 +0000 (UTC)
Subject: Re: [PATCH v2 6/6] block/block-copy: use aio-task-pool API
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
 <20200325134639.16337-7-vsementsov@virtuozzo.com>
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
Message-ID: <74a7f4e6-6c6b-a484-95c6-838f34fb9f22@redhat.com>
Date: Tue, 28 Apr 2020 12:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200325134639.16337-7-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y2f7OFPTU9MAsqfE6MtMwm7tyKXmO8MH7"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
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
--y2f7OFPTU9MAsqfE6MtMwm7tyKXmO8MH7
Content-Type: multipart/mixed; boundary="zoWntt0cxuQ33CEPW8bQClpgrUqRmfrqt"

--zoWntt0cxuQ33CEPW8bQClpgrUqRmfrqt
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.03.20 14:46, Vladimir Sementsov-Ogievskiy wrote:
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

Looks good, just some nits:

> diff --git a/block/block-copy.c b/block/block-copy.c
> index 910947cb43..9994598eb7 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c

[...]

> @@ -225,6 +237,30 @@ void block_copy_set_progress_meter(BlockCopyState *s=
, ProgressMeter *pm)
>      s->progress =3D pm;
>  }
> =20
> +/* Takes ownership on @task */

*of

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

Hm, I think -ECANCELED might be better.  Not that it really matters...

> +        g_free(task);
> +        return aio_task_pool_status(pool);

Here, too.  (Here, there=92s also the fact that this task doesn=92t really
fail because of the same reason that the other task failed, so we should
have our own error code here.)

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

> @@ -519,25 +584,38 @@ static int coroutine_fn block_copy_dirty_clusters(B=
lockCopyState *s,

[...]

> +out:
> +    if (aio) {
> +        aio_task_pool_wait_all(aio);
> +        if (ret =3D=3D 0) {
> +            ret =3D aio_task_pool_status(aio);
> +        }
> +        g_free(aio);

aio_task_pool_free()?

Max


--zoWntt0cxuQ33CEPW8bQClpgrUqRmfrqt--

--y2f7OFPTU9MAsqfE6MtMwm7tyKXmO8MH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6n/wkACgkQ9AfbAGHV
z0DKEQf9GPFmP86bXLqa0Gr1PUuIdkYgGvNb6VPOq/XOR9hvHWY4LAOJBNXiynO+
hFTlAOMkkcGHAZdGIkBDrFBdLxiY2YHPTNl6+xeiP4y/+rVDCjFfSciFEXLzbmDV
ZI+LTopFEKaBERBgsM0JLBxJ1S3q/mML5jVLLA/YpgS18F+AESbXgW3Ul33L5zHk
6cwbbAjOFY5OCMH+QTvZw6yuA69aJJtLCl2l8QWWj+2F4VViUsGvSWvYqWtsjl8h
S96bRVtAFMcBHslxQkPGvhzcJTYkFeETUWm4c5qmONI2vL2DmlznHeVA/8C4u6CY
rm2V1d1RQNjcBmvw1gfWCfVfAGYtVQ==
=Glk1
-----END PGP SIGNATURE-----

--y2f7OFPTU9MAsqfE6MtMwm7tyKXmO8MH7--


