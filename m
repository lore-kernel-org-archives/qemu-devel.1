Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BFDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3FB206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO3JpU6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3FB206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEFH-00059z-DF
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jiEEa-0004gJ-Jb
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:38:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56801
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jiEEY-0001nD-Ei
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591609101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsmcJvbyOJF4ssgvXUBLlquvPMkIdrzailSSLFQszLU=;
 b=MO3JpU6gn4CibyFAgW5E9et25zCizEsV7pvBH3n32iYcYwgGkwj/KqLLr41Lfxxe3aQK7R
 10i2ZboknOpoLnEcb6jr4xnExAbPtX7V37jGKNtBHVyxtY4Q+jPU+H5mtRFgblz8i514Sm
 QauavqCP++SJGikJkSDIFM29fulmokA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-SpPQOr0BOHG5CD8o-NY_bQ-1; Mon, 08 Jun 2020 05:38:19 -0400
X-MC-Unique: SpPQOr0BOHG5CD8o-NY_bQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D97B8018AC;
 Mon,  8 Jun 2020 09:38:18 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97D0B648DB;
 Mon,  8 Jun 2020 09:38:15 +0000 (UTC)
Date: Mon, 8 Jun 2020 11:38:12 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200608093812.GA400568@angien.pipo.sk>
References: <20200604091651.GF2995787@angien.pipo.sk>
 <20200604113145.GE4512@linux.fritz.box>
 <20200604162237.GA22354@angien.pipo.sk>
 <20200605090123.GD5869@linux.fritz.box>
 <20200605092403.GB22354@angien.pipo.sk>
 <20200605094407.GG5869@linux.fritz.box>
 <20200605095810.GC22354@angien.pipo.sk>
 <20200605100747.GH5869@linux.fritz.box>
 <20200605105902.GD22354@angien.pipo.sk>
 <e0d889a2-2a52-1c3f-89fb-55a41dc6d226@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <e0d889a2-2a52-1c3f-89fb-55a41dc6d226@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 06, 2020 at 09:55:13 +0300, Vladimir Sementsov-Ogievskiy wrote:
> 05.06.2020 13:59, Peter Krempa wrote:
> > On Fri, Jun 05, 2020 at 12:07:47 +0200, Kevin Wolf wrote:
> > > Am 05.06.2020 um 11:58 hat Peter Krempa geschrieben:
> > > > On Fri, Jun 05, 2020 at 11:44:07 +0200, Kevin Wolf wrote:
> >=20
> > [...]
> >=20
> > > > The above was actually inspired by a very recent problem I have in =
my
> > > > attempt to use the dirty bitmap populate job to refactor how libvir=
t
> > > > handles bitmaps. I've just figured out that I need to shuffle aroun=
d
> > > > some stuff as I can't run the dirty-bitmap-populate job while an ac=
tive
> > > > layer commit is in synchronised phase and I wanted to do the mergin=
g at
> > > > that point. That reminded me of a possible gotcha in having to sequ=
ence
> > > > the blockjobs which certainly would be more painful.
> > >=20
> > > It would probably be good to have not only an iotests case that tests
> > > the low-level functionality of the block job, but also one that
> > > resembles the way libvirt would actually use it in combination with
> > > other jobs.
> >=20
>=20
> Hi! Sorry me missing the discussion for a long time.
>=20
> About new job semantics: if you create temporary bitmaps anyway, I do thi=
nk that we should allow to populate into target bitmap directly, without cr=
eating any internal temporary bitmaps. I suggested it when reviewing v1, Jo=
hn argued for more transaction-like semantics to look like other jobs. Stil=
l, we can support both modes if we want.
>=20
> Allowing to use one target for several populating job is an interesting i=
dea. Current series does "bdrv_dirty_bitmap_set_busy(target_bitmap, true);"=
, which forbids it.. Hmm. If we just drop it, nothing prevents user just re=
move target bitmap during the job. So, we'll need something like collective=
-busy bitmap..
>=20
> > I certainly can document the way we'll use it but that in turn depends
> > on how the job behaves.
> >=20
> > With the current state of the job I plan to use it in two scenarios:
> >=20
> > Preface: I'm currently changing libvirt to use one active bitmap per
> > checkpoint (checkpoint is name for the point in time we want to take
> > backup from). This means that a layer of the backing chain can have
> > multiple active bitmaps depending on how many checkpoints were created
> > in the current top layer. (previously we've tried to optimize things by
> > having just one bitmap active, but the semantics were getting too crazy
> > to be maintainable long-term)
>=20
> Hmm. I had a plan of creating "lazy" disabled bitmaps, to optimize scenar=
io with one active bitmap, so that disabled bitmaps are not loaded into RAM=
 on start, but only on demand. But how to do it with "many active bitmaps" =
scenario? I don't think that's a good idea.. Possibly, we can implement laz=
iness by internally make only one active bitmap and merge it here and there=
 when you request some active bitmap which we actually didn't load yet..
>=20
> Could you describe, what is the exact problem with "several disabled - on=
e active" scheme, and how is it solved by "several active"?

The 'several disabled one active' semantics _heavily_ depend on metadata
which must be tracked outside of qemu and is more prone to break. If any
of the intermediate bitmaps is broken or missing everything breaks.

Then there's the complexity of the code which handles merging of the
bitmaps during block jobs. Jobs such as blockdev-mirror in full mode and
block-commit squash together the data and we need to do something about
the bitmaps for the backups to work properly afterwards.

Without considering overlays which were created without propagating
bitmaps, the code was already getting hairy especially in the case of
backups where we needed to stitch together bitmaps for all the bitmaps
corresponding to the given point in time where the backup is taken from.

When we add overlays without any bitmaps into the mix the code for
resolving which bitmaps to merge the code is becoming very unpleasant,
hard to understand and maintain and that is the main point for the
switch.

I don't want to add unnecessary complexity to the libvirt code which
will make it more fragile or hard to understand and fix in the future.

Both points which I heard for now (performance, and backup granularity
in case of non-default qcow2 block size) don't seem compelling enough to
me to make my life of implementing the feature in libvirt so much
harder.

Also users really can just remove the point in time they wish to backup
from after a successful backup which will also remove the corresponding
active bitmap.

> > Bitmaps are no longer propagated over to upper layers when creating
> > snapshots as we can use block-dirty-bitmap-populate instead.
>=20
> Unexpected turn. When all this topic only started, it was reasoned more l=
ike "if user forget to create bitmap at start, let's help him".. But now it=
 becomes the common scenario. Hmm.

It's not only a "user forgot" thing, but more that a systemic change
would be required.

Additionally until _very_ recently it wasn't possible to create bitmaps
using qemu-img, which made it impossible to create overlays for inactive
VMs. Arguably this has changed so we could require it. It still adds a
moving part which can break if the user doesn't add the bitmap or
requires yet another special case handling if we want to compensate for
that.

As of such, in libvirt's tech-preview implementation that is present
currently upstream, if you create a qcow2 overlay without adding the
appropriate bitmaps, the backups simply won't work.

> What do you think of granularity? We in Virtuozzo use 1M cluster as a def=
ault for qcow2 images. But we use 64k granularity (default) for bitmaps, to=
 have smaller incremental backups. So, this is advantage of creating bitmap=
 over relaying on block-status capturing by block-dirty-bitmap-populate: yo=
u don't control dirtiness granularity. So, I think that bitmap propagation,=
 or just creating new dirty bitmap to track dirtiness from start of new sna=
pshot is better.

This is a valid argument. Backups in this scenario will be bigger. I
still don't feel like the code needs to be made much more complex
because of it though.

> > 1) backup
> >=20
> > Prior to doing the backup I'm figuring out the final backup bitmap, thi=
s
> > involves creating a temporary bitmap populated by the job for every
> > layer of the backing chain above of the one which contains the bitmap w=
e
> > want to take a backup from and then merge all of them together as a bas=
e
> > for the backup.
>=20
> (just thinking out loud)
>=20
> So, assume the sequence top -> middle -> base
>=20
> If we have a backup, which was done when we were in base, than bitmap is =
stored in base. And  is loaded, and is active, but don't changes really, as=
 base is opened read-only.]
> We merge block-status information of top and middle together with this bi=
tmap, and aggregate difference between last backup and current state.
>=20
> >=20
> > 2) blockjobs
> >=20
> > Note: This is currently an outline how the things should be as I've hit
> > the snag with attempting to run the population jobs during 'ready' stat=
e
> > of a active-layer block-commit/blockdev-mirror job only an hour ago and
> > I need to change a few things.
> >=20
> > 2.1) active layer block-commit/blockdev-mirror
> >=20
> > When the job reaches 'ready' state I'll create bitmaps in the
> > destination/base image of the job for every bitmap in the images
> > dropped/merged (we use blockdev-mirror in full-sync mode) by the
> > blockjob. This will capture the writes that happen after 'job-complete'=
.
> >=20
> > The job will then be completed and the 2.2. will be executed as well.
>=20
> So, the aim is not to miss any new writes after switching to new bs, but =
do not capture into bitmaps writes which are copying the whole disk during =
mirror.
>=20
> >=20
> > 2.2) non-active commit and also continuation of active layer block-comm=
it/blockdev-mirror
> >=20
> > After the job is completed succesfully I'll create temporary
> > non-persistent bitmaps for/in the images removed by the blockjob and
> > merge them into the destination image's bitmaps depending on their
> > original location in the backing chain so that the bitmap state still
> > properly describes which blocks have changed.
>=20
> I don't follow. How do you populate these new temporary bitmaps? They are=
 empty after creation..

With the 'block-dirty-bitmap-populate' block job.

> > After that the original images willbe blockdev-del-eted. The above is
> > partialy in use today and since the job is already completed also
> > requires blockdev-reopen to successfuly write to the bitmaps.
> >=20
> > ----
> >=20
> > While writing the above down I've actually realized that controling the
> > destination of the bitmap might not be as useful as I've thought
> > originally as in 2.2. step I might need the allocation bitmap merged
> > into multiple bitmaps, so I'd either need a temporary bitmap anyways or
> > would have to re-run the job multiple times which seems wasteful. I'm n=
o
> > longer fully persuaded that adding the 'merge' step to the dirty
> > populate blockjob will be the best thing since sliced bread.
> >=20
>=20
> What is 'merge' step?

In some previous replies to Kevin, we discussed that it might be worth
optimizing 'block-dirty-bitmap-populate' to directly populate the bits
in the target bitmap rather than after the job is complete, so
efectively directly mering it. I probably described it wrong here.

>Do you mean that populating directly into target bitmap is not really need=
ed?

I need the bitmap populated by 'block-dirty-bitmap-populate' to be
merged into multiple bitmaps in the new semantics. If the job itself
doesn't support that sematics, changing it to just to directly populate
one bitmap doesn't seem to be worth it since I'll be using intermediate
bitmaps anyways.


