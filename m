Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D54C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC36F20872
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5ikBTbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC36F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKBK-0008VN-L2
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGK9w-0006nA-Op
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:50:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22826
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGK9v-0005Pv-9R
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599735030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3PTc3qe5S8NHYJ0TEpMXj1qbb27NckZAefxBpDar5Bs=;
 b=R5ikBTbGWyFAH9GJIHbw7aezjJWkTuoZNnGIfFUEpd7AXnS0bYSghSf8pwgvSOIBrWaIV0
 77hh7mcFl/k7KI3HYaLA4n6YVY+/Ig+mHF/LU4sMukxIJOIMb06ZyVbkhSyYJbtfnRQfi+
 8hrPabU829/V5vz6GqMSKeBF7CReSME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ITlauSRIMlmh-HYxFjAe7A-1; Thu, 10 Sep 2020 06:50:26 -0400
X-MC-Unique: ITlauSRIMlmh-HYxFjAe7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 087861008557;
 Thu, 10 Sep 2020 10:50:25 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B58995C22E;
 Thu, 10 Sep 2020 10:50:21 +0000 (UTC)
Date: Thu, 10 Sep 2020 11:50:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 4/4] block/nvme: Use qemu_vfio_pci_init_msix_irqs() to
 initialize our IRQ
Message-ID: <20200910105020.GD45048@stefanha-x1.localdomain>
References: <20200909142354.334859-1-philmd@redhat.com>
 <20200909142354.334859-5-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909142354.334859-5-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:44:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 04:23:54PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Instead of initializing one MSIX IRQ with the generic
> qemu_vfio_pci_init_irq() function, use the MSIX specific one which
> will allow us to use multiple IRQs. For now we provide an array of
> a single IRQ.
>=20
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9aBOwACgkQnKSrs4Gr
c8iRnAgApUxAa783mZkR5wPi+SnA7uzxI8eMgYdiOSdCK93TMmu+MuOO/ReWwdOC
kYOLiVXQk8ldfe++nds+HZ4MrwfHgiUDD0vHbwcbU8lgJJLG6/41To+tLayFapka
NsHEaWrmoxByiMoS227/Ujo4zYOlqKO8mHZftm4ifvXG76eWfJeAA/z12UzNoFvq
aVjhaKlLR2kCceyfe/Z7WWndvuGL1nqtMPH1zvZgTrKxuFDJea4bZ3obPMxmizzv
4Psy9zXYLIfDlCrbG39W1m0ItCG7KD5p5GWeJLRxI6uHlSep+LU8mfe3JOJU+Rhh
7qrHucvcOMwYq5Yft3Ky650qrsNJ/Q==
=gP2k
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--


