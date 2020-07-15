Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927E8C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6200420720
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQlsHjwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6200420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jveSR-0006nA-KK
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 06:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jveRd-0006LP-Hl
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:15:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29852
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jveRb-0005rV-3t
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 06:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594808117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UX2BYJfTIajBbCI/m/gTxcoWCh8uDnyeEhwXp5Iplus=;
 b=jQlsHjwY+IqNQA0SEFVSh4d4dMtMQXyge2HVYd2DOKbvZmEzNeoRLUor1KIqHZB4uCx/SY
 NX+xB//rbHa7Kys2Cu9GxYP6QP5x7xlrjmOpnfub7v6k1XKfltHCbrS4lWXiMol4DzrQ/I
 0PEtMeRDLIr6ermfoF47+Yrq5piwX2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-MS2T9GcZMRqvtf7b1v0m0w-1; Wed, 15 Jul 2020 06:15:13 -0400
X-MC-Unique: MS2T9GcZMRqvtf7b1v0m0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E5261005264;
 Wed, 15 Jul 2020 10:15:10 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E63FC10013C3;
 Wed, 15 Jul 2020 10:15:03 +0000 (UTC)
Date: Wed, 15 Jul 2020 11:15:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200715101502.GC18817@stefanha-x1.localdomain>
References: <8101D131-3B95-4CF5-8D46-8755593AA97D@oracle.com>
 <A0E4C51F-B41C-486B-A5CE-3C4C2C9C1A40@oracle.com>
 <20200602090629.66f9e3f7@x1.home>
 <E78F4C2E-4382-4C98-9606-F1ABD9753699@oracle.com>
 <20200615104929.GD1491454@stefanha-x1.localdomain>
 <DE330A27-2343-459F-9EA0-D3C5F20EE87D@oracle.com>
 <20200623122715.GF36568@stefanha-x1.localdomain>
 <7B305CB0-0D5F-4FF8-ACDC-828AF37687B1@oracle.com>
 <20200626133020.GZ281902@stefanha-x1.localdomain>
 <4C0893E7-B72C-4499-9379-7E4DDB94E771@oracle.com>
MIME-Version: 1.0
In-Reply-To: <4C0893E7-B72C-4499-9379-7E4DDB94E771@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--da4uJneut+ArUgXk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 11:23:25PM -0700, John G Johnson wrote:
>=20
> =09We=E2=80=99ve made the review changes to the doc, and moved to RST for=
mat,
> so the doc can go into the QEMU sources.
>=20
> =09=09=09=09=09=09Thanos & JJ
> =20
>=20
> https://github.com/tmakatos/qemu/blob/master/docs/devel/vfio-over-socket.=
rst

Great! Feel free to send a patch to qemu-devel so the proposal can be
discussed in detail.

Stefan

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8O1yYACgkQnKSrs4Gr
c8gdcQf/Vr/6ScIqT/pfB1WgiSFpO+L3BrFBQfcG66x8bNAVmk1UtIRAGWG0zf2x
WP5NOlx2sdqPvks/sU9QQhsOr8mrmiSKzV8zbRGizTm0ZvepzIOqSWQbQCvW9ZQG
MIojds3FJDs7DvpgT+r6ciKkLhkUcOT1tK7Vhjt49lC8WSCDraQX/YYvd1vSDyxp
05uAE8Vkjxkr/05B2jleRUOZjXo6Jeviq+Jf8/oDUzxToSVdKnQOKVDjywiAR9zT
ZWD2GJO/sNPdoHYpKV6Q6Na/OocnAPWmcVBXxW2uwhsGC9rjZI4qPZ5JZdcojiXl
EX9pGRTfB4GEJSxEQ4kEiPkBREb7eg==
=aOgy
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--


