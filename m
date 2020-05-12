Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA95C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26983206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF6mNMha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26983206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSD2-0005w8-Ah
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYSC9-0005Ue-CA
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:31:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYSC7-00075g-S3
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589279487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvLIKZtcpOT229CjTOeoZRK51NTpvGmcgp6q+OuSIbk=;
 b=TF6mNMha+b3YMZcgip4NS50ASX0RwTGicRhM5SHVRKObnvP3LyrOTiniGjQJTeHjIMAw0p
 13XtnJLmwSXHx61gFNgq1NhcGNR911vbCawZnxsHrchMJ7ECwRz78WVFD3HExthWX4XvOM
 VMmxgBuuBJZ8KgjQLIDNcv63K+FSSyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-VanNWZGNPcms1F6s8TuqdQ-1; Tue, 12 May 2020 06:31:22 -0400
X-MC-Unique: VanNWZGNPcms1F6s8TuqdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5937393A6;
 Tue, 12 May 2020 10:31:20 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A73431D4;
 Tue, 12 May 2020 10:31:14 +0000 (UTC)
Date: Tue, 12 May 2020 11:31:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 13/36] multi-process: setup PCI host bridge for
 remote device
Message-ID: <20200512103108.GD300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <ef096f6770e86ca13fe364cdab292927e8cef829.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <ef096f6770e86ca13fe364cdab292927e8cef829.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
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

--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:48PM -0700, elena.ufimtseva@oracle.com wrote:
> diff --git a/include/remote/pcihost.h b/include/remote/pcihost.h
> new file mode 100644
> index 0000000000..7aca9ccaf1
> --- /dev/null
> +++ b/include/remote/pcihost.h
> @@ -0,0 +1,45 @@
> +/*
> + * PCI Host for remote device
> + *
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef REMOTE_PCIHOST_H
> +#define REMOTE_PCIHOST_H
> +
> +#include <stddef.h>
> +#include <stdint.h>
> +
> +#include "exec/memory.h"
> +#include "hw/pci/pcie_host.h"
> +
> +#define TYPE_REMOTE_HOST_DEVICE "remote-pcihost"
> +#define REMOTE_HOST_DEVICE(obj) \
> +    OBJECT_CHECK(RemPCIHost, (obj), TYPE_REMOTE_HOST_DEVICE)
> +
> +typedef struct RemPCIHost {

Hmm...this object has no state or behavior specific to remote device
emulation. Could you use an existing PCIe host instead? It's not clear
to me that a new object is needed.

> +    /*< private >*/
> +    PCIExpressHost parent_obj;
> +    /*< public >*/
> +
> +    /*
> +     * Memory Controller Hub (MCH) may not be necessary for the emulatio=
n
> +     * program. The two important reasons for implementing a PCI host in=
 the
> +     * emulation program are:
> +     * - Provide a PCI bus for IO devices
> +     * - Enable translation of guest PA to the PCI bar regions
> +     *
> +     * For both the above mentioned purposes, it doesn't look like we wo=
uld
> +     * need the MCH
> +     */
> +
> +    MemoryRegion *mr_pci_mem;
> +    MemoryRegion *mr_sys_mem;

Unused?

> +    MemoryRegion *mr_sys_io;
> +} RemPCIHost;

The name "RemotePCIHost" would be consistent with the QOM type and the
filename. It might seem trivial but when reading code that others have
written every time the naming changes you need to figure out why (just
an inconsistency or is this a different concept/abstraction?).

> +
> +#endif
> diff --git a/remote/Makefile.objs b/remote/Makefile.objs
> index a9b2256b2a..2757f5a265 100644
> --- a/remote/Makefile.objs
> +++ b/remote/Makefile.objs
> @@ -1 +1,2 @@
>  remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-main.o
> +remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcihost.o
> diff --git a/remote/pcihost.c b/remote/pcihost.c
> new file mode 100644
> index 0000000000..dbe081903e
> --- /dev/null
> +++ b/remote/pcihost.c
> @@ -0,0 +1,64 @@
> +/*
> + * Remote PCI host device
> + *
> + * Copyright =A9 2018, 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <sys/types.h>
> +#include <unistd.h>

"qemu/osdep.h" already includes these headers.

> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/pci/pcie_host.h"
> +#include "hw/qdev-properties.h"
> +#include "remote/pcihost.h"
> +#include "exec/memory.h"
> +
> +static const char *remote_host_root_bus_path(PCIHostState *host_bridge,
> +                                             PCIBus *rootbus)
> +{
> +    return "0000:00";
> +}
> +
> +static void remote_host_realize(DeviceState *dev, Error **errp)
> +{
> +    char *busname =3D g_strdup_printf("remote-pci-%ld", (unsigned long)g=
etpid());
> +    PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
> +    RemPCIHost *s =3D REMOTE_HOST_DEVICE(dev);
> +
> +    pci->bus =3D pci_root_bus_new(DEVICE(s), busname,
> +                                s->mr_pci_mem, s->mr_sys_io,
> +                                0, TYPE_PCIE_BUS);
> +}
> +
> +static void remote_host_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
> +
> +    hc->root_bus_path =3D remote_host_root_bus_path;
> +    dc->realize =3D remote_host_realize;
> +
> +    dc->user_creatable =3D false;
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->fw_name =3D "pci";
> +}
> +
> +static const TypeInfo remote_host_info =3D {
> +    .name =3D TYPE_REMOTE_HOST_DEVICE,
> +    .parent =3D TYPE_PCIE_HOST_BRIDGE,
> +    .instance_size =3D sizeof(RemPCIHost),
> +    .class_init =3D remote_host_class_init,
> +};
> +
> +static void remote_machine_register(void)
> +{
> +    type_register_static(&remote_host_info);
> +}
> +
> +type_init(remote_machine_register)

The naming in this file is inconsistent:

remote_host_root_bus_path -> remote_pcihost_root_bus_path
remote_machine_register -> remote_pcihost_register

I haven't listed all instances.

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66euwACgkQnKSrs4Gr
c8jmDAgAgK78DYvkDKLndwak0kpuvN8+hcjVpyZaVLGhTTZuaezWwXjiWyX9cOJY
jek8UKFFYHJBFDIBxn/wtFVcDLZHdltM58R+Th5H8gufDFMP5IxXHxLchs+ai1wR
3vNUlXnS0hjB0hnGAAAFCSfMWcIzeH3eKU5claH08n/OWrr4el4PHiNveI1du2M9
GAi681HvKIexjfpM2bDiwP2VRPaM2YoNw+WeY6+gXNQ+iWziIXRkB2gGfk2+6vx9
m98XnpE0i4vEZ/HBB5tI8cReEQxsLpj4uMkrnGI2UpeoUWIac7PXVyZy0NHGBxqO
hRMfVk8IhI3JbtrwKFj11hggm4bPbA==
=7kT6
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--


