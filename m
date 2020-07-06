Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61071206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V24OXTyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61071206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPVO-0002Ho-L1
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsPUJ-0001IR-W5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:40:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39556
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jsPUI-0002xE-3a
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 07:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594035641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2VPa0I8Jp6u5xk2t4WWc/zlt2AwUES4CZgrUoTzxOU=;
 b=V24OXTyRqtz+aCWoi9Y+Ivi1XPIDPpXrASFgGZTcqb4zUR3bViW0xliY7pA1S0rSxzTVRX
 EgdYNZ2aOPmFfekcBoNzTvdl3YVQbmg0SQotIzK1AXWWbhBvJGCMl6imHRRQW0EIiJ78ts
 2fmSuYLaB2KeXPnpic2Q2ro2Nfv5dKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-RI42tYMxOTGtLUpFcgZi8Q-1; Mon, 06 Jul 2020 07:40:39 -0400
X-MC-Unique: RI42tYMxOTGtLUpFcgZi8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2C82800406;
 Mon,  6 Jul 2020 11:40:38 +0000 (UTC)
Received: from localhost (ovpn-114-217.ams2.redhat.com [10.36.114.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33BE9C0D93;
 Mon,  6 Jul 2020 11:40:37 +0000 (UTC)
Date: Mon, 6 Jul 2020 12:40:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 14/16] block/nvme: Extract nvme_poll_queue()
Message-ID: <20200706114035.GC342708@stefanha-x1.localdomain>
References: <20200704213051.19749-1-philmd@redhat.com>
 <20200704213051.19749-15-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704213051.19749-15-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 11:30:49PM +0200, Philippe Mathieu-Daud=E9 wrote:
> As we want to do per-queue polling, extract the nvme_poll_queue()
> method which operates on a single queue.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> Stefan better double check here!
> ---
>  block/nvme.c | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8DDbMACgkQnKSrs4Gr
c8hpBQf+I6jO/e3VzyUK4C/RFlcLQ+8zCb5WXi2NY1CZi4KKZKtD/jE5YjAlpHog
FTQJcziWdtFa2rdUWYpnzMYnjrj7ngy5iYZlZrgycrA+JduBedSxuY1melLXGcnp
1pAEjcnN9a+CAW43asdHIlea4YUo1XPjfn6t6jhIkDIqtEICXg8p73DZDtRSKoNe
7UyZllpyWU8PXQl9kO568ZgzljR6MjtEcR1rnH0l9O84FIRt3/XpKJhHZLSSLrQa
hGNBTu4mzrCOydW+uaKdKMM2A4H3zHS9Aqw1UmUYB+Ib+9l+RVMRZYyo5b45I8fu
69LVufSm1iXRZZyWC0aiGLOmZ6H8OQ==
=XTL0
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--


