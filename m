Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D5C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462C224658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 18:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dz7HyVND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462C224658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irRF8-0000oG-GB
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 13:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1irREF-0008U1-Er
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1irRED-00011P-Th
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:47:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1irRED-00010T-QN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 13:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579027669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvQEIXLaRxvX1IYXxyQ5xbRIKamA7hXI6GXdxDyJkUs=;
 b=dz7HyVNDsJv4YvJKr1xinEdDzseJykV8nVSei522sOWaP9GToJ3Cp0YwhlESsqxrO7JpME
 flN7/SUc+KPKcfezPb65BNsPsUNegXanIrKmRS3FgDPVb3X0YUw29gvodOD+0p/Nhr/eSZ
 klUGedZ1cQCmdW62bJH50XJkrdbHe8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-MoIa4zmgNpOGX7vixbrR0A-1; Tue, 14 Jan 2020 13:47:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA5A610054E3;
 Tue, 14 Jan 2020 18:47:44 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93F9560C18;
 Tue, 14 Jan 2020 18:47:42 +0000 (UTC)
Date: Tue, 14 Jan 2020 11:47:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/vfio: Move the IGD quirk code to a separate file
Message-ID: <20200114114741.1eb6bfd8@w520.home>
In-Reply-To: <c82afcab-8f0b-d6ed-af40-0611b178f910@redhat.com>
References: <20200114161757.28831-1-thuth@redhat.com>
 <c82afcab-8f0b-d6ed-af40-0611b178f910@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: MoIa4zmgNpOGX7vixbrR0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 18:10:26 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/14/20 5:17 PM, Thomas Huth wrote:
> > The IGD quirk code defines a separate device, the so-called
> > "vfio-pci-igd-lpc-bridge" which shows up as a user-creatable
> > device in all QEMU binaries that include the vfio code. This
> > is a little bit unfortunate for two reasons: First, this device
> > is completely useless in binaries like qemu-system-s390x.
> > Second we also would like to disable it in downstream RHEL
> > which currently requires some extra patches there since the
> > device does not have a proper Kconfig-style switch yet.
> >=20
> > So it would be good if the device could be disabled more easily,
> > thus let's move the code to a separate file instead and introduce
> > a proper Kconfig switch for it which gets only enabled by default
> > if we also have CONFIG_PC_PCI enabled.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   hw/vfio/Kconfig       |   5 +
> >   hw/vfio/Makefile.objs |   1 +
> >   hw/vfio/igd.c         | 616 +++++++++++++++++++++++++++++++++++++++++=
+
> >   hw/vfio/pci-quirks.c  | 614 +----------------------------------------
> >   hw/vfio/pci.h         |  17 ++
> >   5 files changed, 642 insertions(+), 611 deletions(-)
> >   create mode 100644 hw/vfio/igd.c
> >=20
> > diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
> > index f0eaa75ce7..7cdba0560a 100644
> > --- a/hw/vfio/Kconfig
> > +++ b/hw/vfio/Kconfig
> > @@ -36,3 +36,8 @@ config VFIO_AP
> >       default y
> >       select VFIO
> >       depends on LINUX && S390_CCW_VIRTIO
> > +
> > +config VFIO_IGD
> > +    bool
> > +    default y if PC_PCI =20
>=20
> With the details from Alex here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg663667.html
>=20
> I'm tempted to use:
>=20
>      default y if XEN
>      depends on PC_PCI

I think you might be confused, there are two separate LPC bridges in
QEMU for IGD support, one specifically for Xen and this one
specifically for VFIO.  This one is never used in a Xen environment.
Thanks,

Alex

> Watch out the Xen Kconfig seems fragile, yesterday using --enable-xen=20
> --disable-tcg I hit this build error:
>=20
>    LINK    i386-softmmu/qemu-system-i386
> /usr/bin/ld: hw/xen/xen_pt.o: in function=20
> `xen_igd_passthrough_isa_bridge_create':
> /home/phil/source/qemu/hw/xen/xen_pt.c:701: undefined reference to=20
> `igd_passthrough_isa_bridge_create'
>=20
> > +    depends on VFIO_PCI
> > diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> > index abad8b818c..9bb1c09e84 100644
> > --- a/hw/vfio/Makefile.objs
> > +++ b/hw/vfio/Makefile.objs
> > @@ -5,3 +5,4 @@ obj-$(CONFIG_VFIO_PLATFORM) +=3D platform.o
> >   obj-$(CONFIG_VFIO_XGMAC) +=3D calxeda-xgmac.o
> >   obj-$(CONFIG_VFIO_AMD_XGBE) +=3D amd-xgbe.o
> >   obj-$(CONFIG_VFIO_AP) +=3D ap.o
> > +obj-$(CONFIG_VFIO_IGD) +=3D igd.o =20
>=20


