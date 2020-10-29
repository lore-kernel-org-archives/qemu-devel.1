Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8B3C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF50218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvoMACSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF50218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY23w-0001rW-HU
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 03:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kY22j-0001HR-9G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kY22g-00037D-8W
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603955292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1VCKO8uUi6/9BU4tzPtMzI5+tSmuZMHYT/rzY1CBZg=;
 b=GvoMACSlFtB7Fu7lW6kjdzIwxv5RjQuMaRvYmrHui18ATLoDtetU/3Iz0YnBMnSUFUA2H7
 D/f3dk3xcwF+PrxLpNff2SYj5Aepb70c6YM/3H03a445GjImCuKg836aHieAVhidz67hXT
 pSnAAxs6asNnBClwse0Hx15D3zt8DjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-Xm4nQgrsOfqEtYyePhyrFg-1; Thu, 29 Oct 2020 03:08:10 -0400
X-MC-Unique: Xm4nQgrsOfqEtYyePhyrFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 203C810866A3;
 Thu, 29 Oct 2020 07:08:09 +0000 (UTC)
Received: from localhost (ovpn-112-178.ams2.redhat.com [10.36.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8F566266E;
 Thu, 29 Oct 2020 07:08:08 +0000 (UTC)
Date: Thu, 29 Oct 2020 07:08:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 4/7] coroutine: add libucontext as external library
Message-ID: <20201029070807.GA251558@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-5-j@getutm.app>
 <20201028114759.GH221115@stefanha-x1.localdomain>
 <CA+E+eSB6jE+fbxtmtAOQYHL1ZY-FNuQGXzryoSzkeVB5woDiWQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+E+eSB6jE+fbxtmtAOQYHL1ZY-FNuQGXzryoSzkeVB5woDiWQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2020 at 05:59:37PM -0700, Joelle van Dyne wrote:
> Mirroring the repo by QEMU is fine and preferred. Not sure if anything
> is required from my end there.

I can set up the mirror when this patch series is merged.

Stefan

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+aalcACgkQnKSrs4Gr
c8h/KAgAl7kCoo62H4sajGMAL3IZMpeoxeQtJeZhnyxeRraszj9ISPueH3tkpDIk
FTGAEjkMW3u92bAx9FEAk/Njww6A5oyLwPPHS3XMmYi/5+1gkVQPjAxT4J9FScQE
IRlQ8Q9VM+NqIMZ3fjJ4E2Pboe0EKRVWo2o2YKiJ2hOiMxW2S07MeXxYGGKNVpuM
cCPVyOshMMCtyQ6unzIjKZhr6RlKIpr20ORmrW7CFAnHobZ3KF6X2q6yarKvdfvR
8hT8PeaX2skEgKGVmqqWuXPp1EW6lMYHyg+yU3kpqhw9Z68mOXPgsfSxEt8CJSWZ
bZYeCIl8kElmTCr8P9TnGlyNKzbT3A==
=Mh31
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


