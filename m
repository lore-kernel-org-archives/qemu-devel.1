Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F775C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3AE20717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abu/Fxrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3AE20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihcT3-0004Eg-3L
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihcKq-0000yE-OY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihcKn-000235-Sd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:38:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihcKn-0001wp-KO
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576687080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+E0JouZUQhLMwOWSadwvnifo5sHnpMlW7MmB8lamB7I=;
 b=abu/FxrmfBpUC4YjZy4LF5krRB4AjPuTqbiPB8Z1GHehR0HKfRtqpdEfJ6Y8irjVcZYaYy
 cz9u2aKzVYNsXDZCp/0+ecPWKLU6KIKAvn+UewZE5s2UwWsB/joWX6AZXvLhOLBHsm4NY8
 viayEZq9vq3KHQXP9QO7hpSAoT/h3dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-MGUtMdnLNo-LNWHNOAQJQg-1; Wed, 18 Dec 2019 11:37:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AACD800D24;
 Wed, 18 Dec 2019 16:37:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CCD326DD7;
 Wed, 18 Dec 2019 16:37:55 +0000 (UTC)
Date: Wed, 18 Dec 2019 17:37:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] block: eliminate BDRV_REQ_NO_SERIALISING
Message-ID: <20191218163636.GC4632@linux.fritz.box>
References: <1576675026-25046-1-git-send-email-pbonzini@redhat.com>
 <1576675026-25046-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1576675026-25046-2-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: MGUtMdnLNo-LNWHNOAQJQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[ Fixing the qemu-block address ]

Am 18.12.2019 um 14:17 hat Paolo Bonzini geschrieben:
> It is unused since commit 00e30f0 ("block/backup: use backup-top instead
> of write notifiers", 2019-10-01), drop it to simplify the code.
>=20
> While at it, drop redundant assertions on flags.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c            | 18 ++++--------------
>  include/block/block.h | 12 ------------
>  2 files changed, 4 insertions(+), 26 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index f75777f..b3a67fe 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1445,8 +1445,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
>       * potential fallback support, if we ever implement any read flags
>       * to pass through to drivers.  For now, there aren't any
>       * passthrough flags.  */
> -    assert(!(flags & ~(BDRV_REQ_NO_SERIALISING | BDRV_REQ_COPY_ON_READ |
> -                       BDRV_REQ_PREFETCH)));
> +    assert(!(flags & ~(BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH)));
> =20
>      /* Handle Copy on Read and associated serialisation */
>      if (flags & BDRV_REQ_COPY_ON_READ) {
> @@ -1458,12 +1457,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvCh=
ild *child,
>          bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
>      }
> =20
> -    /* BDRV_REQ_SERIALISING is only for write operation */
> -    assert(!(flags & BDRV_REQ_SERIALISING));

I think we shoud still keep this assertion as long as read requests
don't mark themselves as serialising when BDRV_REQ_SERIALISING is given.
Otherwise, someone might add the flag to a read request and will later
be surprised that it didn't work.

> -    if (!(flags & BDRV_REQ_NO_SERIALISING)) {
> -        bdrv_wait_serialising_requests(req);
> -    }
> +    bdrv_wait_serialising_requests(req);
> =20
>      if (flags & BDRV_REQ_COPY_ON_READ) {
>          int64_t pnum;
> @@ -1711,7 +1705,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *chi=
ld,
>      bdrv_inc_in_flight(bs);
> =20
>      /* Don't do copy-on-read if we read data before write operation */
> -    if (atomic_read(&bs->copy_on_read) && !(flags & BDRV_REQ_NO_SERIALIS=
ING)) {
> +    if (atomic_read(&bs->copy_on_read)) {

The comment wants an update, too (or maybe a removal).

>          flags |=3D BDRV_REQ_COPY_ON_READ;
>      }
> =20
> @@ -1852,8 +1846,6 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t=
 offset, uint64_t bytes,
>          return -EPERM;
>      }
> =20
> -    /* BDRV_REQ_NO_SERIALISING is only for read operation */
> -    assert(!(flags & BDRV_REQ_NO_SERIALISING));
>      assert(!(bs->open_flags & BDRV_O_INACTIVE));
>      assert((bs->open_flags & BDRV_O_NO_IO) =3D=3D 0);
>      assert(!(flags & ~BDRV_REQ_MASK));
> @@ -3222,9 +3214,7 @@ static int coroutine_fn bdrv_co_copy_range_internal=
(
> =20
>          /* BDRV_REQ_SERIALISING is only for write operation */
>          assert(!(read_flags & BDRV_REQ_SERIALISING));

Here you kept the assertion, so apart from making sense anyway, it would
also be more consistent to keep it above, too. :-)

> -        if (!(read_flags & BDRV_REQ_NO_SERIALISING)) {
> -            bdrv_wait_serialising_requests(&req);
> -        }
> +        bdrv_wait_serialising_requests(&req);
> =20
>          ret =3D src->bs->drv->bdrv_co_copy_range_from(src->bs,

Kevin


