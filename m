Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E47FC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B88720714
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQIkKIGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B88720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkYi-0002RL-5u
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXkXu-0001S6-4j
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXkXs-00083E-S5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:22:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36830
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXkXs-00082f-NZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574335364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dqu78u6yRo4Gua36j1fiPc0+csz+5H2Qn1kPtuTeits=;
 b=BQIkKIGhA7XZ3rjGCruTCEE8VgkRlHpv3E1Xmfu+KmmJPjejHg8SBppn6RMl5Qwh/s4/g5
 LE+GUkX6d20SkOVRkHZoK72xURfB2uN2L8z5G5nE25YO5mDSfvVCdWiZmM18hi5KhcnOtV
 v7YPC/HGCDrFgLvzPQL6fHNEJvx7Nlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-B_N_eDliO2y5xuI86tM7TQ-1; Thu, 21 Nov 2019 06:22:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A966CB3DBD;
 Thu, 21 Nov 2019 11:22:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F6D83DA0;
 Thu, 21 Nov 2019 11:22:37 +0000 (UTC)
Date: Thu, 21 Nov 2019 12:22:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 2/6] block: truncate: Don't make backing file data
 visible
Message-ID: <20191121112235.GD6007@linux.fritz.box>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-3-kwolf@redhat.com>
 <96c2c681-851d-4b83-2acd-3952fa850e5f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <96c2c681-851d-4b83-2acd-3952fa850e5f@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: B_N_eDliO2y5xuI86tM7TQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.11.2019 um 22:15 hat Eric Blake geschrieben:
> On 11/20/19 12:44 PM, Kevin Wolf wrote:
> > When extending the size of an image that has a backing file larger than
> > its old size, make sure that the backing file data doesn't become
> > visible in the guest, but the added area is properly zeroed out.
> >=20
> > Consider the following scenario where the overlay is shorter than its
> > backing file:
> >=20
> >      base.qcow2:     AAAAAAAA
> >      overlay.qcow2:  BBBB
> >=20
> > When resizing (extending) overlay.qcow2, the new blocks should not stay
> > unallocated and make the additional As from base.qcow2 visible like
> > before this patch, but zeros should be read.
> >=20
> > A similar case happens with the various variants of a commit job when a=
n
> > intermediate file is short (- for unallocated):
> >=20
> >      base.qcow2:     A-A-AAAA
> >      mid.qcow2:      BB-B
> >      top.qcow2:      C--C--C-
> >=20
> > After commit top.qcow2 to mid.qcow2, the following happens:
> >=20
> >      mid.qcow2:      CB-C00C0 (correct result)
> >      mid.qcow2:      CB-C--C- (before this fix)
> >=20
> > Without the fix, blocks that previously read as zeros on top.qcow2
> > suddenly turn into A.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/io.c | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> >=20
>=20
> > +    if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE_OFF)=
 {
> > +        int64_t backing_len;
> > +
> > +        backing_len =3D bdrv_getlength(backing_bs(bs));
> > +        if (backing_len < 0) {
> > +            ret =3D backing_len;
> > +            goto out;
> > +        }
> > +
> > +        if (backing_len > old_size) {
> > +            ret =3D bdrv_co_do_pwrite_zeroes(
> > +                    bs, old_size, MIN(new_bytes, backing_len - old_siz=
e),
> > +                    BDRV_REQ_ZERO_WRITE | BDRV_REQ_MAY_UNMAP);
> > +            if (ret < 0) {
> > +                goto out;
> > +            }
> > +        }
> > +    }
>=20
> Note that if writing zeroes is not fast, and it turns out that we copy a =
lot
> of data rather than unallocated sections from the image being committed,
> that this can actually slow things down (doing a bulk pre-zero doubles up
> data I/O unless it is fast, which is why we added BDRV_REQ_NO_FALLBACK to
> avoid slow pre-zeroing).  However, the complication of zeroing only the
> unallocated clusters rather than a bulk pre-zeroing

I'm not sure how there could already be any allocated clusters in the
area that we just added? (Apart from preallocation, of course, which is
why this is restricted to PREALLOC_MODE_OFF.)

You're right that if this truncate was called in the context of a commit
block job rather than a resize, the zeros might be overwritten later.
I'm not sure if leaving clusters unallocated while the job is running
(and might be cancelled) is right, though. On the other hand, while the
job is running, the target image on its own is invalid anyway.

> for something that is an unlikely corner case (how often do you create
> an overlay shorter than the backing file?) is not worth the extra code
> maintenance (unlike in the 'qemu-img convert' case where it was worth
> the optimization). So I'm fine with how you fixed it here.

Also note that raw doesn't support backing files and qcow2 generally
supports zero writes. If you use an external data file and backing file
at the same time and your file system doesn't support zero writes, you
could run into the problem. Or if you use a more unusual image format
(including qcow2 v2).

So it's really two corner cases combined.

Kevin


