Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529ADC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B0123718
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGnMW+/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B0123718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqIz-0000CU-0s
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLq9n-0005e9-Ew
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLq9d-0002of-O1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:01:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601049660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7dYlZ8amXPbroQ/pSrgeoV+H0FiTUvNCqjpjtR9w+0E=;
 b=SGnMW+/SNMyh2mSPcPOvjQjK4mNMRLZbtNMM5rTNaxSTpDGI/Ixr8oLCKu3qzkY/SR/DmJ
 QR+EIn8vOb8fTUja5ppFDN1yBraOpRQN2YMjZS+NOOKr5ZOyWzSZWDD2+hAl/821dxI21+
 QoTY59bag+KGvZV+n2ajuB4bq465qI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-18FqvLVUMXizpo9A2UWRew-1; Fri, 25 Sep 2020 12:00:58 -0400
X-MC-Unique: 18FqvLVUMXizpo9A2UWRew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE22085EE95;
 Fri, 25 Sep 2020 16:00:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-83.ams2.redhat.com [10.36.114.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C2A219C66;
 Fri, 25 Sep 2020 16:00:52 +0000 (UTC)
Date: Fri, 25 Sep 2020 18:00:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v7 12/13] block: Add bdrv_co_move_to_aio_context()
Message-ID: <20200925160051.GI5731@linux.fritz.box>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-13-kwolf@redhat.com>
 <20200915143142.GE629589@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200915143142.GE629589@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.09.2020 um 16:31 hat Stefan Hajnoczi geschrieben:
> On Wed, Sep 09, 2020 at 05:11:48PM +0200, Kevin Wolf wrote:
> > Add a function to move the current coroutine to the AioContext of a
> > given BlockDriverState.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/block.h |  6 ++++++
> >  block.c               | 10 ++++++++++
> >  2 files changed, 16 insertions(+)
> >=20
> > diff --git a/include/block/block.h b/include/block/block.h
> > index 981ab5b314..80ab322f11 100644
> > --- a/include/block/block.h
> > +++ b/include/block/block.h
> > @@ -626,6 +626,12 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs,=
 const char *tag);
> >   */
> >  AioContext *bdrv_get_aio_context(BlockDriverState *bs);
> > =20
> > +/**
> > + * Move the current coroutine to the AioContext of @bs and return the =
old
> > + * AioContext of the coroutine.
> > + */
> > +AioContext *coroutine_fn bdrv_co_move_to_aio_context(BlockDriverState =
*bs);
>=20
> I'm not sure this function handles all cases:
> 1. Being called without the BQL (i.e. from an IOThread).
> 2. Being called while a device stops using its IOThread.
>=20
> The races that come to mind are fetching the AioContext for bs and then
> scheduling a BH. The BH is executed later on by the event loop. There
> might be cases where the AioContext for bs is updated before the BH
> runs.

Updating the AioContext of a node drains the BDS first, so it would
execute any BHs still pending in the old AioContext. So this part looks
safe to me.

I'm not sure what you mean with the BQL part. I don't think I'm
accessing anything protected by the BQL?

> I didn't investigate these cases but wanted to mention them in case you
> want to add doc comments about when this function can be used or if
> you'd like to verify them yourself.

One thing that I'm not completely sure about (but that isn't really
related to this specific patch) is AioContext changes later in the
process when the actual command handler has yielded. We may have to be
careful to prevent those for coroutine based QMP commands in the block
layer.

By sheer luck, qmp_block_resize() creates a new BlockBackend that has
blk->allow_aio_context_change =3D false. So we're actually good in the
only command I'm converting. Phew.

Kevin

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9uFDMACgkQfwmycsiP
L9bDYg/+LHS24aJqjlGVbzMdyc/QTpDPNP8yaJPsMZhaEsoqeCea4BxCSWr6dEkK
Op4ORKnh99UHj6Rz7grXFvrfeAYPULruRvemFLs5R7yw1tS/DloBsxNzp/xLV/kN
jBQkH3vxpBYfpjazlYQP2KlN6U8Gf6rnTFUtXSFJwNm9bTJ3/8nzJq/ulPCFu8DN
i89LJOPG9SrMCOgrbEOSPQjH/7WZSGqZRrEwx+gtLlAjRnBr9YHqocTsbLdAlBJK
WVE7LYedGYOMA+Wrckeum0xuN1MPNvuVkL3ggss+aR6pKt7ldp5MyRtFiKrbp9xE
k/M3ha8QJuLcmOa0/J5ZxRDJxpHQ6g0d1NBMmMrHn/3V6Y3VYNgyseSa5WpRrgTj
25NorMAcb+un2N49Ub5h8xeEbYBKTJnLCs3MwexfUl//sRB7/zXw2hTnPnl6v4Rp
RD7Wcc2i2Zh/fkrabN/D5M30RZDv82b8d1SJyXWbdG3kSV/qfMOtlJsT6IzPvmFW
N26jZXMluTk40sQTQRhX+GrMB5ViaFoJ+K11dQ5f9sDEjomUF9yE7XbXDrGhtAaq
YT0hs+J5SQ/os+19TCZMCuCV2Ou9AwQd4RTuDHsknICY1ac9oBLlLFicHXCDsmeC
/y5TFqYs6VY0W/f7GvcmV+nuddsejemIYBw1ICMkKon/y/qaTx8=
=fMAZ
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--


