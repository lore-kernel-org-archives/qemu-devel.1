Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA68C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA37220878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+TYuBOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA37220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpJq-0007t7-56
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLpIe-0006um-Ms
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLpId-0003MV-1a
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:06:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601046374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPtF+ALpjNQsPfoTQUC0BokxT26CM6uMZJSuGxmKweY=;
 b=h+TYuBOf/IoK4wo32mLKEtc0G/oSsYjKvsNYB8O/lOvzxJZCbJ+0/bah/2ex2NL6+sRYSL
 LwmN/OXQ+WBYTN5BXSSLpY/C1LFsNEKJzhwoJpUEx5hlD7AxKEG17E4771f2b7s6B3lVUt
 w2HHJAcA+Wb2R8j97f+39ZpZnbVSCPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-AP5VQ60FN_ubv-HOoXkGrQ-1; Fri, 25 Sep 2020 11:06:10 -0400
X-MC-Unique: AP5VQ60FN_ubv-HOoXkGrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9254C10BBEEF;
 Fri, 25 Sep 2020 15:06:03 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FCAF5D9DC;
 Fri, 25 Sep 2020 15:06:02 +0000 (UTC)
Date: Fri, 25 Sep 2020 16:06:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/4] block: move block exports to libblockdev
Message-ID: <20200925150602.GA343759@stefanha-x1.localdomain>
References: <20200925134229.246169-1-stefanha@redhat.com>
 <20200925134229.246169-4-stefanha@redhat.com>
 <48e58e9a-0feb-66b4-0e41-9ee01e2e272f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <48e58e9a-0feb-66b4-0e41-9ee01e2e272f@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 04:11:54PM +0200, Paolo Bonzini wrote:
> On 25/09/20 15:42, Stefan Hajnoczi wrote:
> > Block exports are used by softmmu, qemu-storage-daemon, and qemu-nbd.
> > They are not used by other programs and are not otherwise needed in
> > libblock.
> >=20
> > Undo the recent move of blockdev-nbd.c from blockdev_ss into block_ss.
> > Two stubs are required to support this:
> > 1. bdrv_close_all() (libblock) calls blk_exp_close_all() (libblockdev).
> > 2. qemu_system_killed() is called by os-posix.c (libblockdev) and not
> >    implemented in qemu-nbd.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Another possibility is to call os_setup_signal_handling in qemu-nbd.c
> where we currently set the SIGTERM handler.  The existing
> termsig_handler can be repurposed as qemu_system_killed.

That is nicer. Will fix in v2.

Stefan

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9uB1oACgkQnKSrs4Gr
c8hBvAf9HyV/GwprwtX7TvyG4v6ukELfDQUNzdglXXg9qDbf9qWZtpqSsystS6c0
e7IiwnpqVrRqahMg2sG+CyFGGk9HOdP5wljyyoVO5kXLd7samp818iDQH0ndrGCR
rpncqXfKGPTaLexpy9j2DqAZC3LkciRRXvijQGrl5sZC0ECIOl1mDKUajj7RzRAq
zUsLc7iGIP3OTaw89Glhr+nnWC9bhUL+Ns3NOgFK0l2GxnuEe6EGLSFWrxeLxIa1
1uUcv0hvtSTYrrTMuQx+CVw3nA6CAwv/7pdUNz2gi5wUs8bBPSt3tNUnI/MrExju
ACOfDv8Ouxx2HcOSVU89MU5W4aFh3g==
=9pe4
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--


