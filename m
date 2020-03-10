Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D52FC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC20520873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRS8eFjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC20520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBekp-0004SU-0G
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1jBejm-0003NR-VS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1jBejk-0005NT-MR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:15:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52108
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1jBejd-0005J7-LL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583846148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGhwnl51X7799IZwV6bIRQ/LQ7I4Jk5W7B3puWiBYjA=;
 b=NRS8eFjCAZjFBRvlrUqp9Sx2C3W6r0NqmNUnSf7LTnR31aa2C48FzxshejV0G3IaJlXkH/
 jojCHmCMZVF5gILdqVpC75fT8TCbPkrRXlkpbJEXA5v1kB7dT1JGaFvii4csL4Yc8vGtWi
 2ntR/j+t+NCyZoq9h0/UmYpzFJfflt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-yueH-nM1Peue-dZ6G1Z6-A-1; Tue, 10 Mar 2020 09:15:46 -0400
X-MC-Unique: yueH-nM1Peue-dZ6G1Z6-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 082858017DF;
 Tue, 10 Mar 2020 13:15:45 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E49D60BF3;
 Tue, 10 Mar 2020 13:15:41 +0000 (UTC)
Date: Tue, 10 Mar 2020 14:15:38 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 2/7] block: Relax restrictions for blockdev-snapshot
Message-ID: <20200310131538.GZ1320660@angien.pipo.sk>
References: <20200310113831.27293-1-kwolf@redhat.com>
 <20200310113831.27293-3-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200310113831.27293-3-kwolf@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 12:38:26 +0100, Kevin Wolf wrote:
> blockdev-snapshot returned an error if the overlay was already in use,
> which it defined as having any BlockBackend parent. This is in fact both
> too strict (some parents can tolerate the change of visible data caused
> by attaching a backing file) and too loose (some non-BlockBackend
> parents may not be happy with it).
>=20
> One important use case that is prevented by the too strict check is live
> storage migration with blockdev-mirror. Here, the target node is
> usually opened without a backing file so that the active layer is
> mirrored while its backing chain can be copied in the background.
>=20
> The backing chain should be attached to the mirror target node when
> finalising the job, just before switching the users of the source node
> to the new copy (at which point the mirror job still has a reference to
> the node). drive-mirror did this automatically, but with blockdev-mirror
> this is the job of the QMP client, so it needs a way to do this.
>=20
> blockdev-snapshot is the obvious way, so this patch makes it work in
> this scenario. The new condition is that no parent uses CONSISTENT_READ
> permissions. This will ensure that the operation will still be blocked
> when the node is attached to the guest device, so blockdev-snapshot
> remains safe.
>=20
> (For the sake of completeness, x-blockdev-reopen can be used to achieve
> the same, however it is a big hammer, performs the graph change
> completely unchecked and is still experimental. So even with the option
> of using x-blockdev-reopen, there are reasons why blockdev-snapshot
> should be able to perform this operation.)
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockdev.c                 | 14 ++++++++------
>  tests/qemu-iotests/085.out |  4 ++--
>  2 files changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 3e44fa766b..bba0e9775b 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1501,6 +1501,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
>      TransactionAction *action =3D common->action;
>      AioContext *aio_context;
>      AioContext *old_context;
> +    uint64_t perm, shared;
>      int ret;
> =20
>      /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
> @@ -1616,16 +1617,17 @@ static void external_snapshot_prepare(BlkActionSt=
ate *common,
>          goto out;
>      }
> =20
> -    if (bdrv_has_blk(state->new_bs)) {
> +    /*
> +     * Allow attaching a backing file to an overlay that's already in us=
e only
> +     * if the parents don't assume that they are already seeing a valid =
image.
> +     * (Specifically, allow it as a mirror target, which is write-only a=
ccess.)
> +     */
> +    bdrv_get_cumulative_perm(state->new_bs, &perm, &shared);
> +    if (perm & BLK_PERM_CONSISTENT_READ) {
>          error_setg(errp, "The overlay is already in use");
>          goto out;
>      }

Moving this code a bit further down ...

> =20
> -    if (bdrv_op_is_blocked(state->new_bs, BLOCK_OP_TYPE_EXTERNAL_SNAPSHO=
T,
> -                           errp)) {
> -        goto out;
> -    }
> -
>      if (state->new_bs->backing !=3D NULL) {
>          error_setg(errp, "The overlay already has a backing image");
>          goto out;
> diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
> index d94ad22f70..fd11aae678 100644
> --- a/tests/qemu-iotests/085.out
> +++ b/tests/qemu-iotests/085.out
> @@ -82,7 +82,7 @@ Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=3DIMGF=
MT size=3D134217728 backing_f
>  =3D=3D=3D Invalid command - cannot create a snapshot using a file BDS =
=3D=3D=3D
> =20
>  { 'execute': 'blockdev-snapshot', 'arguments': { 'node':'virtio0', 'over=
lay':'file_12' } }
> -{"error": {"class": "GenericError", "desc": "The overlay does not suppor=
t backing images"}}
> +{"error": {"class": "GenericError", "desc": "The overlay is already in u=
se"}}
> =20
>  =3D=3D=3D Invalid command - snapshot node used as active layer =3D=3D=3D
> =20
> @@ -96,7 +96,7 @@ Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=3DIMGF=
MT size=3D134217728 backing_f
>  =3D=3D=3D Invalid command - snapshot node used as backing hd =3D=3D=3D
> =20
>  { 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'ove=
rlay':'snap_11' } }
> -{"error": {"class": "GenericError", "desc": "Node 'snap_11' is busy: nod=
e is used as backing hd of 'snap_12'"}}
> +{"error": {"class": "GenericError", "desc": "The overlay is already in u=
se"}}

Would probably prevent these test changes.

Reviewed-by: Peter Krempa <pkrempa@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>


