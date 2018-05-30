Received: from eggs.gnu.org ([2001:4830:134:3::10]:38175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNxTV-0006YC-1E
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fNxTU-0003je-4x
	for qemu-devel@nongnu.org; Wed, 30 May 2018 05:32:57 -0400
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-10-f4bug@amsat.org>
	<20180529134053.1ea9f46d.cohuck@redhat.com>
	<11289f38-6d0f-74c9-1719-83b2a3ed2d97@amsat.org>
	<20180530074026-mutt-send-email-mst@kernel.org>
	<CAAdtpL7sDOg2m+Ffsbc3f_Za6fr3in5ZfBJ2BAtGNJ1j4vbhJQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1a5c08d-4b69-7590-0c48-1d459d2fbdab@redhat.com>
Date: Wed, 30 May 2018 11:32:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAAdtpL7sDOg2m+Ffsbc3f_Za6fr3in5ZfBJ2BAtGNJ1j4vbhJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Anthony Green <green@moxielogic.com>, Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:S390" <qemu-s390x@nongnu.org>

On 30/05/2018 07:50, Philippe Mathieu-Daud=C3=A9 wrote:
>>> No, not all :/
>>> I started with "(cpu_loop_|tlb_|tb_)" then kept brutebuilding until n=
o
>>> more errors appear. In 2 more steps I added "cpu_address_space_init|"
>>> then "|GETPC|singlestep|TranslationBlock". Quick and dirty enough for=
 my
>>> goal than trying to build a regex to explode function/struct names fr=
om
>>> headers. This is a clever way to do it for long term command reuse ta=
ken
>>> from commit messages...
>> Brutebuilding isn't a good way to find unused includes, some other hea=
der
>> might pull in an include you are trying to remove for its own purposes=
.
>> If you want to try brutebuilding you must also verify that's
>> not the case - e.g. look at the dependency file generated.
> Hmm you mean the .d files in the build dir?

You can also check which include files include this one.  In this case
you can see that brute-building was more or less enough:

$ git grep -l exec-all -- '*.h'
accel/tcg/translate-all.h
include/exec/tb-lookup.h
include/exec/translator.h
linux-user/qemu.h
target/ppc/helper_regs.h

Leaving aside linux-user/qemu.h, let's check which files include one of
those headers, but they do not include exec/exec-all.h:

$ git grep -L exec-all \
   $(git grep -lFf <(git grep -l exec-all -- '*.h' | \
     grep -v qemu.h | sed 's,.*/,,'))
linux-user/mmap.c
target/arm/translate.h
target/ppc/int_helper.c
trace/control-target.c

I'll send some patches shortly to fix up what's left.

Paolo
