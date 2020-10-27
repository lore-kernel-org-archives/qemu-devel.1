Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B1C83869
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC1D2242B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRkD4rFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC1D2242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXR9b-0002R0-5D
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXR6n-0000d5-AZ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXR6l-0003YT-N1
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603813318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=31VUs3Chj7qnSQ1dV6+Ed4cwLyBd3ll3qFOGGKa4EdA=;
 b=IRkD4rFA20/jd3G85T59o3qkxSu2CDWYxHPFTwWZyxjsGCqVj/PVBdgDKWdBUgrpSBRWLf
 Ko3X/q+XCCU0r8DMgJe6Bu1oClqqkmmYPEzRiCu/HWhMOTTaoOroKUQXDreiK552OQ1vCh
 wmwcowtaWK6LF+upPtQRsKYwHGugS4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-FvU9C3PnOlCl1bBOGlqamQ-1; Tue, 27 Oct 2020 11:41:56 -0400
X-MC-Unique: FvU9C3PnOlCl1bBOGlqamQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4019D186DD4A;
 Tue, 27 Oct 2020 15:41:55 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20F245B4A4;
 Tue, 27 Oct 2020 15:41:50 +0000 (UTC)
Date: Tue, 27 Oct 2020 16:41:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2] block: End quiescent sections when a BDS is deleted
Message-ID: <20201027154149.GE4628@merkur.fritz.box>
References: <160346526998.272601.9045392804399803158.stgit@bahia.lan>
 <20201027135404.GB102411@stefanha-x1.localdomain>
 <20201027162441.787da040@bahia>
MIME-Version: 1.0
In-Reply-To: <20201027162441.787da040@bahia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 27.10.2020 um 16:24 hat Greg Kurz geschrieben:
> On Tue, 27 Oct 2020 13:54:04 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > On Fri, Oct 23, 2020 at 05:01:10PM +0200, Greg Kurz wrote:
> > > +/**
> > > + * End all quiescent sections started by bdrv_drain_all_begin(). Thi=
s is
> > > + * only needed when deleting a BDS before bdrv_drain_all_end() is ca=
lled.
> > > + */
> > > +void bdrv_drain_all_end_quiesce(BlockDriverState *bs);
> >=20
> > This function is only called from block.c. Can it be moved to the
> > private block_int.h header?
> >=20
>=20
> Ha, I wasn't aware of block_int.h... It seems to be a very good idea.
>=20
> > The code is not clear on whether bdrv_drain_all_end_quiesce() is an API
> > that others can use or an internal helper function that must only be
> > called by bdrv_close(). I came to the conclusion that the latter is tru=
e
> > after reviewing the patch.
> >=20
>=20
> Yes it is.
>=20
> > Please update the bdrv_drain_all_end_quiesce() doc comment to clarify
> > that this function is an internal helper for bdrv_close() - no one else
> > needs to worry about it.
>=20
> I'll do that.
>=20
> Thanks for the suggestions Stefan.

I already sent a pull request, so if you're going to change something,
please make it a follow-up patch rather than a new patch version.

Kevin

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl+YP70ACgkQfwmycsiP
L9aSFA//ZOmoe8g3t4cTYaGGwdkoYV/MjX96vJJayM/79H9XYVqP1mhso4Vxk9kB
fciWpnSi02Ou1GeSj1IUG9Us0MxNXrKCQl0zbxcstCAHMOv9DU9XLfI3K5+D3L4T
IH3aFFn2DE1KIpFaRagUGJ68yIuHnzUnFk6CMsFZlA9HyFvLOBLBgbGTeBwpggc5
kZ32+Bpo73L5vx5BGc0kbYVAv89GXaaELLLR10TBwoOuvffuGrbqPrKuUOXhm2VI
UpYcH52Jj73ejRoqQPKwYHshF1gYHno119PzxuuHKj44zNIgmSmVW8I49HEI7JgQ
/MZvhEoLDV7bbQFpuW18cMlvPBvB2WesjJ+Lwn/p8mNHZlxyzmp+EFjgn0baVn36
I3jzkJYuxU5lVu3EruOkM11iou+4+POxbp55VFFrqSq1Pc89TafUtUI9GflO5Gyy
EC4PZTHBQpCj4Gr0jFF2tDcBuylmO5VSdkZgeDEKVPjNhenG2q/CA8Dqqm3z7Ht1
FOSNtc/3Cq5dfE3iYOJ7BoWZs9m/eH9C+cmPIpnX6NqYOEMkS81XasddGJC/1RNi
+0ppMPCYeC9Eqa0oF+SCAjQ4ivSJ3SanRpVHFUvoEACH5hBxQITEzlTuTyB96cRC
UGIWjUX079vUEg14UUNDZsE+dUmWA1FUsEZZ6oY+z+JeAGtzThk=
=k+Yu
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--


