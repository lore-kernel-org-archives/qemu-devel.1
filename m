Received: from eggs.gnu.org ([2001:4830:134:3::10]:46878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1ga1CV-0006vg-9K
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1ga1CR-0005gk-6X
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:29:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ga1CQ-0005XE-SA
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:29:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so2388569wrs.10
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 08:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-4-philmd@redhat.com>
	<20181219101034.2dgs2faryopmflnz@kamzik.brq.redhat.com>
	<49ed6ada-c821-6afd-11a9-9520901a151c@redhat.com>
	<20181219130037.c5lrlps6ljqxvs5b@kamzik.brq.redhat.com>
	<20181220161828.7387f3f5@Igors-MacBook-Pro.local>
In-Reply-To: <20181220161828.7387f3f5@Igors-MacBook-Pro.local>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 20 Dec 2018 17:29:06 +0100
Message-ID: <CAP+75-Uep=GV1_Y1f3Owh39FRkxrKkcdyX5MDat2iZh1X_8s8A@mail.gmail.com>
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
Cc: Andrew Jones <drjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 1803872@bugs.launchpad.net, Thomas Huth <thuth@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Liu Yuan <namei.unix@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Max Reitz <mreitz@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, Dec 20, 2018 at 4:18 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 19 Dec 2018 14:00:37 +0100
> Andrew Jones <drjones@redhat.com> wrote:
>
> > On Wed, Dec 19, 2018 at 01:43:40PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > Hi Drew,
> > >
> > > On 12/19/18 11:10 AM, Andrew Jones wrote:
> > > > On Tue, Dec 18, 2018 at 06:51:20PM +0100, Philippe Mathieu-Daud=C3=
=A9 wrote:
> > > >> GCC 8 added a -Wstringop-truncation warning:
> > > >>
> > > >>   The -Wstringop-truncation warning added in GCC 8.0 via r254630 f=
or
> > > >>   bug 81117 is specifically intended to highlight likely unintende=
d
> > > >>   uses of the strncpy function that truncate the terminating NUL
> > > >>   character from the source string.
> > > >>
> > > >> This new warning leads to compilation failures:
> > > >>
> > > >>     CC      hw/acpi/core.o
> > > >>   In function 'acpi_table_install', inlined from 'acpi_table_add' =
at qemu/hw/acpi/core.c:296:5:
> > > >>   qemu/hw/acpi/core.c:184:9: error: 'strncpy' specified bound 4 eq=
uals destination size [-Werror=3Dstringop-truncation]
> > > >>            strncpy(ext_hdr->sig, hdrs->sig, sizeof ext_hdr->sig);
> > > >>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > >>   make: *** [qemu/rules.mak:69: hw/acpi/core.o] Error 1
> > > >>
> > > >> Use the QEMU_NONSTRING attribute, since ACPI tables don't require =
the
> > > >> strings to be NUL-terminated.
> > > >
> > > > Aren't we always starting with zero-initialized structures in ACPI =
code?
> > > > If so, then we should be able to change the strncpy's to memcpy's.
> > >
> > > The first call zero-initializes, but then we call realloc():
> > >
> > >     /* We won't fail from here on. Initialize / extend the globals. *=
/
> > >     if (acpi_tables =3D=3D NULL) {
> > >         acpi_tables_len =3D sizeof(uint16_t);
> > >         acpi_tables =3D g_malloc0(acpi_tables_len);
> > >     }
> > >
> > >     acpi_tables =3D g_realloc(acpi_tables, acpi_tables_len +
> > >                                          ACPI_TABLE_PFX_SIZE +
> > >                                          sizeof dfl_hdr + body_size);
> > >
> > >     ext_hdr =3D (struct acpi_table_header *)(acpi_tables +
> > >                                            acpi_tables_len);
> > >
> > > So memcpy() isn't enough.
> >
> > Ah, thanks.
> >
> > >
> > > I can resend the previous patch which uses strpadcpy() if you prefer,
> > > Igor already reviewed it:
> > >
> > > https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04406.html
> > >
> >
> > I do like strpadcpy() better, but I'm not going to lose sleep about
> > this either way it goes.
> I'm ok with both ways, but v2 consensus was to use QEMU_NONSTRING if I go=
t it right

Yes, MST recommended it because this attribute is clever than strpadcpy().
