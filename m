Received: from eggs.gnu.org ([209.51.188.92]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmfFF-0005Nz-ET
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmfDa-0004KT-N2
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:38:55 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmfDa-0004Jm-Gs
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:38:54 -0500
Received: by mail-wm1-x344.google.com with SMTP id m22so3085185wml.3
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:38:54 -0800 (PST)
References: <251451940.431966.1548259107629.ref@mail.yahoo.com>
	<251451940.431966.1548259107629@mail.yahoo.com>
	<20190123180804.GA1040@flamenco>
	<70145779.391347.1548334794441@mail.yahoo.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <70145779.391347.1548334794441@mail.yahoo.com>
Date: Thu, 24 Jan 2019 13:38:51 +0000
Message-ID: <87va2eyy38.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] m68k gdb has stopped single stepping correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Cc: "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>


Lucien Anti-Spam via Qemu-devel <qemu-devel@nongnu.org> writes:

>
>
>    > On Thursday, January 24, 2019, 3:08:07 AM GMT+9, Emilio G. Cota <cot=
a@braap.org> wrote: > > On Wed, Jan 23, 2019 at 15:58:27 +0000, Lucien Anti=
-Spam via Qemu-devel wrote:> > Hi folks,
>> > I noticed that with 3.x release that the GDB options (-S -s) for certa=
in CPU results in very weird stepping.Usually stops afer a few steps, whils=
t the stub continues responding the PC doesnt update, however, I have only =
deeply looked at the m68k.
>> > In the case of the m68K the SR gets the trace bit set (T=3D10b), and t=
he PC doesnt update.The m68k gdbstub, and main gdbstub seem mostly unchange=
d.But it seems the INSN handling has changed greatly for the m68k.
>> > Does anyone have any ideas what happened?>> Can you please bisect to f=
ind at which point things start misbehaving?
>>
>> Thanks,
>>  Emilio
> Understood, I was hoping my original post might jog someone's memory abou=
t the issue.
> Apparently not, so after some digging I found that it was introduced with=
 the refactor to TranslatorOps, specifically two lines got dropped that upd=
ate the PC if single-stepping is being performed ( commit 11ab74b01e0a8ea49=
73eed89c6b90fa6e4fb9fb6 )
> Since its not valid to revert, shall I go ahead and submit a patch for
> these two lines?

Yes please!

> Also I noticed a lack of gdb-stub tests, but there are cpu tests (eg. che=
ck-qtest-m68k).  I was considering it might be interesting to write some ba=
sic network code to send / receive gdb packets to re-use these cpu tests fo=
r step, break-point, register update, and so on.
> I saw a gdb-python test but I felt this would need specific kernel \
> gdb for each cpu with is likely to end in a lot of problems getting
> right gdbs - simple packet send/receive/check would be better?

The gdb-python test works should work with pretty much any kernel image
but is currently only run manually. It only really sets breakpoints at
common points in the kernel and doesn't need a rootfs to complete.

So it's useful for bisecting but it would be nice to have proper
integrated tests. I basically submitted it so it wouldn't just languish
in my own magic directory of random tests.

> What do people think, what would be the right approach to this?

Once thing we have now is tests/tcg and the infrastructure for building
foreign binaries on most developer systems. We can certainly leverage
those to have a nice test binary which we can use to exercise gdbstub
for linux-user debugging with the appropriate wrapping of gdb and
launching a guest.

There is also a WIP series I posted:

  Subject: [RFC PATCH  00/13] Enabling tcg/tests for xtensa, mips and cris
  Date: Mon, 10 Dec 2018 15:28:16 +0000
  Message-Id: <20181210152829.29271-1-alex.bennee@linaro.org>

Which makes the tests/tcg infrastructure aware of softmmu targets (used
for system emulation). We could certainly build a mini-stub of an OS
using this to exercise the system gdbstub. You could just use the
existing binaries we use for migration testing although it would be nice
to have them in source form as well.

You might want to look at the avocado tests - they may be better suited
for coordinating several binaries talking to each other (although the
existing qtest tests do do something similar).

>
> Cheers,Luc
>
>


--
Alex Benn=C3=A9e
