Received: from eggs.gnu.org ([2001:4830:134:3::10]:46490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fx5C1-0006G0-Kc
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 02:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fx5Bu-0000vV-SV
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 02:52:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44468 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fx5Bu-0000ux-IU
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 02:51:58 -0400
Date: Tue, 4 Sep 2018 08:51:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180904085152.685b47ab@redhat.com>
In-Reply-To: <87musy1cdc.fsf@trasno.org>
References: <20180831172424.12029-1-marcandre.lureau@redhat.com>
	<20180831172424.12029-4-marcandre.lureau@redhat.com>
	<CAJ+F1CKEjAnQDtt2n0LOu4MKT94fqWnfjXUprp3vqYY=JghfsA@mail.gmail.com>
	<87musy1cdc.fsf@trasno.org>
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
To: Juan Quintela <quintela@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, xiaoguangrong@tencent.com, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 03 Sep 2018 23:48:15 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > Hi
> >
> > On Fri, Aug 31, 2018 at 7:32 PM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote: =20
> >>
> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>
> >> Implement a virtual memory device for the TPM Physical Presence interf=
ace.
> >> The memory is located at 0xFED45000 and used by ACPI to send messages =
to the
> >> firmware (BIOS) and by the firmware to provide parameters for each one=
 of
> >> the supported codes.
> >>
> >> This interface should be used by all TPM devices on x86 and can be
> >> added by calling tpm_ppi_init_io().
> >>
> >> Note: bios_linker cannot be used to allocate the PPI memory region,
> >> since the reserved memory should stay stable across reboots, and might
> >> be needed before the ACPI tables are installed.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> Reviewed-by: Igor Mammedov <imammedo@redhat.com> =20
>=20
>=20
> ....
>=20
> >> + */
> >> +#define TPM_PPI_ADDR_SIZE           0x400
> >> +#define TPM_PPI_ADDR_BASE           0xFED45000 =20
>=20
> > There is a (new) issue with the PPI ram region:
> >
> > READ of size 32 at 0x61d000090480 thread T6
> >     #0 0x5622bd8de0f4 in buffer_zero_avx2
> > /home/elmarco/src/qq/util/bufferiszero.c:169
> >     #1 0x5622bd8de899 in select_accel_fn
> > /home/elmarco/src/qq/util/bufferiszero.c:282
> >     #2 0x5622bd8de8f1 in buffer_is_zero
> > /home/elmarco/src/qq/util/bufferiszero.c:309
> >     #3 0x5622bc209f94 in is_zero_range /home/elmarco/src/qq/migration/r=
am.c:82
> >     #4 0x5622bc21938d in save_zero_page_to_file
> > /home/elmarco/src/qq/migration/ram.c:1694
> >     #5 0x5622bc219452 in save_zero_page
> > /home/elmarco/src/qq/migration/ram.c:1713
> >     #6 0x5622bc21db67 in ram_save_target_page
> > /home/elmarco/src/qq/migration/ram.c:2289
> >     #7 0x5622bc21e13e in ram_save_host_page
> > /home/elmarco/src/qq/migration/ram.c:2351
> >     #8 0x5622bc21ea3a in ram_find_and_save_block
> > /home/elmarco/src/qq/migration/ram.c:2413
> >     #9 0x5622bc223b5d in ram_save_iterate
> > /home/elmarco/src/qq/migration/ram.c:3193
> >     #10 0x5622bd16f544 in qemu_savevm_state_iterate
> > /home/elmarco/src/qq/migration/savevm.c:1103
> >     #11 0x5622bd157e75 in migration_iteration_run
> > /home/elmarco/src/qq/migration/migration.c:2897
> >     #12 0x5622bd15892e in migration_thread
> > /home/elmarco/src/qq/migration/migration.c:3018
> >     #13 0x5622bd902f31 in qemu_thread_start
> > /home/elmarco/src/qq/util/qemu-thread-posix.c:504
> >     #14 0x7f42f0ef4593 in start_thread (/lib64/libpthread.so.0+0x7593)
> >     #15 0x7f42f0c280de in clone (/lib64/libc.so.6+0xfa0de)
> > 0x61d000090490 is located 0 bytes to the right of 2064-byte region
> > [0x61d00008fc80,0x61d000090490)
> >
> > migration code is assuming RAM is multiple of TARGET_PAGE_SIZE. =20
>=20
> Physical RAM is multiple of TARGET_PAGE_SIZE O:-)
> That assumtion is held in too many places, if you can change the size to
> be multiple of page size, that would be greate.
>=20
> > Should the migration code be fixed, or should the TPM code allocate
> > ram differently? =20
>=20
> Migration people (i.e. me) would preffer that you fix the TPM
> allocation.  Or you can decide that this is *not* RAM.  The unit of
> transfer for migrate ram is ram pages, a.k.a. TARGET_PAGE_SIZE.
I'd loath to waste whole page in already cramped area.
Can we implement it as mmio region? (it will add some bolerplate code for r=
ead/write
handlers/migration and cause vmexits on every read/write but it's not a hot=
 path so we might not care)
=20
> > In all case, I think the migration code should either be fixed or have
> > an assert. =20
>=20
> An assert for sure.
>=20
> Fixed .... Do we have real devices that put ram regions that are smaller
> than page size?
>=20
> Later, Juan.
