Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92353C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59473206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdxRRnIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59473206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYU90-0006Dy-Ja
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYU7x-0005Ml-Cx
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:35:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48099
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYU7v-00085v-RB
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589286914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WRhetdZvD7G7XsPvD/7RhzAtjnF9dNohdn3pkTcgwVI=;
 b=RdxRRnIplMF6s1K4K09ejEE6DY8Y1016d4lIJtZud2pJWznXG4nDoFEhmnlGlDAYA43dxj
 QmaDwtTD9vJJIo6F/Ry1bENT41TnnshvGs2Ew8i/+gbo3ZSyNANzyXrioTq73OVnAlDXjR
 ps6IX4IHigsmmbWkUgRzXoqtYf7PLlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-MD2XHcCvPD6rCPZf6rfIug-1; Tue, 12 May 2020 08:35:13 -0400
X-MC-Unique: MD2XHcCvPD6rCPZf6rfIug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F21278014D6;
 Tue, 12 May 2020 12:35:10 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84C8D5D9DD;
 Tue, 12 May 2020 12:35:01 +0000 (UTC)
Date: Tue, 12 May 2020 13:35:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 18/36] multi-process: Initialize Proxy Object's
 communication channel
Message-ID: <20200512123500.GH300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <4a67a368c3ca27e393ac7646ed27b3821dd748e2.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <4a67a368c3ca27e393ac7646ed27b3821dd748e2.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kHRd/tpU31Zn62xO"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--kHRd/tpU31Zn62xO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:53PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Add "socket" object property which initializes the communication channel
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  hw/proxy/qemu-proxy.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> index bf6c4117ef..40bf56fd37 100644
> --- a/hw/proxy/qemu-proxy.c
> +++ b/hw/proxy/qemu-proxy.c
> @@ -14,6 +14,25 @@
>  #include "hw/proxy/qemu-proxy.h"
>  #include "hw/pci/pci.h"
> =20
> +static void proxy_set_socket(Object *obj, const char *str, Error **errp)
> +{
> +    PCIProxyDev *pdev =3D PCI_PROXY_DEV(obj);
> +
> +    pdev->socket =3D atoi(str);
> +
> +    mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
> +                        pdev->socket);

If mpqemu_link objects are not going to use QOM's object-oriented
features then a plain C struct is fine. There is no need to define a QOM
type for mpqemu_link in an earlier patch.

> +}
> +
> +static void proxy_init(Object *obj)
> +{
> +    PCIProxyDev *pdev =3D PCI_PROXY_DEV(obj);
> +
> +    pdev->mpqemu_link =3D mpqemu_link_create();
> +
> +    object_property_add_str(obj, "socket", NULL, proxy_set_socket, NULL)=
;

Please use a qdev property like vhost-vsock.c's vhostfd and call it
either "fd" so it's clear this is the file descriptor.

monitor_fd_param() should be used to parse the fd string at .realize()
time.

--kHRd/tpU31Zn62xO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66l/QACgkQnKSrs4Gr
c8jfqQf/fkZJWJDmVmFZSErnLvAw6lkJQtfdjp6LEzV9QS7khW2w5u5/vNQKzhgI
hfEprDn66xMqqDgyhT4s8s3tZXJeqN/h1HtI3b5yIxwOKb5F474KYsoutmKk4cbH
BUH/u3UJOGANb7WQKmZGLIgKrOkB73N6vgZ/bj7Ijgw0hg42nRbzLIKD6npVb6hh
kiirOOKlAQg3k4iowjixpJTdQwVvBfbg/gYIKEnjPstxS/A8FvxdxGT/N74Pzr/j
o+Sz9mDM2LGAzycjSp7aUCt1kc1m1ABuus3qTITpTO3wBSakbXZ1BW3Em4Td1Ge7
1Q7wDFCq7uTYXyAuIn75DWml5FZBSQ==
=ShA5
-----END PGP SIGNATURE-----

--kHRd/tpU31Zn62xO--


