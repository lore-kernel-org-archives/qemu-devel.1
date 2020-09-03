Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7A8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE06B206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq5b3n6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE06B206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpE3-0004Nw-PX
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDpDW-0003pU-Dd
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:23:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDpDT-0006l7-GF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599139430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HcxJFieVY4YuZVuY/Wsb12wMqPxs6kbweiJuP3IE9QE=;
 b=Cq5b3n6+Hp/N9lvslF1EaXcR5dhCqqE1Tm0Fzi1JoHvDLxxy2hRxDNfqicW8iksU0Me/o3
 m0gPZdJsfA5YgBrMBOqvUsD45yuekqZL5oea8Svg2zGuJakqGn6OKLhGHoFu7OL7XyqB7G
 0RfREtsfeMLtbC+f3qbybVk9SMmcn0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-mJtYZgH-N7ydNqznqchFxA-1; Thu, 03 Sep 2020 09:23:47 -0400
X-MC-Unique: mJtYZgH-N7ydNqznqchFxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D189418BA28C;
 Thu,  3 Sep 2020 13:23:46 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-183.ams2.redhat.com [10.36.114.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18B1E5D9CC;
 Thu,  3 Sep 2020 13:23:44 +0000 (UTC)
Date: Thu, 3 Sep 2020 15:23:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC qemu 0/6] mirror: implement incremental and bitmap modes
Message-ID: <20200903132343.GD8835@linux.fritz.box>
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
 <d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com>
 <1599127031.9uxdp5h9o2.astroid@nora.none>
 <ef545f46-7cbb-43f0-2ab8-f3d49643d1e6@redhat.com>
 <20200903123850.GB8835@linux.fritz.box>
 <ec747431-b2fa-2e67-984b-3cf70e0c79e4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ec747431-b2fa-2e67-984b-3cf70e0c79e4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--8GpibOaaTibBMecb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.09.2020 um 14:57 hat Max Reitz geschrieben:
> On 03.09.20 14:38, Kevin Wolf wrote:
> > Am 03.09.2020 um 13:04 hat Max Reitz geschrieben:
> >> On 03.09.20 12:13, Fabian Gr=C3=BCnbichler wrote:
> >>> On August 21, 2020 3:03 pm, Max Reitz wrote:
> >>>> On 18.02.20 11:07, Fabian Gr=C3=BCnbichler wrote:
> >>> I am not sure how=20
> >>> the S-O-B by John is supposed to enter the mix - should I just includ=
e=20
> >>> it in the squashed patch (which would be partly authored, but=20
> >>> not-yet-signed-off by him otherwise?)?
> >>
> >> I=E2=80=99m not too sure on the proceedings, actually.  I think it sho=
uld be
> >> fine if you put his S-o-b there, as long as your patch is somehow base=
d
> >> on a patch that he sent earlier with his S-o-b underneath.  But I=E2=
=80=99m not
> >> sure.
> >=20
> > Signed-off-by means that John certifies the DCO for the patch (at least
> > the original version that you possibly modified), so you cannot just ad=
d
> > it without asking him.
>=20
> But what if you take a patch from someone and heavily modify it =E2=80=93
> wouldn=E2=80=99t you keep the original S-o-b and explain the modification=
s in
> the commit message?

Ah, if that patch already had a S-o-b, then yes. You keep it not only to
show who touched the patch, but also because your own S-o-b depends on
the one from the original author (you only have the rights to contribute
it because the original author had them and could pass them on to you).

I thought it was based on a patch that came without S-o-b.

Kevin

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9Q7l8ACgkQfwmycsiP
L9a4ew//Vbi0G8WyFc/ntdpijv4EJATjbUDAHm9W488y0g9MCwiWvPlOb1BnZuf9
US6A3VkjtmTlSWEvMYe0XgQ+BI58aCOFmYdZTsUydGyrVauaTkBDov43DS/YJfB9
V2GIBWr5lFRhXtB+xhfFjvwHA4NhOM09HHGpYjm1Vjmih2QWhYiVn/E/wtVZ+FFg
vpgpNcrG6bydARrX06fiNH8QmdxZ7UaPTHNLJXjK7iecNT0b5zycnPtPgAPgWbDs
ySKWkS2y4Jw2VQx1n45290J61BdEc7g7VgG0/8CSDXNjM6F5M7lhbekmEHBAgtPQ
tirUKL1pQDSnj4N1hRbtc4D8hEKKh/Rq79043lmJte10B/k1y+C2y/A/L51YVB4I
7Oivo/sOkQiLN+446TmMthf+5ExkRqMSp0I/94doHlQyHQDSawzq0xR2X+QYQN7g
yqpLEkM9j7AFLnSDB5ZfGoUSwuGUxdQ52PoJnWHR41i7fLir5q1x/nDLYtDDVO4D
XaBo3+c5c3MgZLPgN4MNimNtzdv9M19q9jqSFw1xeNfaSujwh1SUP73MtSUTiZZk
M+ZACmzKquiNmjAVBsioFeyDc69qTYDx6a2cA1Zu0BdhqOBQp/wyx9SH52Pv7ra1
T2baiacZRTYP7F4ZAsZVL6WxeZk+uT3lbuhZyWsbFrBy1FVOH6w=
=36rc
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--


