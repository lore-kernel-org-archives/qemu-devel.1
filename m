Received: from eggs.gnu.org ([2001:4830:134:3::10]:47286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewB0k-0000yM-4x
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewB0j-0006qO-5O
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:20:26 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:46305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewB0i-0006pn-RW
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 14:20:25 -0400
Received: by mail-oi0-x233.google.com with SMTP id x12so3483475oie.13
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:20:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180314120906.30872-1-berrange@redhat.com>
References: <20180314120906.30872-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Mar 2018 18:20:03 +0000
Message-ID: <CAFEAcA8fEJxyc25a+BydGqHH4FcG=-Kvqcxgmdrar=L6tHFMDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] configure: shorthand for only enabling
 native softmmu target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 March 2018 at 12:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> With the huge number of QEMU targets, a default configuration will take
> a very long time to rebuild. When developing most code changes, it is
> sufficient to test compilation with a single target - rebuilding all
> targets just extends compile times while not detecting any new problems.
>
> Developers will often thus specify a single target for configure,
> commonly matching the host architecture. eg
>
>   ./configure --target-list=3Dx86_64-softmmu
>
> This works fine, but is a bit of a verbose thing to type out everytime
> configure is invoked. There are already short-hand args to disable all
> user targets, all softmmu targets, or all tcg targets. This adds one
> further shorthand to disable all non-native architecture targets.
>
>   ./configure --native

How common actually is that, though? Almost all the time when
I'm picking targets I want something that's *not* the native
target...

More to the point, I actually only fairly rarely run configure
by hand at all. I have a source tree, with a subdir build/
which I have lots of subdirectories of for each config I
care about or have cared about. So if I want to do something
with sparc I'll just use 'make -C build/sparc' which will
automatically rerun configure with the right arguments, because
they're in the config.status in that build tree.

And as Alex points out you already usually want to feed
configure a pile of options, like --enable-debug. I also
like --with-pkgversion=3Dfoo, because without that the
version depends on the git commit hash, which means
every time the git hash changes multiple files and
executables get pointlessly rebuilt because the version
string changed. Keeping build dirs around means that
all this sort of customisation of options stays around.

So I'm not hugely keen on this patch, because it saves
20 characters on a command line that really ought not to
need typing more than once a month at most, but it
adds another messy case statement in configure that
knows about multiple architecture and subarchitecture
names.

thanks
-- PMM
