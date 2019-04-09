Received: from eggs.gnu.org ([209.51.188.92]:44576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hDwnp-00056g-ML
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hDwno-0002kA-JE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:53:05 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:38016
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hDwno-0002jq-91
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:53:04 -0400
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
	<740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
Date: Tue, 9 Apr 2019 21:46:40 +0200
MIME-Version: 1.0
In-Reply-To: <740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Samuel Thibault <samuel.thibault@ens-lyon.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 05.04.19 11:16, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/5/19 11:02 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Apr 05, 2019 at 10:47:54AM +0200, Philippe Mathieu-Daud=C3=A9 =
wrote:
>> Do the various crashes that you illustrate in that cover letter
>> still exist today ? If so, 2 years of continued brokenness with no
>> fixes would reinforce the the view that it is time to remove TCI
>> from the codebase.
>=20
> Or find a maintainer and add tests...

Thank you for CC'ing me. I could not spend much of my free time for QEMU
last year and typically will miss important messages on the list unless
my address is explicitly given. Nevertheless I still feel responsible
for TCI, and I am also listed as maintainer in MAINTAINERS.

In the past there was only limited use of TCI (as far as I know), and
the current implementation worked for many applications, for example to
count the frequency of TCG opcodes.

The known problems with the current implementation are

* Misaligned memory accesses. This should be easy to fix. I already sent
a patch (currently discussed) which fixed user mode emulation on ARM for =
me.

* Calling conventions. The current implementation works on many hosts,
but for example not on Sparc. A fix would require simple calling
conventions for all helper functions (for example stack based argument
passing, can this be enforced?), or it needs to know the signature of
each helper function at runtime. I'm afraid that fixing this would
require much work. A runtime test whether calls of helper functions work
correctly could be implemented easily and could abort the program
execution when calls fail to pass the right arguments. Would such a
runtime test help a little bit?

* Performance. It can be improved a bit by implementing more TCG opcodes
for the interpreter, but of course TCI is slower than TCG (which is
slower than KVM).

Cheers
Stefan
