Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2303CC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25022468B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMmZdxeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25022468B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcgi-00048b-VZ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBcfo-0003bp-NL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBcfn-0005pN-7I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:03:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBcfn-0005lY-1q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583838222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lPHHuP9YQ5m1/9ytGCAtLKrt2mrrZIT0v9wyKgI7ogM=;
 b=NMmZdxeNhgADRvt8E+ZkMMVfu08CaydqZFlgVX5z4sQ9hUSo4fpbniRHDNe6DRGSp3I/hW
 qlVOzG1DYcTjt1tMS4dgWOQLQ9HtImJOWIVZGINODiuCCpQiM+tCqcgIWp5CPI8KEwc9FM
 aA6QXRVqXsTnVi5jcx5JqX1PLtfVnHI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-mu3SU0gWNumxpGZSf92Lxg-1; Tue, 10 Mar 2020 07:03:40 -0400
X-MC-Unique: mu3SU0gWNumxpGZSf92Lxg-1
Received: by mail-qk1-f199.google.com with SMTP id w6so9423621qki.13
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 04:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kVrCt/L4fiBSkh5RbnMXyLRdq9W6GrwG46UYFZA7nBo=;
 b=Vkr0H/OOmfWKHKdPM3HcQe9B05hMGaV9PABqq25xnuYA3NOucMbl98kE9uX/9Uh1LL
 TK1BxkQpjO1ELcXcMJ1tFY6S1dbKgaGG6E+wUopvZZzGaH8MJFsTwp5xJzyChhNNVv5J
 DuCKuiGiV6FKLW0NYU4DaaudnHPihefUB/zUK3+Xvqb3ita6DzPyBoXnxXPnTuIeY0Vp
 qY9kDMLlnE5nYF8EGxZNVbWt9SXVtsQfJXP1VpUbtDg4SyOBEZkU6QiHwnuzG63J61AE
 ejbqMjhutQqrOHDXJytP+IoYuV5hwdDvL029cttOImU1e70cSwSC0JzDm7hyJPmbSd8f
 c1CQ==
X-Gm-Message-State: ANhLgQ1eaRTaJAfIjybxVpBWE+KHMw4Z387NGJpPF5ziHTA/fyEu3jLW
 dnFN/XbPPh0q7DV6yK2g5P52p4RlWTMhTMCh/5u4BPF6vPGO0K9Kdx+wxReHVvK+JWeTwuixrqL
 edeaYJCHbe7QRIfs=
X-Received: by 2002:ac8:6f0f:: with SMTP id g15mr18368940qtv.255.1583838220021; 
 Tue, 10 Mar 2020 04:03:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuHVMJpHyQyRDRtdx/K5Fqg7CoqohI+bsTRjSeu/nAODy0ioAF3QQHzRCkwOSo82q4StJJ5tw==
X-Received: by 2002:ac8:6f0f:: with SMTP id g15mr18368919qtv.255.1583838219692; 
 Tue, 10 Mar 2020 04:03:39 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id w21sm2164895qkf.60.2020.03.10.04.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 04:03:38 -0700 (PDT)
Date: Tue, 10 Mar 2020 07:03:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 1/2] spapr: Disable legacy virtio devices for
 pseries-5.0 and later
Message-ID: <20200310065901-mutt-send-email-mst@kernel.org>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200305043009.611636-2-david@gibson.dropbear.id.au>
 <20200305113146.6850f04b@bahia.home>
 <20200310104329.3dd232d2@bahia.home>
MIME-Version: 1.0
In-Reply-To: <20200310104329.3dd232d2@bahia.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pair@us.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, paulus@samba.org,
 clg@kaod.org, mdroth@us.ibm.com, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 10:43:29AM +0100, Greg Kurz wrote:
> On Thu, 5 Mar 2020 11:31:46 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Thu,  5 Mar 2020 15:30:08 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > PAPR specifies a kind of odd, paravirtualized PCI bus, which looks to
> > > the guess mostly like classic PCI, even if some of the individual
> > > devices on the bus are PCI Express.  One consequence of that is that
> > > virtio-pci devices still default to being in transitional mode, thoug=
h
> > > legacy mode is now disabled by default on current q35 x86 machine
> > > types.
> > >=20
> > > Legacy mode virtio devices aren't really necessary any more, and are
> > > causing some problems for future changes.  Therefore, for the
> > > pseries-5.0 machine type (and onwards), switch to modern-only
> > > virtio-pci devices by default.
> > >=20
> > > This does mean we no longer support guest kernels prior to 4.0, unles=
s
> > > they have modern virtio support backported (which some distro kernels
> > > like that in RHEL7 do).
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > FWIW, I could test the following:
> > - allows a RHEL7 guest with pre 4.0 kernel to boot, as mentioned
> >   in the changelog
> > - breaks boot of older RHEL 6.10 guests as expected
> > - allows migration of older machine types to/from QEMU 4.2
> >=20
> > Tested-by: Greg Kurz <groug@kaod.org>
> >=20
>=20
> Wait... I gave a try to virtiofsd and there's a problem:
>=20
> $ ./ppc64-softmmu/qemu-system-ppc64 -device vhost-user-fs-pci
> Unexpected error in object_property_find() at /home/greg/Work/qemu/qemu-p=
pc/qom/object.c:1231:
> qemu-system-ppc64: -device vhost-user-fs-pci: can't apply global virtio-p=
ci.disable-legacy=3Don: Property '.disable-legacy' not found
> Aborted (core dumped)
>=20
> It is still not possible to set the disable-legacy prop on the
> vhost-user-fs-pci device, even without this patch, but QEMU
> doesn't abort:
>=20
> $ ./ppc64-softmmu/qemu-system-ppc64 -device vhost-user-fs-pci -global vir=
tio-pci.disable-legacy=3Don
> qemu-system-ppc64: -device vhost-user-fs-pci: can't apply global virtio-p=
ci.disable-legacy=3Don: Property '.disable-legacy' not found
> $
>=20
> It seems to be related to the fact that vhost-user-fs-pci is a non-transi=
tional
> only device, as shown with this workaround:
>=20
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4574,7 +4574,7 @@ static void spapr_machine_latest_class_options(Mach=
ineClass *mc)
>       * class since it doesn't have a compat_props.
>       */
>      static GlobalProperty compat[] =3D {
> -        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> +        { TYPE_VIRTIO_PCI "-transitional", "disable-legacy", "on", },
>      };
> =20
>      mc->alias =3D "pseries";

Does this actually help? There's no type virtio-pci-transitional, is
there?

>=20
> but there's probably a better way to address this.
>=20
> MST, Any suggestion ?

Hmm I'm not sure how to fix this properly. The only idea that comes
to mind is a new internal-only "x-disable-legacy" that would be on virtio-p=
ci,
duplicating functionality of disable-legacy but intended for
globals like this.



> > >  hw/ppc/spapr.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 2eb0d8f70d..3cfc98ac61 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -65,6 +65,7 @@
> > > =20
> > >  #include "hw/pci/pci.h"
> > >  #include "hw/scsi/scsi.h"
> > > +#include "hw/virtio/virtio-pci.h"
> > >  #include "hw/virtio/virtio-scsi.h"
> > >  #include "hw/virtio/vhost-scsi-common.h"
> > > =20
> > > @@ -4566,8 +4567,20 @@ static const TypeInfo spapr_machine_info =3D {
> > > =20
> > >  static void spapr_machine_latest_class_options(MachineClass *mc)
> > >  {
> > > +    /*
> > > +     * Most defaults for the latest behaviour are inherited from the
> > > +     * base class, but we need to override the (non ppc specific)
> > > +     * default behaviour for virtio.  We can't do that from the base
> > > +     * class since it doesn't have a compat_props.
> > > +     */
> > > +    static GlobalProperty compat[] =3D {
> > > +        { TYPE_VIRTIO_PCI, "disable-legacy", "on", },
> > > +    };
> > > +
> > >      mc->alias =3D "pseries";
> > >      mc->is_default =3D true;
> > > +
> > > +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat))=
;
> > >  }
> > > =20
> > >  #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                =
 \
> > > @@ -4607,6 +4620,9 @@ DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
> > >  static void spapr_machine_4_2_class_options(MachineClass *mc)
> > >  {
> > >      SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > > +    static GlobalProperty compat[] =3D {
> > > +        { TYPE_VIRTIO_PCI, "disable-legacy", "auto" },
> > > +    };
> > > =20
> > >      spapr_machine_5_0_class_options(mc);
> > >      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_=
len);
> > > @@ -4614,6 +4630,7 @@ static void spapr_machine_4_2_class_options(Mac=
hineClass *mc)
> > >      smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> > >      smc->rma_limit =3D 16 * GiB;
> > >      mc->nvdimm_supported =3D false;
> > > +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat))=
;
> > >  }
> > > =20
> > >  DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
> >=20


