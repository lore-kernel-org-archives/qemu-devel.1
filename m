Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E389EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D94206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHXoRGPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D94206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GjS-0006mk-Ta
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3GiU-0006Hb-KT
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:32:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29541
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k3GiT-0004ap-13
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596623531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JmM8hWu2BmFcOo3qv5ozw4D71cHtdlyxmHw78zDDuB4=;
 b=CHXoRGPVFTkfPq82cxlBDukOkWq+6xfdTF6ZfW6PiNb23rYQSIdve8CkgbLR75vAZqz+UT
 4nUBPG/xomkFu5UX+P9JsFhkowLmJg6uRh/7Bf9lq7Imkb+E6iPO/JiYtQHTGafZsglJzC
 0JuskYod/NiAfWbCPepa3CdCZVFaPmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-tOOO9PHQML6Hp9Um_ykB3g-1; Wed, 05 Aug 2020 06:32:09 -0400
X-MC-Unique: tOOO9PHQML6Hp9Um_ykB3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 319AE192376D;
 Wed,  5 Aug 2020 10:32:08 +0000 (UTC)
Received: from localhost (ovpn-114-155.ams2.redhat.com [10.36.114.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F61C1002388;
 Wed,  5 Aug 2020 10:32:04 +0000 (UTC)
Date: Wed, 5 Aug 2020 11:32:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 3/7] device-core: use RCU for list of childs of a bus
Message-ID: <20200805103203.GA361702@stefanha-x1.localdomain>
References: <20200715150159.95050-1-mlevitsk@redhat.com>
 <20200715150159.95050-4-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200715150159.95050-4-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 06:01:55PM +0300, Maxim Levitsky wrote:
> This fixes the race between device emulation code that tries to find
> a child device to dispatch the request to (e.g a scsi disk),
> and hotplug of a new device to that bus.
>=20
> Note that this doesn't convert all the readers of the list
> but only these that might go over that list without BQL held.
>=20
> This is a very small first step to make this code thread safe.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  hw/core/bus.c          | 28 ++++++++++++++++++----------
>  hw/core/qdev.c         | 37 +++++++++++++++++++++++--------------
>  hw/scsi/scsi-bus.c     | 17 ++++++++++++++---
>  hw/scsi/virtio-scsi.c  |  6 +++++-
>  include/hw/qdev-core.h |  9 +++++++++
>  5 files changed, 69 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8qiqMACgkQnKSrs4Gr
c8iwzgf9FdlPBXAqZlqoypPLuBc/RiRmh28YJElFvBMFu1wihZx+qQWn0Ok+mL7V
L+vrt9Z7PzVthkyx9uH2iOCahZbRyynJpX4nMzCfRdiDU3xLED0VYvoKNgN+waKc
c+MSvnp9TOzE6TkgKPMeUcZxtoccHpnqe0BWqmccfKVrO1PhDpSgmhSVJaVHn0L1
0phmpgkDPY3PqAn6CcNZqCuKsDbV3kicE5ToOEs3YX/Xn1hATUmgCb9dFZolqSPH
kEOrjRam1CvvogBzha4daYa+qoxe34nksOlMOiDjGgRj5cOxP6TKPWw6IIa7xx6U
Cs17rDaf2VOA3NFXvzAeYt/HU0ouNw==
=Kqct
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--


