Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6435C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8059F20825
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 09:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iipnCfXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8059F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyXq2-0003yZ-PI
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 05:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyXpR-0003U5-Rt
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:47:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyXpQ-0005Kv-82
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 05:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595497670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DX8uXEh/qO3DTMaGzg0CHAG1+ZxeoLutgHjWRbdLlEI=;
 b=iipnCfXfM9kOuPajrRa51pKMJuivMJyL669SimkKVlO7sro3mNXGNC3mvidm8uewn27nuF
 9CR9Hhgm2TVkrEJvnL4fN5X1fOuj8H7DQITbs28oWabSyIcuNheR5otWm8iFW+ZykK9yar
 kMs3tNKnzRJIRzEHhsxRiNzKDHIPvro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-ap4V2y9KMKWDpl4vVdcIKw-1; Thu, 23 Jul 2020 05:47:46 -0400
X-MC-Unique: ap4V2y9KMKWDpl4vVdcIKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8507100CD4E;
 Thu, 23 Jul 2020 09:47:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF36E5D9E2;
 Thu, 23 Jul 2020 09:47:42 +0000 (UTC)
Subject: Re: [PATCH v2 17/20] backup: move to block-copy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-18-vsementsov@virtuozzo.com>
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
Message-ID: <6376705f-d24d-1b40-f4dd-480c53c7ae55@redhat.com>
Date: Thu, 23 Jul 2020 11:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-18-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9xAgZ9d7uFUaIQa0f7hIKrhjUNIublmPD"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9xAgZ9d7uFUaIQa0f7hIKrhjUNIublmPD
Content-Type: multipart/mixed; boundary="7yjSwbmJBF26XVaHHRlQKVc9ObUJzlU6k"

--7yjSwbmJBF26XVaHHRlQKVc9ObUJzlU6k
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> This brings async request handling and block-status driven chunk sizes
> to backup out of the box, which improves backup performance.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block-copy.h |   9 +--
>  block/backup.c             | 145 +++++++++++++++++++------------------
>  block/block-copy.c         |  21 ++----
>  3 files changed, 83 insertions(+), 92 deletions(-)

This patch feels like it should be multiple ones.  I don=E2=80=99t see why =
a
patch that lets backup use block-copy (more) should have to modify the
block-copy code.

More specifically: I think that block_copy_set_progress_callback()
should be removed in a separate patch.  Also, moving
@cb_opaque/@progress_opaque from BlockCopyState into BlockCopyCallState
seems like a separate patch to me, too.

(I presume if the cb had had its own opaque object from patch 5 on,
there wouldn=E2=80=99t be this problem now.  We=E2=80=99d just stop using t=
he progress
callback in backup, and remove it in one separate patch.)

[...]

> diff --git a/block/backup.c b/block/backup.c
> index ec2676abc2..59c00f5293 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -44,42 +44,19 @@ typedef struct BackupBlockJob {
>      BlockdevOnError on_source_error;
>      BlockdevOnError on_target_error;
>      uint64_t len;
> -    uint64_t bytes_read;
>      int64_t cluster_size;
>      int max_workers;
>      int64_t max_chunk;
> =20
>      BlockCopyState *bcs;
> +
> +    BlockCopyCallState *bcs_call;

Can this be more descriptive?  E.g. background_bcs?  bg_bcs_call?  bg_bcsc?

> +    int ret;
> +    bool error_is_read;
>  } BackupBlockJob;
> =20
>  static const BlockJobDriver backup_job_driver;
> =20

[...]

>  static int coroutine_fn backup_loop(BackupBlockJob *job)
>  {
> -    bool error_is_read;
> -    int64_t offset;
> -    BdrvDirtyBitmapIter *bdbi;
> -    int ret =3D 0;
> +    while (true) { /* retry loop */
> +        assert(!job->bcs_call);
> +        job->bcs_call =3D block_copy_async(job->bcs, 0,
> +                                         QEMU_ALIGN_UP(job->len,
> +                                                       job->cluster_size=
),
> +                                         true, job->max_workers, job->ma=
x_chunk,
> +                                         backup_block_copy_callback, job=
);
> =20
> -    bdbi =3D bdrv_dirty_iter_new(block_copy_dirty_bitmap(job->bcs));
> -    while ((offset =3D bdrv_dirty_iter_next(bdbi)) !=3D -1) {
> -        do {
> -            if (yield_and_check(job)) {
> -                goto out;
> +        while (job->bcs_call && !job->common.job.cancelled) {
> +            /* wait and handle pauses */

Doesn=E2=80=99t someone need to reset BlockCopyCallState.cancelled when the=
 job
is unpaused?  I can=E2=80=99t see anyone doing that.

Well, or even just reentering the block-copy operation after
backup_pause() has cancelled it.  Is there some magic I=E2=80=99m missing?

Does pausing (which leads to cancelling the block-copy operation) just
yield to the CB being invoked, so the copy operation is considered done,
and then we just enter the next iteration of the loop and try again?
But cancelling the block-copy operation leads to it returning 0, AFAIR,
so...

> +
> +            job_pause_point(&job->common.job);
> +
> +            if (job->bcs_call && !job->common.job.cancelled) {
> +                job_yield(&job->common.job);
>              }
> -            ret =3D backup_do_cow(job, offset, job->cluster_size, &error=
_is_read);
> -            if (ret < 0 && backup_error_action(job, error_is_read, -ret)=
 =3D=3D
> -                           BLOCK_ERROR_ACTION_REPORT)
> -            {
> -                goto out;
> +        }
> +
> +        if (!job->bcs_call && job->ret =3D=3D 0) {
> +            /* Success */
> +            return 0;

...I would assume we return here when the job is paused.

> +        }
> +
> +        if (job->common.job.cancelled) {
> +            if (job->bcs_call) {
> +                block_copy_cancel(job->bcs_call);
>              }
> -        } while (ret < 0);
> +            return 0;
> +        }
> +
> +        if (!job->bcs_call && job->ret < 0 &&

Is it even possible for bcs_call to be non-NULL here?

> +            (backup_error_action(job, job->error_is_read, -job->ret) =3D=
=3D
> +             BLOCK_ERROR_ACTION_REPORT))
> +        {
> +            return job->ret;
> +        }

So if we get an error, and the error action isn=E2=80=99t REPORT, we just t=
ry
the whole operation again?  That doesn=E2=80=99t sound very IGNORE-y to me.

>      }
> =20
> - out:
> -    bdrv_dirty_iter_free(bdbi);
> -    return ret;
> +    g_assert_not_reached();
>  }
> =20
>  static void backup_init_bcs_bitmap(BackupBlockJob *job)
> @@ -246,9 +227,14 @@ static int coroutine_fn backup_run(Job *job, Error *=
*errp)
>          int64_t count;
> =20
>          for (offset =3D 0; offset < s->len; ) {
> -            if (yield_and_check(s)) {
> -                ret =3D -ECANCELED;
> -                goto out;
> +            if (job_is_cancelled(job)) {
> +                return -ECANCELED;

I=E2=80=99d either drop the out label altogether, or use it here.  It=E2=80=
=99s a bit
weird to use it sometimes, but not all the time.

> +            }
> +
> +            job_pause_point(job);
> +
> +            if (job_is_cancelled(job)) {
> +                return -ECANCELED;
>              }
> =20
>              ret =3D block_copy_reset_unallocated(s->bcs, offset, &count)=
;
> @@ -281,6 +267,25 @@ static int coroutine_fn backup_run(Job *job, Error *=
*errp)
>      return ret;
>  }
> =20
> +static void coroutine_fn backup_pause(Job *job)
> +{
> +    BackupBlockJob *s =3D container_of(job, BackupBlockJob, common.job);
> +
> +    if (s->bcs_call) {
> +        block_copy_cancel(s->bcs_call);
> +    }
> +}
> +
> +static void coroutine_fn backup_set_speed(BlockJob *job, int64_t speed)
> +{
> +    BackupBlockJob *s =3D container_of(job, BackupBlockJob, common);
> +
> +    if (s->bcs) {
> +        /* In block_job_create we yet don't have bcs */

Shouldn=E2=80=99t hurt to make it conditional, but how can we get here in
block_job_create()?

> +        block_copy_set_speed(s->bcs, s->bcs_call, speed);
> +    }
> +}
> +
>  static const BlockJobDriver backup_job_driver =3D {
>      .job_driver =3D {
>          .instance_size          =3D sizeof(BackupBlockJob),


--7yjSwbmJBF26XVaHHRlQKVc9ObUJzlU6k--

--9xAgZ9d7uFUaIQa0f7hIKrhjUNIublmPD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8ZXL0ACgkQ9AfbAGHV
z0By8gf/SUMri6dAwyfPb6tlCRx4iqgf+r2+bnf/zcR/ezV6mXCY6WgR+W9mJRfW
WCWMsHxHi7tKxcKY1HZoA4NfV59EvK6xPd3NPdNRypEpmwgR/Qeyvji9piz5MCvp
N0gjZjpFT/6nke/jc3DxijLErxmWuzuXGGcI42C36dYJZxz9R00ULeYLhC2eBBKX
UdCgUTwgbVdS1ZE97H2Hy+XOPZ+Y7lvbl200aopqHmobNcRu8vwJ4YzVgul1sgxA
VUoxgmmVEP3/tsUT6VpBptJnTcxoYWKk2vJs7cecPbiQtUVODm5rPJl+GOkaNK4r
XLkCKQb8jb2taUZz19WMHaZzH9/rAA==
=ny4d
-----END PGP SIGNATURE-----

--9xAgZ9d7uFUaIQa0f7hIKrhjUNIublmPD--


