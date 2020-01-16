Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C8AC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A026B206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RS2gN9Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A026B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7yp-0004s1-PT
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is7xx-000473-3N
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is7xt-0004jb-Tj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:25:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44468
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is7xt-0004jO-Ox
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579191949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EhsHqm/imxoNqOiOLpJxoFA1HHZ2MHAn1H7JMVO3YQ=;
 b=RS2gN9UmDw+GhLcMGMgHYcdHtRNrng5P6S+gADDSNJkieYeuMV2IRIDRZCNU2SRr7niJU4
 +upk6If2vlbwyxxf8owPrhnSpVAbS1g4k60pf9DYrQxo4+zDCWHiAR5WLMDEVqZHK4IODc
 cp3PD5c1Fu0MtigpvxFSg4ymkQI+Hws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-iWspuhREN96T5jifGkCXpg-1; Thu, 16 Jan 2020 11:25:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16193107ACCD;
 Thu, 16 Jan 2020 16:25:43 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21BAE60C84;
 Thu, 16 Jan 2020 16:25:39 +0000 (UTC)
Date: Thu, 16 Jan 2020 17:25:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 48/86] lm32:milkymist: use memdev for RAM
Message-ID: <20200116172538.681c9152@redhat.com>
In-Reply-To: <131b0631-7afd-8b1b-641c-2806248f704c@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-49-git-send-email-imammedo@redhat.com>
 <131b0631-7afd-8b1b-641c-2806248f704c@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iWspuhREN96T5jifGkCXpg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: michael@walle.cc, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 19:32:19 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/15/20 4:07 PM, Igor Mammedov wrote:
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
> > ---
> > v2:
> >    * fix format string causing build failure on 32-bit host
> >      (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
> >=20
> > CC: michael@walle.cc
> > ---
> >   hw/lm32/milkymist.c | 19 ++++++++++++-------
> >   1 file changed, 12 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> > index 460d322..73c28f4 100644
> > --- a/hw/lm32/milkymist.c
> > +++ b/hw/lm32/milkymist.c
> > @@ -82,6 +82,7 @@ static void main_cpu_reset(void *opaque)
> >   static void
> >   milkymist_init(MachineState *machine)
> >   {
> > +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >       const char *kernel_filename =3D machine->kernel_filename;
> >       const char *kernel_cmdline =3D machine->kernel_cmdline;
> >       const char *initrd_filename =3D machine->initrd_filename;
> > @@ -90,22 +91,26 @@ milkymist_init(MachineState *machine)
> >       int kernel_size;
> >       DriveInfo *dinfo;
> >       MemoryRegion *address_space_mem =3D get_system_memory();
> > -    MemoryRegion *phys_sdram =3D g_new(MemoryRegion, 1);
> >       qemu_irq irq[32];
> >       int i;
> >       char *bios_filename;
> >       ResetInfo *reset_info;
> >  =20
> > +    if (machine->ram_size !=3D mc->default_ram_size) {
> > +        error_report("Invalid RAM size, should be " RAM_ADDR_UFMT " By=
tes",
> > +                     mc->default_ram_size); =20
>=20
> I'd be displayed nicer using size_to_str(). Can be improved later.
I'll use it on respin, including similar places on other boards

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> >       /* memory map */
> >       hwaddr flash_base   =3D 0x00000000;
> >       size_t flash_sector_size        =3D 128 * KiB;
> >       size_t flash_size               =3D 32 * MiB;
> >       hwaddr sdram_base   =3D 0x40000000;
> > -    size_t sdram_size               =3D 128 * MiB;
> >  =20
> >       hwaddr initrd_base  =3D sdram_base + 0x1002000;
> >       hwaddr cmdline_base =3D sdram_base + 0x1000000;
> > -    size_t initrd_max =3D sdram_size - 0x1002000;
> > +    size_t initrd_max =3D machine->ram_size - 0x1002000;
> >  =20
> >       reset_info =3D g_malloc0(sizeof(ResetInfo));
> >  =20
> > @@ -116,9 +121,7 @@ milkymist_init(MachineState *machine)
> >  =20
> >       cpu_lm32_set_phys_msb_ignore(env, 1);
> >  =20
> > -    memory_region_allocate_system_memory(phys_sdram, NULL, "milkymist.=
sdram",
> > -                                         sdram_size);
> > -    memory_region_add_subregion(address_space_mem, sdram_base, phys_sd=
ram);
> > +    memory_region_add_subregion(address_space_mem, sdram_base, machine=
->ram);
> >  =20
> >       dinfo =3D drive_get(IF_PFLASH, 0, 0);
> >       /* Numonyx JS28F256J3F105 */
> > @@ -183,7 +186,7 @@ milkymist_init(MachineState *machine)
> >  =20
> >           if (kernel_size < 0) {
> >               kernel_size =3D load_image_targphys(kernel_filename, sdra=
m_base,
> > -                                              sdram_size);
> > +                                              machine->ram_size);
> >               reset_info->bootstrap_pc =3D sdram_base;
> >           }
> >  =20
> > @@ -216,6 +219,8 @@ static void milkymist_machine_init(MachineClass *mc=
)
> >       mc->init =3D milkymist_init;
> >       mc->is_default =3D 0;
> >       mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
> > +    mc->default_ram_size =3D 128 * MiB;
> > +    mc->default_ram_id =3D "milkymist.sdram";
> >   }
> >  =20
> >   DEFINE_MACHINE("milkymist", milkymist_machine_init)
> >  =20
>=20


