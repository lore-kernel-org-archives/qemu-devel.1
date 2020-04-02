Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B7EC2BA15
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A94320757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQEb28R8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A94320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzBt-0005dl-Lm
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jJzAa-0004XJ-Id
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jJzAZ-0007V6-CE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:42:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jJzAZ-0007Ud-6r
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585831321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eaSCZ3v8e0Uv4SBFWmg89bVob2iGtkC9F0T0xYgILdQ=;
 b=DQEb28R8cq9pFhito6O6pPlCtx1P3+6Iop4K06pyKlKiMR9hOiP1BPWl5XIJbDV6UqYEtv
 0b5eO/Nn93FlOkSV1Ojqnq9NWvdQAOsi4vRtFIQqsILaP9EQpBd+xnHTybKx/qs2Pf3bpe
 BHQat/tI58qhwN0N3RbmcpzH6fj9BvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-BcFTrCEgMyinYrDq8bhfGg-1; Thu, 02 Apr 2020 08:41:58 -0400
X-MC-Unique: BcFTrCEgMyinYrDq8bhfGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C8EA1137840;
 Thu,  2 Apr 2020 12:41:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-246.ams2.redhat.com
 [10.36.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B46A25D9C9;
 Thu,  2 Apr 2020 12:41:47 +0000 (UTC)
Subject: Re: [PATCH v4 2/3] replication: acquire aio context before calling
 job_cancel_sync
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20200401081504.200017-1-s.reiter@proxmox.com>
 <20200401081504.200017-3-s.reiter@proxmox.com>
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
Message-ID: <7d231bb6-4b1c-1cd1-51a6-4bef97de65e0@redhat.com>
Date: Thu, 2 Apr 2020 14:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401081504.200017-3-s.reiter@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZsbgE8y7zvscoxmv2ETbySXpVEeKqf615"
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, slp@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZsbgE8y7zvscoxmv2ETbySXpVEeKqf615
Content-Type: multipart/mixed; boundary="v0wbhkzEfAVGFYYhGeyBIfMh5l9GDwi4W"

--v0wbhkzEfAVGFYYhGeyBIfMh5l9GDwi4W
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.04.20 10:15, Stefan Reiter wrote:
> job_cancel_sync requires the job's lock to be held, all other callers
> already do this (replication_stop, drive_backup_abort,
> blockdev_backup_abort, job_cancel_sync_all, cancel_common).

I think all other callers come directly from QMP, though, so they have
no locks yet.  This OTOH is called from a block driver function, so I
would assume the BDS context is locked already (or rather, this is
executed in the BDS context).

I also think that the commit job runs in the same context.  So I would
assume that this would be a nested lock, which should be unnecessary and
might cause problems.  Maybe we should just assert that the job=92s
context is the current context?

(Or would that still be problematic because now job_txn_apply() wants to
release some context, and that isn=92t possible without this patch?  I
would hope it=92s possible, because I think we shouldn=92t have to acquire
the current context, and should be free to release it...?  I have no
idea.  Maybe we are actually free to reacquire the current context here.)

> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
>  block/replication.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/replication.c b/block/replication.c
> index 413d95407d..17ddc31569 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -144,12 +144,18 @@ fail:
>  static void replication_close(BlockDriverState *bs)
>  {
>      BDRVReplicationState *s =3D bs->opaque;
> +    Job *commit_job;
> +    AioContext *commit_ctx;
> =20
>      if (s->stage =3D=3D BLOCK_REPLICATION_RUNNING) {
>          replication_stop(s->rs, false, NULL);
>      }
>      if (s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> -        job_cancel_sync(&s->commit_job->job);
> +        commit_job =3D &s->commit_job->job;
> +        commit_ctx =3D commit_job->aio_context;
> +        aio_context_acquire(commit_ctx);
> +        job_cancel_sync(commit_job);
> +        aio_context_release(commit_ctx);

Anyway, there=92s also the problem that I would guess the
job_cancel_sync() might move the job from its current context back into
the main context.  Then we=92d release the wrong context here.

Max

>      }
> =20
>      if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
>=20



--v0wbhkzEfAVGFYYhGeyBIfMh5l9GDwi4W--

--ZsbgE8y7zvscoxmv2ETbySXpVEeKqf615
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6F3YoACgkQ9AfbAGHV
z0CUgQf+NaZLJ+mzMjr+9Pp6At1VQUVOk9XAbWlfoGbBwhXCnsfAsSuSHzyCFkTT
UZb1am4nc6//IolYue/NI8kEcXSCLyUUXj0JHSDFgIADPeECDiBglaIDBfiJ9AB7
lj/5f1IA3YT6X9CS9OToGqovw/fAXTu7MlMJFlB6smkdHtdTndJmIOUa59eR/aJ6
tUKBGND8Etr7ygiV5JqRle41VOyLTGsCWQFGPrY+oRN3Cv1gO5sTpN3LcMSq1oHj
GGQJPnWPgpkEpclNd5LnrKfr3aelD/ZOupFbGMWaG8Ovr9+UtC+SsU/Xl/7RFFyH
bwY8Rpi1zRt6Am11Th4r+0OYm2HL9w==
=yNc+
-----END PGP SIGNATURE-----

--ZsbgE8y7zvscoxmv2ETbySXpVEeKqf615--


