Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F751C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB29420768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bX2F7Swp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB29420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZw0-0004Ri-5D
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyZux-0003L9-Qn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:01:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jyZum-0006YY-Nj
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595505691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4vB/w7DvmHDlxrw5lQsmYSywCIP6gpUztnYMHOKuOzI=;
 b=bX2F7Swpne8lFnR2Rerh3sR273oEvCr/l5df/UhLGNnOlbNap9Ml/E3w2QK8hNd7/qage4
 9XbO5wtnKGQ1nhmm8mm2Gmjx/Bob26KX45mC2EWr6RZqbcmN69Tv1IW3DUdLXiuoC1n6/Y
 7WcOrA4JqdpG0atLtkzORdaw55B4Pjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-HlUOsiZENm2rdNxfxXXYrg-1; Thu, 23 Jul 2020 08:01:27 -0400
X-MC-Unique: HlUOsiZENm2rdNxfxXXYrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4195B800685;
 Thu, 23 Jul 2020 12:01:26 +0000 (UTC)
Received: from localhost (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA71870106;
 Thu, 23 Jul 2020 12:01:22 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:01:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] e1000e: make TX reentrant
Message-ID: <20200723120121.GF186372@stefanha-x1.localdomain>
References: <20200722085747.6514-1-jasowang@redhat.com>
 <20200722085747.6514-2-jasowang@redhat.com>
 <4022bb82-9c7a-cf74-8caf-03ef0989f5f8@msgid.tls.msk.ru>
 <7dc09488-c73c-c016-735e-8316273c3322@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7dc09488-c73c-c016-735e-8316273c3322@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: dmitry.fleytman@gmail.com, mst@redhat.com, liq3ea@gmail.com, liq3ea@163.com,
 qemu-devel@nongnu.org, alxndr@bu.edu, Michael Tokarev <mjt@tls.msk.ru>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 10:25:35AM +0800, Jason Wang wrote:
>=20
> On 2020/7/22 =E4=B8=8B=E5=8D=888:53, Michael Tokarev wrote:
> > FWIW, this is not "making TX reentrant", it is about forbidding
> > reentrancy instead :)
> >=20
> > /mjt
>=20
>=20
> Indeed, I will rename the title.

Please also include a comment explaining the purpose of the early return
in the code.

Stefan

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZfBEACgkQnKSrs4Gr
c8jdHwf/UKU+ki7l88n6zV3MCeqKxV/boTwDP1AEcmXz1BWnKubWi2bHxKN4Otz8
nq27xwkYe+CDqkdoFwTn/EVCiz0bUcEYxqoseRf8QmS0IG60H2KKrVnLQV+LSNV1
c4xITpIVwT13GVIak12jFdk16rTtS/zGnVHnl1N7OSgpu4tEbuz8wVbebxyVtC32
WSaZHsyGwdFfBXAbIONIdCLsqYPFNTHvpqPwte29E8o9ED1qIOh7LSxpGyWq0hyh
YL4LZ2XA6xlbPAcNZ54foJIg2l1Jkqr6zadO0nTNcmnY0YygNoEUd3MjPIndlWYx
Mgl+Sqa8a/4vk2FLC9Za1PcxiV/YFQ==
=D39I
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--


