Received: from eggs.gnu.org ([2001:4830:134:3::10]:45701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fNsw8-0002ZB-O4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fNsw7-0007Kb-Sw
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:42:12 -0400
Date: Wed, 30 May 2018 07:42:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180530074026-mutt-send-email-mst@kernel.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-10-f4bug@amsat.org>
	<20180529134053.1ea9f46d.cohuck@redhat.com>
	<11289f38-6d0f-74c9-1719-83b2a3ed2d97@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <11289f38-6d0f-74c9-1719-83b2a3ed2d97@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/21] target: Do not include
 "exec/exec-all.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Anthony Green <green@moxielogic.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

On Wed, May 30, 2018 at 12:12:55AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Hi Cornelia,
>=20
> On 05/29/2018 08:40 AM, Cornelia Huck wrote:
> > On Mon, 28 May 2018 20:27:07 -0300
> > Philippe Mathieu-Daud=E9 <f4bug@amsat.org> wrote:
> >=20
> >> Code change produced with:
> >>     $ git grep '#include "exec/exec-all.h"' | \
> >>       cut -d: -f-1 | \
> >>       xargs egrep -L "(cpu_address_space_init|cpu_loop_|tlb_|tb_|GET=
PC|singlestep|TranslationBlock)" | \
> >=20
> > Hm, does this expression catch all files that need to include
> > exec-all.h? The resulting patch seems fine, though.
>=20
> No, not all :/
> I started with "(cpu_loop_|tlb_|tb_)" then kept brutebuilding until no
> more errors appear. In 2 more steps I added "cpu_address_space_init|"
> then "|GETPC|singlestep|TranslationBlock". Quick and dirty enough for m=
y
> goal than trying to build a regex to explode function/struct names from
> headers. This is a clever way to do it for long term command reuse take=
n
> from commit messages...

Brutebuilding isn't a good way to find unused includes, some other header
might pull in an include you are trying to remove for its own purposes.
If you want to try brutebuilding you must also verify that's
not the case - e.g. look at the dependency file generated.

> >>       xargs sed -i.bak '/#include "exec\/exec-all.h"/d'
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
