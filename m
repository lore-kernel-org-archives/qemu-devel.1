Received: from eggs.gnu.org ([2001:4830:134:3::10]:54232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXSN5-0006gm-Kl
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXSMz-0008Qd-Ok
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:21:35 -0400
Date: Mon, 25 Jun 2018 16:21:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180625162125.506483aa.cohuck@redhat.com>
In-Reply-To: <cd40e518-ee0c-f8fe-d910-562c2c64709d@redhat.com>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-20-f4bug@amsat.org>
	<20180625150719.0392da6c.cohuck@redhat.com>
	<cd40e518-ee0c-f8fe-d910-562c2c64709d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 19/46] hw/s390x: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "open
	list:S390" <qemu-s390x@nongnu.org>

On Mon, 25 Jun 2018 15:16:15 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 25.06.2018 15:07, Cornelia Huck wrote:
> > On Mon, 25 Jun 2018 09:42:11 -0300
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> It eases code review, unit is explicit.
> >>
> >> Patch generated using:
> >>
> >>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ includ=
e/hw/
> >>
> >> and modified manually.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> Acked-by: Cornelia Huck <cohuck@redhat.com> =20
> >=20
> > Hm, I had not looked at the v2+ patches, as this already carried my
> > ack...
> >  =20
> >> ---
> >>  hw/s390x/s390-skeys.c    | 3 ++-
> >>  hw/s390x/s390-stattrib.c | 3 ++- =20
> >=20
> > ...but these two were added later on.
> >  =20
> >>  hw/s390x/sclp.c          | 3 ++-
> >>  3 files changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> >> index 76241c240e..15f7ab0e53 100644
> >> --- a/hw/s390x/s390-skeys.c
> >> +++ b/hw/s390x/s390-skeys.c
> >> @@ -10,6 +10,7 @@
> >>   */
> >> =20
> >>  #include "qemu/osdep.h"
> >> +#include "qemu/units.h"
> >>  #include "hw/boards.h"
> >>  #include "hw/s390x/storage-keys.h"
> >>  #include "qapi/error.h"
> >> @@ -19,7 +20,7 @@
> >>  #include "sysemu/kvm.h"
> >>  #include "migration/register.h"
> >> =20
> >> -#define S390_SKEYS_BUFFER_SIZE 131072  /* Room for 128k storage keys =
*/
> >> +#define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage =
keys */ =20
> >=20
> > This one looks confusing to me. We're not allocating 128 chunks of 1
> > KiB size, but space enough for 128k byte values. What do others think? =
=20
>=20
> Hm, as this define is called "_SIZE" it should be the right thing to do.
>=20
> I would agree if it would be "_SKEY.*_COUNT"

Yes, but I found it a bit non-intuitive, as it is not immediately clear
that we want to support 128k byte values. It's probably clearer than
the previous magic value, though.

No real objections to this change from my side, though.
