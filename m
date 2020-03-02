Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ACDC3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23B8217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSZNj5gs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23B8217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nnO-0005NH-2I
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j8nmm-0004xM-QN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j8nmk-0003rO-K5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:19:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30954
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j8nmk-0003r9-Fn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583165953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5v94ivr1HafG5iOUYgdVJIbXHfgAnLYUHVXSBuGl0pg=;
 b=aSZNj5gsDiZGXxPgaGHbROvF9pz3wcIuGj7L8M5Kv3JcZVAXEQNt6TsNU7wKf9I9sL8jMa
 e++0tp/O4S6l4SPZQRjT4iFSaiTAXVEXSL2kTt2VsK5gvm1JtoJ+PkOcLe8mqhk3zyPukG
 Q7n/YeY/vf0dRG3Zu/6E76Wutb9+yvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-y9Tftw3mOh-dizkzWp7Bsg-1; Mon, 02 Mar 2020 11:19:07 -0500
X-MC-Unique: y9Tftw3mOh-dizkzWp7Bsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EE2E1005510;
 Mon,  2 Mar 2020 16:19:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-7.ams2.redhat.com [10.36.117.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 026001001B28;
 Mon,  2 Mar 2020 16:19:04 +0000 (UTC)
Date: Mon, 2 Mar 2020 17:19:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Subject: Re: [PATCH] icount: make dma reads deterministic
Message-ID: <20200302161903.GF4965@linux.fritz.box>
References: <158315399043.847.4021939910752786131.stgit@pasha-Precision-3630-Tower>
MIME-Version: 1.0
In-Reply-To: <158315399043.847.4021939910752786131.stgit@pasha-Precision-3630-Tower>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Cc: dovgaluk@ispras.ru, jsnow@redhat.com, qemu-devel@nongnu.org,
 pavel.dovgaluk@ispras.ru, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.03.2020 um 13:59 hat Pavel Dovgalyuk geschrieben:
> Windows guest sometimes makes DMA requests with overlapping
> target addresses. This leads to the following structure of iov for
> the block driver:
>=20
> addr size1
> addr size2
> addr size3
>=20
> It means that three adjacent disk blocks should be read into the same
> memory buffer. Windows does not expects anything from these bytes
> (should it be data from the first block, or the last one, or some mix),
> but uses them somehow. It leads to non-determinism of the guest execution=
,
> because block driver does not preserve any order of reading.
>=20
> This situation was discusses in the mailing list at least twice:
> https://lists.gnu.org/archive/html/qemu-devel/2010-09/msg01996.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05185.html
>=20
> This patch makes such disk reads deterministic in icount mode.
> It skips SG parts that were already affected by prior reads
> within the same request. Parts that are non identical, but are just
> overlapped, are trimmed.
>=20
> Examples for different SG part sequences:
>=20
> 1)
> A1 1000
> A1 1000
> ->
> A1 1000
>=20
> 2)
> A1 1000
> A2 1000
> A1 1000
> A3 1000
> ->
> Two requests with different offsets, because second A1/1000 should be ski=
pped.
> A1 1000
> A2 1000
> --
> A3 1000

How is the "--" line represented in the code?

> 3)
> A1 800
> A2 1000
> A1 1000
> ->
> First 800 bytes of third SG are skipped.
> A1 800
> A2 1000
> --
> A1+800 800
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  dma-helpers.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 53 insertions(+), 4 deletions(-)
>=20
> diff --git a/dma-helpers.c b/dma-helpers.c
> index e8a26e81e1..d71512f707 100644
> --- a/dma-helpers.c
> +++ b/dma-helpers.c
> @@ -13,6 +13,7 @@
>  #include "trace-root.h"
>  #include "qemu/thread.h"
>  #include "qemu/main-loop.h"
> +#include "sysemu/cpus.h"
> =20
>  /* #define DEBUG_IOMMU */
> =20
> @@ -139,17 +140,65 @@ static void dma_blk_cb(void *opaque, int ret)
>      dma_blk_unmap(dbs);
> =20
>      while (dbs->sg_cur_index < dbs->sg->nsg) {
> +        bool skip =3D false;
>          cur_addr =3D dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_b=
yte;
>          cur_len =3D dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byt=
e;
> -        mem =3D dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir=
);
> -        if (!mem)
> -            break;
> -        qemu_iovec_add(&dbs->iov, mem, cur_len);
> +
> +        /*
> +         * Make reads deterministic in icount mode.
> +         * Windows sometimes issues disk read requests with
> +         * overlapping SGs. It leads to non-determinism, because
> +         * resulting buffer contents may be mixed from several
> +         * sectors.
> +         * This code crops SGs that were already read in this request.
> +         */

Please make use of the full line length for the commit text, and add
empty lines between paragraphs.

> +        if (use_icount
> +            && dbs->dir =3D=3D DMA_DIRECTION_FROM_DEVICE) {

This fits in a single line.

> +            int i;
> +            for (i =3D 0 ; i < dbs->sg_cur_index ; ++i) {
> +                if (dbs->sg->sg[i].base <=3D cur_addr
> +                    && dbs->sg->sg[i].base + dbs->sg->sg[i].len > cur_ad=
dr) {

This is range_covers_byte(dbs->sg->sg[i].base, dbs->sg->sg[i].len, cur_addr=
).

> +                    cur_len =3D MIN(cur_len,
> +                        dbs->sg->sg[i].base + dbs->sg->sg[i].len - cur_a=
ddr);

cur_len is now the number of bytes have are not covered by sg[i] yet.
cur_addr is unchanged. It's not used after this, so I guess this
inconsistency is acceptable.

> +                    skip =3D true;
> +                    break;
> +                } else if (cur_addr <=3D dbs->sg->sg[i].base
> +                    && cur_addr + cur_len > dbs->sg->sg[i].base) {

This is range_covers_byte(cur_addr, cur_len, dbs->sg->sg[i].base).

> +                    cur_len =3D dbs->sg->sg[i].base - cur_addr;

cur_len is again the number of bytes not covered by sg[i]. cur_addr is
unchanged, but actually makes sense in this branch.

> +                    break;
> +                }
> +            }
> +        }
> +
> +        assert(cur_len);

What stops a guest from adding a zero-length entry?

> +        if (!skip) {
> +            mem =3D dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs-=
>dir);
> +            if (!mem)
> +                break;
> +            qemu_iovec_add(&dbs->iov, mem, cur_len);

The if statement requires braces.

You're adding a possibly shortened iovec entry here, and then you
continue to add more iovec entries after it. This is the part where I
think the "--" entries from the commit message are missing.

dbs->io_func doesn't know that some part in the middle of the request is
missing, so you'll operate on the wrong data.

> +        } else {
> +            if (dbs->iov.size !=3D 0) {
> +                break;
> +            }

Ok, if we already had something before the "hole", this just splits the
request in two.

How is it possible for dbs->iov.size to be 0, when we just found out
that it overlaps with something?

> +            /* skip this SG */
> +            dbs->offset +=3D cur_len;

Ok, if we didn't have anything before it (for whatever reason), we can
just start the request later.

> +        }
> +
>          dbs->sg_cur_byte +=3D cur_len;
>          if (dbs->sg_cur_byte =3D=3D dbs->sg->sg[dbs->sg_cur_index].len) =
{
>              dbs->sg_cur_byte =3D 0;
>              ++dbs->sg_cur_index;
>          }
> +
> +        /*
> +         * All remaining SGs were skipped.
> +         * This is not reschedule case, because we already
> +         * performed the reads, and the last SGs were skipped.
> +         */
> +        if (dbs->sg_cur_index =3D=3D dbs->sg->nsg && dbs->iov.size =3D=
=3D 0) {
> +            dma_complete(dbs, ret);
> +            return;
> +        }
>      }

I think the concept of skipping SG list entries makes this patch
relatively complex. Maybe one of these would work better:

1. Instead of skipping, add a temporary bounce buffer to the iovec.

2. Instead of skipping, just exit the loop and effectively split the
   request in multiple parts (like you already do in one case). Then the
   memory will still be written to twice, but deterministically so that
   the later SG list entry always wins.

I think 2. sounds quite attractive because you don't have to manage any
additional state. You can even simplify the loop to use ranges_overlap()
instead of two separate cases: No matter which way the ranges overlap,
you just execute the first part and continue with the overlapping part
in the next dma_blk_cb() callback.

Kevin


