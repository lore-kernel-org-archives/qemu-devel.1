Received: from eggs.gnu.org ([2001:4830:134:3::10]:43720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fxTwS-0000hs-IO
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fxTwO-00075P-HN
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:17:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fxTwO-00073w-Av
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 05:17:36 -0400
Date: Wed, 5 Sep 2018 11:17:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180905111724.2be38489@igors-macbook-pro.local>
In-Reply-To: <CAJ+F1CKaRhO8sGf51SHf1mrL=RA+NmCdtLdPcpMrcufp4wfB3w@mail.gmail.com>
References: <20180831172424.12029-1-marcandre.lureau@redhat.com>
	<20180831172424.12029-4-marcandre.lureau@redhat.com>
	<CAJ+F1CKEjAnQDtt2n0LOu4MKT94fqWnfjXUprp3vqYY=JghfsA@mail.gmail.com>
	<87musy1cdc.fsf@trasno.org> <20180904085152.685b47ab@redhat.com>
	<CAJ+F1CKaRhO8sGf51SHf1mrL=RA+NmCdtLdPcpMrcufp4wfB3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 3/6] tpm: allocate/map buffer for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, xiaoguangrong@tencent.com, QEMU <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 5 Sep 2018 12:21:39 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Tue, Sep 4, 2018 at 10:51 AM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Mon, 03 Sep 2018 23:48:15 +0200
> > Juan Quintela <quintela@redhat.com> wrote:
> >
> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > > > Hi
> > > >
> > > > On Fri, Aug 31, 2018 at 7:32 PM Marc-Andr=C3=A9 Lureau
> > > > <marcandre.lureau@redhat.com> wrote:
> > > >>
> > > >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > >>
> > > >> Implement a virtual memory device for the TPM Physical Presence in=
terface.
> > > >> The memory is located at 0xFED45000 and used by ACPI to send messa=
ges to the
> > > >> firmware (BIOS) and by the firmware to provide parameters for each=
 one of
> > > >> the supported codes.
> > > >>
> > > >> This interface should be used by all TPM devices on x86 and can be
> > > >> added by calling tpm_ppi_init_io().
> > > >>
> > > >> Note: bios_linker cannot be used to allocate the PPI memory region,
> > > >> since the reserved memory should stay stable across reboots, and m=
ight
> > > >> be needed before the ACPI tables are installed.
> > > >>
> > > >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > >> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > >
> > >
> > > ....
> > >
> > > >> + */
> > > >> +#define TPM_PPI_ADDR_SIZE           0x400
> > > >> +#define TPM_PPI_ADDR_BASE           0xFED45000
> > >
> > > > There is a (new) issue with the PPI ram region:
> > > >
> > > > READ of size 32 at 0x61d000090480 thread T6
> > > >     #0 0x5622bd8de0f4 in buffer_zero_avx2
> > > > /home/elmarco/src/qq/util/bufferiszero.c:169
> > > >     #1 0x5622bd8de899 in select_accel_fn
> > > > /home/elmarco/src/qq/util/bufferiszero.c:282
> > > >     #2 0x5622bd8de8f1 in buffer_is_zero
> > > > /home/elmarco/src/qq/util/bufferiszero.c:309
> > > >     #3 0x5622bc209f94 in is_zero_range /home/elmarco/src/qq/migrati=
on/ram.c:82
> > > >     #4 0x5622bc21938d in save_zero_page_to_file
> > > > /home/elmarco/src/qq/migration/ram.c:1694
> > > >     #5 0x5622bc219452 in save_zero_page
> > > > /home/elmarco/src/qq/migration/ram.c:1713
> > > >     #6 0x5622bc21db67 in ram_save_target_page
> > > > /home/elmarco/src/qq/migration/ram.c:2289
> > > >     #7 0x5622bc21e13e in ram_save_host_page
> > > > /home/elmarco/src/qq/migration/ram.c:2351
> > > >     #8 0x5622bc21ea3a in ram_find_and_save_block
> > > > /home/elmarco/src/qq/migration/ram.c:2413
> > > >     #9 0x5622bc223b5d in ram_save_iterate
> > > > /home/elmarco/src/qq/migration/ram.c:3193
> > > >     #10 0x5622bd16f544 in qemu_savevm_state_iterate
> > > > /home/elmarco/src/qq/migration/savevm.c:1103
> > > >     #11 0x5622bd157e75 in migration_iteration_run
> > > > /home/elmarco/src/qq/migration/migration.c:2897
> > > >     #12 0x5622bd15892e in migration_thread
> > > > /home/elmarco/src/qq/migration/migration.c:3018
> > > >     #13 0x5622bd902f31 in qemu_thread_start
> > > > /home/elmarco/src/qq/util/qemu-thread-posix.c:504
> > > >     #14 0x7f42f0ef4593 in start_thread (/lib64/libpthread.so.0+0x75=
93)
> > > >     #15 0x7f42f0c280de in clone (/lib64/libc.so.6+0xfa0de)
> > > > 0x61d000090490 is located 0 bytes to the right of 2064-byte region
> > > > [0x61d00008fc80,0x61d000090490)
> > > >
> > > > migration code is assuming RAM is multiple of TARGET_PAGE_SIZE.
> > >
> > > Physical RAM is multiple of TARGET_PAGE_SIZE O:-)
> > > That assumtion is held in too many places, if you can change the size=
 to
> > > be multiple of page size, that would be greate.
>=20
> It needs the RAMBlock to be a multiple of TARGET_PAGE_SIZE, but the
> memory region (in guest and qemu MemoryRegion) can be less. This is
> already the case with for ex, "/rom@etc/acpi/rsdp", which is 36 bytes.
RSDP is different in sense that it's not mapped to GPA


> I suppose 2 different MemoryRegions (backed by different RAMBlock)
> that would be placed on the same page (for ex, at offset 0x0, size
> 0x10 and offset 0x10, size 0x100) would work fine in general and with
> migration?
memory_region_add_subregion() maps whole region only,
theoretically you can make an alias region and map that but it would
be rather ugly.

>=20
> > >
> > > > Should the migration code be fixed, or should the TPM code allocate
> > > > ram differently?
> > >
> > > Migration people (i.e. me) would preffer that you fix the TPM
> > > allocation.  Or you can decide that this is *not* RAM.  The unit of
> > > transfer for migrate ram is ram pages, a.k.a. TARGET_PAGE_SIZE.
> > I'd loath to waste whole page in already cramped area.
> > Can we implement it as mmio region? (it will add some bolerplate code f=
or read/write
> > handlers/migration and cause vmexits on every read/write but it's not a=
 hot path so we might not care)
> >
>=20
>=20
> I have done some small adjustments to allow
> memory_region_init_ram_device_ptr() to work with a MemoryRegions size
> !=3D backed RAMBlock, and it seems to work fine (and doesn't need to
> allocate more space of guest memory range, or fall back to mmio)
>=20
> thanks
>=20
> > > > In all case, I think the migration code should either be fixed or h=
ave
> > > > an assert.
> > >
> > > An assert for sure.
> > >
> > > Fixed .... Do we have real devices that put ram regions that are smal=
ler
> > > than page size?
> > >
> > > Later, Juan.
> >
>=20
>=20
