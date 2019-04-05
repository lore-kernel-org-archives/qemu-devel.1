Received: from eggs.gnu.org ([209.51.188.92]:51432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKW1-000562-Hi
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKW0-0007fN-1n
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:48:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKVy-0007eP-FB
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:47:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so6931714wra.12
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 01:47:57 -0700 (PDT)
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
Date: Fri, 5 Apr 2019 10:47:54 +0200
MIME-Version: 1.0
In-Reply-To: <b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Aurelien Jarno <aurelien@aurel32.net>

Hi Helge,

On 4/5/19 9:56 AM, Helge Deller wrote:
> On 05.04.19 03:34, Peter Maydell wrote:
>> On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
>>> If a non-release architecture is found, and it's known that there is no
>>> native TCG support for that CPU, automatically fall back to the TCI
>>> implementation instead of requesting the user to run configure again
>>> with the --enable-tcg-interpreter option.
>>>
>>> This change simplifies building qemu in automatic build environments
>>> (like in my case the debian buildds) because one does not need to
>>> special case on the architectures.
>>
>> I don't think we should do this. TCI is unmaintained, has several
>> known flaws,
> 
> Just out of interest: Is there a list with those flaws somewhere?

The last big discussion is in this thread:
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06528.html

>> does not provide the level of performance that
>> people expect from QEMU, and we've talked about removing it
>> altogether. In particular, distros should not automatically ship
>> a TCI QEMU -- it's something that a user can use if they
>> explicitly opt into but which I don't think we want to surprise
>> anybody with.
> 
> I won't argue against your points. They are all valid.
> 
>> If we care about a host architecture we should support it
>> with a proper TCG backend. If we don't care that much we
>> shouldn't support it.
> 
> Looking just at some of the debian "ports" (non-release) architectures:
> alpha, hppa, ia64, m68k, powerpc, sh4, sparc64
> Most likely nobody will ever care enough to write a TCG backend for those,
> and it doesn't even make sense because they are so much slower than
> the currently supported TCG backend architectures. So why should one want
> to emulate a fast x86 machine on slow m68k for example?

>From experience: when a m68k compiler is only provided as a x86 binary
and you want to recompile m68k code on an embedded m68k with no network
access.

Another example appeared last year on the list, when using a binary
compiled for a more recent ISA on an outdated ISA.

> The only reason when it *can* make sense is, when you need "basic"
> emulation or availability of binaries for cross-dependecies in distros,
> e.g. to build other packages or to be able to install other packages.
> As one example, many packages depend on libvirt (frontend tools, monitoring
> stuff, ...) and libvirt again depends on some qemu binaries.
> So, having qemu buildable (even if the result is slow) makes life easier.
> 
> I know, my point above now turns into a "distro packaging" issue.
> That's why I'm questioning, why should distros (or even direct end-users)
> be forced to distinguish between architectures?
> Shouldn't running "./configure" find out what's available and then
>  auto-configure itself to the *best* what's possible?
> 
> And, my patch still prints the warning that that's an unsupported
> architecture, at the end of configure there is still the big warning
> about "*this architecture may go away*", and if someone complains about
> performance on such an architecture you can still happily invite him to
> write the TCG backend.
> 
> Anyway, if you think Philippe's suggestion of "why not add a "hppa" case selecting
> TCI in the switch?" is the better solution, then I'm happy to send such a patch
> instead.

I suggested that as a "less worth" approach, but I'm 100% with Peter on
this.
I understand your use and still think this should be handled by Debian
for his "ports" (non-release) architectures, as an explicit selected
option on the list you mentioned (alpha, hppa, ia64, m68k, powerpc, sh4,
sparc64).
