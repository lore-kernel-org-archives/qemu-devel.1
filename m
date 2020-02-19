Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DBFC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032AE20801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTokPMb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032AE20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PfW-00038P-2x
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Pea-0001fy-Mf
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4PeZ-0006eo-I2
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:44:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4PeZ-0006eO-Dz
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582119879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPAKdOmu4t6Po9MScP95tT5WsZMKIpOJreI48wCI/PM=;
 b=ZTokPMb0Y3NeBVGquYJEtVlAwtfvtzjrYfuJAWKa+BRcHcQq8ALGSmmBxpW958NkrOSZ+k
 qophYCvDpxqKhdVal9vaqX58tL51C2UZpcW3QZpdzHCKWAtB5yP5paZN3Hu9VAP/bjAunp
 ig1G0p19PP2zSol0PNE7Q4thT3999Ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-YJpPJmgPOf2bgT8g4AE5rg-1; Wed, 19 Feb 2020 08:44:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D9D8010E5
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 13:44:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C051196AE;
 Wed, 19 Feb 2020 13:44:32 +0000 (UTC)
Date: Wed, 19 Feb 2020 14:44:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v5 27/79] arm/palm: use memdev for RAM
Message-ID: <20200219144430.5151535f@redhat.com>
In-Reply-To: <e9302ce2-2d10-f3c5-25b6-6b9eee291192@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-28-imammedo@redhat.com>
 <e9302ce2-2d10-f3c5-25b6-6b9eee291192@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: YJpPJmgPOf2bgT8g4AE5rg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 18:22:06 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/17/20 6:34 PM, Igor Mammedov wrote:
> > memory_region_allocate_system_memory() API is going away, so
> > replace it with memdev allocated MemoryRegion. The later is
> > initialized by generic code, so board only needs to opt in
> > to memdev scheme by providing
> >    MachineClass::default_ram_id
> > and using MachineState::ram instead of manually initializing
> > RAM memory region.
> >=20
> > PS:
> >   while at it add check for user supplied RAM size and error
> >   out if it mismatches board expected value.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > ---
> > v2:
> >    * fix format string causing build failure on 32-bit host
> >      (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
> >=20
> > CC: balrogg@gmail.com
> > ---
> >   hw/arm/palm.c | 20 ++++++++++++++------
> >   1 file changed, 14 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/arm/palm.c b/hw/arm/palm.c
> > index 72eca8cc55..388b2629a5 100644
> > --- a/hw/arm/palm.c
> > +++ b/hw/arm/palm.c
> > @@ -31,6 +31,7 @@
> >   #include "hw/loader.h"
> >   #include "exec/address-spaces.h"
> >   #include "cpu.h"
> > +#include "qemu/cutils.h"
> >  =20
> >   static uint64_t static_read(void *opaque, hwaddr offset, unsigned siz=
e)
> >   {
> > @@ -181,7 +182,6 @@ static void palmte_gpio_setup(struct omap_mpu_state=
_s *cpu)
> >  =20
> >   static struct arm_boot_info palmte_binfo =3D {
> >       .loader_start =3D OMAP_EMIFF_BASE,
> > -    .ram_size =3D 0x02000000, =20
>=20
> Again, this is incorrect. Used by hw/arm/boot::do_cpu_reset().
Thanks,
fixed in v6

>=20
> >       .board_id =3D 0x331,
> >   };
> >  =20
> > @@ -195,15 +195,21 @@ static void palmte_init(MachineState *machine)
> >       static uint32_t cs2val =3D 0x0000e1a0;
> >       static uint32_t cs3val =3D 0xe1a0e1a0;
> >       int rom_size, rom_loaded =3D 0;
> > -    MemoryRegion *dram =3D g_new(MemoryRegion, 1);
> > +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >       MemoryRegion *flash =3D g_new(MemoryRegion, 1);
> >       MemoryRegion *cs =3D g_new(MemoryRegion, 4);
> >  =20
> > -    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
> > -                                         palmte_binfo.ram_size);
> > -    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE, dr=
am);
> > +    if (machine->ram_size !=3D mc->default_ram_size) {
> > +        char *sz =3D size_to_str(mc->default_ram_size);
> > +        error_report("Invalid RAM size, should be %s", sz);
> > +        g_free(sz);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +    memory_region_add_subregion(address_space_mem, OMAP_EMIFF_BASE,
> > +                                machine->ram);
> >  =20
> > -    mpu =3D omap310_mpu_init(dram, machine->cpu_type);
> > +    mpu =3D omap310_mpu_init(machine->ram, machine->cpu_type);
> >  =20
> >       /* External Flash (EMIFS) */
> >       memory_region_init_ram(flash, NULL, "palmte.flash", flash_size,
> > @@ -265,6 +271,8 @@ static void palmte_machine_init(MachineClass *mc)
> >       mc->init =3D palmte_init;
> >       mc->ignore_memory_transaction_failures =3D true;
> >       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
> > +    mc->default_ram_size =3D 0x02000000;
> > +    mc->default_ram_id =3D "omap1.dram";
> >   }
> >  =20
> >   DEFINE_MACHINE("cheetah", palmte_machine_init)
> >  =20
>=20


