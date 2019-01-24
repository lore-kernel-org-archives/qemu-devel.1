Received: from eggs.gnu.org ([209.51.188.92]:54485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1gmldE-0003Rc-O9
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1gmldD-0002zO-Gu
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:29:48 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:55668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1gmldD-0002z4-9X
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:29:47 -0500
Received: by mail-it1-x144.google.com with SMTP id m62so7109231ith.5
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20190124040457.2546-1-doug16k@gmail.com>
	<CAFEAcA9fVkGEMPUaSapn6YOV0DR_rS17pWKZHTxQz0aCM+et3g@mail.gmail.com>
In-Reply-To: <CAFEAcA9fVkGEMPUaSapn6YOV0DR_rS17pWKZHTxQz0aCM+et3g@mail.gmail.com>
From: Doug Gale <doug16k@gmail.com>
Date: Thu, 24 Jan 2019 16:59:35 -0330
Message-ID: <CAEfK_460635_tXwDLoKGhMQ7smz0Gy2OVLBMQpU8GrhxA02ywA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Fix i386/x86_64 machine
 description and add control registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

The machine description we send is being (silently) thrown on the floor by
GDB and GDB silently uses the default machine description.

With current QEMU, if you debug gdb, and set debug_xml=1 and continue, then
attach to qemu gdbstub from the debugged gdb, you will see the xml parse
fail completely, and gdb will fall back to the default machine description,
silently, and changes to our xml (in qemu source code) have no effect. They
might as well be empty.

The point of fixing the machine description was IDE's with GDB integration
will break on QEMU. The default machine description has fs_base, which
fails to be retrieved, whick breaks the whole register window (in
qt-creator at least, likely others). With my patch the register window
works perfectly.

I didn't delete anything, I removed the superfluous nesting of files by
xi:include and moved the description into a single xml file. I added
fs_base, gs_base, k_gs_base, cr0/2/3/4/6, efer.

Removing the nesting into xml includes fixes it because the xml parse fails
on <feature nested within <feature, so I solved it by removing unnecessary
include indirections and placed the data inline.

I tried lots of things to fix the nesting. After a while I asked, why
bother? It doesn't need to go through that include level of indirection
does it?

This patch leads to another patch I want to submit later, which fixes the
broken real mode and protected mode debugging on x86_64. I want to add the
ability to turn off the "always 64 bit registers" hack that works around
'g' packet too large. You fix that by patching gdb (which then reacts to
packet to large with realloc instead of freaking out), not by breaking real
and protected mode debugging on x86_64 target by forcing always-64-bit. My
intention is to default to current behavior and have a command line switch
that enables changing register sizes (fixing real and protected mode
debugging on x86_64).

This patch includes a FORCE_64 define that will be replaced by a check for
the option that indicates patched gdb and "register size change ok mode".


On Thu, Jan 24, 2019 at 6:44 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 24 Jan 2019 at 04:08, Doug Gale <doug16k@gmail.com> wrote:
> >
> > Signed-off-by: Doug Gale <doug16k@gmail.com>
> > ---
> >  configure                   |   4 +-
> >  gdb-xml/i386-32bit-core.xml |  65 -----------
> >  gdb-xml/i386-32bit-sse.xml  |  52 ---------
> >  gdb-xml/i386-32bit.xml      | 184 ++++++++++++++++++++++++++++++-
> >  gdb-xml/i386-64bit-core.xml |  73 -------------
> >  gdb-xml/i386-64bit-sse.xml  |  60 -----------
> >  gdb-xml/i386-64bit.xml      | 210 +++++++++++++++++++++++++++++++++++-
> >  target/i386/cpu.c           |   4 +-
> >  target/i386/gdbstub.c       | 186 +++++++++++++++++++++++++++++++-
> >  9 files changed, 573 insertions(+), 265 deletions(-)
> >  delete mode 100644 gdb-xml/i386-32bit-core.xml
> >  delete mode 100644 gdb-xml/i386-32bit-sse.xml
> >  delete mode 100644 gdb-xml/i386-64bit-core.xml
> >  delete mode 100644 gdb-xml/i386-64bit-sse.xml
>
> Could you provide a commit message that explains what's
> wrong with the machine description we have (ie what bug
> or bugs this change is fixing) and why deleting half
> the xml files is the right way to fix it, please?
>
> Does the "add control registers" part need to be in
> the same patch, or is it a separate feature which
> could be in its own patch ?
>
> thanks
> -- PMM
>
