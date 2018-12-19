Received: from eggs.gnu.org ([2001:4830:134:3::10]:44077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gZY2A-00047s-Jw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gZY26-0002gL-GH
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:20:54 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gZY26-0002fc-40
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:20:50 -0500
Received: by mail-wr1-f44.google.com with SMTP id v13so18686902wrw.5
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 01:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-4-philmd@redhat.com>
	<20181219101552.17b942bb@redhat.com>
In-Reply-To: <20181219101552.17b942bb@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 19 Dec 2018 10:20:36 +0100
Message-ID: <CAP+75-XEQYC1XNcCy7-vaF3DOB=3HTUWmLz_XL+DZybxUDi1Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/5] hw/acpi: Use QEMU_NONSTRING for non
 NUL-terminated arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, 1803872@bugs.launchpad.net

Le mer. 19 d=C3=A9c. 2018 10:16, Igor Mammedov <imammedo@redhat.com> a =C3=
=A9crit :

> On Tue, 18 Dec 2018 18:51:20 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>
> > GCC 8 added a -Wstringop-truncation warning:
> >
> >   The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
> >   bug 81117 is specifically intended to highlight likely unintended
> >   uses of the strncpy function that truncate the terminating NUL
> >   character from the source string.
> >
> > This new warning leads to compilation failures:
> >
> >     CC      hw/acpi/core.o
> >   In function 'acpi_table_install', inlined from 'acpi_table_add' at
> qemu/hw/acpi/core.c:296:5:
> >   qemu/hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equals
> destination size [-Werror=3Dstringop-truncation]
> >            strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
> >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   make: *** [qemu/rules.mak:69: hw/acpi/core.o] Error 1
> >
> > Use the QEMU_NONSTRING attribute, since ACPI tables don't require the
> > strings to be NUL-terminated.
> >
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  hw/acpi/core.c              | 8 ++++----
> >  include/hw/acpi/acpi-defs.h | 8 ++++----
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> > index aafdc61648..f60f750c3d 100644
> > --- a/hw/acpi/core.c
> > +++ b/hw/acpi/core.c
> > @@ -35,14 +35,14 @@
> >  struct acpi_table_header {
> >      uint16_t _length;         /* our length, not actual part of the hd=
r
> */
> >                                /* allows easier parsing for fw_cfg
> clients */
> > -    char sig[4];              /* ACPI signature (4 ASCII characters) *=
/
> > +    char sig[4] QEMU_NONSTRING; /* ACPI signature (4 ASCII characters)
> */
> >      uint32_t length;          /* Length of table, in bytes, including
> header */
> >      uint8_t revision;         /* ACPI Specification minor version # */
> >      uint8_t checksum;         /* To make sum of entire table =3D=3D 0 =
*/
> > -    char oem_id[6];           /* OEM identification */
> > -    char oem_table_id[8];     /* OEM table identification */
> > +    char oem_id[6] QEMU_NONSTRING; /* OEM identification */
> > +    char oem_table_id[8] QEMU_NONSTRING; /* OEM table identification *=
/
> >      uint32_t oem_revision;    /* OEM revision number */
> > -    char asl_compiler_id[4];  /* ASL compiler vendor ID */
> > +    char asl_compiler_id[4] QEMU_NONSTRING; /* ASL compiler vendor ID =
*/
> >      uint32_t asl_compiler_revision; /* ASL compiler revision number */
> >  } QEMU_PACKED;
> >
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index af8e023968..3bf0bec8ba 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -43,7 +43,7 @@ enum {
> >  struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer *=
/
> >      uint64_t signature;              /* ACPI signature, contains "RSD
> PTR " */
> >      uint8_t  checksum;               /* To make sum of struct =3D=3D 0=
 */
> > -    uint8_t  oem_id [6];             /* OEM identification */
> > +    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */
> >      uint8_t  revision;               /* Must be 0 for 1.0, 2 for 2.0 *=
/
> >      uint32_t rsdt_physical_address;  /* 32-bit physical address of RSD=
T
> */
> >      uint32_t length;                 /* XSDT Length in bytes including
> hdr */
>
> you'll need to rebase this on top the latest Michael's pull request.
> [PULL v2 25/30] hw: arm: Carry RSDP specific data through  AcpiRsdpData
> [PULL v2 29/30] hw: acpi: Remove AcpiRsdpDescriptor and fix tests
>

OK. Can I add your Ack-by then?

> @@ -62,10 +62,10 @@ typedef struct AcpiRsdpDescriptor AcpiRsdpDescriptor;
> >      uint32_t length;                 /* Length of table, in bytes,
> including header */ \
> >      uint8_t  revision;               /* ACPI Specification minor
> version # */ \
> >      uint8_t  checksum;               /* To make sum of entire table =
=3D=3D
> 0 */ \
> > -    uint8_t  oem_id [6];             /* OEM identification */ \
> > -    uint8_t  oem_table_id [8];       /* OEM table identification */ \
> > +    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */ \
> > +    uint8_t  oem_table_id [8] QEMU_NONSTRING; /* OEM table
> identification */ \
> >      uint32_t oem_revision;           /* OEM revision number */ \
> > -    uint8_t  asl_compiler_id [4];    /* ASL compiler vendor ID */ \
> > +    uint8_t  asl_compiler_id [4] QEMU_NONSTRING; /* ASL compiler vendo=
r
> ID */ \
> >      uint32_t asl_compiler_revision;  /* ASL compiler revision number *=
/
> >
> >
>
>
