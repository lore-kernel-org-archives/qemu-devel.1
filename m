Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0547C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8726D20716
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpHTgZ5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8726D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihcW4-0007HP-8W
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihcUB-0005iR-Rs
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihcUA-0001kD-DG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:47:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihcUA-0001gn-7M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576687661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKmpyXCe1UvmXa8493ASsmx6keV/mkvWOQw/mH2C2HM=;
 b=PpHTgZ5CequrKum/1KzejEQpsNdfghX9aMmFioC+C37qJ53+dDcmTiXI5kYxO0EApKskOY
 8UWlqaWFpgCq/I8vei1ReezIIZGiI6PvzSklLQX2l5cRXpqrbsHAyVVlKjyHWtXHuoqPun
 mZ7atKV8nSE7aIEKAhbEF1K9y5QkzDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222--iLtyYOiNYCj776LjtS4Zg-1; Wed, 18 Dec 2019 11:47:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE1399123E;
 Wed, 18 Dec 2019 16:47:36 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5F155D9E2;
 Wed, 18 Dec 2019 16:47:35 +0000 (UTC)
Date: Wed, 18 Dec 2019 17:47:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] block/io: wait for serialising requests when a
 request becomes serialising
Message-ID: <20191218164618.GD4632@linux.fritz.box>
References: <1576675026-25046-1-git-send-email-pbonzini@redhat.com>
 <1576675026-25046-3-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1576675026-25046-3-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -iLtyYOiNYCj776LjtS4Zg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.12.2019 um 14:17 hat Paolo Bonzini geschrieben:
> Marking without waiting would not result in actual serialising behavior.
> Thus, make a call bdrv_mark_request_serialising sufficient for
> serialisation to happen.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> @@ -1851,13 +1841,18 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64=
_t offset, uint64_t bytes,
>      assert(!(flags & ~BDRV_REQ_MASK));
> =20
>      if (flags & BDRV_REQ_SERIALISING) {
> -        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
> +        waited =3D bdrv_mark_request_serialising(req, bdrv_get_cluster_s=
ize(bs));
> +        /*
> +         * For a misaligned request, we should have already waited
> +         * in bdrv_padding_rmw_read and locked out concurrent writers.

Actually, bdrv_padding_rmw_read() only asserts that the request is
already serialised. bdrv_mark_request_serialising() is already called by
the callers of bdrv_padding_rmw_read().

> +         */
> +        assert(!waited ||
> +               (req->offset =3D=3D req->overlap_offset &&
> +                req->bytes =3D=3D req->overlap_bytes));
> +    } else {
> +        bdrv_wait_serialising_requests(req);
>      }
> =20
> -    waited =3D bdrv_wait_serialising_requests(req);
> -
> -    assert(!waited || !req->serialising ||
> -           is_request_serialising_and_aligned(req));
>      assert(req->overlap_offset <=3D offset);
>      assert(offset + bytes <=3D req->overlap_offset + req->overlap_bytes)=
;
>      assert(end_sector <=3D bs->total_sectors || child->perm & BLK_PERM_R=
ESIZE);

Other than the comment, the patch looks fine to me.

Kevin


