Received: from eggs.gnu.org ([209.51.188.92]:54402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hBiIR-0003zs-Hq
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hBiEO-0003jZ-Dg
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:55:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:52729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1hBiEL-0003G3-Ca
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:55:14 -0400
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<CAFEAcA8qyunxOtqrWLPsr34fUt5t2kCrXa8hOMti0bYYbZDpyA@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <a218f29d-7c96-6e88-1590-0a182c99c71d@gmx.de>
Date: Wed, 3 Apr 2019 17:55:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8qyunxOtqrWLPsr34fUt5t2kCrXa8hOMti0bYYbZDpyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On 03.04.19 17:16, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 19:51, Helge Deller <deller@gmx.de> wrote:
>
> [cc'ing Eduardo as the seccomp submaintainer]
>
>> On a non-release architecture, the configure program aborts if the
>> --enable-seccomp flag was given (with no way to work around it on the
>> command line):
>>
>> ERROR: User requested feature libseccomp
>>         configure was not able to find it.
>>         libseccomp is not supported for host cpu parisc64
>
> Surely the workaround is "don't pass --enable-seccomp on
> the configure command line" ?

Sure, that's the easy solution but doesn't work for me.
The only reason why I come up with this patch, is that
on Debian the qemu package fails to build on parisc because
of this issue, as can be seen here:
https://buildd.debian.org/status/logs.php?pkg=3Dqemu&arch=3Dhppa
Debian sets the -enable-seccomp flags, so it fails on parisc
(already in the qemu 1.3 release).
> Our general approach with configure arguments is:
>  --disable-foo means "don't try to look for or use foo"
>  --enable-foo means "use foo, and stop with an error if we can't use
>      foo for any reason (eg not found, version too old)"

Yes, that's OK.

> passing nothing means "look for foo, use it if we can,
>      but if we can't then just silently don't use foo"
>
> So I think if the user specifically asks us to use seccomp on a
> host architecture where it won't work then configure should fail.

True, it should fail if it's not useable.
But In my case, latest libseccomp is avaialble & functional, but
nevertheless configure fails because parisc is not in the white list.

> Is the underlying problem here:
>  * we use a whitelist of host architectures to enable seccomp for
>    and we should not do that (eg blacklist instead, or just allow it
>    for any host architecture)?

Yes, that's one option.
My patch partly does that by allowing -enble-seccomp as long as a
libseccomp package is found.

>  * using a whitelist is ok, but we should add some more host archs to it=
?

I think for non-release architectures there is no need to be too strict.
If something is available, just use it, independend of the architecture.
This solves it not just for parisc...

I'm fine with any solution as long as it works :-)

> What particular host arch are you using?

You already found out in your other mail: hppa/parisc.

Helge
