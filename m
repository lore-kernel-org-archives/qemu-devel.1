Received: from eggs.gnu.org ([209.51.188.92]:54965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ggxpC-0004Wm-Bd
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 15:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ggxp9-0007Ki-Qc
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 15:18:10 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ggxp9-00078Y-MG
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 15:18:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id i7so5844056qtj.10
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 12:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20190108084039.9254-1-marcandre.lureau@redhat.com>
	<20190108084039.9254-7-marcandre.lureau@redhat.com>
	<8a2f71b4-fe55-2bf7-20db-85b17335b0de@linux.ibm.com>
In-Reply-To: <8a2f71b4-fe55-2bf7-20db-85b17335b0de@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 9 Jan 2019 00:17:51 +0400
Message-ID: <CAMxuvaxqRAywowErCU0oEmgg1nT+rVfE56uf3XtAY5LeM6re8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v14 6/6] tpm: clear RAM when "memory
 overwrite" requested
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?B?TWF0aGlldS1EYXVkw6ksIFBoaWxpcHBl?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Tue, Jan 8, 2019 at 11:25 PM Stefan Berger <stefanb@linux.ibm.com> wrote=
:
>
> On 1/8/19 3:40 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Note: the "Platform Reset Attack Mitigation" specification isn't
> > explicit about NVDIMM, since they could have different usages. It uses
> > the term "system memory" generally (and also "volatile memory RAM" in
> > its introduction). For initial support, I propose to consider
> > non-volatile memory as not being subject to the memory clear. There is
> > an on-going discussion in the TCG "pcclientwg" working group for
> > future revisions.
> >
> > CPU cache clearing is done unconditionally in edk2 since commit
> > d20ae95a13e851 (edk2-stable201811).
>
>
> I just tried to test the series(from level of virt-manager).
> Unfortunately this patch here seems to break QEMU...
>
>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/tpm/tpm_ppi.h    | 10 ++++++++++
> >   hw/tpm/tpm_crb.c    |  1 +
> >   hw/tpm/tpm_ppi.c    | 22 ++++++++++++++++++++++
> >   hw/tpm/tpm_tis.c    |  1 +
> >   hw/tpm/trace-events |  3 +++
> >   5 files changed, 37 insertions(+)
> >
> > diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> > index c5e555fe2c..d33ef27de6 100644
> > --- a/hw/tpm/tpm_ppi.h
> > +++ b/hw/tpm/tpm_ppi.h
> > @@ -33,4 +33,14 @@ typedef struct TPMPPI {
> >   void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> >                     hwaddr addr, Object *obj);
> >
> > +/**
> > + * tpm_ppi_reset:
> > + * @tpmppi: a TPMPPI
> > + *
> > + * Function to call on machine reset. It will check if the "Memory
> > + * overwrite" variable is set, and perform a memory clear on volatile
> > + * memory if requested.
> > + **/
> > +void tpm_ppi_reset(TPMPPI *tpmppi);
> > +
> >   #endif /* TPM_TPM_PPI_H */
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index 012ec686d4..663469bd20 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
> >   {
> >       CRBState *s =3D CRB(dev);
> >
> > +    tpm_ppi_reset(&s->ppi);
> >       tpm_backend_reset(s->tpmbe);
> >
> >       memset(s->regs, 0, sizeof(s->regs));
> > diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> > index cf17779c20..cd8205f212 100644
> > --- a/hw/tpm/tpm_ppi.c
> > +++ b/hw/tpm/tpm_ppi.c
> > @@ -16,8 +16,30 @@
> >   #include "qapi/error.h"
> >   #include "cpu.h"
> >   #include "sysemu/memory_mapping.h"
> > +#include "sysemu/reset.h"
> >   #include "migration/vmstate.h"
> >   #include "tpm_ppi.h"
> > +#include "trace.h"
> > +
> > +void tpm_ppi_reset(TPMPPI *tpmppi)
> > +{
> > +    if (tpmppi->buf[0x15a /* movv, docs/specs/tpm.txt */] & 0x1) {
>
> this has to be:
>
> if (tpmppi->buf && tpmppi->buf[0x15a ...])

Oh I see, if ppi is disabled (that is with older machines).. Sorry for
not noticing! This is imho a better fix:


diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 663469bd20..3087acc4ab 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -233,7 +233,9 @@ static void tpm_crb_reset(void *dev)
 {
     CRBState *s =3D CRB(dev);

-    tpm_ppi_reset(&s->ppi);
+    if (s->ppi_enabled) {
+        tpm_ppi_reset(&s->ppi);
+    }
     tpm_backend_reset(s->tpmbe);

     memset(s->regs, 0, sizeof(s->regs));
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 6a5511e042..fd6bb9b59a 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -872,7 +872,9 @@ static void tpm_tis_reset(DeviceState *dev)
     s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver),
                             TPM_TIS_BUFFER_MAX);

-    tpm_ppi_reset(&s->ppi);
+    if (s->ppi_enabled) {
+        tpm_ppi_reset(&s->ppi);
+    }
     tpm_backend_reset(s->be_driver);

     s->active_locty =3D TPM_TIS_NO_LOCALITY;


Philippe, do I retain your reviewed-by with this change?

Thanks
>
>
> > +        GuestPhysBlockList guest_phys_blocks;
> > +        GuestPhysBlock *block;
> > +
> > +        guest_phys_blocks_init(&guest_phys_blocks);
> > +        guest_phys_blocks_append(&guest_phys_blocks);
> > +        QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
> > +            trace_tpm_ppi_memset(block->host_addr,
> > +                                 block->target_end - block->target_sta=
rt);
> > +            memset(block->host_addr, 0,
> > +                   block->target_end - block->target_start);
> > +            memory_region_set_dirty(block->mr, 0,
> > +                                    block->target_end - block->target_=
start);
> > +        }
> > +        guest_phys_blocks_free(&guest_phys_blocks);
> > +    }
> > +}
> >
> >   void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> >                     hwaddr addr, Object *obj)
> > diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> > index 02d9d5c911..6a5511e042 100644
> > --- a/hw/tpm/tpm_tis.c
> > +++ b/hw/tpm/tpm_tis.c
> > @@ -872,6 +872,7 @@ static void tpm_tis_reset(DeviceState *dev)
> >       s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_drive=
r),
> >                               TPM_TIS_BUFFER_MAX);
> >
> > +    tpm_ppi_reset(&s->ppi);
> >       tpm_backend_reset(s->be_driver);
> >
> >       s->active_locty =3D TPM_TIS_NO_LOCALITY;
> > diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> > index 25bee0cecf..920d32ad55 100644
> > --- a/hw/tpm/trace-events
> > +++ b/hw/tpm/trace-events
> > @@ -51,3 +51,6 @@ tpm_tis_mmio_write_init_abort(void) "Initiating abort=
"
> >   tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
> >   tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to =
send to TPM: 0x%08x (size=3D%d)"
> >   tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_of=
fset =3D %u"
> > +
> > +# hw/tpm/tpm_ppi.c
> > +tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
>
>
