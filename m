Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABBCC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867AF22474
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsVn89BU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867AF22474
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOmg-0005hQ-LA
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXOPG-0003iO-GS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXOPD-0003yK-Uf
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXOPD-0003wS-Qf
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574250259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SKmIu6xhnGRasg21dUm80DoX/OMdwS345NZAMpx8R34=;
 b=BsVn89BUVcxjzY98Cj/wpEexfTwdduP/2oRhfOAEnQMngAZID38W3gGZuEpF9BqjC+qBt0
 MtQhN1TFh6dhk4IpoM4WnfL87ha/i6IclMv3NFLmcNQa+SeUn0BrVybPm/FyZxV8SspX1k
 +rTph2euLItK0jY6mVzZjdDNQ76p02c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-Vtc-xzikPyKnNjF9pi7MZA-1; Wed, 20 Nov 2019 06:44:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A811E801FCF;
 Wed, 20 Nov 2019 11:44:14 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71DC91036C84;
 Wed, 20 Nov 2019 11:44:10 +0000 (UTC)
Date: Wed, 20 Nov 2019 12:44:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Message-ID: <20191120114408.GA5779@linux.fritz.box>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <7f8574a2-8fd2-9724-a197-d67d3c69d538@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <7f8574a2-8fd2-9724-a197-d67d3c69d538@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Vtc-xzikPyKnNjF9pi7MZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.11.2019 um 11:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 16.11.2019 19:34, Vladimir Sementsov-Ogievskiy wrote:
> > Hi all!
> >=20
> > I wanted to understand, what is the real difference between bdrv_block_=
status_above
> > and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work t=
hrough
> > bdrv_block_status_above..
> >=20
> > And I found the problem: bdrv_is_allocated_above considers space after =
EOF as
> > UNALLOCATED for intermediate nodes..
> >=20
> > UNALLOCATED is not about allocation at fs level, but about should we go=
 to backing or
> > not.. And it seems incorrect for me, as in case of short backing file, =
we'll read
> > zeroes after EOF, instead of going further by backing chain.
> >=20
> > This leads to the following effect:
> >=20
> > ./qemu-img create -f qcow2 base.qcow2 2M
> > ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
> >=20
> > ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
> > ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
> >=20
> > Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
> > ./qemu-io -c "read -P 0 1M 1M" top.qcow2
> > read 1048576/1048576 bytes at offset 1048576
> > 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
> >=20
> > But after commit guest visible state is changed, which seems wrong for =
me:
> > ./qemu-img commit top.qcow2 -b mid.qcow2
> >=20
> > ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
> > Pattern verification failed at offset 1048576, 1048576 bytes
> > read 1048576/1048576 bytes at offset 1048576
> > 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
> >=20
> > ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
> > read 1048576/1048576 bytes at offset 1048576
> > 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
> >=20
> >=20
> > I don't know, is it a real bug, as I don't know, do we support backing =
file larger than
> > its parent. Still, I'm not sure that this behavior of bdrv_is_allocated=
_above don't lead
> > to other problems.
> >=20
> > =3D=3D=3D=3D=3D
> >=20
> > Hmm, bdrv_block_allocated_above behaves strange too:
> >=20
> > with want_zero=3Dtrue, it may report unallocated zeroes because of shor=
t backing files, which
> > are actually "allocated" in POV of backing chains. But I see this may i=
nfluence only
> > qemu-img compare, and I don't see can it trigger some bug..
> >=20
> > with want_zero=3Dfalse, it may do no progress because of short backing =
file. Moreover it may
> > report EOF in the middle!! But want_zero=3Dfalse used only in bdrv_is_a=
llocated, which considers
> > onlyt top layer, so it seems OK.
> >=20
> > =3D=3D=3D=3D=3D
> >=20
> > So, I propose these series, still I'm not sure is there a real bug.
> >=20
> > Vladimir Sementsov-Ogievskiy (4):
> >    block/io: fix bdrv_co_block_status_above
> >    block/io: bdrv_common_block_status_above: support include_base
> >    block/io: bdrv_common_block_status_above: support bs =3D=3D base
> >    block/io: fix bdrv_is_allocated_above
> >=20
> >   block/io.c                 | 104 ++++++++++++++++++------------------=
-
> >   tests/qemu-iotests/154.out |   4 +-
> >   2 files changed, 53 insertions(+), 55 deletions(-)
> >=20
>=20
>=20
> Interesting that the problem illustrated here is not fixed by the series,=
 it's actually
> relates to the fact that mirror does truncation with PREALLOC_MODE_OFF, w=
hich leads
> to unallocated qcow2 clusters, which I think should be fixed too.

Yes, this is what I posted yesterday. (With a suggested quick fix, but
it turns out it was not quite correct, see below.)

> To illustrate the problem fixed by the series, we should commit to base:
>=20
> # ./qemu-img commit top.qcow2 -b base.qcow2
> Image committed.
> # ./qemu-io -c "read -P 0 1M 1M" base.qcow2
> Pattern verification failed at offset 1048576, 1048576 bytes
> read 1048576/1048576 bytes at offset 1048576
> 1 MiB, 1 ops; 00.00 sec (5.366 GiB/sec and 5494.4149 ops/sec)

Ok, I'll try that later.

> Hmm, but how to fix the problem about truncate? I think truncate must
> not make underlying backing available for read.. Discard operation
> doesn't do it.
>=20
> So, actually on PREALLOC_MODE_OFF we must allocated L2 tables and mark
> new clusters as ZERO?

Yes, we need to write zeroes to the new area if the backing file covers
it. We need to do this not only in mirror/commit/bdrv_commit(), but in
fact for all truncate operations: Berto mentioned on IRC yesterday that
you can get into the same situation with 'block_resize' monitor
commands.

So I tried to fix this yesterday, and I thought that I had a fix, when I
noticed that bdrv_co_do_zero_pwritev() takes a 32 bit bytes parameter.
So I'll still need to fix this. Other than that, I suppose the following
fix should work (but is probably a bit too invasive for -rc3).

Kevin

diff --git a/block/io.c b/block/io.c
index f75777f5ea..4118bf0118 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3382,6 +3382,32 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, =
int64_t offset, bool exact,
         goto out;
     }

+    /*
+     * If the image has a backing file that is large enough that it would
+     * provide data for the new area, we cannot leave it unallocated becau=
se
+     * then the backing file content would become visible. Instead, zero-f=
ill
+     * the area where backing file and new area overlap.
+     */
+    if (new_bytes && bs->backing && prealloc =3D=3D PREALLOC_MODE_OFF) {
+        int64_t backing_len;
+
+        backing_len =3D bdrv_getlength(backing_bs(bs));
+        if (backing_len < 0) {
+            ret =3D backing_len;
+            goto out;
+        }
+
+        if (backing_len > old_size) {
+            /* FIXME bytes parameter is 32 bits */
+            ret =3D bdrv_co_do_zero_pwritev(child, old_size,
+                                          MIN(new_bytes, backing_len - old=
_size),
+                                          BDRV_REQ_ZERO_WRITE | BDRV_REQ_M=
AY_UNMAP, &req);
+            if (ret < 0) {
+                goto out;
+            }
+        }
+    }
+
     ret =3D refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not refresh total sector count=
");


