Received: from eggs.gnu.org ([2001:4830:134:3::10]:59007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNuSM-0003U8-C6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNuSJ-0001tS-68
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:19:34 -0400
MIME-Version: 1.0
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-10-f4bug@amsat.org>
	<20180529134053.1ea9f46d.cohuck@redhat.com>
	<11289f38-6d0f-74c9-1719-83b2a3ed2d97@amsat.org>
	<20180530074026-mutt-send-email-mst@kernel.org>
	<CAAdtpL7sDOg2m+Ffsbc3f_Za6fr3in5ZfBJ2BAtGNJ1j4vbhJQ@mail.gmail.com>
In-Reply-To: <CAAdtpL7sDOg2m+Ffsbc3f_Za6fr3in5ZfBJ2BAtGNJ1j4vbhJQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 30 May 2018 03:19:19 -0300
Message-ID: <CAAdtpL6eW5=djFE-k7bHUR6s_b=wAmMuOLM8Djb_CYPf54L8CA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Anthony Green <green@moxielogic.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

Le mer. 30 mai 2018 02:50, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> a
=C3=A9crit :

> On Wed, May 30, 2018 at 1:42 AM, Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > On Wed, May 30, 2018 at 12:12:55AM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> Hi Cornelia,
> >>
> >> On 05/29/2018 08:40 AM, Cornelia Huck wrote:
> >> > On Mon, 28 May 2018 20:27:07 -0300
> >> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >> >
> >> >> Code change produced with:
> >> >>     $ git grep '#include "exec/exec-all.h"' | \
> >> >>       cut -d: -f-1 | \
> >> >>       xargs egrep -L
> "(cpu_address_space_init|cpu_loop_|tlb_|tb_|GETPC|singlestep|TranslationB=
lock)"
> | \
> >> >
> >> > Hm, does this expression catch all files that need to include
> >> > exec-all.h? The resulting patch seems fine, though.
> >>
> >> No, not all :/
> >> I started with "(cpu_loop_|tlb_|tb_)" then kept brutebuilding until no
> >> more errors appear. In 2 more steps I added "cpu_address_space_init|"
> >> then "|GETPC|singlestep|TranslationBlock". Quick and dirty enough for =
my
> >> goal than trying to build a regex to explode function/struct names fro=
m
> >> headers. This is a clever way to do it for long term command reuse tak=
en
> >> from commit messages...
> >
> > Brutebuilding isn't a good way to find unused includes, some other head=
er
> > might pull in an include you are trying to remove for its own purposes.
> > If you want to try brutebuilding you must also verify that's
> > not the case - e.g. look at the dependency file generated.
>

I think I get it for headers, but here I'm only modifying .c source files.
I'll restrict the shell command to .c


> Hmm you mean the .d files in the build dir?
>
> i.e.
> $ find lm32-softmmu -name \*.d -exec fgrep -L exec-all.h {} \; | sed
> -e 's/.*-softmmu\/\(.*\)d$/\1c/'
> dump.c
> numa.c
> tcg/tcg-common.c
> tcg/optimize.c
> tcg/tcg-op-gvec.c
> tcg/tcg-op-vec.c
> accel/tcg/tcg-runtime-gvec.c
> accel/tcg/tcg-all.c
> accel/accel.c
> accel/stubs/whpx-stub.c
> accel/stubs/hvf-stub.c
> accel/stubs/kvm-stub.c
> accel/stubs/hax-stub.c
> hw/lm32/milkymist.c
> hw/lm32/lm32_boards.c
> hw/core/generic-loader.c
> ...
>
> Then look why each .c included it?
>
> >
> >> >>       xargs sed -i.bak '/#include "exec\/exec-all.h"/d'
> >> >>
> >> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
