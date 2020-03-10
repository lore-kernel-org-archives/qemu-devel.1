Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC74C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E042464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgkTColj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E042464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdWn-0001hq-C5
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBdUu-0007Sq-Sm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBdUq-0000pk-SU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:56:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21812
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBdUq-0000l0-Ne
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583841386;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NV2xMe2Sr31cOfB4CcEfvpZFOEN/h7KzHUcZvxqQTA8=;
 b=DgkTColj0bzFK7wpAJXjab9bPUnSGG78OR5h/BkbOD63SC9U/9WcO+x/+TXxFxEovD+ClQ
 aUXl2lbVQB1KQhKC0vJY5PQ+LHWj4AFIuSlN+GivzjHbdq3g488M7VR4IbH7svfjEgzIZf
 GqFqhENHKQ+oRqfb+gH663YAWpXp8OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-NMGenh5uM42T86bRAR_1cw-1; Tue, 10 Mar 2020 07:56:22 -0400
X-MC-Unique: NMGenh5uM42T86bRAR_1cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2726F18AB2C2;
 Tue, 10 Mar 2020 11:56:21 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 438721001DDE;
 Tue, 10 Mar 2020 11:56:15 +0000 (UTC)
Date: Tue, 10 Mar 2020 11:56:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 1/2] spapr: Disable legacy virtio devices for
 pseries-5.0 and later
Message-ID: <20200310115611.GE3234052@redhat.com>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200305043009.611636-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
In-Reply-To: <20200305043009.611636-2-david@gibson.dropbear.id.au>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, groug@kaod.org,
 qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org, mdroth@us.ibm.com,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 03:30:08PM +1100, David Gibson wrote:
> PAPR specifies a kind of odd, paravirtualized PCI bus, which looks to
> the guess mostly like classic PCI, even if some of the individual
> devices on the bus are PCI Express.  One consequence of that is that
> virtio-pci devices still default to being in transitional mode, though
> legacy mode is now disabled by default on current q35 x86 machine
> types.

Two things to note here

x86 defaults to the i440fx  machine type, and so defaults
to transitional mode. AFAIK, only RHEL-8 downstream changed
x86 to defualt to q35

With q35 whether you get transitional mode or not is actually
dependent on where you place the device. If it is placed into
a PCIe root port, then it is modern-only. If it is placed into
a PCI bridge, then it is transitional still.

> Legacy mode virtio devices aren't really necessary any more, and are

Legacy mode is required for RHEL-6 which has not reached EOL yet.

> causing some problems for future changes.  Therefore, for the
> pseries-5.0 machine type (and onwards), switch to modern-only
> virtio-pci devices by default.


The challenge I see with pseries, as compared to x86 is around
how apps deal with mgmt / guest setup.  With x86 there are
distinct machine types i440fx / q35, so mgmt apps could decide
what todo based on the chipset & device support. eg they can
determine whether the guest supports PCIe at all, and they
can determine whether the guest supports virtio-1.0. Thus
they can decide between three options

 - Use i440fx
 - Use q35 with placement in PCI bridge
 - Use q35 with placement in PCIe root port

These rules applies no matter what version of q35/i440fx
is in use.

With PPC, we're changing behaviour of the existing pseries
machine type in a minor version. Management apps need to
avoid creating logic that depends on a specific minor version
because these version numbers are all changed by downstream
distro vendors. IOW, as a comparison to x86, this change is
akin to altering behaviour of the i440fx machine type so
that it disables legacy mode despite still being PCI, and
not PCIe.

Is there any liklihood we'll ever introduce a true PCIe
based machine type for PPC, so we get something much
closer to x86/aarch64 machine types in terms of PCIe
architecture ?

> This does mean we no longer support guest kernels prior to 4.0, unless
> they have modern virtio support backported (which some distro kernels
> like that in RHEL7 do).
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2eb0d8f70d..3cfc98ac61 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -65,6 +65,7 @@
> =20
>  #include "hw/pci/pci.h"
>  #include "hw/scsi/scsi.h"
> +#include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-scsi.h"
>  #include "hw/virtio/vhost-scsi-common.h"
> =20
> @@ -4566,8 +4567,20 @@ static const TypeInfo spapr_machine_info =3D {
> =20
>  static void spapr_machine_latest_class_options(MachineClass *mc)
>  {
> +    /*
> +     * Most defaults for the latest behaviour are inherited from the
> +     * base class, but we need to override the (non ppc specific)
> +     * default behaviour for virtio.  We can't do that from the base
> +     * class since it doesn't have a compat_props.
> +     */
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> +    };
> +
>      mc->alias =3D "pseries";
>      mc->is_default =3D true;
> +
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
> =20
>  #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
> @@ -4607,6 +4620,9 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
>  static void spapr_machine_4_2_class_options(MachineClass *mc)
>  {
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +    static GlobalProperty compat[] =3D {
> +        { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
> +    };
> =20
>      spapr_machine_5_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len)=
;
> @@ -4614,6 +4630,7 @@ static void spapr_machine_4_2_class_options(Machine=
Class *mc)
>      smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
>      smc->rma_limit =3D 16 * GiB;
>      mc->nvdimm_supported =3D false;
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>  }
> =20
>  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
> --=20
> 2.24.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


