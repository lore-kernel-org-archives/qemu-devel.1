Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F4C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A992072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbRIVSie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A992072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwDr-0004yH-UK
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jJwD6-0003xT-Jj
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jJwD4-0007b2-V8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:32:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52607
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jJwD4-0007Yv-QU
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585819946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X+KOdGcGEw2gSawHhNqh1nXXjrQa7I35RsICu1UaYPM=;
 b=XbRIVSieiDRdwsWsF7BOkurT4CemPm0RrdZhlTwaFo4IhhlNi4uWSgCm9Y15bxfDqYnmsf
 UwKZ0Z5CfA9huIQj9UDAb91ct+Vm+4heogGBcGGm+PDiVCef47y2XFmgfpjwF/5Q/gxLun
 HbYMVcItEru68VEhi3/L4xaxXavabuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-a7oFSUDONxyxI6iWkCv5MQ-1; Thu, 02 Apr 2020 05:32:24 -0400
X-MC-Unique: a7oFSUDONxyxI6iWkCv5MQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C19A013F7;
 Thu,  2 Apr 2020 09:32:22 +0000 (UTC)
Received: from localhost (ovpn-113-134.ams2.redhat.com [10.36.113.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54E9F5D9CA;
 Thu,  2 Apr 2020 09:32:22 +0000 (UTC)
Date: Thu, 2 Apr 2020 10:32:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] util/async: Add memory barrier to aio_ctx_prepare
Message-ID: <20200402093221.GD28280@stefanha-x1.localdomain>
References: <20200402024431.1629-1-fangying1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200402024431.1629-1-fangying1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, qemu-arm@nongnu.org, Ying Fang <fangying1@huawei.com>,
 pbonzini@redhat.com, wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 10:44:31AM +0800, Ying Fang wrote:
> Qemu main thread is found to hang up in the mainloop when doing
> image format convert on aarch64 platform and it is highly
> reproduceable by executing test using:
>=20
> qemu-img convert -f qcow2 -O qcow2 origin.qcow2 converted.qcow2
>=20
> This mysterious hang can be explained by a race condition between
> the main thread and an io worker thread. There can be a chance that
> the last worker thread has called aio_bh_schedule_oneshot and it is
> checking against notify_me to deliver a notfiy event. At the same
> time, the main thread is calling aio_ctx_prepare however it first
> calls qemu_timeout_ns_to_ms, thus the worker thread did not see
> notify_me as true and did not send a notify event. The time line
> can be shown in the following way:
>=20
>  Main Thread
>  ------------------------------------------------
>  aio_ctx_prepare
>     atomic_or(&ctx->notify_me, 1);
>     /* out of order execution goes here */
>     *timeout =3D qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
>=20
>  Worker Thread
>  -----------------------------------------------
>  aio_bh_schedule_oneshot -> aio_bh_enqueue
>     aio_notify
> =09smp_mb();
> =09if (ctx->notify_me) {   /* worker thread checks notify_me here */
> =09    event_notifier_set(&ctx->notifier);
> =09    atomic_mb_set(&ctx->notified, true);
> =09}

Paolo, I'm not sure how to interpret this case according to
docs/devel/atomics.txt.  Maybe you can clarify.

atomic_or() is sequentially consistent and I therefore expected it to
act as a barrier.  Or does sequential consistency only cover the memory
accessed via the sequentially consistent atomics APIs and everything
else (like aio_compute_timeout()) can be reordered?

>=20
> Normal VM runtime is not affected by this hang since there is always some
> timer timeout or subsequent io worker come and notify the main thead.
> To fix this problem, a memory barrier is added to aio_ctx_prepare and
> it is proved to have the hang fixed in our test.
>=20
> This hang is not observed on the x86 platform however it can be easily
> reproduced on the aarch64 platform, thus it is architecture related.
> Not sure if this is revelant to Commit eabc977973103527bbb8fed69c91cfaa66=
91f8ab
>=20
> Signed-off-by: Ying Fang <fangying1@huawei.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Reported-by: Euler Robot <euler.robot@huawei.com>
>=20
> ---
> =09v2: add comments before the barrier
>=20
> ---
>  util/async.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/async.c b/util/async.c
> index b94518b..89a4f3e 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -250,7 +250,8 @@ aio_ctx_prepare(GSource *source, gint    *timeout)
>      AioContext *ctx =3D (AioContext *) source;
> =20
>      atomic_or(&ctx->notify_me, 1);
> -
> +    /* Make sure notify_me is set before aio_compute_timeout */
> +    smp_mb();
>      /* We assume there is no timeout already supplied */
>      *timeout =3D qemu_timeout_ns_to_ms(aio_compute_timeout(ctx));
> =20
> --=20
> 1.8.3.1
>=20
>=20

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6FsSUACgkQnKSrs4Gr
c8jxmwf/WbDZ3sZ09kVAjfwMqMWFjjIgEoekyuEL7nfvi/1ZmG9JHqH6SW66rUrw
ZPtSHKJew8ex87lEZWwoHrIRkUBWrQal8zq3j0vzismRTMTXC/YyG9uLzG7GuIKB
bkZUJCPD67G66gG+rGmkM+QD1aAAUGML8mHRG3uPp9B9mpA+REtl+w+LDXPechTx
mlNqaD4Q/NiSovjzM9zbaNkH2icTNBBjseTs0ooahjMzUrBAOI9q3E8PnRJCNxq9
Y3ItDnFG82N/o0U7+eUmh0jj5lF1kIiUy3yUkdsfpuARbP+5MTEBsoPWw8FOetSk
sEoTR4RAp/R4ZYtCEqtAVjAG34Simw==
=o9TH
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--


