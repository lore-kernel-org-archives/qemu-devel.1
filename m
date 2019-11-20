Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF43C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018A5208A1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhId1dDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018A5208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXXMx-0005k0-6l
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 16:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXXKa-0004Yv-NI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXXKZ-0004jw-0F
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:16:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24291
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXXKY-0004jG-Ox
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 16:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574284564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kzzQhYXIpNh5/pnQrvsKPBCvjnMXthrE5pZzjnKo7I=;
 b=OhId1dDnj9ofHHDgX7aIDtNJyj2aYjOCSMtfFzXxLLyrbM0YE6kazFZU8/OxDj/dcsZUfn
 5jo8hBpxHFKkZ7DumfHp1M1/DptKXd5WDqoMaxe/Vx0i2J5Af/6cnjvgzDHLLNflkfpMA+
 6LtuZ4syOpAyNMSPCiRZDm9nsFsNxEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-acCxfPLHPRuirtCuTRF-gA-1; Wed, 20 Nov 2019 16:16:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B2B11925765;
 Wed, 20 Nov 2019 21:16:01 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EFA551C88;
 Wed, 20 Nov 2019 21:15:58 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] block: truncate: Don't make backing file data
 visible
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-3-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <96c2c681-851d-4b83-2acd-3952fa850e5f@redhat.com>
Date: Wed, 20 Nov 2019 15:15:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120184501.28159-3-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: acCxfPLHPRuirtCuTRF-gA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 12:44 PM, Kevin Wolf wrote:
> When extending the size of an image that has a backing file larger than
> its old size, make sure that the backing file data doesn't become
> visible in the guest, but the added area is properly zeroed out.
>=20
> Consider the following scenario where the overlay is shorter than its
> backing file:
>=20
>      base.qcow2:     AAAAAAAA
>      overlay.qcow2:  BBBB
>=20
> When resizing (extending) overlay.qcow2, the new blocks should not stay
> unallocated and make the additional As from base.qcow2 visible like
> before this patch, but zeros should be read.
>=20
> A similar case happens with the various variants of a commit job when an
> intermediate file is short (- for unallocated):
>=20
>      base.qcow2:     A-A-AAAA
>      mid.qcow2:      BB-B
>      top.qcow2:      C--C--C-
>=20
> After commit top.qcow2 to mid.qcow2, the following happens:
>=20
>      mid.qcow2:      CB-C00C0 (correct result)
>      mid.qcow2:      CB-C--C- (before this fix)
>=20
> Without the fix, blocks that previously read as zeros on top.qcow2
> suddenly turn into A.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>=20

> +    if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE_OFF) {
> +        int64_t backing_len;
> +
> +        backing_len =3D bdrv_getlength(backing_bs(bs));
> +        if (backing_len < 0) {
> +            ret =3D backing_len;
> +            goto out;
> +        }
> +
> +        if (backing_len > old_size) {
> +            ret =3D bdrv_co_do_pwrite_zeroes(
> +                    bs, old_size, MIN(new_bytes, backing_len - old_size)=
,
> +                    BDRV_REQ_ZERO_WRITE | BDRV_REQ_MAY_UNMAP);
> +            if (ret < 0) {
> +                goto out;
> +            }
> +        }
> +    }

Note that if writing zeroes is not fast, and it turns out that we copy a=20
lot of data rather than unallocated sections from the image being=20
committed, that this can actually slow things down (doing a bulk=20
pre-zero doubles up data I/O unless it is fast, which is why we added=20
BDRV_REQ_NO_FALLBACK to avoid slow pre-zeroing).  However, the=20
complication of zeroing only the unallocated clusters rather than a bulk=20
pre-zeroing for something that is an unlikely corner case (how often do=20
you create an overlay shorter than the backing file?) is not worth the=20
extra code maintenance (unlike in the 'qemu-img convert' case where it=20
was worth the optimization). So I'm fine with how you fixed it here.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


