Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8E7C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FD4206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iV6rFsh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FD4206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvjK-0001OZ-Dp
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIvbA-0002V9-CM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:13:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIvb7-0003AZ-6w
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600355599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lTTXm1sCCee6TwMCsLggshFrJmrqgTdlUV5hd+ay7rc=;
 b=iV6rFsh/ZKe08CVrd7lU4QeHA+QL00Rwog7FHvller7LAWPNAWqaTcPzSTtZ9NPJxptRzw
 FBdqL2i19PL+ynsiq24kVHC2ALgTNKwfkE2cdcECke1c9FRShzvvwrB5GVztifCe5QB5TH
 IT0vZ2YT6nizYSMrh+zptsbKzWmODB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-bBdnxmvmO3ue5c7ZRnsTPA-1; Thu, 17 Sep 2020 11:13:03 -0400
X-MC-Unique: bBdnxmvmO3ue5c7ZRnsTPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F8268BF133;
 Thu, 17 Sep 2020 15:13:01 +0000 (UTC)
Received: from localhost (ovpn-112-183.ams2.redhat.com [10.36.112.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16C17610F2;
 Thu, 17 Sep 2020 15:13:00 +0000 (UTC)
Date: Thu, 17 Sep 2020 11:42:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/3] block/nvme: Use atomic operations instead of
 'volatile' keyword
Message-ID: <20200917104225.GD809514@stefanha-x1.localdomain>
References: <20200916204004.1511985-1-philmd@redhat.com>
 <20200916204004.1511985-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916204004.1511985-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-2.997, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 10:40:03PM +0200, Philippe Mathieu-Daud=E9 wrote:

I think the current use of volatile is fine. It's widely used in device
drivers (see Linux and DPDK) so I'm not sure eliminating it is
worthwhile.

> Follow docs/devel/atomics.rst guidelines and use atomic operations.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index b91749713e0..be80ea1f410 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -46,7 +46,7 @@ typedef struct {
>      uint8_t  *queue;
>      uint64_t iova;
>      /* Hardware MMIO register */
> -    volatile uint32_t *doorbell;
> +    uint32_t *doorbell;
>  } NVMeQueue;
> =20
>  typedef struct {
> @@ -82,7 +82,7 @@ typedef struct {
>  } NVMeQueuePair;
> =20
>  /* Memory mapped registers */
> -typedef volatile struct {
> +typedef struct {
>      NvmeBar ctrl;
>      struct {
>          uint32_t sq_tail;
> @@ -273,8 +273,7 @@ static void nvme_kick(NVMeQueuePair *q)
>      trace_nvme_kick(s, q->index);
>      assert(!(q->sq.tail & 0xFF00));
>      /* Fence the write to submission queue entry before notifying the de=
vice. */
> -    smp_wmb();
> -    *q->sq.doorbell =3D cpu_to_le32(q->sq.tail);
> +    atomic_rcu_set(q->sq.doorbell, cpu_to_le32(q->sq.tail));

I suggest using smp_wmb()/smp_rmb() instead of atomic operations since
operation doesn't actually need to be atomic.

This hunk can be dropped from the patch, the existing behavior is
already correct.

> @@ -734,10 +731,11 @@ static int nvme_init(BlockDriverState *bs, const ch=
ar *device, int namespace,
>      timeout_ms =3D MIN(500 * ((cap >> 24) & 0xFF), 30000);
> =20
>      /* Reset device to get a clean state. */
> -    s->regs->ctrl.cc &=3D const_le32(0xFE);
> +    atomic_set(&s->regs->ctrl.cc,
> +               cpu_to_le32(atomic_read(&s->regs->ctrl.cc) & const_le32(0=
xFE)));
>      /* Wait for CSTS.RDY =3D 0. */
>      deadline =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * S=
CALE_MS;
> -    while (s->regs->ctrl.csts & const_le32(0x1)) {
> +    while (atomic_read(&s->regs->ctrl.csts) & const_le32(0x1)) {
>          if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
>              error_setg(errp, "Timeout while waiting for device to reset =
(%"
>                               PRId64 " ms)",

Linux drivers use readl()/writel() to perform memory loads/stores with
appropriate constraints for MMIO accesses (e.g. the instructions cannot
be optimized by the compiler). QEMU lacks an API like this because it
didn't contain userspace drivers before block/nvme.c.

The semantics needed here are that the compiler must perform the memory
access and cannot optimize it.

Please introduce an API for hardware register accesses instead of
(ab)using atomics.

Stefan

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9jPZEACgkQnKSrs4Gr
c8ibnQf+LxuIQH+KqHjPg3oX36adr5koZ5RWLfPnjTsosidRay717buN5z/OswFm
eJirrlLtXTp6ugAmZx2iFyd5xOrSFlyAPbGo6nHa2IvVo9AGfxJHf2WgGPgL/EyD
X2mERZlTyqyjEa2fgvd4etQPxnDPIlAd0xAuowNtVIL5Yy5cOk6MHoBZ0iBEfxRV
5n014+NQNWS+hTpOxPsX8ecNxhXCsQs1FkeLbS7xO1wzSxXtexxL5mgJ9gk2nUmj
QJdH+pGDIysgOu/4OIUIHcv60/c/qvnrC+IbTph71plK8YRjFgABaorbQmdk+/fz
w2o/v+eUIVzBfeVgFwAaqKDN48KCJA==
=Gwuo
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--


