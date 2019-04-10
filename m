Received: from eggs.gnu.org ([209.51.188.92]:58492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hE6dV-0007bD-Ak
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hE6dU-0001ka-3t
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:23:05 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:52906
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hE6dT-0001kD-OL
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 02:23:04 -0400
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
	<740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
	<a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
	<35359e2b-7f07-8815-4f2b-f1435abc4e63@linaro.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <526e88d8-1c5e-1598-6ad3-9b4152ece556@weilnetz.de>
Date: Wed, 10 Apr 2019 08:17:27 +0200
MIME-Version: 1.0
In-Reply-To: <35359e2b-7f07-8815-4f2b-f1435abc4e63@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Aurelien Jarno <aurelien@aurel32.net>

On 09.04.19 22:39, Richard Henderson wrote:
> On 4/9/19 9:46 AM, Stefan Weil wrote:
>> * Calling conventions. The current implementation works on many hosts,
>> but for example not on Sparc. A fix would require simple calling
>> conventions for all helper functions (for example stack based argument
>> passing, can this be enforced?), or it needs to know the signature of
>> each helper function at runtime. I'm afraid that fixing this would
>> require much work. A runtime test whether calls of helper functions wo=
rk
>> correctly could be implemented easily and could abort the program
>> execution when calls fail to pass the right arguments. Would such a
>> runtime test help a little bit?
>=20
> In the rewrite of tci that I proposed some years ago,
> I used libffi for this.
>=20
> Those patches could probably be recovered...
>=20
> https://patchwork.ozlabs.org/patch/348528/
> https://patchwork.ozlabs.org/patch/348527/


The first patch is the important one because it adds the signature to
each helper function. As soon as this information is passed to the
interpreter, the rest is simple. It should not be necessary to add a new
dependency on libffi, because there are no foreign calling conventions
here: all helpers use the C calling convention of the host architecture.

The TCG implementation for Sparc (and other hosts with special calling
conventions) must also have some minimum information on the signatures
of the helper functions. It should be possible to use the same
information for TCI. Maybe your approach ist a general form which could
be used for any TCG implementation.

Stefan
