Received: from eggs.gnu.org ([209.51.188.92]:54779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw52J-0005DF-8i
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw52D-0005MB-Mg
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:02:11 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-11-armbru@redhat.com>
	<CAMo8BfKk1kPwtqHhfNnP9g6WqwfJ=RPdZgrKsKw7zgbOhc8utQ@mail.gmail.com>
Date: Tue, 19 Feb 2019 14:01:37 +0100
In-Reply-To: <CAMo8BfKk1kPwtqHhfNnP9g6WqwfJ=RPdZgrKsKw7zgbOhc8utQ@mail.gmail.com>
	(Max Filippov's message of "Tue, 19 Feb 2019 00:43:26 -0800")
Message-ID: <87k1hwue32.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/10] hw/arm hw/xtensa: De-duplicate
 pflash creation code some
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, lersek@redhat.com, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Alex =?utf-8?Q?Ben?= =?utf-8?Q?n=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Peter Crosthwaite <crosthwaitepeter@gmail.com>

Max Filippov <jcmvbkbc@gmail.com> writes:

> On Mon, Feb 18, 2019 at 5:07 AM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> pflash_cfi01_register() creates a TYPE_CFI_PFLASH01 device, sets
>> properties, realizes, and wires up.
>>
>> We have three modified copies of it, because their users need to set
>> additional properties, or have the wiring done differently.
>>
>> Factor out their common part into pflash_cfi01_create().
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/arm/vexpress.c        | 22 +++++-----------------
>>  hw/arm/virt.c            | 26 +++++++++-----------------
>>  hw/block/pflash_cfi01.c  | 39 +++++++++++++++++++++++++++------------
>>  hw/xtensa/xtfpga.c       | 18 +++++++-----------
>
> I was told that it's better this way when I did that initially:
>   http://lists.gnu.org/archive/html/qemu-devel/2015-09/msg06927.html
>
> Has the idea of "better" changed since then?
> I'm fine with the code either way, just curious.

I'm not sure about our collective idea of "better".  I simply saw a
helper function duplicated with minor variations because it fails to
capture what's truly common, so I fixed that.

If we think helper functions capturing device creation and property
setting are bad, and open coding would be better. then we should get rid
of pflash_cfi01_register() and pflash_cfi02_register() everywhere, not
just avoid it in these three places.

Cc'ing the usual QOM suspects for guidance.
