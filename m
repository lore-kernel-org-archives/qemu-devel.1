Received: from eggs.gnu.org ([2001:4830:134:3::10]:33058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fpW9f-00020i-PC
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fpW9b-0006tx-E2
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:02:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fpW9b-0006tI-3P
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 06:02:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id u12-v6so16685480wrr.4
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 03:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180810153223.28409-1-marcandre.lureau@redhat.com>
	<20180810153223.28409-7-marcandre.lureau@redhat.com>
	<20180813110744.3d0ee400@redhat.com>
In-Reply-To: <20180813110744.3d0ee400@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Aug 2018 12:02:06 +0200
Message-ID: <CAJ+F1C+sCoJzOVGxmjKdTjPyk6EH7_vXZT7vdRPCiFrHQmtr7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 6/6] tpm: add ACPI memory clear interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi
On Mon, Aug 13, 2018 at 11:09 AM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Fri, 10 Aug 2018 17:32:23 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > This allows to pass the last failing test from the Windows HLK TPM 2.0
> > TCG PPI 1.3 tests.
> >
> > The interface is described in the "TCG Platform Reset Attack
> > Mitigation Specification", chapter 6 "ACPI _DSM Function". According
> > to Laszlo, it's not so easy to implement in OVMF, he suggested to do
> > it in qemu instead.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/tpm/tpm_ppi.h     |  2 ++
> >  hw/i386/acpi-build.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/tpm/tpm_crb.c     |  1 +
> >  hw/tpm/tpm_ppi.c     | 23 ++++++++++++++++++++++
> >  hw/tpm/tpm_tis.c     |  1 +
> >  docs/specs/tpm.txt   |  2 ++
> >  hw/tpm/trace-events  |  3 +++
> >  7 files changed, 78 insertions(+)
> >
> > diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> > index f6458bf87e..3239751e9f 100644
> > --- a/hw/tpm/tpm_ppi.h
> > +++ b/hw/tpm/tpm_ppi.h
> > @@ -23,4 +23,6 @@ typedef struct TPMPPI {
> >  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> >                    hwaddr addr, Object *obj, Error **errp);
> >
> > +void tpm_ppi_reset(TPMPPI *tpmppi);
> > +
> >  #endif /* TPM_TPM_PPI_H */
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index c5e9a6e11d..271c7240dc 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1824,6 +1824,13 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
> >      pprq =3D aml_name("PPRQ");
> >      pprm =3D aml_name("PPRM");
> >
> > +    aml_append(dev,
> > +               aml_operation_region("TPP3", AML_SYSTEM_MEMORY,
> > +                                    aml_int(TPM_PPI_ADDR_BASE + 0x200)=
,
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
> >
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index b243222fd6..48f6a716ad 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
> >  {
> >      CRBState *s =3D CRB(dev);
> >
> > +    tpm_ppi_reset(&s->ppi);
> >      tpm_backend_reset(s->tpmbe);
> >
> >      memset(s->regs, 0, sizeof(s->regs));
> > diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> > index 8b46b9dd4b..dbfe342ca2 100644
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
> > +    char *ptr =3D memory_region_get_ram_ptr(&tpmppi->ram);
> > +
> > +    if (ptr[0x200] & 0x1) {
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
> > +        }
> > +        guest_phys_blocks_free(&guest_phys_blocks);
> > +    }
> > +}
> >
> >  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> >                    hwaddr addr, Object *obj, Error **errp)
> > @@ -27,5 +49,6 @@ bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion=
 *m,
> >      vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> >
> >      memory_region_add_subregion(m, addr, &tpmppi->ram);
> > +
> >      return true;
> >  }
> > diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> > index 70432ffe8b..d9bfa956cc 100644
> > --- a/hw/tpm/tpm_tis.c
> > +++ b/hw/tpm/tpm_tis.c
> > @@ -868,6 +868,7 @@ static void tpm_tis_reset(DeviceState *dev)
> >      s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver=
),
> >                              TPM_TIS_BUFFER_MAX);
> >
> > +    tpm_ppi_reset(&s->ppi);
> >      tpm_backend_reset(s->be_driver);
> >
> >      s->active_locty =3D TPM_TIS_NO_LOCALITY;
> > diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> > index f3b7615161..54a3e1e4c5 100644
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
> > + | movv     |   0x1  |  0x200 | Memory overwrite variable             =
    |
> >   +----------+--------+--------+---------------------------------------=
----+
> why 0x200 and not 0x15a ?
>

I thought it would be better to leave some room for PPI, but that
probably doesn't help much. Let's move it to 0x15a.

> Btw why TPM_PPI_ADDR_SIZE is 0x400 and excess bytes aren't documented any=
where?

I guess for the same reason, Stefan wanted to have some room for
future changes. Is that a problem?

Stefan, can you confirm?
> >
> >     The following values are supported for the 'func' field. They corre=
spond
> > diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> > index 25bee0cecf..920d32ad55 100644
> > --- a/hw/tpm/trace-events
> > +++ b/hw/tpm/trace-events
> > @@ -51,3 +51,6 @@ tpm_tis_mmio_write_init_abort(void) "Initiating abort=
"
> >  tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
> >  tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to s=
end to TPM: 0x%08x (size=3D%d)"
> >  tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_off=
set =3D %u"
> > +
> > +# hw/tpm/tpm_ppi.c
> > +tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
>
>


--=20
Marc-Andr=C3=A9 Lureau
