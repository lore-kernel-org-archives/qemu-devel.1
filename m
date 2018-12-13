Received: from eggs.gnu.org ([2001:4830:134:3::10]:58925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXPgZ-0004lO-4J
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gXPgW-0007KD-Bd
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:01:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gXPgV-0006tC-Ss
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:01:44 -0500
Date: Thu, 13 Dec 2018 13:01:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181213130130.40a31420@redhat.com>
In-Reply-To: <62b5734c-c23e-cfc2-701e-45692a7f1bd1@redhat.com>
References: <20180910083222.8245-1-marcandre.lureau@redhat.com>
	<20180910083222.8245-7-marcandre.lureau@redhat.com>
	<62b5734c-c23e-cfc2-701e-45692a7f1bd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 6/6] tpm: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 12 Dec 2018 17:22:21 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 9/10/18 10:32 AM, Marc-Andr=C3=A9 Lureau wrote:
> > This allows to pass the last failing test from the Windows HLK TPM 2.0
> > TCG PPI 1.3 tests.
> >=20
> > The interface is described in the "TCG Platform Reset Attack
> > Mitigation Specification", chapter 6 "ACPI _DSM Function". According
> > to Laszlo, it's not so easy to implement in OVMF, he suggested to do
> > it in qemu instead.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/tpm/tpm_ppi.h     |  2 ++
> >  hw/i386/acpi-build.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/tpm/tpm_crb.c     |  1 +
> >  hw/tpm/tpm_ppi.c     | 22 +++++++++++++++++++++
> >  hw/tpm/tpm_tis.c     |  1 +
> >  docs/specs/tpm.txt   |  2 ++
> >  hw/tpm/trace-events  |  3 +++
> >  7 files changed, 77 insertions(+)
> >=20
> > diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> > index c2ab2ed300..b8f67962c7 100644
> > --- a/hw/tpm/tpm_ppi.h
> > +++ b/hw/tpm/tpm_ppi.h
> > @@ -23,4 +23,6 @@ typedef struct TPMPPI {
> >  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> >                    hwaddr addr, Object *obj, Error **errp);
> >   =20
>=20
> Can you add documentation?
>=20
> > +void tpm_ppi_reset(TPMPPI *tpmppi);
> > +
> >  #endif /* TPM_TPM_PPI_H */
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index c5e9a6e11d..2ab3e8fae7 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1824,6 +1824,13 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
> >      pprq =3D aml_name("PPRQ");
> >      pprm =3D aml_name("PPRM");
> > =20
> > +    aml_append(dev,
> > +               aml_operation_region("TPP3", AML_SYSTEM_MEMORY,
> > +                                    aml_int(TPM_PPI_ADDR_BASE + 0x15a)=
, =20
>=20
> Can you add a definition for this magic value?
> Maybe:
>=20
> #define TPM_PPI_MEMORY_OVERWRITE_OFFSET 0x15a
>=20
> or
>=20
> #define TPM_PPI_MOVV_OFFSET 0x15a
I'd prefer explicit numeric values there as it's a bit easier to review
and grep in 'spec' since one doesn't have to jump to define definition
first to find out value to compare with spec.
What I'd add though is verbatim comment from spec like we do
in APCI code so we could jump to the field of interest in spec
just doing copy&paste&search

>=20
> > +                                    0x1));
> > +    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE=
);
> > +    aml_append(field, aml_named_field("MOVV", 8));
> > +    aml_append(dev, field);
> >      /*
> >       * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dynamic
> >       * operation region inside of a method for getting FUNC[op].
> > @@ -2166,7 +2173,46 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
> >              aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
> >          }
> >          aml_append(method, ifctx);
> > +
> > +        ifctx =3D aml_if(
> > +            aml_equal(uuid,
> > +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2D45D=
")));
> > +        {
> > +            /* standard DSM query function */
> > +            ifctx2 =3D aml_if(aml_equal(function, zero));
> > +            {
> > +                uint8_t byte_list[1] =3D { 0x03 };
> > +                aml_append(ifctx2, aml_return(aml_buffer(1, byte_list)=
));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /*
> > +             * TCG Platform Reset Attack Mitigation Specification 1.0 =
Ch.6
> > +             *
> > +             * Arg 2 (Integer): Function Index =3D 1
> > +             * Arg 3 (Package): Arguments =3D Package: Type: Integer
> > +             *                  Operation Value of the Request
> > +             * Returns: Type: Integer
> > +             *          0: Success
> > +             *          1: General Failure
> > +             */
> > +            ifctx2 =3D aml_if(aml_equal(function, one));
> > +            {
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_derefof(aml_index(arguments, =
zero)),
> > +                                     op));
> > +                {
> > +                    aml_append(ifctx2, aml_store(op, aml_name("MOVV"))=
);
> > +
> > +                    /* 0: success */
> > +                    aml_append(ifctx2, aml_return(zero));
> > +                }
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +        }
> > +        aml_append(method, ifctx);
> >      }
> > +
> >      aml_append(dev, method);
> >  }
> > =20
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index b243222fd6..48f6a716ad 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
> >  {
> >      CRBState *s =3D CRB(dev);
> > =20
> > +    tpm_ppi_reset(&s->ppi);
> >      tpm_backend_reset(s->tpmbe);
> > =20
> >      memset(s->regs, 0, sizeof(s->regs));
> > diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> > index f2f07f895e..ac05ba8d3c 100644
> > --- a/hw/tpm/tpm_ppi.c
> > +++ b/hw/tpm/tpm_ppi.c
> > @@ -16,8 +16,30 @@
> >  #include "qapi/error.h"
> >  #include "cpu.h"
> >  #include "sysemu/memory_mapping.h"
> > +#include "sysemu/reset.h"
> >  #include "migration/vmstate.h"
> >  #include "tpm_ppi.h"
> > +#include "trace.h"
> > +
> > +void tpm_ppi_reset(TPMPPI *tpmppi)
> > +{
> > +    if (tpmppi->buf[0x15a] & 0x1) { =20
>=20
> TPM_PPI_MOVV_OFFSET
>=20
> > +        GuestPhysBlockList guest_phys_blocks;
> > +        GuestPhysBlock *block;
> > +
> > +        guest_phys_blocks_init(&guest_phys_blocks);
> > +        guest_phys_blocks_append(&guest_phys_blocks);
> > +        QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
> > +            trace_tpm_ppi_memset(block->host_addr,
> > +                             block->target_end - block->target_start);
> > +            memset(block->host_addr, 0,
> > +                   block->target_end - block->target_start);
> > +            memory_region_set_dirty(block->mr, 0,
> > +                                    block->target_end - block->target_=
start);
> > +        }
> > +        guest_phys_blocks_free(&guest_phys_blocks);
> > +    }
> > +}
> > =20
> >  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> >                    hwaddr addr, Object *obj, Error **errp)
> > diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> > index 70432ffe8b..d9bfa956cc 100644
> > --- a/hw/tpm/tpm_tis.c
> > +++ b/hw/tpm/tpm_tis.c
> > @@ -868,6 +868,7 @@ static void tpm_tis_reset(DeviceState *dev)
> >      s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver=
),
> >                              TPM_TIS_BUFFER_MAX);
> > =20
> > +    tpm_ppi_reset(&s->ppi);
> >      tpm_backend_reset(s->be_driver);
> > =20
> >      s->active_locty =3D TPM_TIS_NO_LOCALITY;
> > diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> > index 332c2ae597..ce9bda3c89 100644
> > --- a/docs/specs/tpm.txt
> > +++ b/docs/specs/tpm.txt
> > @@ -121,6 +121,8 @@ layout:
> >   +----------+--------+--------+---------------------------------------=
----+
> >   | next_step|   0x1  |  0x159 | Operation to execute after reboot by  =
    |
> >   |          |        |        | firmware. Used by firmware.           =
    |
> > + +----------+--------+--------+---------------------------------------=
----+
> > + | movv     |   0x1  |  0x15a | Memory overwrite variable             =
    |
> >   +----------+--------+--------+---------------------------------------=
----+
> > =20
> >     The following values are supported for the 'func' field. They corre=
spond
> > diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> > index 25bee0cecf..920d32ad55 100644
> > --- a/hw/tpm/trace-events
> > +++ b/hw/tpm/trace-events
> > @@ -51,3 +51,6 @@ tpm_tis_mmio_write_init_abort(void) "Initiating abort"
> >  tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
> >  tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to s=
end to TPM: 0x%08x (size=3D%d)"
> >  tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_off=
set =3D %u"
> > +
> > +# hw/tpm/tpm_ppi.c
> > +tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
> >  =20
>=20
> I'd split this patch in 2: Add ACPI, Add tpm_ppi_reset.
