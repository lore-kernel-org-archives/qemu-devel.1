Received: from eggs.gnu.org ([2001:4830:134:3::10]:55114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZYba-0007ph-Lq
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZYbZ-0006Ja-1w
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:57:30 -0500
Date: Wed, 19 Dec 2018 10:57:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181219105700.35390f09@redhat.com>
In-Reply-To: <CAP+75-XEQYC1XNcCy7-vaF3DOB=3HTUWmLz_XL+DZybxUDi1Mw@mail.gmail.com>
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-4-philmd@redhat.com>
	<20181219101552.17b942bb@redhat.com>
	<CAP+75-XEQYC1XNcCy7-vaF3DOB=3HTUWmLz_XL+DZybxUDi1Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, 1803872@bugs.launchpad.net, Thomas Huth <thuth@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Liu Yuan <namei.unix@gmail.com>, =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>, Max Reitz <mreitz@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 19 Dec 2018 10:20:36 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Le mer. 19 d=C3=A9c. 2018 10:16, Igor Mammedov <imammedo@redhat.com> a =
=C3=A9crit :
>=20
> > On Tue, 18 Dec 2018 18:51:20 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> > =20
> > > GCC 8 added a -Wstringop-truncation warning:
> > >
> > >   The -Wstringop-truncation warning added in GCC 8.0 via r254630 for
> > >   bug 81117 is specifically intended to highlight likely unintended
> > >   uses of the strncpy function that truncate the terminating NUL
> > >   character from the source string.
> > >
> > > This new warning leads to compilation failures:
> > >
> > >     CC      hw/acpi/core.o
> > >   In function 'acpi_table_install', inlined from 'acpi_table_add' at =
=20
> > qemu/hw/acpi/core.c:296:5: =20
> > >   qemu/hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 equal=
s =20
> > destination size [-Werror=3Dstringop-truncation] =20
> > >            strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
> > >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   make: *** [qemu/rules.mak:69: hw/acpi/core.o] Error 1
> > >
> > > Use the QEMU_NONSTRING attribute, since ACPI tables don't require the
> > > strings to be NUL-terminated.
> > >
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >  hw/acpi/core.c              | 8 ++++----
> > >  include/hw/acpi/acpi-defs.h | 8 ++++----
> > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> > > index aafdc61648..f60f750c3d 100644
> > > --- a/hw/acpi/core.c
> > > +++ b/hw/acpi/core.c
> > > @@ -35,14 +35,14 @@
> > >  struct acpi_table_header {
> > >      uint16_t _length;         /* our length, not actual part of the =
hdr =20
> > */ =20
> > >                                /* allows easier parsing for fw_cfg =20
> > clients */ =20
> > > -    char sig[4];              /* ACPI signature (4 ASCII characters)=
 */
> > > +    char sig[4] QEMU_NONSTRING; /* ACPI signature (4 ASCII character=
s) =20
> > */ =20
> > >      uint32_t length;          /* Length of table, in bytes, includin=
g =20
> > header */ =20
> > >      uint8_t revision;         /* ACPI Specification minor version # =
*/
> > >      uint8_t checksum;         /* To make sum of entire table =3D=3D =
0 */
> > > -    char oem_id[6];           /* OEM identification */
> > > -    char oem_table_id[8];     /* OEM table identification */
> > > +    char oem_id[6] QEMU_NONSTRING; /* OEM identification */
> > > +    char oem_table_id[8] QEMU_NONSTRING; /* OEM table identification=
 */
> > >      uint32_t oem_revision;    /* OEM revision number */
> > > -    char asl_compiler_id[4];  /* ASL compiler vendor ID */
> > > +    char asl_compiler_id[4] QEMU_NONSTRING; /* ASL compiler vendor I=
D */
> > >      uint32_t asl_compiler_revision; /* ASL compiler revision number =
*/
> > >  } QEMU_PACKED;
> > >
> > > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > > index af8e023968..3bf0bec8ba 100644
> > > --- a/include/hw/acpi/acpi-defs.h
> > > +++ b/include/hw/acpi/acpi-defs.h
> > > @@ -43,7 +43,7 @@ enum {
> > >  struct AcpiRsdpDescriptor {        /* Root System Descriptor Pointer=
 */
> > >      uint64_t signature;              /* ACPI signature, contains "RS=
D =20
> > PTR " */ =20
> > >      uint8_t  checksum;               /* To make sum of struct =3D=3D=
 0 */
> > > -    uint8_t  oem_id [6];             /* OEM identification */
> > > +    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */
> > >      uint8_t  revision;               /* Must be 0 for 1.0, 2 for 2.0=
 */
> > >      uint32_t rsdt_physical_address;  /* 32-bit physical address of R=
SDT =20
> > */ =20
> > >      uint32_t length;                 /* XSDT Length in bytes includi=
ng =20
> > hdr */
> >
> > you'll need to rebase this on top the latest Michael's pull request.
> > [PULL v2 25/30] hw: arm: Carry RSDP specific data through  AcpiRsdpData
> > [PULL v2 29/30] hw: acpi: Remove AcpiRsdpDescriptor and fix tests
> > =20
>=20
> OK. Can I add your Ack-by then?
pls note that new AcpiRsdpData has oem_id field that needs the same treatme=
nt

with rebase
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>=20
> > @@ -62,10 +62,10 @@ typedef struct AcpiRsdpDescriptor AcpiRsdpDescripto=
r; =20
> > >      uint32_t length;                 /* Length of table, in bytes, =
=20
> > including header */ \ =20
> > >      uint8_t  revision;               /* ACPI Specification minor =20
> > version # */ \ =20
> > >      uint8_t  checksum;               /* To make sum of entire table =
=3D=3D =20
> > 0 */ \ =20
> > > -    uint8_t  oem_id [6];             /* OEM identification */ \
> > > -    uint8_t  oem_table_id [8];       /* OEM table identification */ \
> > > +    uint8_t  oem_id [6] QEMU_NONSTRING; /* OEM identification */ \
> > > +    uint8_t  oem_table_id [8] QEMU_NONSTRING; /* OEM table =20
> > identification */ \ =20
> > >      uint32_t oem_revision;           /* OEM revision number */ \
> > > -    uint8_t  asl_compiler_id [4];    /* ASL compiler vendor ID */ \
> > > +    uint8_t  asl_compiler_id [4] QEMU_NONSTRING; /* ASL compiler ven=
dor =20
> > ID */ \ =20
> > >      uint32_t asl_compiler_revision;  /* ASL compiler revision number=
 */
> > >
> > > =20
> >
> > =20
