Received: from eggs.gnu.org ([2001:4830:134:3::10]:51669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0NCL-0003EZ-8w
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0NCI-0001oy-3q
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:37:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e0NCH-0001oF-Qs
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:37:26 -0400
Date: Fri, 6 Oct 2017 09:37:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171006093721.5abd84ef@nial.brq.redhat.com>
In-Reply-To: <d83f1682-840e-87b7-9e65-8b83af9d83b1@ilande.co.uk>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
	<1507211474-188400-34-git-send-email-imammedo@redhat.com>
	<d83f1682-840e-87b7-9e65-8b83af9d83b1@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 33/40] sparc: sparc: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, atar4qemu@gmail.com

On Thu, 5 Oct 2017 18:25:04 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 05/10/17 14:51, Igor Mammedov wrote:
>=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > CC: mark.cave-ayland@ilande.co.uk
> > CC: atar4qemu@gmail.com
> > ---
> >  hw/sparc/sun4m.c | 29 ++++++++++++-----------------
> >  1 file changed, 12 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> > index e1bdd48..68b2378 100644
> > --- a/hw/sparc/sun4m.c
> > +++ b/hw/sparc/sun4m.c
> > @@ -94,7 +94,6 @@ struct sun4m_hwdef {
> >      } vsimm[MAX_VSIMMS];
> >      hwaddr ecc_base;
> >      uint64_t max_mem;
> > -    const char * const default_cpu_model;
> >      uint32_t ecc_version;
> >      uint32_t iommu_version;
> >      uint16_t machine_id;
> > @@ -790,14 +789,14 @@ static const TypeInfo ram_info =3D {
> >      .class_init    =3D ram_class_init,
> >  };
> > =20
> > -static void cpu_devinit(const char *cpu_model, unsigned int id,
> > +static void cpu_devinit(const char *cpu_type, unsigned int id,
> >                          uint64_t prom_addr, qemu_irq **cpu_irqs)
> >  {
> >      CPUState *cs;
> >      SPARCCPU *cpu;
> >      CPUSPARCState *env;
> > =20
> > -    cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
> > +    cpu =3D SPARC_CPU(cpu_create(cpu_type));
> >      env =3D &cpu->env;
> > =20
> >      cpu_sparc_set_id(env, id);
> > @@ -820,7 +819,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef =
*hwdef,
> >                            MachineState *machine)
> >  {
> >      DeviceState *slavio_intctl;
> > -    const char *cpu_model =3D machine->cpu_model;
> >      unsigned int i;
> >      void *iommu, *espdma, *ledma, *nvram;
> >      qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_C=
PUS],
> > @@ -833,11 +831,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef=
 *hwdef,
> >      unsigned int num_vsimms;
> > =20
> >      /* init CPUs */
> > -    if (!cpu_model)
> > -        cpu_model =3D hwdef->default_cpu_model;
> > -
> >      for(i =3D 0; i < smp_cpus; i++) {
> > -        cpu_devinit(cpu_model, i, hwdef->slavio_base, &cpu_irqs[i]);
> > +        cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irq=
s[i]);
> >      }
> > =20
> >      for (i =3D smp_cpus; i < MAX_CPUS; i++)
> > @@ -1074,7 +1069,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] =
=3D {
> >          .machine_id =3D ss5_id,
> >          .iommu_version =3D 0x05000000,
> >          .max_mem =3D 0x10000000,
> > -        .default_cpu_model =3D "Fujitsu MB86904",
> >      },
> >      /* SS-10 */
> >      {
> > @@ -1100,7 +1094,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] =
=3D {
> >          .machine_id =3D ss10_id,
> >          .iommu_version =3D 0x03000000,
> >          .max_mem =3D 0xf00000000ULL,
> > -        .default_cpu_model =3D "TI SuperSparc II",
> >      },
> >      /* SS-600MP */
> >      {
> > @@ -1124,7 +1117,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] =
=3D {
> >          .machine_id =3D ss600mp_id,
> >          .iommu_version =3D 0x01000000,
> >          .max_mem =3D 0xf00000000ULL,
> > -        .default_cpu_model =3D "TI SuperSparc II",
> >      },
> >      /* SS-20 */
> >      {
> > @@ -1166,7 +1158,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] =
=3D {
> >          .machine_id =3D ss20_id,
> >          .iommu_version =3D 0x13000000,
> >          .max_mem =3D 0xf00000000ULL,
> > -        .default_cpu_model =3D "TI SuperSparc II",
> >      },
> >      /* Voyager */
> >      {
> > @@ -1190,7 +1181,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] =
=3D {
> >          .machine_id =3D vger_id,
> >          .iommu_version =3D 0x05000000,
> >          .max_mem =3D 0x10000000,
> > -        .default_cpu_model =3D "Fujitsu MB86904",
> >      },
> >      /* LX */
> >      {
> > @@ -1215,7 +1205,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] =
=3D {
> >          .machine_id =3D lx_id,
> >          .iommu_version =3D 0x04000000,
> >          .max_mem =3D 0x10000000,
> > -        .default_cpu_model =3D "TI MicroSparc I",
> >      },
> >      /* SS-4 */
> >      {
> > @@ -1240,7 +1229,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] =
=3D {
> >          .machine_id =3D ss4_id,
> >          .iommu_version =3D 0x05000000,
> >          .max_mem =3D 0x10000000,
> > -        .default_cpu_model =3D "Fujitsu MB86904",
> >      },
> >      /* SPARCClassic */
> >      {
> > @@ -1264,7 +1252,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] =
=3D {
> >          .machine_id =3D scls_id,
> >          .iommu_version =3D 0x05000000,
> >          .max_mem =3D 0x10000000,
> > -        .default_cpu_model =3D "TI MicroSparc I",
> >      },
> >      /* SPARCbook */
> >      {
> > @@ -1288,7 +1275,6 @@ static const struct sun4m_hwdef sun4m_hwdefs[] =
=3D {
> >          .machine_id =3D sbook_id,
> >          .iommu_version =3D 0x05000000,
> >          .max_mem =3D 0x10000000,
> > -        .default_cpu_model =3D "TI MicroSparc I",
> >      },
> >  };
> > =20
> > @@ -1355,6 +1341,7 @@ static void ss5_class_init(ObjectClass *oc, void =
*data)
> >      mc->block_default_type =3D IF_SCSI;
> >      mc->is_default =3D 1;
> >      mc->default_boot_order =3D "c";
> > +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
> >  }
> > =20
> >  static const TypeInfo ss5_type =3D {
> > @@ -1372,6 +1359,7 @@ static void ss10_class_init(ObjectClass *oc, void=
 *data)
> >      mc->block_default_type =3D IF_SCSI;
> >      mc->max_cpus =3D 4;
> >      mc->default_boot_order =3D "c";
> > +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
> >  }
> > =20
> >  static const TypeInfo ss10_type =3D {
> > @@ -1389,6 +1377,7 @@ static void ss600mp_class_init(ObjectClass *oc, v=
oid *data)
> >      mc->block_default_type =3D IF_SCSI;
> >      mc->max_cpus =3D 4;
> >      mc->default_boot_order =3D "c";
> > +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
> >  }
> > =20
> >  static const TypeInfo ss600mp_type =3D {
> > @@ -1406,6 +1395,7 @@ static void ss20_class_init(ObjectClass *oc, void=
 *data)
> >      mc->block_default_type =3D IF_SCSI;
> >      mc->max_cpus =3D 4;
> >      mc->default_boot_order =3D "c";
> > +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
> >  }
> > =20
> >  static const TypeInfo ss20_type =3D {
> > @@ -1422,6 +1412,7 @@ static void voyager_class_init(ObjectClass *oc, v=
oid *data)
> >      mc->init =3D vger_init;
> >      mc->block_default_type =3D IF_SCSI;
> >      mc->default_boot_order =3D "c";
> > +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
> >  }
> > =20
> >  static const TypeInfo voyager_type =3D {
> > @@ -1438,6 +1429,7 @@ static void ss_lx_class_init(ObjectClass *oc, voi=
d *data)
> >      mc->init =3D ss_lx_init;
> >      mc->block_default_type =3D IF_SCSI;
> >      mc->default_boot_order =3D "c";
> > +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
> >  }
> > =20
> >  static const TypeInfo ss_lx_type =3D {
> > @@ -1454,6 +1446,7 @@ static void ss4_class_init(ObjectClass *oc, void =
*data)
> >      mc->init =3D ss4_init;
> >      mc->block_default_type =3D IF_SCSI;
> >      mc->default_boot_order =3D "c";
> > +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
> >  }
> > =20
> >  static const TypeInfo ss4_type =3D {
> > @@ -1470,6 +1463,7 @@ static void scls_class_init(ObjectClass *oc, void=
 *data)
> >      mc->init =3D scls_init;
> >      mc->block_default_type =3D IF_SCSI;
> >      mc->default_boot_order =3D "c";
> > +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
> >  }
> > =20
> >  static const TypeInfo scls_type =3D {
> > @@ -1486,6 +1480,7 @@ static void sbook_class_init(ObjectClass *oc, voi=
d *data)
> >      mc->init =3D sbook_init;
> >      mc->block_default_type =3D IF_SCSI;
> >      mc->default_boot_order =3D "c";
> > +    mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
> >  }
> > =20
> >  static const TypeInfo sbook_type =3D { =20
>=20
> No objections to this patch but just to confirm from the previous
> discussion that the cpu type gets parsed in a way such that an existing
> -cpu "TI SuperSparc II" option gets mapped to the correct
> "TI-SuperSparc-II" type? Presumably this is now handled at a different
> level?
old way still works, see sparc_cpu_type_name()

call chain is
 vl.c:
   machine->cpu_type =3D cpu_parse_cpu_model()
                          -> sparc_cpu_class_by_name()
                               -> sparc_cpu_type_name()
  =20
>=20
>=20
> ATB,
>=20
> Mark.
>=20
