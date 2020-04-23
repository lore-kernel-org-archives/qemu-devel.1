Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7497EC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F187C20767
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSd9bntp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F187C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRe78-0000dz-3i
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRe5u-0007D9-2x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRe5t-0001m0-Mu
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:48:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43551
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRe5t-0001jy-2m
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587656932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZyr8aq0wFC0KaPX01AX5MSXRFLmJJ3H2ULg9hbJC5g=;
 b=FSd9bntpiaNO6QyxQWGyxYY0bwww5sVecgv2RfZRsYCfs49/6aX8q+BKkrBaMj61+JvG0B
 ZT3O8yTvnduW03njxSW9aKfzCwVSLeTLLvvuoP/RbSGI1v3Z4RszIopjVi1nyr/h2KmmM9
 I1apR1a2n9uybx31iLx95Vx0VnQXXkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-SSPOay-JNEWb46_TM1tEDw-1; Thu, 23 Apr 2020 11:48:48 -0400
X-MC-Unique: SSPOay-JNEWb46_TM1tEDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2220E100CC8F;
 Thu, 23 Apr 2020 15:48:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8985F196AE;
 Thu, 23 Apr 2020 15:48:45 +0000 (UTC)
Date: Thu, 23 Apr 2020 17:48:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 04/10] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
Message-ID: <20200423154844.GE23654@linux.fritz.box>
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-5-kwolf@redhat.com>
 <b9d97ddb-b13d-637a-1848-1d93a2d44736@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b9d97ddb-b13d-637a-1848-1d93a2d44736@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.04.2020 um 17:18 hat Eric Blake geschrieben:
> On 4/23/20 10:01 AM, Kevin Wolf wrote:
> > If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> > qcow2_cluster_zeroize() with flags=3D0 does the right thing: It doesn't
> > undo any previous preallocation, but just adds the zero flag to all
> > relevant L2 entries. If an external data file is in use, a write_zeroes
> > request to the data file is made instead.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Max Reitz <mreitz@redhat.com>
> > ---
> >   block/qcow2-cluster.c |  2 +-
> >   block/qcow2.c         | 33 +++++++++++++++++++++++++++++++++
> >   2 files changed, 34 insertions(+), 1 deletion(-)
> >=20
>=20
> > +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
> > +        uint64_t zero_start =3D QEMU_ALIGN_UP(old_length, s->cluster_s=
ize);
> > +
> > +        /*
> > +         * Use zero clusters as much as we can. qcow2_cluster_zeroize(=
)
> > +         * requires a cluster-aligned start. The end may be unaligned =
if it is
> > +         * at the end of the image (which it is here).
> > +         */
> > +        ret =3D qcow2_cluster_zeroize(bs, zero_start, offset - zero_st=
art, 0);
> > +        if (ret < 0) {
> > +            error_setg_errno(errp, -ret, "Failed to zero out new clust=
ers");
> > +            goto fail;
> > +        }
> > +
> > +        /* Write explicit zeros for the unaligned head */
> > +        if (zero_start > old_length) {
> > +            uint8_t *buf =3D qemu_blockalign0(bs, s->cluster_size);
> > +            QEMUIOVector qiov;
> > +            qemu_iovec_init_buf(&qiov, buf, zero_start - old_length);
> > +
> > +            qemu_co_mutex_unlock(&s->lock);
> > +            ret =3D qcow2_co_pwritev_part(bs, old_length, qiov.size, &=
qiov, 0, 0);
>=20
> This works, but would it be any more efficient to use
> qcow2_co_pwrite_zeroes?  If the head of the cluster is already zero, then
> qcow2_co_pwrite_zeroes can turn into qcow2_cluster_zeroize for this clust=
er,
> while qcow2_co_pwritev_part cannot.

The problem is that qcow2_co_pwrite_zeroes() will return -ENOTSUP if the
request is still unaligned after this optimisation. I would have to go
through the generic bdrv_co_pwrite_zeroes() to get the fallback, but I
can't do that because bs->total_sectors isn't updated yet.

Kevin


