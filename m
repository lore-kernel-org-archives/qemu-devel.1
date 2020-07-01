Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C2BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1260F206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfSeDdah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1260F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqYaI-000864-BI
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 04:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqYZd-0007ep-MB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:58:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqYZb-0008PZ-6B
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593593909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k1Me6BTTY4CKi2ECxkCpC29W39nRlREQH5h6atphcms=;
 b=PfSeDdahWoHEWKu3gLtNPPbEf4cAxS2yo2OqQB8e1Poxzvdo17p9Dfk5KQg4hpEEOCYl2J
 vtoETmhKWYbuuOhk3EkJjAW0X0g3N3TESLpoe1sdWeUsg24daeSJZAvcwvUu8+Rzed2hoX
 G+qGkoJCdM7WBNjMnhsJaBLw569/UAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-u19Vov8FPnmV80G6jBiyrw-1; Wed, 01 Jul 2020 04:58:27 -0400
X-MC-Unique: u19Vov8FPnmV80G6jBiyrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9207BFC0;
 Wed,  1 Jul 2020 08:58:25 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B16B95C1C5;
 Wed,  1 Jul 2020 08:58:19 +0000 (UTC)
Date: Wed, 1 Jul 2020 09:58:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 11/21] multi-process: introduce proxy object
Message-ID: <20200701085817.GD126613@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <91d295b59735fab5b46959b489b1384cc13bdb67.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <91d295b59735fab5b46959b489b1384cc13bdb67.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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

--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:09:33AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Defines a PCI Device proxy object as a child of TYPE_PCI_DEVICE.
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  MAINTAINERS            |  2 ++
>  hw/pci/Makefile.objs   |  1 +
>  hw/pci/proxy.c         | 70 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/pci/proxy.h | 43 ++++++++++++++++++++++++++
>  4 files changed, 116 insertions(+)
>  create mode 100644 hw/pci/proxy.c
>  create mode 100644 include/hw/pci/proxy.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 017c96eace..b48c3114c1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2952,6 +2952,8 @@ F: include/io/mpqemu-link.h
>  F: hw/i386/remote-msg.c
>  F: include/hw/i386/remote-memory.h
>  F: hw/i386/remote-memory.c
> +F: hw/pci/proxy.c
> +F: include/hw/pci/proxy.h
> =20
>  Build and test automation
>  -------------------------
> diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
> index c78f2fb24b..515dda506c 100644
> --- a/hw/pci/Makefile.objs
> +++ b/hw/pci/Makefile.objs
> @@ -12,3 +12,4 @@ common-obj-$(CONFIG_PCI_EXPRESS) +=3D pcie_port.o pcie_=
host.o
> =20
>  common-obj-$(call lnot,$(CONFIG_PCI)) +=3D pci-stub.o
>  common-obj-$(CONFIG_ALL) +=3D pci-stub.o
> +obj-$(CONFIG_MPQEMU) +=3D proxy.o
> diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
> new file mode 100644
> index 0000000000..6d62399c52
> --- /dev/null
> +++ b/hw/pci/proxy.c
> @@ -0,0 +1,70 @@
> +/*
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +
> +#include "hw/pci/proxy.h"
> +#include "hw/pci/pci.h"
> +#include "qapi/error.h"
> +#include "io/channel-util.h"
> +#include "hw/qdev-properties.h"
> +#include "monitor/monitor.h"
> +
> +static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
> +{
> +    pdev->com =3D qio_channel_new_fd(fd, errp);

The caller needs to close(fd) on failure:

  if (!pdev->com) {
      close(fd);
  }

> +}

pdev->com is never freed. It seems like hotplug should be possible
eventually. Implementing ->unrealize() from the start will make that
easier because it will be necessary to think through the lifecycle of
this object.

> +
> +static Property proxy_properties[] =3D {
> +    DEFINE_PROP_STRING("fd", PCIProxyDev, fd),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
> +{
> +    PCIProxyDev *dev =3D PCI_PROXY_DEV(device);
> +    int proxyfd;
> +
> +    if (dev->fd) {

Does it make sense to succeed without fd? If not then errp should be
set so the caller knows .realize() failed.

> +        proxyfd =3D monitor_fd_param(cur_mon, dev->fd, errp);
> +        if (proxyfd =3D=3D -1) {
> +            error_prepend(errp, "proxy: unable to parse proxyfd: ");

The user-visible property name is "fd":
s/proxyfd/fd/

> +typedef struct PCIProxyDevClass {
> +    PCIDeviceClass parent_class;
> +
> +    void (*realize)(PCIProxyDev *dev, Error **errp);
> +
> +    char *command;
> +} PCIProxyDevClass;

Neither ->realize nor ->command are used in this patch. Please drop
PCIProxyDevClass for now. If these fields are used later on then they
should be introduced in the patches that need them.

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78UCkACgkQnKSrs4Gr
c8h0mQgAyo06XexS/Rcbbk1hwJUCE8BQ1r1gFn1ewIHjw9f2BZLHyf9IABiHDIjq
6oB6cVCMbukm4DENibYly7ux/oqyQklyRjmv4n2BJZWwNy9zBmlp4u+vQqpLB6Vg
lKxVJreVlaNLDx/wLQSZLFKO52ZorBBtMwzmunTszSwVj6eMGScap64pyq30Xec4
avjrGh+jPZuDL/VevfuDS6rmqyIjXth32ZlZj7QPbile9V1fQutEuYYrywjYbsIp
8IFkeYaILhaGE1hm89duMQXvUvQ7HGu7RVGaX5AW83nFF02XOWFp68Tw8VQWoyFj
ErLY32yvK1jxe4JvL8oFFItVWB064g==
=n/KW
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--


