Received: from eggs.gnu.org ([2001:4830:134:3::10]:41639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fO0dO-0002qe-PL
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fO0dN-0005RI-NH
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:55:22 -0400
Date: Wed, 30 May 2018 15:55:12 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180530155301-mutt-send-email-mst@kernel.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-10-f4bug@amsat.org>
	<20180529134053.1ea9f46d.cohuck@redhat.com>
	<11289f38-6d0f-74c9-1719-83b2a3ed2d97@amsat.org>
	<20180530074026-mutt-send-email-mst@kernel.org>
	<CAAdtpL7sDOg2m+Ffsbc3f_Za6fr3in5ZfBJ2BAtGNJ1j4vbhJQ@mail.gmail.com>
	<CAAdtpL6eW5=djFE-k7bHUR6s_b=wAmMuOLM8Djb_CYPf54L8CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAAdtpL6eW5=djFE-k7bHUR6s_b=wAmMuOLM8Djb_CYPf54L8CA@mail.gmail.com>
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
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Anthony Green <green@moxielogic.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

On Wed, May 30, 2018 at 03:19:19AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Le mer. 30 mai 2018 02:50, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> a=
 =E9crit=A0:
>=20
>     On Wed, May 30, 2018 at 1:42 AM, Michael S. Tsirkin <mst@redhat.com=
> wrote:
>     > On Wed, May 30, 2018 at 12:12:55AM -0300, Philippe Mathieu-Daud=E9=
 wrote:
>     >> Hi Cornelia,
>     >>
>     >> On 05/29/2018 08:40 AM, Cornelia Huck wrote:
>     >> > On Mon, 28 May 2018 20:27:07 -0300
>     >> > Philippe Mathieu-Daud=E9 <f4bug@amsat.org> wrote:
>     >> >
>     >> >> Code change produced with:
>     >> >>=A0 =A0 =A0$ git grep '#include "exec/exec-all.h"' | \
>     >> >>=A0 =A0 =A0 =A0cut -d: -f-1 | \
>     >> >>=A0 =A0 =A0 =A0xargs egrep -L "(cpu_address_space_init|cpu_loo=
p_|tlb_|tb_|
>     GETPC|singlestep|TranslationBlock)" | \
>     >> >
>     >> > Hm, does this expression catch all files that need to include
>     >> > exec-all.h? The resulting patch seems fine, though.
>     >>
>     >> No, not all :/
>     >> I started with "(cpu_loop_|tlb_|tb_)" then kept brutebuilding un=
til no
>     >> more errors appear. In 2 more steps I added "cpu_address_space_i=
nit|"
>     >> then "|GETPC|singlestep|TranslationBlock". Quick and dirty enoug=
h for my
>     >> goal than trying to build a regex to explode function/struct nam=
es from
>     >> headers. This is a clever way to do it for long term command reu=
se taken
>     >> from commit messages...
>     >
>     > Brutebuilding isn't a good way to find unused includes, some othe=
r header
>     > might pull in an include you are trying to remove for its own pur=
poses.
>     > If you want to try brutebuilding you must also verify that's
>     > not the case - e.g. look at the dependency file generated.
>=20
>=20
> I think I get it for headers, but here I'm only modifying .c source fil=
es.=A0

Same thing - if you call a function from a header, you should include
that header even if some other header happens to pull it in.
Otherwise someone might cleanup that other header and suddenly
your build breaks.



> I'll restrict the shell command to .c=A0

I don't think it matters.

>=20
>=20
>     Hmm you mean the .d files in the build dir?
>=20
>     i.e.
>     $ find lm32-softmmu -name \*.d -exec fgrep -L exec-all.h {} \; | se=
d
>     -e 's/.*-softmmu\/\(.*\)d$/\1c/'
>     dump.c
>     numa.c
>     tcg/tcg-common.c
>     tcg/optimize.c
>     tcg/tcg-op-gvec.c
>     tcg/tcg-op-vec.c
>     accel/tcg/tcg-runtime-gvec.c
>     accel/tcg/tcg-all.c
>     accel/accel.c
>     accel/stubs/whpx-stub.c
>     accel/stubs/hvf-stub.c
>     accel/stubs/kvm-stub.c
>     accel/stubs/hax-stub.c
>     hw/lm32/milkymist.c
>     hw/lm32/lm32_boards.c
>     hw/core/generic-loader.c
>     ...
>=20
>     Then look why each .c included it?
>=20
>     >
>     >> >>=A0 =A0 =A0 =A0xargs sed -i.bak '/#include "exec\/exec-all.h"/=
d'
>     >> >>
>     >> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
