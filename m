Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3054BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA828206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwcMHmqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA828206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7Lz-0002rA-Nu
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7DH-0001xb-HT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7DA-00041e-AF
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600876899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCZDid+64GnE84mjSUHltpy7VClQ/xNk6JkG6G4/bIk=;
 b=VwcMHmqfuNwxXsQN7i0xoM3cdUpwT9bpeTzMLj73DIUuQFm5/Y0rQSGJHjIvj8GE8GAXys
 vG+mHogby2MHiEBhMXO07E1rOWbDFmB9vnpuCOhQnM8qPpbZQZyvGArxBBm6Aep9gF8kiP
 2c95kqF2+TiaC197jmMJ0Wix9ZcBzw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-R7C6yOGMMFaXFe2EnPspzg-1; Wed, 23 Sep 2020 12:01:33 -0400
X-MC-Unique: R7C6yOGMMFaXFe2EnPspzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79ABF801AFA;
 Wed, 23 Sep 2020 16:01:31 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6657D60C04;
 Wed, 23 Sep 2020 16:01:25 +0000 (UTC)
Date: Wed, 23 Sep 2020 17:01:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 13/20] multi-process: Forward PCI config space acceses
 to the remote process
Message-ID: <20200923160124.GH62770@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-14-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-14-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kHRd/tpU31Zn62xO"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--kHRd/tpU31Zn62xO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 11:12:24AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> The Proxy Object sends the PCI config space accesses as messages
> to the remote process over the communication channel
>=20
> TODO:
> Investigate if the local PCI config writes can be dropped.
> Without the proxy local PCI config space writes for the device,
> the driver in the guest times out on the probing.
> We have tried to only refer to the remote for the PCI config writes,
> but the driver timeout in the guest forced as to left this
> as it is (removing local PCI config only).
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  hw/i386/remote-msg.c     | 70 ++++++++++++++++++++++++++++++++++++++++
>  hw/pci/proxy.c           | 50 ++++++++++++++++++++++++++++
>  include/io/mpqemu-link.h |  9 ++++++
>  io/mpqemu-link.c         |  6 ++++
>  4 files changed, 135 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kHRd/tpU31Zn62xO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rcVQACgkQnKSrs4Gr
c8jGkQf9ExoP0I21XjGOR7ILFfeEMZqgrrgvxwaGoa5jexynb2F5XZj20kE/VtsM
5tSKSRCSTw5BppUkUYv9DbwzMAxYP2Vi1s794T4Qi5QwPEsF2h0f6W6fRpbLs0Nt
U80Be4+kHAJoeKsjCf6kqnX13ku1ctz2aRMz/PVdOSJHKQAawxN4+wWzeZE+8dOp
PWQFoEeVrNQg9/odWFMU1zyOu0+IrlDsiXDjc2hH4MYQHbmlQKm4qI48ICEcWwKp
tmPXj+YUyoLwpJWgdYdzBbY4T2qZiFsRu34OxhdTMJNX9ZEJmZAUz/YI+BNdBBaT
dgkgsS23x3XimC6AbU1g3EyTiWbE9Q==
=rHdz
-----END PGP SIGNATURE-----

--kHRd/tpU31Zn62xO--


