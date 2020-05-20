Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9258BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD52207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNy7DXZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD52207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLeB-00041O-Jn
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbLd7-0002iC-Tx
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:07:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23602
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbLd6-0005kD-W2
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589969236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1k3dm+KKiRafwKbPJQxxBMwYJN1g4tlkXRegixO5elg=;
 b=aNy7DXZmuyhVG4MXjOoWp5G3nLRUf4UlOU07GVFAwiOjj0bBPxWSYHF1FHhZ9NngLKW3oQ
 4C8YFFLQv6uhA9FFKGH97KnhbdNlviTH1Okcc/LUvI3eT2h8Uoy4EWGbw2xA+OiGVrAhpl
 AaPNZIscyroIw5eeTFl2UOXXJlpW0lI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-5K7kK1FcMCyV75ykAKu__g-1; Wed, 20 May 2020 06:07:14 -0400
X-MC-Unique: 5K7kK1FcMCyV75ykAKu__g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC97B800688;
 Wed, 20 May 2020 10:07:13 +0000 (UTC)
Received: from nas.mammed.net (unknown [10.40.193.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8A5610013D9;
 Wed, 20 May 2020 10:07:12 +0000 (UTC)
Date: Wed, 20 May 2020 12:07:09 +0200
From: Igor Mammedow <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH] hw/sparc/sun4m: Use memdev backend for main RAM
Message-ID: <20200520120709.558a52ba@nas.mammed.net>
In-Reply-To: <58238d26-a9dc-0cc0-749d-6230d2646f75@amsat.org>
References: <20200510113505.10500-1-f4bug@amsat.org>
 <20200514120951.3588bc30@redhat.com>
 <58238d26-a9dc-0cc0-749d-6230d2646f75@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 14:13:11 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 5/14/20 12:09 PM, Igor Mammedov wrote:
> > On Sun, 10 May 2020 13:35:05 +0200
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> Since commit 82b911aaff3, machine_run_board_init() checks for
> >> ram_memdev_id and consume it. As TYPE_SUN4M_MEMORY is no more
> >> needed, replace it by the generic memdev allocated MemoryRegion
> >> and remove it. This completes commit b2554752b1da7c8f. =20
> >=20
> > I don't get justification here.
> > You are removing 'frontend' device model that has little/nothing
> > to do with how backend is instantiated.
> >=20
> > TYPE_SUN4M_MEMORY is analog to pc-dimm, only for builtin RAM
> > (not really useful but could serve as an example). =20
>=20
> I have no idea about the benefits of using memory frontend/backend
> with emulation. Is there documentation and examples? I'm seeing this
> code as a complicated way of doing a simple thing, but I guess I'm
> missing the big picture here.

Examples are pc-dimm and nv-dimm which thanks to separation easily
reusable across pc/spapr/virt-arm.

Having frontend is also useful for mgmt purposes, where HMP/QMP
just has to enumerate all RAM devices, otherwise boards would have
to provide a callback to describe their custom mappings.

But for embed boards with a single blob of RAM nailed down,
having frontend is probably overkill (at least ATM).
So I'm fine with this patch /with amended commit message/
>=20
> > It's fine to drop it as it doesn't accually do much
> > and map memory region directly like we do elsewhere for builtin RAM
> > and get rid of TYPE_SUN4M_MEMORY boiler-plate code.
> >=20
> > with such reasoning, I'd Ack it, but the final say belongs to board
> > maintainers
> >=20
> >  =20
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>   hw/sparc/sun4m.c | 54
> >> ++---------------------------------------------- 1 file changed, 2
> >> insertions(+), 52 deletions(-)
> >>
> >> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> >> index 36ee1a0a3d..9838c5a183 100644
> >> --- a/hw/sparc/sun4m.c
> >> +++ b/hw/sparc/sun4m.c
> >> @@ -772,50 +772,6 @@ static const TypeInfo prom_info =3D {
> >>       .class_init    =3D prom_class_init,
> >>   };
> >>  =20
> >> -#define TYPE_SUN4M_MEMORY "memory"
> >> -#define SUN4M_RAM(obj) OBJECT_CHECK(RamDevice, (obj),
> >> TYPE_SUN4M_MEMORY) -
> >> -typedef struct RamDevice {
> >> -    SysBusDevice parent_obj;
> >> -    HostMemoryBackend *memdev;
> >> -} RamDevice;
> >> -
> >> -/* System RAM */
> >> -static void ram_realize(DeviceState *dev, Error **errp)
> >> -{
> >> -    RamDevice *d =3D SUN4M_RAM(dev);
> >> -    MemoryRegion *ram =3D host_memory_backend_get_memory(d->memdev);
> >> -
> >> -    sysbus_init_mmio(SYS_BUS_DEVICE(dev), ram);
> >> -}
> >> -
> >> -static void ram_initfn(Object *obj)
> >> -{
> >> -    RamDevice *d =3D SUN4M_RAM(obj);
> >> -    object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
> >> -                             (Object **)&d->memdev,
> >> -                             object_property_allow_set_link,
> >> -                             OBJ_PROP_LINK_STRONG, &error_abort);
> >> -    object_property_set_description(obj, "memdev", "Set RAM
> >> backend"
> >> -                                    "Valid value is ID of a
> >> hostmem backend",
> >> -                                     &error_abort);
> >> -}
> >> -
> >> -static void ram_class_init(ObjectClass *klass, void *data)
> >> -{
> >> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> -
> >> -    dc->realize =3D ram_realize;
> >> -}
> >> -
> >> -static const TypeInfo ram_info =3D {
> >> -    .name          =3D TYPE_SUN4M_MEMORY,
> >> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> >> -    .instance_size =3D sizeof(RamDevice),
> >> -    .instance_init =3D ram_initfn,
> >> -    .class_init    =3D ram_class_init,
> >> -};
> >> -
> >>   static void cpu_devinit(const char *cpu_type, unsigned int id,
> >>                           uint64_t prom_addr, qemu_irq **cpu_irqs)
> >>   {
> >> @@ -858,8 +814,6 @@ static void sun4m_hw_init(const struct
> >> sun4m_hwdef *hwdef, SysBusDevice *s;
> >>       unsigned int smp_cpus =3D machine->smp.cpus;
> >>       unsigned int max_cpus =3D machine->smp.max_cpus;
> >> -    Object *ram_memdev =3D
> >> object_resolve_path_type(machine->ram_memdev_id,
> >> -
> >> TYPE_MEMORY_BACKEND, NULL);=20
> >>       if (machine->ram_size > hwdef->max_mem) {
> >>           error_report("Too much memory for this machine: %"
> >> PRId64 "," @@ -876,11 +830,8 @@ static void sun4m_hw_init(const
> >> struct sun4m_hwdef *hwdef, for (i =3D smp_cpus; i < MAX_CPUS; i++)
> >>           cpu_irqs[i] =3D qemu_allocate_irqs(dummy_cpu_set_irq,
> >> NULL, MAX_PILS);=20
> >> -    /* Create and map RAM frontend */
> >> -    dev =3D qdev_create(NULL, "memory");
> >> -    object_property_set_link(OBJECT(dev), ram_memdev, "memdev",
> >> &error_fatal);
> >> -    qdev_init_nofail(dev);
> >> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
> >> +    /* RAM */
> >> +    memory_region_add_subregion(get_system_memory(), 0,
> >> machine->ram);=20
> >>       /* models without ECC don't trap when missing ram is
> >> accessed */ if (!hwdef->ecc_base) {
> >> @@ -1575,7 +1526,6 @@ static void sun4m_register_types(void)
> >>       type_register_static(&idreg_info);
> >>       type_register_static(&afx_info);
> >>       type_register_static(&prom_info);
> >> -    type_register_static(&ram_info);
> >>  =20
> >>       type_register_static(&ss5_type);
> >>       type_register_static(&ss10_type); =20
> >=20
> >  =20
>=20


