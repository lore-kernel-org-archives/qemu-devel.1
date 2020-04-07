Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3134CC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BA120644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Msz4zGqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BA120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLlKk-0006JB-4N
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jLlJM-0005b8-Ff
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jLlJL-0001o0-AA
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:18:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45194
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jLlJL-0001ng-70
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586254706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/58glWXsnypaeHyXpkDOVffEGWSf7HWNdf0XgaNnDk=;
 b=Msz4zGqpRIWNIJHz5YXfoof0T186/lmdsvSan5FwT5CNY9r6vQlqfUWLSzmCwrJQBJUae/
 jC5hO/csxJrCdiPOzMefvq6uVK4Qkvgx6KkrMUW9T4R3Q6gLcRWL0gzoX8iKYeuXLLvPl5
 4AcPDTsDUQBNISysvv5kl94uhT7K1j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-r-KMTc7sOECE_N2-juvYRA-1; Tue, 07 Apr 2020 06:18:23 -0400
X-MC-Unique: r-KMTc7sOECE_N2-juvYRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 263301005509;
 Tue,  7 Apr 2020 10:18:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D02FE7E303;
 Tue,  7 Apr 2020 10:18:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EEA341750A; Tue,  7 Apr 2020 12:18:14 +0200 (CEST)
Date: Tue, 7 Apr 2020 12:18:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 06/12] acpi: add ISADeviceClass->build_aml()
Message-ID: <20200407101814.scashwicosp3rhg7@sirius.home.kraxel.org>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-7-kraxel@redhat.com>
 <20200406122231.2bb67a7a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200406122231.2bb67a7a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 06, 2020 at 12:22:31PM +0200, Igor Mammedov wrote:
> On Fri,  3 Apr 2020 10:04:56 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> > Also add isa_aml_build() function which walks all isa devices.
> > This allows to move aml builder code to isa devices.
> >=20
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/hw/isa/isa.h |  2 ++
> >  hw/i386/acpi-build.c |  1 +
> >  hw/isa/isa-bus.c     | 15 +++++++++++++++
> >  3 files changed, 18 insertions(+)
> >=20
> > diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> > index e9ac1f1205a4..1534f8826453 100644
> > --- a/include/hw/isa/isa.h
> > +++ b/include/hw/isa/isa.h
> > @@ -70,6 +70,7 @@ typedef struct IsaDmaClass {
> > =20
> >  typedef struct ISADeviceClass {
> >      DeviceClass parent_class;
> > +    void (*build_aml)(ISADevice *dev, Aml *scope);
> >  } ISADeviceClass;
> > =20
> >  struct ISABus {
> > @@ -108,6 +109,7 @@ ISADevice *isa_try_create(ISABus *bus, const char *=
name);
> >  ISADevice *isa_create_simple(ISABus *bus, const char *name);
> > =20
> >  ISADevice *isa_vga_init(ISABus *bus);
> > +void isa_build_aml(ISABus *bus, Aml *scope);
> > =20
> >  /**
> >   * isa_register_ioport: Install an I/O port region on the ISA bus.
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 5d2b9b099684..77fc9df74735 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1259,6 +1259,7 @@ static void build_isa_devices_aml(Aml *table)
> >          error_report("No ISA bus, unable to define IPMI ACPI data");
> >      } else {
> >          build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
> > +        isa_build_aml(ISA_BUS(obj), scope);
>=20
> is it possible to have more than 1 ISA bus on pc/q35 machine?

I don't think this is possible on the x86 architecture due to the way
io ports are addressed.  I think you can have multiple isa busses on
architectures where the isa io address space is just a mmio window on
the isa bridge.  Dunno whenever such machines actually exist in
practice.

I think we can safely compress the whole thing into "assert(obj &&
!ambiguous)".

take care,
  Gerd


