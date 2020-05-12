Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D70FC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5076020661
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LK5vV+zF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5076020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTxd-00066U-IR
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYTwn-0005ai-Fl
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:23:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58632
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYTwl-0003ka-NG
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589286222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ik4sdvqIIlspxHflii6NqnYT5TK+k45ASTSwtghfygY=;
 b=LK5vV+zFEmTvwDqiCwwZySDKsK5/dXI+n0B4FpHKg1vbtcMXaR6mIBi/oYWtB59QQG/uZc
 pxCzi4bJWI28pwWRDDA6ZM+bJzOHeKZxeXTY+rH4Im/P6QUas2fuvRkIn3XSdRqd7WDrQZ
 eZPyZbI+sNJkEVkHDceYZbMJrPmHtVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-e7FMg8pnO4qdc8ILD-uJNg-1; Tue, 12 May 2020 08:23:37 -0400
X-MC-Unique: e7FMg8pnO4qdc8ILD-uJNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7400D460;
 Tue, 12 May 2020 12:23:35 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0204A75285;
 Tue, 12 May 2020 12:23:28 +0000 (UTC)
Date: Tue, 12 May 2020 13:23:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 17/36] multi-process: introduce proxy object
Message-ID: <20200512122327.GG300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <53e7ef183df66e34aa20c026b6bf299b1726ad75.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <53e7ef183df66e34aa20c026b6bf299b1726ad75.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
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

--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:52PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Defines a PCI Device proxy object as a parent of TYPE_PCI_DEVICE.

s/parent/child/

>=20
> PCI Proxy Object registers as a PCI device with QEMU and forwards all
> PCI accesses to the remote process using the communication channel.

Please include that functionality in this patch. The code below just
sets up a skeleton PCI device. There is no code that forwards accesses
to the remote process.

> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  MAINTAINERS                   |  3 ++
>  hw/Makefile.objs              |  2 ++
>  hw/proxy/Makefile.objs        |  1 +
>  hw/proxy/qemu-proxy.c         | 56 +++++++++++++++++++++++++++++++++++
>  include/hw/proxy/qemu-proxy.h | 46 ++++++++++++++++++++++++++++
>  include/io/mpqemu-link.h      |  1 +
>  6 files changed, 109 insertions(+)
>  create mode 100644 hw/proxy/Makefile.objs
>  create mode 100644 hw/proxy/qemu-proxy.c
>  create mode 100644 include/hw/proxy/qemu-proxy.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96f8d7ff19..3da3dcd311 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2866,6 +2866,9 @@ F: include/remote/machine.h
>  F: remote/machine.c
>  F: include/remote/memory.h
>  F: remote/memory.c
> +F: hw/proxy/Makefile.objs
> +F: hw/proxy/qemu-proxy.c
> +F: include/hw/proxy/qemu-proxy.h

It's a generic PCI device. hw/pci/proxy.c would be a good location for
it.

By the way an alternative to the "proxy"/"remote" terminology is
RemotePCIClient/RemotePCIServer. That makes it more obvious that "proxy"
is related the "remote" feature. Feel free to keep the existing
terminology, I just wanted to suggest another possibility.

> =20
>  Build and test automation
>  -------------------------
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index af9235b6f2..7b489b12a5 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -45,6 +45,8 @@ endif
>  common-obj-y +=3D $(devices-dirs-y)
>  obj-y +=3D $(devices-dirs-y)
> =20
> +common-obj-$(CONFIG_MPQEMU) +=3D proxy/
> +
>  remote-pci-obj-$(CONFIG_MPQEMU) +=3D core/
>  remote-pci-obj-$(CONFIG_MPQEMU) +=3D block/
>  remote-pci-obj-$(CONFIG_MPQEMU) +=3D pci/
> diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
> new file mode 100644
> index 0000000000..eb81624cf8
> --- /dev/null
> +++ b/hw/proxy/Makefile.objs
> @@ -0,0 +1 @@
> +common-obj-$(CONFIG_MPQEMU) +=3D qemu-proxy.o
> diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
> new file mode 100644
> index 0000000000..bf6c4117ef
> --- /dev/null
> +++ b/hw/proxy/qemu-proxy.c
> @@ -0,0 +1,56 @@
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
> +#include "qapi/error.h"
> +#include "io/mpqemu-link.h"
> +#include "hw/proxy/qemu-proxy.h"
> +#include "hw/pci/pci.h"
> +
> +static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
> +{
> +    PCIProxyDev *dev =3D PCI_PROXY_DEV(device);
> +    PCIProxyDevClass *k =3D PCI_PROXY_DEV_GET_CLASS(dev);
> +    Error *local_err =3D NULL;
> +
> +    if (k->realize) {

Will anything inherit from this class? I thought this is the remote PCI
client that can acts as a stand-in for all remote PCI devices, so it's
not clear why it's acting as a base class here.

> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index d46cb81058..73cc59b874 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -14,6 +14,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> =20
> +#include "sys/eventfd.h"

Why? Nothing in this patch uses this header.

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66lT8ACgkQnKSrs4Gr
c8iMfwf+JeXcymu+v4u4qf2OqslXsXgdvd66cjGh2toK9uTftBrWwI1ndWA22D+e
CAjK8jYv3TBKzgc1dZeu8l0acxnLPtfbesDk7mkzljP1JHcie85puU4xrve5dUKB
q3Vf81u1cHwJ449dHjhZPh3pLpAAAfOYj5lQndIw+baGJF/yQsOxAr17JuPY0iKp
aqDraBcFce5l6htlu3XR88aYPJ5W21rzU8gw7qWwMlUouNGIf4iBVByLvhYpCzXd
Qt6/MLnKV59YuqA5vpZ9Ct/3Dx+1x4SHZvHlzH9qSq6qdkIRds7Nc013SH2xttMb
Sm91GCYBCrsLZatv3OOqyw3QoFAOUA==
=4SDu
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--


