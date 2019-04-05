Received: from eggs.gnu.org ([209.51.188.92]:42668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCJiY-0006ML-UI
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCJiX-00085G-Ci
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:56341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1hCJiX-0007xI-0L
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:53 -0400
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
Date: Fri, 5 Apr 2019 09:56:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

Hi Peter,

On 05.04.19 03:34, Peter Maydell wrote:
> On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
>> If a non-release architecture is found, and it's known that there is no
>> native TCG support for that CPU, automatically fall back to the TCI
>> implementation instead of requesting the user to run configure again
>> with the --enable-tcg-interpreter option.
>>
>> This change simplifies building qemu in automatic build environments
>> (like in my case the debian buildds) because one does not need to
>> special case on the architectures.
>
> I don't think we should do this. TCI is unmaintained, has several
> known flaws,

Just out of interest: Is there a list with those flaws somewhere?

> does not provide the level of performance that
> people expect from QEMU, and we've talked about removing it
> altogether. In particular, distros should not automatically ship
> a TCI QEMU -- it's something that a user can use if they
> explicitly opt into but which I don't think we want to surprise
> anybody with.

I won't argue against your points. They are all valid.

> If we care about a host architecture we should support it
> with a proper TCG backend. If we don't care that much we
> shouldn't support it.

Looking just at some of the debian "ports" (non-release) architectures:
alpha, hppa, ia64, m68k, powerpc, sh4, sparc64
Most likely nobody will ever care enough to write a TCG backend for those,
and it doesn't even make sense because they are so much slower than
the currently supported TCG backend architectures. So why should one want
to emulate a fast x86 machine on slow m68k for example?

The only reason when it *can* make sense is, when you need "basic"
emulation or availability of binaries for cross-dependecies in distros,
e.g. to build other packages or to be able to install other packages.
As one example, many packages depend on libvirt (frontend tools, monitorin=
g
stuff, ...) and libvirt again depends on some qemu binaries.
So, having qemu buildable (even if the result is slow) makes life easier.

I know, my point above now turns into a "distro packaging" issue.
That's why I'm questioning, why should distros (or even direct end-users)
be forced to distinguish between architectures?
Shouldn't running "./configure" find out what's available and then
 auto-configure itself to the *best* what's possible?

And, my patch still prints the warning that that's an unsupported
architecture, at the end of configure there is still the big warning
about "*this architecture may go away*", and if someone complains about
performance on such an architecture you can still happily invite him to
write the TCG backend.

Anyway, if you think Philippe's suggestion of "why not add a "hppa" case s=
electing
TCI in the switch?" is the better solution, then I'm happy to send such a =
patch
instead.

Helge
