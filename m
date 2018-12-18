Received: from eggs.gnu.org ([2001:4830:134:3::10]:39013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGX1-0001En-Df
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGWy-0006hp-Qv
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:39:35 -0500
Date: Tue, 18 Dec 2018 09:39:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218093738-mutt-send-email-mst@kernel.org>
References: <20181218110333.22558-1-philmd@redhat.com>
	<20181218092648-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181218092648-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Fix strncpy() warnings for GCC8 new
 -Wstringop-truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 18, 2018 at 09:31:00AM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 18, 2018 at 12:03:30PM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
> > GCC 8 new warning prevents builds to success since quite some time.
> > First report on the mailing list is in July 2018:
> > https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03723.html
> >=20
> > Various intents has been sent to fix this:
> > - Incorrectly using g_strlcpy()
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03705.html
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03706.html
> > - Using assert() and strpadcpy()
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03938.html
> > - Use #pragma GCC diagnostic ignored "-Wstringop-truncation"
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> > - adding an inline wrapper with said pragma in there
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> > - -Wno-stringop-truncation is the makefile
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> >=20
> > This series replace the strncpy() calls by strpadcpy() which seemed
> > to me the saniest option.
> >=20
> > Regards,
> >=20
> > Phil.
>=20
> Do you happen to know why does it build fine with
> Gcc 8.2.1?
>=20
> Reading the GCC manual it seems that
> there is a "nostring" attribute

Sorry that should be "nonstring".


> that means
> "might not be 0 terminated".
> I think we should switch to that which fixes the warning
> but also warns if someone tries to misuse these
> as C-strings.
>=20
> Seems to be a better option, does it not?
>=20

Also maybe we can make strpadcpy check for the nonstring
attribute too somehow?
Or did gcc just hardcode the strncpy name?

> > Marc-Andr=E9 Lureau (1):
> >   hw/acpi: Replace strncpy() by strpadcpy(pad=3D'\0')
> >=20
> > Philippe Mathieu-Daud=E9 (2):
> >   block/sheepdog: Replace strncpy() by strpadcpy(pad=3D'\0')
> >   migration: Replace strncpy() by strpadcpy(pad=3D'\0')
> >=20
> >  block/sheepdog.c         |  6 +++---
> >  hw/acpi/aml-build.c      |  6 ++++--
> >  hw/acpi/core.c           | 13 +++++++------
> >  migration/global_state.c |  4 ++--
> >  4 files changed, 16 insertions(+), 13 deletions(-)
> >=20
> > --=20
> > 2.17.2
