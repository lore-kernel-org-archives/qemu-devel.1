Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64172C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A02A206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3azf1G6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A02A206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoWy-0000C2-5n
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDoW6-0007KF-HW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDoW4-0000bA-KO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lVyloMQgFPo5BSn/nR9ynC1wyQYLozJPFWT5+UF7Xz0=;
 b=K3azf1G6akBiDP7egd3XzJXXbPjubn+5zT6S51WZiDW5443p7noZe6DlDxPBEWAzypDkSs
 dHhCrM40PVcOvU2ZveExnKlyN2403gND3pVaNhXpaaugMN0jgc3LrpVF182y1HD3HyO/Rh
 wdfAog43z11JjtK6JGeZdbHOLrxPu0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-_S8damOZMtGD2w5kCDsYew-1; Thu, 03 Sep 2020 08:38:54 -0400
X-MC-Unique: _S8damOZMtGD2w5kCDsYew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A5F839A48;
 Thu,  3 Sep 2020 12:38:53 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-183.ams2.redhat.com [10.36.114.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC20810013C4;
 Thu,  3 Sep 2020 12:38:51 +0000 (UTC)
Date: Thu, 3 Sep 2020 14:38:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC qemu 0/6] mirror: implement incremental and bitmap modes
Message-ID: <20200903123850.GB8835@linux.fritz.box>
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
 <d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com>
 <1599127031.9uxdp5h9o2.astroid@nora.none>
 <ef545f46-7cbb-43f0-2ab8-f3d49643d1e6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ef545f46-7cbb-43f0-2ab8-f3d49643d1e6@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.09.2020 um 13:04 hat Max Reitz geschrieben:
> On 03.09.20 12:13, Fabian Gr=C3=BCnbichler wrote:
> > On August 21, 2020 3:03 pm, Max Reitz wrote:
> >> On 18.02.20 11:07, Fabian Gr=C3=BCnbichler wrote:
> > I am not sure how=20
> > the S-O-B by John is supposed to enter the mix - should I just include=
=20
> > it in the squashed patch (which would be partly authored, but=20
> > not-yet-signed-off by him otherwise?)?
>=20
> I=E2=80=99m not too sure on the proceedings, actually.  I think it should=
 be
> fine if you put his S-o-b there, as long as your patch is somehow based
> on a patch that he sent earlier with his S-o-b underneath.  But I=E2=80=
=99m not
> sure.

Signed-off-by means that John certifies the DCO for the patch (at least
the original version that you possibly modified), so you cannot just add
it without asking him.

John should reply with a Signed-off-by line to the patch in question.
Then you (Fabian) can add it in the next version of the series (if I
understand correctly, you're going to respin anyway).

I see that patch 2 doesn't have any S-o-b at all. It should have both
John's and Fabian's.

Kevin

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9Q49oACgkQfwmycsiP
L9bcBg/7Bn9rcnmIfwyi/rL25qPe5ZB1dQSwVvy1AMX66+ZSyqY2Oss1+bEPeC41
oeoPZAxaUie6IUf1BNKncJ1D8cgX4wT/GRMc5k6AW88IojZzNJfn4wXpctYH8p6r
cC/ZewtmL3KNvxwsIk1D/FHrAclPLI/lIjaMFeLL1VsHHpufy3CepiTL8F0cndYr
7jHvcKzYSfXsj1dYz9R4Uye1ytZ9Xv4pYzQHE2VHldIGGjScSIeUs9Z39XpP8uVT
CIiqQ4roQC+XkUyFEob12o0goHJuS3166BTmk2OtcpLju8hk3X8NHFOPPPf1BHLy
px6zsK/PXzGDsLFKSRHaTFLRac0oXze6PNb/O7o4RygNnBt4rqfIk8Yr9SC2xTPA
fMTd4SR6vcqV0GsePjSIRGBvRXgGemL/SMfZuY6/Vq3ctTs3wWBM+o18TIY6QBYW
KenGyepACF8kQDmuN0S7g0XPNBOdj72ErcmKqbC41WPF+ygKtY6tkKdfWWOjGP/U
pWM5+JoipNWm6XI2UKbGHd3+mresCImQZg813NY5a+k/OLUXdUkKJdHhKPHpcHd8
AQdvwbXf+qen634c8dARRDSr4Z5bylwX4J6uvWdaBa7ft9jKuvWz/bPd6z5x4hb5
aN7GlW7qpi9czrZL9XEs0Cx9om79HgAnfvQaYEq129HPrMnit9c=
=GQzo
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--


