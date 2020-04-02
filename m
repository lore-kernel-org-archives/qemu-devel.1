Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2098C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2D520757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebcDBrFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2D520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJz2t-0000VN-QH
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jJz26-0008QN-UG
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jJz25-00087H-Pp
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:33:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jJz25-000875-Ki
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585830797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kcYhnHzskkAli9F+wZwRqE8rMmOG0MWOU/DSvVK23UM=;
 b=ebcDBrFhqHnVjRDTlF+cvd8vDaVWo5hcQVA4Dtj4IRI6LUKeoMHFw9WYtfFLeZLHKNjt17
 Xyf7AnTaC/ef3RigROy+DytlP5AApcdmCrg92FH7tYAb0sKbtUENWIx3fvqpyOkgzqQmN/
 iaAII1/3TGqCLGGqpCNTUPQgaqtK7B8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-3PbrEd8yP9mDdHs_LC1Vcg-1; Thu, 02 Apr 2020 08:33:15 -0400
X-MC-Unique: 3PbrEd8yP9mDdHs_LC1Vcg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 326A28017F3;
 Thu,  2 Apr 2020 12:33:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-246.ams2.redhat.com
 [10.36.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 128DE6EF97;
 Thu,  2 Apr 2020 12:33:05 +0000 (UTC)
Subject: Re: [PATCH v4 1/3] job: take each job's lock individually in
 job_txn_apply
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20200401081504.200017-1-s.reiter@proxmox.com>
 <20200401081504.200017-2-s.reiter@proxmox.com>
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
Message-ID: <e6319083-4ba0-9d30-3ecd-1c81bf7c20f9@redhat.com>
Date: Thu, 2 Apr 2020 14:33:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401081504.200017-2-s.reiter@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V1Tr6CzMg7mrLlbjLyhWoDxIrVhZ9mVf5"
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, slp@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V1Tr6CzMg7mrLlbjLyhWoDxIrVhZ9mVf5
Content-Type: multipart/mixed; boundary="tvFE6GHX3D7mAS0sQsV2XOEess47rlxft"

--tvFE6GHX3D7mAS0sQsV2XOEess47rlxft
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.04.20 10:15, Stefan Reiter wrote:
> All callers of job_txn_apply hold a single job's lock, but different
> jobs within a transaction can have different contexts, thus we need to
> lock each one individually before applying the callback function.
>=20
> Similar to job_completed_txn_abort this also requires releasing the
> caller's context before and reacquiring it after to avoid recursive
> locks which might break AIO_WAIT_WHILE in the callback.
>=20
> This also brings to light a different issue: When a callback function in
> job_txn_apply moves it's job to a different AIO context, job_exit will
> try to release the wrong lock (now that we re-acquire the lock
> correctly, previously it would just continue with the old lock, leaving
> the job unlocked for the rest of the codepath back to job_exit). Fix
> this by not caching the job's context in job_exit and add a comment
> about why this is done.
>=20
> One test needed adapting, since it calls job_finalize directly, so it
> manually needs to acquire the correct context.
>=20
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
>  job.c                 | 48 ++++++++++++++++++++++++++++++++++---------
>  tests/test-blockjob.c |  2 ++
>  2 files changed, 40 insertions(+), 10 deletions(-)
>=20
> diff --git a/job.c b/job.c
> index 134a07b92e..5fbaaabf78 100644
> --- a/job.c
> +++ b/job.c
> @@ -136,17 +136,36 @@ static void job_txn_del_job(Job *job)
>      }
>  }
> =20
> -static int job_txn_apply(JobTxn *txn, int fn(Job *))
> +static int job_txn_apply(Job *job, int fn(Job *))
>  {
> -    Job *job, *next;
> +    AioContext *inner_ctx;
> +    Job *other_job, *next;
> +    JobTxn *txn =3D job->txn;
>      int rc =3D 0;
> =20
> -    QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
> -        rc =3D fn(job);
> +    /*
> +     * Similar to job_completed_txn_abort, we take each job's lock befor=
e
> +     * applying fn, but since we assume that outer_ctx is held by the ca=
ller,
> +     * we need to release it here to avoid holding the lock twice - whic=
h would
> +     * break AIO_WAIT_WHILE from within fn.
> +     */
> +    aio_context_release(job->aio_context);

Hm, is it safe to drop the lock here and then reacquire it later?  I.e.,
is the job in a consistent state in between?  I don=92t know.  Looks like
it.  Maybe someone else knows better.

(I find the job code rather confusing.)

> +
> +    QLIST_FOREACH_SAFE(other_job, &txn->jobs, txn_list, next) {
> +        inner_ctx =3D other_job->aio_context;
> +        aio_context_acquire(inner_ctx);
> +        rc =3D fn(other_job);
> +        aio_context_release(inner_ctx);
>          if (rc) {
>              break;
>          }
>      }
> +
> +    /*
> +     * Note that job->aio_context might have been changed by calling fn,=
 so we
> +     * can't use a local variable to cache it.
> +     */
> +    aio_context_acquire(job->aio_context);

But all callers of job_txn_apply() (but job_exit(), which you fix in
this patch) cache it.  Won=92t they release the wrong context then?  Or is
a context change only possible when job_txn_apply() is called from
job_exit()?

Max


--tvFE6GHX3D7mAS0sQsV2XOEess47rlxft--

--V1Tr6CzMg7mrLlbjLyhWoDxIrVhZ9mVf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6F238ACgkQ9AfbAGHV
z0DZugf9FPP4qrx5bInbjxuvrp/qeYdZW34GZA71SVWIvfHAYnyb2TXoCFz0SO1Z
C1icY4F/rdaDvlsL2kfeEF8HtW8YYytNN8YGSYNgaUO14Ky5BfePAbBFev0+3lvQ
+n4kf3y5gzBjZBBkqk5+P4E7sOfMg4mk4lcRDm6tZlT6QsU/pFowGkxd+jII0x8T
oCgvYTUHIM2aNaKSYAWZzhqdjQz+rJgjYyGS1gCY03EXZP6gzbpVcEVGRFOfwhsQ
eJD3PODVUrWbKXRpYwXmIVBbE8ilkD/Ebhb0dQUHzTB+pGM9Ipgyj1OSlCrgAvSI
qC35Ls4zXp2TCDx5FuajC9hoP/D4MA==
=lBd/
-----END PGP SIGNATURE-----

--V1Tr6CzMg7mrLlbjLyhWoDxIrVhZ9mVf5--


