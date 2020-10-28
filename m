Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6A3C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521DC24721
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3RewhIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521DC24721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXkVw-0001mg-2h
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 08:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXkTx-0000ko-TH
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXkTr-0006NJ-GI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 08:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603887786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6gaHJZRy8gfqPmBN2ROSS5+K8U+avFvNOzVWmlwWJD8=;
 b=H3RewhItbVCIULeZZhbdsueTwSgbfiCoHuX/c02+Lz4ZdItY+Y3TTgh0b0Z5AGzofTLfRJ
 l0juoLbvVKFtCmUjo9T4EoWQ7QQby/hCFQVvGU3PccuWLEIar/xMUwslVHXbEeFsqHgt9o
 BPa4+bXOIXT9aQg172SibZS9JpingD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-bM4ecxw3NB26PpTkqGGL7g-1; Wed, 28 Oct 2020 08:23:03 -0400
X-MC-Unique: bM4ecxw3NB26PpTkqGGL7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DADE802B6D;
 Wed, 28 Oct 2020 12:23:02 +0000 (UTC)
Received: from localhost (ovpn-115-29.ams2.redhat.com [10.36.115.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAA226EF62;
 Wed, 28 Oct 2020 12:23:01 +0000 (UTC)
Date: Wed, 28 Oct 2020 11:59:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 7/7] block: check availablity for preadv/pwritev on mac
Message-ID: <20201028115946.GK221115@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-8-j@getutm.app>
MIME-Version: 1.0
In-Reply-To: <20201028030701.14086-8-j@getutm.app>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NhBACjNc9vV+/oop"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 08:07:01PM -0700, Joelle van Dyne wrote:
> macOS 11/iOS 14 added preadv/pwritev APIs. Due to weak linking, configure
> will succeed with CONFIG_PREADV even when targeting a lower OS version. W=
e
> therefore need to check at run time if we can actually use these APIs.
>=20
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  block/file-posix.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

What happens when preadv() is called prior to macOS 11/iOS 14?

If I understand correctly the runtime check is preferrable because
otherwise a binary compiled on recent macOS/iOS would ship with preadv()
support but fail when executed on an older macOS/iOS?

--NhBACjNc9vV+/oop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZXTIACgkQnKSrs4Gr
c8hxLwf9GYcJUXHDRWtCbwGBR1b0nE/LpEA/p8H/oPWCN7CstGtSA7TZBHZkHy9o
73PoYwEOsCt5+LlNYB34yycwfOu4/C1zU5HPSSsdhGgWeELBsZl9AxqQxHMPIFLi
cw/Z16Ux0PUpTegeHvYPaO8HJ17ViUUd7HjVcHQ4YL2KXS9Yje+xvt8rrTpWSBfI
V+/PuNVFr8fi7W94S/sZdtZ2xgxsd6KbC9F49QcaI6ukDinvqdU4EwnLRdVRXDlf
cK43LXfCtLYJL/pDpsznZoRRzQ/svBumF8daXRntH0WogtLurgq+OZLPRTwDcff3
z+Hui3kFTuvb8Nfw5zLUXYGw5tfzYg==
=EcPK
-----END PGP SIGNATURE-----

--NhBACjNc9vV+/oop--


