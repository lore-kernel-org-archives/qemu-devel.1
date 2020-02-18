Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17236C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BA42176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFpZxI1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BA42176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3xtC-0006x5-0v
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 03:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3xsU-0006B0-GE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3xsS-0003dO-DM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:05:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3xsS-0003Z5-74
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582013107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKEzw55XnwllSd00B0RXge+Uo4CIMNkh5vfhcxSGNyI=;
 b=bFpZxI1En+21AyEcNWPyZrv+7WI9HjV9tcD+9xeEJNzwrTurAZwgrPQaqwYu13C4BGvYo3
 M7aVlSzf8T2uVYWZ93NgwWzE8nzaApzoxAzMBtLfCEi8zj0ylAo57j8HqNKkyd/B0ANuQ8
 hxshL1IgW4CYdey39U9YB/O0xqQRrqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-hAjXrQ3NM8-VI0UbjkW_DA-1; Tue, 18 Feb 2020 03:05:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F53D1857343;
 Tue, 18 Feb 2020 08:05:04 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C65E690F6F;
 Tue, 18 Feb 2020 08:05:00 +0000 (UTC)
Date: Tue, 18 Feb 2020 09:04:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v5 17/79] arm/integratorcp: use memdev for RAM
Message-ID: <20200218090458.03469ba5@redhat.com>
In-Reply-To: <5e21adc1-a197-9d37-133c-ea510b9b9926@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-18-imammedo@redhat.com>
 <5e21adc1-a197-9d37-133c-ea510b9b9926@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: hAjXrQ3NM8-VI0UbjkW_DA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peter.chubb@nicta.com.au,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 07:55:14 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/17/20 6:33 PM, Igor Mammedov wrote:
> > memory_region_allocate_system_memory() API is going away, so
> > replace it with memdev allocated MemoryRegion. The later is
> > initialized by generic code, so board only needs to opt in
> > to memdev scheme by providing
> >    MachineClass::default_ram_id
> > and using MachineState::ram instead of manually initializing
> > RAM memory region.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > ---
> > CC: peter.chubb@nicta.com.au
> > ---
> >   hw/arm/integratorcp.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> > index 0cd94d9f09..cc845b8534 100644
> > --- a/hw/arm/integratorcp.c
> > +++ b/hw/arm/integratorcp.c
> > @@ -585,7 +585,6 @@ static void integratorcp_init(MachineState *machine=
)
> >       Object *cpuobj;
> >       ARMCPU *cpu;
> >       MemoryRegion *address_space_mem =3D get_system_memory();
> > -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> >       MemoryRegion *ram_alias =3D g_new(MemoryRegion, 1);
> >       qemu_irq pic[32];
> >       DeviceState *dev, *sic, *icp;
> > @@ -605,14 +604,13 @@ static void integratorcp_init(MachineState *machi=
ne)
> >  =20
> >       cpu =3D ARM_CPU(cpuobj);
> >  =20
> > -    memory_region_allocate_system_memory(ram, NULL, "integrator.ram",
> > -                                         ram_size);
> >       /* ??? On a real system the first 1Mb is mapped as SSRAM or boot =
flash.  */
> >       /* ??? RAM should repeat to fill physical memory space.  */
> >       /* SDRAM at address zero*/
> > -    memory_region_add_subregion(address_space_mem, 0, ram);
> > +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
> >       /* And again at address 0x80000000 */
> > -    memory_region_init_alias(ram_alias, NULL, "ram.alias", ram, 0, ram=
_size);
> > +    memory_region_init_alias(ram_alias, NULL, "ram.alias", machine->ra=
m,
> > +                             0, ram_size);
> >       memory_region_add_subregion(address_space_mem, 0x80000000, ram_al=
ias);
> >  =20
> >       dev =3D qdev_create(NULL, TYPE_INTEGRATOR_CM);
> > @@ -660,6 +658,7 @@ static void integratorcp_machine_init(MachineClass =
*mc)
> >       mc->init =3D integratorcp_init;
> >       mc->ignore_memory_transaction_failures =3D true;
> >       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
> > +    mc->default_ram_id =3D "integrator.ram";
> >   }
> >  =20
> >   DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
> >  =20
>=20
> Looking at integratorcm_realize() this machine seems to handle at most=20
> 512MiB.
>=20
I'll add a patch on top.


