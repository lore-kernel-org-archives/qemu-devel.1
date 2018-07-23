Received: from eggs.gnu.org ([2001:4830:134:3::10]:48411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhYhy-0001ch-Sm
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 07:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhYhu-0003ja-Pu
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 07:08:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fhYhu-0003g5-Iq
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 07:08:50 -0400
Date: Mon, 23 Jul 2018 13:08:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180723130845.1b372220@redhat.com>
In-Reply-To: <CAJ+F1CL6+jKAWJJ+mb7rC3d7+tOoXSf8aM-JhHOJMEO7GAz2BA@mail.gmail.com>
References: <20180716125948.11666-1-marcandre.lureau@redhat.com>
	<20180716125948.11666-6-marcandre.lureau@redhat.com>
	<20180717095727.7b63dcd0@redhat.com>
	<CAJ+F1CL6+jKAWJJ+mb7rC3d7+tOoXSf8aM-JhHOJMEO7GAz2BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 5/5] PoC: tpm: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 17 Jul 2018 17:39:12 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Tue, Jul 17, 2018 at 9:57 AM, Igor Mammedov <imammedo@redhat.com> wrot=
e:
> > On Mon, 16 Jul 2018 14:59:48 +0200
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > =20
> >> This allows to pass the last failing test from the Windows HLK TPM 2.0
> >> TCG PPI 1.3 tests.
> >>
> >> The interface is described in the "TCG Platform Reset Attack
> >> Mitigation Specification", chapter 6 "ACPI _DSM Function". According
> >> to Laszlo, it's not so easy to implement in OVMF, he suggested to do
> >> it in qemu instead. It is relatively simple to implement in QEMU, but
> >> make this a proof-of-concept PATCH for discussion, since this is not
> >> a conventional approach.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  hw/i386/acpi-build.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
> >>  hw/tpm/tpm_ppi.c     | 25 ++++++++++++++++++++++++
> >>  docs/specs/tpm.txt   |  2 ++
> >>  hw/tpm/trace-events  |  3 +++
> >>  4 files changed, 76 insertions(+)
> >>
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 882fc27846..7e3c217076 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -1824,6 +1824,13 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
> >>      pprq =3D aml_name("PPRQ");
> >>      pprm =3D aml_name("PPRM");
> >>
> >> +    aml_append(dev,
> >> +               aml_operation_region("TPP3", AML_SYSTEM_MEMORY,
> >> +                                    aml_int(TPM_PPI_ADDR_BASE + 0x200=
),
> >> +                                    0x1));
> >> +    field =3D aml_field("TPP3", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE=
); =20
> >                                  ^^^ AML_BYTE_ACC =20
>=20
> ok
>=20
>=20
> > =20
> >> +    aml_append(field, aml_named_field("MOVV", 8));
> >> +    aml_append(dev, field);
> >>      /*
> >>       * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dynamic
> >>       * operation region inside of a method for getting FUNC[op].
> >> @@ -2166,7 +2173,46 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
> >>              aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
> >>          }
> >>          aml_append(method, ifctx);
> >> +
> >> +        ifctx =3D aml_if(
> >> +            aml_equal(uuid,
> >> +                      aml_touuid("376054ED-CC13-4675-901C-4756D7F2D45=
D")));
> >> +        {
> >> +            /* standard DSM query function */
> >> +            ifctx2 =3D aml_if(aml_equal(function, zero));
> >> +            {
> >> +                uint8_t byte_list[1] =3D { 0x03 };
> >> +                aml_append(ifctx2, aml_return(aml_buffer(1, byte_list=
)));
> >> +            }
> >> +            aml_append(ifctx, ifctx2);
> >> +
> >> +            /*
> >> +             * TCG Platform Reset Attack Mitigation Specification 1.0=
 Ch.6
> >> +             *
> >> +             * Arg 2 (Integer): Function Index =3D 1
> >> +             * Arg 3 (Package): Arguments =3D Package: Type: Integer
> >> +             *                  Operation Value of the Request
> >> +             * Returns: Type: Integer
> >> +             *          0: Success
> >> +             *          1: General Failure
> >> +             */
> >> +            ifctx2 =3D aml_if(aml_equal(function, one));
> >> +            {
> >> +                aml_append(ifctx2,
> >> +                           aml_store(aml_derefof(aml_index(arguments,=
 zero)),
> >> +                                     op));
> >> +                {
> >> +                    aml_append(ifctx2, aml_store(op, aml_name("MOVV")=
));
> >> +
> >> +                    /* 0: success */
> >> +                    aml_append(ifctx2, aml_return(zero));
> >> +                }
> >> +            }
> >> +            aml_append(ifctx, ifctx2);
> >> +        }
> >> +        aml_append(method, ifctx);
> >>      }
> >> +
> >>      aml_append(dev, method);
> >>  }
> >>
> >> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> >> index 8b46b9dd4b..64e8d828e8 100644
> >> --- a/hw/tpm/tpm_ppi.c
> >> +++ b/hw/tpm/tpm_ppi.c
> >> @@ -16,8 +16,31 @@
> >>  #include "qapi/error.h"
> >>  #include "cpu.h"
> >>  #include "sysemu/memory_mapping.h"
> >> +#include "sysemu/reset.h"
> >>  #include "migration/vmstate.h"
> >>  #include "tpm_ppi.h"
> >> +#include "trace.h"
> >> +
> >> +static void tpm_ppi_reset(void *opaque)
> >> +{
> >> +    TPMPPI *tpmppi =3D opaque;
> >> +    char *ptr =3D memory_region_get_ram_ptr(&tpmppi->ram);
> >> +
> >> +    if (ptr[0x200] & 0x1) {
> >> +        GuestPhysBlockList guest_phys_blocks;
> >> +        GuestPhysBlock *block;
> >> +
> >> +        guest_phys_blocks_init(&guest_phys_blocks);
> >> +        guest_phys_blocks_append(&guest_phys_blocks);
> >> +        QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
> >> +            trace_tpm_ppi_memset(block->host_addr,
> >> +                             block->target_end - block->target_start);
> >> +            memset(block->host_addr, 0,
> >> +                   block->target_end - block->target_start);
> >> +        }
> >> +        guest_phys_blocks_free(&guest_phys_blocks);
> >> +    }
> >> +}
> >>
> >>  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> >>                    hwaddr addr, Object *obj, Error **errp)
> >> @@ -27,5 +50,7 @@ bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegio=
n *m,
> >>      vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> >>
> >>      memory_region_add_subregion(m, addr, &tpmppi->ram);
> >> +    qemu_register_reset(tpm_ppi_reset, tpmppi); =20
> > is it necessary,
> > shouldn't it be reset by bus initiated reset? =20
>=20
> There is no bus for CRB device (we could eventually move it to SYSBUS,
> but there was some complication with piix iirc).
>=20
> Other than that, the role for BusClass.reset() isn't so clear to me,
> but it seems to be linked with the same qemu reset handler.

I'd suggest to drop qemu_register_reset() here, export tpm_ppi_reset()
and call it explicitly from tpm_crb_reset() and tpm_tis_reset() if
ppi is enabled.


> >> +
> >>      return true;
> >>  }
> >> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> >> index 16b210c1f2..9c44384315 100644
> >> --- a/docs/specs/tpm.txt
> >> +++ b/docs/specs/tpm.txt
> >> @@ -121,6 +121,8 @@ layout:
> >>   +----------+--------+--------+--------------------------------------=
-----+
> >>   | next_step|   0x1  |  0x159 | Operation to execute after reboot by =
     |
> >>   |          |        |        | firmware. Used by firmware.          =
     |
> >> + +----------+--------+--------+--------------------------------------=
-----+
> >> + | movv     |   0x1  |  0x200 | Memory overwrite variable            =
     |
> >>   +----------+--------+--------+--------------------------------------=
-----+
> >>
> >>     The following values are supported for the 'func' field. They corr=
espond
> >> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> >> index 25bee0cecf..920d32ad55 100644
> >> --- a/hw/tpm/trace-events
> >> +++ b/hw/tpm/trace-events
> >> @@ -51,3 +51,6 @@ tpm_tis_mmio_write_init_abort(void) "Initiating abor=
t"
> >>  tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
> >>  tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to =
send to TPM: 0x%08x (size=3D%d)"
> >>  tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_of=
fset =3D %u"
> >> +
> >> +# hw/tpm/tpm_ppi.c
> >> +tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu" =20
> >
> > =20
>=20
>=20
>=20
