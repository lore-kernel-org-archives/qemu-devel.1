Received: from eggs.gnu.org ([2001:4830:134:3::10]:41440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fxq9D-00063X-3g
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fxq8f-0001Pq-C7
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:00:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fxq8f-0001OJ-21
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 04:59:45 -0400
Date: Thu, 6 Sep 2018 09:59:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180906085937.GA2639@work-vm>
References: <20180831172424.12029-1-marcandre.lureau@redhat.com>
	<20180831172424.12029-7-marcandre.lureau@redhat.com>
	<20180904084648.680c564b@redhat.com>
	<CAJ+F1CLDPQr04Khj-B4UXMzEV-Cu_J2e4S4j2c43NT-s3HwywQ@mail.gmail.com>
	<20180906095802.7dffbf1b@redhat.com>
	<CAJ+F1CJymU2J+5T2pHd=bC1FDnEQZxAAWKEt_E_fPnUjQRb_dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJymU2J+5T2pHd=bC1FDnEQZxAAWKEt_E_fPnUjQRb_dQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 6/6] tpm: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Sep 6, 2018 at 11:58 AM Igor Mammedov <imammedo@redhat.com> wro=
te:
> >
> > On Thu, 6 Sep 2018 07:50:09 +0400
> > Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> wrote:
> >
> > > Hi
> > >
> > > On Tue, Sep 4, 2018 at 10:47 AM Igor Mammedov <imammedo@redhat.com>=
 wrote:
> > > >
> > > > On Fri, 31 Aug 2018 19:24:24 +0200
> > > > Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> wrote:
> > > >
> > > > > This allows to pass the last failing test from the Windows HLK =
TPM 2.0
> > > > > TCG PPI 1.3 tests.
> > > > >
> > > > > The interface is described in the "TCG Platform Reset Attack
> > > > > Mitigation Specification", chapter 6 "ACPI _DSM Function". Acco=
rding
> > > > > to Laszlo, it's not so easy to implement in OVMF, he suggested =
to do
> > > > > it in qemu instead.
> > > > >
> > > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com=
>
> > > > > ---
> > > > >  hw/tpm/tpm_ppi.h     |  2 ++
> > > > >  hw/i386/acpi-build.c | 46 ++++++++++++++++++++++++++++++++++++=
++++++++
> > > > >  hw/tpm/tpm_crb.c     |  1 +
> > > > >  hw/tpm/tpm_ppi.c     | 23 ++++++++++++++++++++++
> > > > >  hw/tpm/tpm_tis.c     |  1 +
> > > > >  docs/specs/tpm.txt   |  2 ++
> > > > >  hw/tpm/trace-events  |  3 +++
> > > > >  7 files changed, 78 insertions(+)
> > > > >
> > > > > diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> > > > > index f6458bf87e..3239751e9f 100644
> > > > > --- a/hw/tpm/tpm_ppi.h
> > > > > +++ b/hw/tpm/tpm_ppi.h
> > > > > @@ -23,4 +23,6 @@ typedef struct TPMPPI {
> > > > >  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> > > > >                    hwaddr addr, Object *obj, Error **errp);
> > > > >
> > > > > +void tpm_ppi_reset(TPMPPI *tpmppi);
> > > > > +
> > > > >  #endif /* TPM_TPM_PPI_H */
> > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > > index c5e9a6e11d..2ab3e8fae7 100644
> > > > > --- a/hw/i386/acpi-build.c
> > > > > +++ b/hw/i386/acpi-build.c
> > > > > @@ -1824,6 +1824,13 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
> > > > >      pprq =3D aml_name("PPRQ");
> > > > >      pprm =3D aml_name("PPRM");
> > > > >
> > > > > +    aml_append(dev,
> > > > > +               aml_operation_region("TPP3", AML_SYSTEM_MEMORY,
> > > > > +                                    aml_int(TPM_PPI_ADDR_BASE =
+ 0x15a),
> > > > > +                                    0x1));
> > > > > +    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_=
PRESERVE);
> > > > > +    aml_append(field, aml_named_field("MOVV", 8));
> > > > > +    aml_append(dev, field);
> > > > >      /*
> > > > >       * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a=
 dynamic
> > > > >       * operation region inside of a method for getting FUNC[op=
].
> > > > > @@ -2166,7 +2173,46 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
> > > > >              aml_append(ifctx, aml_return(aml_buffer(1, zerobyt=
e)));
> > > > >          }
> > > > >          aml_append(method, ifctx);
> > > > > +
> > > > > +        ifctx =3D aml_if(
> > > > > +            aml_equal(uuid,
> > > > > +                      aml_touuid("376054ED-CC13-4675-901C-4756=
D7F2D45D")));
> > > > > +        {
> > > > > +            /* standard DSM query function */
> > > > > +            ifctx2 =3D aml_if(aml_equal(function, zero));
> > > > > +            {
> > > > > +                uint8_t byte_list[1] =3D { 0x03 };
> > > > > +                aml_append(ifctx2, aml_return(aml_buffer(1, by=
te_list)));
> > > > > +            }
> > > > > +            aml_append(ifctx, ifctx2);
> > > > > +
> > > > > +            /*
> > > > > +             * TCG Platform Reset Attack Mitigation Specificat=
ion 1.0 Ch.6
> > > > > +             *
> > > > > +             * Arg 2 (Integer): Function Index =3D 1
> > > > > +             * Arg 3 (Package): Arguments =3D Package: Type: I=
nteger
> > > > > +             *                  Operation Value of the Request
> > > > > +             * Returns: Type: Integer
> > > > > +             *          0: Success
> > > > > +             *          1: General Failure
> > > > > +             */
> > > > > +            ifctx2 =3D aml_if(aml_equal(function, one));
> > > > > +            {
> > > > > +                aml_append(ifctx2,
> > > > > +                           aml_store(aml_derefof(aml_index(arg=
uments, zero)),
> > > > > +                                     op));
> > > > > +                {
> > > > > +                    aml_append(ifctx2, aml_store(op, aml_name(=
"MOVV")));
> > > > > +
> > > > > +                    /* 0: success */
> > > > > +                    aml_append(ifctx2, aml_return(zero));
> > > > > +                }
> > > > > +            }
> > > > > +            aml_append(ifctx, ifctx2);
> > > > > +        }
> > > > > +        aml_append(method, ifctx);
> > > > >      }
> > > > > +
> > > > >      aml_append(dev, method);
> > > > >  }
> > > > >
> > > > > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > > > > index b243222fd6..48f6a716ad 100644
> > > > > --- a/hw/tpm/tpm_crb.c
> > > > > +++ b/hw/tpm/tpm_crb.c
> > > > > @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
> > > > >  {
> > > > >      CRBState *s =3D CRB(dev);
> > > > >
> > > > > +    tpm_ppi_reset(&s->ppi);
> > > > >      tpm_backend_reset(s->tpmbe);
> > > > >
> > > > >      memset(s->regs, 0, sizeof(s->regs));
> > > > > diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> > > > > index 8b46b9dd4b..ce43bc5729 100644
> > > > > --- a/hw/tpm/tpm_ppi.c
> > > > > +++ b/hw/tpm/tpm_ppi.c
> > > > > @@ -16,8 +16,30 @@
> > > > >  #include "qapi/error.h"
> > > > >  #include "cpu.h"
> > > > >  #include "sysemu/memory_mapping.h"
> > > > > +#include "sysemu/reset.h"
> > > > >  #include "migration/vmstate.h"
> > > > >  #include "tpm_ppi.h"
> > > > > +#include "trace.h"
> > > > > +
> > > > > +void tpm_ppi_reset(TPMPPI *tpmppi)
> > > > > +{
> > > >
> > > >
> > > > > +    char *ptr =3D memory_region_get_ram_ptr(&tpmppi->ram);
> > > > nvdimm seems to use cpu_physical_memory_read() to access guest
> > > > accessible memory, so question is what's difference?
> > >
> > > cpu_physical_memory_read() is higher level, doing dispatch on addre=
ss
> > > and length checks.
> > >
> > > This is a bit unnecessary, as ppi->buf could be accessed directly.
> > [...]
> > > > > +            memset(block->host_addr, 0,
> > > > > +                   block->target_end - block->target_start);
> > > > > +        }
> > my concern here is that if we directly touch guest memory here
> > we might get in trouble on migration without dirtying modified
> > ranges
>=20
> It is a read-only of one byte.
> by the time the reset handler is called, the memory must have been
> already migrated.

Looks like a write to me?
Also, don't forget that a guest reset can happen during a migration.

Dave

> >
> > PS:
> > feel free it ignore since I don't have a clue what I'm talking about =
:)
> >
> > > > > +        guest_phys_blocks_free(&guest_phys_blocks);
> > > > > +    }
> > > > > +}
> > > > >
> > > > >  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> > > > >                    hwaddr addr, Object *obj, Error **errp)
> > > > > @@ -27,5 +49,6 @@ bool tpm_ppi_init(TPMPPI *tpmppi, struct Memo=
ryRegion *m,
> > > > >      vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> > > > >
> > > > >      memory_region_add_subregion(m, addr, &tpmppi->ram);
> > > > > +
> > > > >      return true;
> > > > >  }
> > > > > diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> > > > > index 70432ffe8b..d9bfa956cc 100644
> > > > > --- a/hw/tpm/tpm_tis.c
> > > > > +++ b/hw/tpm/tpm_tis.c
> > > > > @@ -868,6 +868,7 @@ static void tpm_tis_reset(DeviceState *dev)
> > > > >      s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->b=
e_driver),
> > > > >                              TPM_TIS_BUFFER_MAX);
> > > > >
> > > > > +    tpm_ppi_reset(&s->ppi);
> > > > >      tpm_backend_reset(s->be_driver);
> > > > >
> > > > >      s->active_locty =3D TPM_TIS_NO_LOCALITY;
> > > > > diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> > > > > index 332c2ae597..ce9bda3c89 100644
> > > > > --- a/docs/specs/tpm.txt
> > > > > +++ b/docs/specs/tpm.txt
> > > > > @@ -121,6 +121,8 @@ layout:
> > > > >   +----------+--------+--------+-------------------------------=
------------+
> > > > >   | next_step|   0x1  |  0x159 | Operation to execute after reb=
oot by      |
> > > > >   |          |        |        | firmware. Used by firmware.   =
            |
> > > > > + +----------+--------+--------+-------------------------------=
------------+
> > > > > + | movv     |   0x1  |  0x15a | Memory overwrite variable     =
            |
> > > > >   +----------+--------+--------+-------------------------------=
------------+
> > > > >
> > > > >     The following values are supported for the 'func' field. Th=
ey correspond
> > > > > diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> > > > > index 25bee0cecf..920d32ad55 100644
> > > > > --- a/hw/tpm/trace-events
> > > > > +++ b/hw/tpm/trace-events
> > > > > @@ -51,3 +51,6 @@ tpm_tis_mmio_write_init_abort(void) "Initiati=
ng abort"
> > > > >  tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
> > > > >  tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "D=
ata to send to TPM: 0x%08x (size=3D%d)"
> > > > >  tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d=
, rw_offset =3D %u"
> > > > > +
> > > > > +# hw/tpm/tpm_ppi.c
> > > > > +tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
> > > >
> > > >
> > >
> > >
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
