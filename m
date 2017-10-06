Received: from eggs.gnu.org ([2001:4830:134:3::10]:45989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1e0T9E-0000Q5-VD
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1e0T99-0005FC-7u
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:58:41 -0400
MIME-Version: 1.0
In-Reply-To: <20171006135425.GF26575@redhat.com>
References: <CAEfK_45dZvxvBNQpPLo71ZJhrPN5_GJr8uJ2pJZpCaFf0+i3YA@mail.gmail.com>
	<62e835a4-ba5d-e620-47d2-180932a33426@redhat.com>
	<20171006135425.GF26575@redhat.com>
From: Doug Gale <doug16k@gmail.com>
Date: Fri, 6 Oct 2017 09:58:33 -0400
Message-ID: <CAEfK_444_fPwjnj1M8w8XNFFwiMJW-pdN7R1Tdu+FfvB38ZBtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Patch to add helpful tracing output for driver
 authors in NVMe emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, keith.busch@intel.com, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

I tried to get tracing to work before and I have never gotten it
working. I'll give it another try and redo the patch with tracing
infrastructure if necessary. The printf are nice because the dev can
just look at the terminal where qemu is running. Can you view the
trace output in realtime? When their code is sitting at a breakpoint
in their driver, can they see the last thing that was traced right
there? Or do they have to go run some cumbersome command and wade
through it after an entire test run after the vm shut down?


On Fri, Oct 6, 2017 at 9:54 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Fri, Oct 06, 2017 at 08:50:31AM -0500, Eric Blake wrote:
>> On 10/05/2017 06:18 PM, Doug Gale wrote:
>> > I added the tracing output in this patch to assist me in implementing
>> > an NVMe driver. It helped tremendously.
>> >
>> >>From 1d19086cdef8d492929852d582cb41dcc5026f71 Mon Sep 17 00:00:00 2001
>> > From: Doug Gale <doug16k@gmail.com>
>> > Date: Thu, 5 Oct 2017 19:02:03 -0400
>> > Subject: [PATCH] Add tracing output to NVMe emulation to help driver authors.
>> >
>> > It is off by default, enable it by uncommenting #define DEBUG_NVME
>> > or through CFLAGS
>> >
>> > Signed-off-by: Doug Gale <doug16k@gmail.com>
>> > ---
>> >  hw/block/nvme.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>> >  1 file changed, 177 insertions(+), 14 deletions(-)
>> >
>> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>> > index 9aa32692a3..74220c0171 100644
>> > --- a/hw/block/nvme.c
>> > +++ b/hw/block/nvme.c
>> > @@ -36,6 +36,14 @@
>> >
>> >  #include "nvme.h"
>> >
>> > +//#define DEBUG_NVME
>> > +
>> > +#ifdef DEBUG_NVME
>> > +#define DPRINTF(fmt, ...) fprintf(stderr, "nvme: " fmt "\n", ## __VA_ARGS__)
>> > +#else
>> > +#define DPRINTF(fmt, ...) ((void)0)
>> > +#endif
>>
>> As Kevin said, using trace-events is nicer than fprintf().  But if you
>> absolutely insist on fprintf(), then do NOT do it like this, because
>> this leads to bit-rot.  Instead, do it in a form that lets -Wformat
>> checking work even when tracing is disabled:
>
> [snip]
>
> IMHO using of trace() instead of fprintf() is pretty much mandatory
> at this point. We've been making a concious effort to replace fprintfs
> with trace across code, so shouldn't add more fprintfs. It is just so
> much more useful to be able to enable the debugging without having to
> recompile the binary.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
