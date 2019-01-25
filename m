Received: from eggs.gnu.org ([209.51.188.92]:54283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmyAY-0001lu-Lf
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmyAX-0000zC-K3
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:53:02 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmyAV-0000tQ-Mk
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:53:01 -0500
Received: by mail-oi1-x244.google.com with SMTP id w13so7226710oiw.9
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 01:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20190124040457.2546-1-doug16k@gmail.com>
	<CAFEAcA9fVkGEMPUaSapn6YOV0DR_rS17pWKZHTxQz0aCM+et3g@mail.gmail.com>
	<CAEfK_460635_tXwDLoKGhMQ7smz0Gy2OVLBMQpU8GrhxA02ywA@mail.gmail.com>
In-Reply-To: <CAEfK_460635_tXwDLoKGhMQ7smz0Gy2OVLBMQpU8GrhxA02ywA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 09:52:46 +0000
Message-ID: <CAFEAcA9AhBLS4J+bsv_srq0qw1PXeUF346Y_J0cujgfH+tFOJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Doug Gale <doug16k@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 24 Jan 2019 at 20:29, Doug Gale <doug16k@gmail.com> wrote:
> The machine description we send is being (silently) thrown on the floor b=
y GDB and GDB silently uses the default machine description.
>
> With current QEMU, if you debug gdb, and set debug_xml=3D1 and continue, =
then attach to qemu gdbstub from the debugged gdb, you will see the xml par=
se fail completely, and gdb will fall back to the default machine descripti=
on, silently, and changes to our xml (in qemu source code) have no effect. =
They might as well be empty.
>
> The point of fixing the machine description was IDE's with GDB integratio=
n will break on QEMU. The default machine description has fs_base, which fa=
ils to be retrieved, whick breaks the whole register window (in qt-creator =
at least, likely others). With my patch the register window works perfectly=
.
>
> I didn't delete anything, I removed the superfluous nesting of files by x=
i:include and moved the description into a single xml file. I added fs_base=
, gs_base, k_gs_base, cr0/2/3/4/6, efer.
>
> Removing the nesting into xml includes fixes it because the xml parse fai=
ls on <feature nested within <feature, so I solved it by removing unnecessa=
ry include indirections and placed the data inline.


Thanks for this explanation -- the patch makes a lot more sense with it.
I'm confused though -- the XML we ship is basically what gdb itself
ships and uses internally:
https://sourceware.org/git/gitweb.cgi?p=3Dbinutils-gdb.git;a=3Dblob;f=3Dgdb=
/features/i386/i386.xml;h=3Dbeb1496d9773efcf0e0526dc540a5e206a2e21fc;hb=3DH=
EAD

and that uses xi:include to pull in the other files.
So it seems odd that gdb can't parse the XML it is using
itself internally. Maybe QEMU is doing something else wrong
somewhere?

thanks
-- PMM
