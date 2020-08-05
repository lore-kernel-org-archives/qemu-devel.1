Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A023C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AAA22D75
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsvImh3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AAA22D75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3JF0-0005EE-LG
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3JET-0004oJ-8r
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:13:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3JEQ-0000th-FZ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596633199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RHTmQAWJIvljYPTP1tA/FYbnToRW15Ma/1/i90syStM=;
 b=AsvImh3oUQf51YD96GJ8aXdYuTEt5S7IymwnC6GZgPBc+3gscQRP8Z2Lgx6iBPS6KccSMH
 /EpOVS01xVDDg9YPteE/0I5xyekyAxRH5UXUYUAiiPPwf7A3o9y5WSuwpRUlN+xBn+9sxc
 fHun52sp1WPfc2qvT1Oq83J1S0hbO7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-8p3sf1vGPfCTUs_ceAwzkA-1; Wed, 05 Aug 2020 09:13:16 -0400
X-MC-Unique: 8p3sf1vGPfCTUs_ceAwzkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3F448015F7;
 Wed,  5 Aug 2020 13:13:14 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 897277B900;
 Wed,  5 Aug 2020 13:13:14 +0000 (UTC)
Date: Wed, 5 Aug 2020 14:13:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [Bug 1890360] [NEW] Assertion failure in address_space_unmap
 through virtio-blk
Message-ID: <20200805131313.GI361702@stefanha-x1.localdomain>
References: <159659017753.10948.1930355246009105000.malonedeb@chaenomeles.canonical.com>
 <20200805020059.qm2jpzfeqmwwbige@mozz.bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200805020059.qm2jpzfeqmwwbige@mozz.bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/GPgYEyhnw15BExa"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bug 1890360 <1890360@bugs.launchpad.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/GPgYEyhnw15BExa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2020 at 10:00:59PM -0400, Alexander Bulekov wrote:
> Hi Stefan,
> This looks an awful lot like the one you looked at here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg705719.html
> though this one is for virtio-pci, while that one was for virtio-mmio:
>=20
> They are probably the same issue, but the original reproducer no longer
> causes an asserion failure for me, so maybe there was already a fix..

I root caused the original issue but didn't create a fix.

I'll send a fix next week and check if it also takes care of this
failure report.

Stefan

--/GPgYEyhnw15BExa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8qsGkACgkQnKSrs4Gr
c8h6gQf/ZSNKjkODMpPVMKDe5c4KsIAqvBO57NDI13tkuuANwvEH3YgNVWwPH6KH
e6V8Qu7/cg7ts6X/2mVhUhzP3rCVkyPXACtATOA8UbmgCI9UIal1GkDflurZH7Wf
FOob/OGLj11kGGNziN95o1fL/3lg7r5mDCeF2UWVu7HSl72G0J//ZhEd5pLDWxeh
d+OREcjQ/YeNTtRhf8dGVl0wEERgOHfCeQtrtqDDiwtjK7C4bao/qowaMKjQJp3R
L0FikNmJqrVmXpkWC5IUTyIoiuPyRwmLKVKcAo666dMdAy/D1LmX0GavYMm3KszK
To1LnkDMVL/dlLr7SCFQVAkNcAOrxw==
=rPoR
-----END PGP SIGNATURE-----

--/GPgYEyhnw15BExa--


