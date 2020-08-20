Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396EEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E800F2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehtzNbD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E800F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kvz-0004Kr-6Z
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8kv8-0003Jl-9T
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8kv4-000498-IA
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597931272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T1uwJzzOnIAsFTI6zbRA/qeO9n+MaW1ld34Z5OurkBk=;
 b=ehtzNbD91ztbPb9+Wrw/Hjeyk02bIcqLFPIomHq2rAXndAKcZK5SffpfCVZFV10uXop+cP
 sUe7Q6k7FhagFTLL6u8byyDjcTEQ4rO0c+OnL967jJtJfBYWl5CHikt/bpd9RzHsNA9Rje
 +d306I0ohbzmNqURG3ezQAfYlFcstjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-EhPciwhlN1eTI_xRmktfWQ-1; Thu, 20 Aug 2020 09:47:49 -0400
X-MC-Unique: EhPciwhlN1eTI_xRmktfWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22ADE1007482;
 Thu, 20 Aug 2020 13:47:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 062D07A1F4;
 Thu, 20 Aug 2020 13:47:46 +0000 (UTC)
Date: Thu, 20 Aug 2020 15:47:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 35/47] commit: Deal with filters
Message-ID: <20200820134745.GE99531@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-36-mreitz@redhat.com>
 <20200819175106.GI10272@linux.fritz.box>
 <fe136446-ac29-67de-faf4-125145970fd1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fe136446-ac29-67de-faf4-125145970fd1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:00:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.08.2020 um 13:27 hat Max Reitz geschrieben:
> On 19.08.20 19:58, Kevin Wolf wrote:
> > Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
> >> This includes some permission limiting (for example, we only need to
> >> take the RESIZE permission if the base is smaller than the top).
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/block-backend.c          |  9 +++-
> >>  block/commit.c                 | 96 +++++++++++++++++++++++++--------=
-
> >>  block/monitor/block-hmp-cmds.c |  2 +-
> >>  blockdev.c                     |  4 +-
> >>  4 files changed, 81 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/block/block-backend.c b/block/block-backend.c
> >> index 6936b25c83..7f2c7dbccc 100644
> >> --- a/block/block-backend.c
> >> +++ b/block/block-backend.c
> >> @@ -2271,8 +2271,13 @@ int blk_commit_all(void)
> >>          AioContext *aio_context =3D blk_get_aio_context(blk);
> >> =20
> >>          aio_context_acquire(aio_context);
> >> -        if (blk_is_inserted(blk) && blk->root->bs->backing) {
> >> -            int ret =3D bdrv_commit(blk->root->bs);
> >=20
> > The old code didn't try to commit nodes that don't have a backing file.
> >=20
> >> +        if (blk_is_inserted(blk)) {
> >> +            BlockDriverState *non_filter;
> >> +            int ret;
> >> +
> >> +            /* Legacy function, so skip implicit filters */
> >> +            non_filter =3D bdrv_skip_implicit_filters(blk->root->bs);
> >> +            ret =3D bdrv_commit(non_filter);
> >=20
> > The new one tries unconditionally. For nodes without a backing file,
> > bdrv_commit() will return -ENOTSUP, so the whole function fails.
>=20
> :(
>=20
> Hm.  Should I fix it by checking for
> bdrv_cow_bs(bdrv_skip_implicit_filters())?  Or bdrv_backing_chain_next()
> and change the bdrv_skip_implicit_filters() to a bdrv_skip_filters()?  I
> feel like that would make even more sense.

I agree that bdrv_skip_filters() makes more sense. If I have a qcow2
image and an explicit throttle filter on top, there is no reason to skip
this image.

bdrv_backing_chain_next() or bdrv_cow_bs() should be the same in a
boolean context, so I'd vote for bdrv_cow_bs() because it has less work
to do to get the same result.

> > (First real bug at patch 35. I almost thought I wouldn't find any!)
>=20
> :)
>=20
> >>              if (ret < 0) {
> >>                  aio_context_release(aio_context);
> >>                  return ret;
> >> diff --git a/block/commit.c b/block/commit.c
> >> index 7732d02dfe..4122b6736d 100644
> >> --- a/block/commit.c
> >> +++ b/block/commit.c
> >> @@ -37,6 +37,7 @@ typedef struct CommitBlockJob {
> >>      BlockBackend *top;
> >>      BlockBackend *base;
> >>      BlockDriverState *base_bs;
> >> +    BlockDriverState *base_overlay;
> >>      BlockdevOnError on_error;
> >>      bool base_read_only;
> >>      bool chain_frozen;
> >=20
> > Hm, again this mysterious base_overlay. I know that stream introduced i=
t
> > to avoid freezing the link to base, but commit doesn't seem to do that.
> >=20
> > Is it to avoid using the block status of filter drivers between
> > base_overlay and base?
>=20
> Yes.
>=20
> > If so, I guess that goes back to the question I
> > raised earlier in this series: What is the block status supposed to tel=
l
> > for filter nodes?
>=20
> Honestly, I would really like to get away without having to answer that
> question in this series.  Intuitively, I feel like falling through to
> the next data-bearing layer is not something most callers want.  But I=E2=
=80=99d
> rather investigate that question separately from this series (even
> though that likely means we=E2=80=99ll never do it), and just treat it as=
 it is
> in this series.

Well, I'm asking the question because not having the answer makes us
jump through hoops in this series to accomodate a behaviour it probably
shouldn't even have. (Because I agree that filters should probably keep
DATA clear, i.e. they are never the layer that defines the content.)

Additional node references (i.e. references that are not edges in the
graph) always make the design more complicated and require us to
consider more things like what happens on graph changes. So it's a
question of maintainability.

> > But anyway, in contrast to mirror, commit actually freezes the chain
> > between commit_top_bs and base, so it should be safe at least.
> >=20
> >> @@ -89,7 +90,7 @@ static void commit_abort(Job *job)
> >>       * XXX Can (or should) we somehow keep 'consistent read' blocked =
even
> >>       * after the failed/cancelled commit job is gone? If we already w=
rote
> >>       * something to base, the intermediate images aren't valid any mo=
re. */
> >> -    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
> >> +    bdrv_replace_node(s->commit_top_bs, s->commit_top_bs->backing->bs=
,
> >>                        &error_abort);
> >> =20
> >>      bdrv_unref(s->commit_top_bs);
> >> @@ -153,7 +154,7 @@ static int coroutine_fn commit_run(Job *job, Error=
 **errp)
> >>              break;
> >>          }
> >>          /* Copy if allocated above the base */
> >> -        ret =3D bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->bas=
e), false,
> >> +        ret =3D bdrv_is_allocated_above(blk_bs(s->top), s->base_overl=
ay, true,
> >>                                        offset, COMMIT_BUFFER_SIZE, &n)=
;
> >>          copy =3D (ret =3D=3D 1);
> >>          trace_commit_one_iteration(s, offset, n, ret);
> >> @@ -253,15 +254,35 @@ void commit_start(const char *job_id, BlockDrive=
rState *bs,
> >>      CommitBlockJob *s;
> >>      BlockDriverState *iter;
> >>      BlockDriverState *commit_top_bs =3D NULL;
> >> +    BlockDriverState *filtered_base;
> >>      Error *local_err =3D NULL;
> >> +    int64_t base_size, top_size;
> >> +    uint64_t perms, iter_shared_perms;
> >>      int ret;
> >> =20
> >>      assert(top !=3D bs);
> >> -    if (top =3D=3D base) {
> >> +    if (bdrv_skip_filters(top) =3D=3D bdrv_skip_filters(base)) {
> >>          error_setg(errp, "Invalid files for merge: top and base are t=
he same");
> >>          return;
> >>      }
> >> =20
> >> +    base_size =3D bdrv_getlength(base);
> >> +    if (base_size < 0) {
> >> +        error_setg_errno(errp, -base_size, "Could not inquire base im=
age size");
> >> +        return;
> >> +    }
> >> +
> >> +    top_size =3D bdrv_getlength(top);
> >> +    if (top_size < 0) {
> >> +        error_setg_errno(errp, -top_size, "Could not inquire top imag=
e size");
> >> +        return;
> >> +    }
> >> +
> >> +    perms =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
> >> +    if (base_size < top_size) {
> >> +        perms |=3D BLK_PERM_RESIZE;
> >> +    }
> >=20
> > base_perms would indicate which permissions these are (particularly
> > because it's not the next thing that requires permissions, but only use=
d
> > further down the function).
>=20
> %s/\<perms\>/base_perms/?  Sure.

Sorry, I admit this wasn't phrased very clearly. But yes, renaming the
variable this way is what I meant.

> >>      s =3D block_job_create(job_id, &commit_job_driver, NULL, bs, 0, B=
LK_PERM_ALL,
> >>                           speed, creation_flags, NULL, NULL, errp);
> >>      if (!s) {
> >> @@ -301,17 +322,43 @@ void commit_start(const char *job_id, BlockDrive=
rState *bs,
> >> =20
> >>      s->commit_top_bs =3D commit_top_bs;
> >> =20
> >> -    /* Block all nodes between top and base, because they will
> >> -     * disappear from the chain after this operation. */
> >> -    assert(bdrv_chain_contains(top, base));
> >> -    for (iter =3D top; iter !=3D base; iter =3D backing_bs(iter)) {
> >> -        /* XXX BLK_PERM_WRITE needs to be allowed so we don't block o=
urselves
> >> -         * at s->base (if writes are blocked for a node, they are als=
o blocked
> >> -         * for its backing file). The other options would be a second=
 filter
> >> -         * driver above s->base. */
> >> +    /*
> >> +     * Block all nodes between top and base, because they will
> >> +     * disappear from the chain after this operation.
> >> +     * Note that this assumes that the user is fine with removing all
> >> +     * nodes (including R/W filters) between top and base.  Assuring
> >> +     * this is the responsibility of the interface (i.e. whoever call=
s
> >> +     * commit_start()).
> >> +     */
> >> +    s->base_overlay =3D bdrv_find_overlay(top, base);
> >> +    assert(s->base_overlay);
> >> +
> >> +    /*
> >> +     * The topmost node with
> >> +     * bdrv_skip_filters(filtered_base) =3D=3D bdrv_skip_filters(base=
)
> >> +     */
> >> +    filtered_base =3D bdrv_cow_bs(s->base_overlay);
> >> +    assert(bdrv_skip_filters(filtered_base) =3D=3D bdrv_skip_filters(=
base));
> >> +
> >> +    /*
> >> +     * XXX BLK_PERM_WRITE needs to be allowed so we don't block ourse=
lves
> >> +     * at s->base (if writes are blocked for a node, they are also bl=
ocked
> >> +     * for its backing file). The other options would be a second fil=
ter
> >> +     * driver above s->base.
> >> +     */
> >> +    iter_shared_perms =3D BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
> >> +
> >> +    for (iter =3D top; iter !=3D base; iter =3D bdrv_filter_or_cow_bs=
(iter)) {
> >> +        if (iter =3D=3D filtered_base) {
> >> +            /*
> >> +             * From here on, all nodes are filters on the base.  This
> >> +             * allows us to share BLK_PERM_CONSISTENT_READ.
> >> +             */
> >> +            iter_shared_perms |=3D BLK_PERM_CONSISTENT_READ;
> >> +        }
> >> +
> >>          ret =3D block_job_add_bdrv(&s->common, "intermediate node", i=
ter, 0,
> >> -                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_=
WRITE,
> >> -                                 errp);
> >> +                                 iter_shared_perms, errp);
> >>          if (ret < 0) {
> >>              goto fail;
> >>          }
> >> @@ -328,9 +375,7 @@ void commit_start(const char *job_id, BlockDriverS=
tate *bs,
> >>      }
> >> =20
> >>      s->base =3D blk_new(s->common.job.aio_context,
> >> -                      BLK_PERM_CONSISTENT_READ
> >> -                      | BLK_PERM_WRITE
> >> -                      | BLK_PERM_RESIZE,
> >> +                      perms,
> >>                        BLK_PERM_CONSISTENT_READ
> >>                        | BLK_PERM_GRAPH_MOD
> >>                        | BLK_PERM_WRITE_UNCHANGED);
> >> @@ -398,19 +443,22 @@ int bdrv_commit(BlockDriverState *bs)
> >>      if (!drv)
> >>          return -ENOMEDIUM;
> >> =20
> >> -    if (!bs->backing) {
> >> +    backing_file_bs =3D bdrv_cow_bs(bs);
> >> +
> >> +    if (!backing_file_bs) {
> >>          return -ENOTSUP;
> >>      }
> >> =20
> >>      if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
> >> -        bdrv_op_is_blocked(bs->backing->bs, BLOCK_OP_TYPE_COMMIT_TARG=
ET, NULL)) {
> >> +        bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARG=
ET, NULL))
> >> +    {
> >>          return -EBUSY;
> >>      }
> >> =20
> >> -    ro =3D bs->backing->bs->read_only;
> >> +    ro =3D backing_file_bs->read_only;
> >> =20
> >>      if (ro) {
> >> -        if (bdrv_reopen_set_read_only(bs->backing->bs, false, NULL)) =
{
> >> +        if (bdrv_reopen_set_read_only(backing_file_bs, false, NULL)) =
{
> >>              return -EACCES;
> >>          }
> >>      }
> >> @@ -428,8 +476,6 @@ int bdrv_commit(BlockDriverState *bs)
> >>      }
> >> =20
> >>      /* Insert commit_top block node above backing, so we can write to=
 it */
> >> -    backing_file_bs =3D backing_bs(bs);
> >> -
> >>      commit_top_bs =3D bdrv_new_open_driver(&bdrv_commit_top, NULL, BD=
RV_O_RDWR,
> >>                                           &local_err);
> >>      if (commit_top_bs =3D=3D NULL) {
> >> @@ -515,15 +561,13 @@ ro_cleanup:
> >>      qemu_vfree(buf);
> >> =20
> >>      blk_unref(backing);
> >> -    if (backing_file_bs) {
> >> -        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
> >> -    }
> >> +    bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
> >=20
> > This means that bdrv_set_backing_hd() is now called to undo a change
> > that hasn't even been made yet. This fails (with &error_abort) if the
> > backing chain is frozen.
> >=20
> > On the other hand, the other bdrv_set_backing_hd() calls in the same
> > function would fail the same way.
>=20
> True. :)
>=20
> Still, maybe there=E2=80=99s an op blocker from a concurrent job, so we g=
o to
> the failure path and then we=E2=80=99d abort here.  So better to guard it=
 by
> checking whether bdrv_cow_bs(bs) !=3D backing_file_bs.

Certainly can't hurt.

Kevin

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl8+fwEACgkQfwmycsiP
L9Z8vA//RGKG2eIQRev/VMy3VX68hvAH7R4g57Re2JNK6OxM7XEbceTpohvcX+oV
dx+JkYliTe+RMEk78/vF6NwhkMzdEjvWvlfTjpCjRXRytzVKd8fAFx8HwuAd5Dc8
vthujU3Dn4Pxsbb1BEmQvsdhu9T/Pj7GGHdAOMr4W0Ltw4u23+gvobTJk5uXzeAc
7hhaCDwis/NLZpIDHMlroLch1EkG/Cv5UkMDHEcgdT39A3+Iqvq2n8M45HSHUKwL
lQXXd8llaQEXdE2v4CC/r1gcn39cD3smsKZ7s85pg9mZPhMmQbic0Bfxf4t4ukDV
rnfZ6I8sY89l4yg1ilW8BelhLQcNMLuzXa+5kW9v/2LIAsA7VDNMnq9YjKfihngj
ce6a562dBZwLe1+ga4D1+gUsaTu6lH9+jL7DdGEqU9sH6Lns256BNQRcMbOvrG+c
F3FDq7GH3fqlBlffF0UUbxqWe0r0l4Bb7j78DDqXHYxsFLPabFxEw4nRWs/Zx3Xi
tu7u4cbPSQALc0umet7CzqmMW3HrMmcpbmeJm2sMmJmuz52bevA5M3tvxiqMOrXF
yxJfMz582jGmBmOJkgHF3It9bJZ/qx77aUFUx8DFSoTsXr7jqPfcjB5TSnTmsKkf
4yEZujNqxXDaY9prGo20rNOb3BiEvGtgsVvXcJEznt/BQeROdKY=
=qVRA
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


