Received: from eggs.gnu.org ([2001:4830:134:3::10]:39142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAe8i-0003qQ-Nv
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAe8e-0005D4-2e
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:16:28 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAe8d-0005BX-TR
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:16:24 -0400
Received: by mail-oi0-x243.google.com with SMTP id y15-v6so6847059oia.13
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 09:16:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c7e00162-cf50-0194-d283-17e7dc8fae56@linux.ibm.com>
References: <c7e00162-cf50-0194-d283-17e7dc8fae56@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 17:16:02 +0100
Message-ID: <CAFEAcA-KJb6L0bCKQAE-TjfSQg6OSb0JvumGjVyYYTE46mdKbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] configure script mistakenly detects static
 libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: muriloo@linux.ibm.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 April 2018 at 17:10, Murilo Opsfelder Araujo
<muriloo@linux.ibm.com> wrote:
> Hi, everyone!
>
> I'm facing an issue on how configure script detects static libraries and
> would like to hear from community to find a common ground on how to
> possibly fix it.
>
> Throughout configure, we use pkg-config command to verify if a library
> is installed so qemu can be linked to it. This works fine when linking
> qemu dynamically. However, configuring qemu with --static can mistakenly
> detect a library that is actually not present on the system.
>
> For example, on Ubuntu Xenial, libcacard-dev package provides only
> libcacard.so (not libcacard.a) and pkg-config reports success in both
> cases:
>
>     $ pkg-config libcacard
>     $ echo $?
>     0
>
>     $ pkg-config --static libcacard
>     $ echo $?
>     0
>
> Since we use `pkg-config libcacard` to set smartcard=yes, this
> mistakenly enables smartcard feature. This is acceptable with dynamic
> linkage, but can be an issue with static linkage, where libcacard.a
> doesn't exist on the system, resulting on a build error:

This seems to me to be an error in your distro's pkg-config information.
If static linking against libcacard doesn't work, then
"pkg-config --static libcacard" should fail.

Unfortunately IME the static linking support in distro-suppled
pkgconfig files is rarely tested, so it's not uncommon for it to
be broken.

>From an upstream QEMU point of view, we primarily support --static
for the benefit of the linux-user binaries, not for system emulation.
So we care more if a "configure --disable-system --disable-tools --static"
build doesn't work, than if the problem is only with features used
by the system emulator binaries.

thanks
-- PMM
