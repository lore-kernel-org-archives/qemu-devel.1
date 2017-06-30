Received: from eggs.gnu.org ([2001:4830:134:3::10]:44559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQsAp-0002cU-5S
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQsAn-0003Oh-GV
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:25:11 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQsAn-0003Mm-66
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:25:09 -0400
Received: by mail-wm0-x234.google.com with SMTP id b184so39539786wme.1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 02:25:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6b33a0d9-524c-6125-4623-2eb9ef5f36a6@weilnetz.de>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<6b33a0d9-524c-6125-4623-2eb9ef5f36a6@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Jun 2017 10:24:47 +0100
Message-ID: <CAFEAcA_PYVTLDFjrYFoATKn=tBAJ=bLT4aWY54MvybjVKTo7fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>

On 29 June 2017 at 19:09, Stefan Weil <sw@weilnetz.de> wrote:
> Nevertheless QEMU is the only software which I know which not
> only addresses the needs for server / PC virtualisation, but
> also is useful for researchers and scientists, archivists,
> learners and teachers or experimenters.
>
> Up to now, I had the impression that QEMU is sufficiently modular
> so that the different perspectives and expectations could be
> supported without harming each other too much. The only drawback
> was additional code (which would not be needed when focussing on
> a single perspective) causing additional compilation time
> and more (formal, mostly automated) file changes for code clean
> ups and API=E2=80=8C changes.

Yes, the whole of TCG demonstrates that we're not purely
trying to be a virtual-machine-usecase-only codebase,
so certainly there is scope for having multiple parts
and uses in QEMU.

I think the part of TCI that makes it stand out as awkward
here is that it is an option that you have to pick at
configure time, and enabling it disables the standard
TCG backend. If it was a runtime option to use the
interpreter rather than the codegen (in the same way that
you can runtime select between KVM and TCG), I think that
would help a lot:
 * reduces the number of build configs we need to test
 * means it's accessible to the bulk of users who use their
   distro's build of QEMU rather than rolling their own
 * less of a beartrap for users who enable the config
   option and then wonder why QEMU is running so slowly
 * opens the possibility of using the interpreter as part
   of mainstream TCG (eg in the cases of "execute one
   insn and throw it away, which might be faster
   interpreted in theory)

TCI is also awkward because it means we don't really know
what the set of platforms we run on is. (For instance I'd
like to fix our configure script which currently uses 'uname'
as a fallback for identifying target CPU and OS, which
is totally wrong for cross-compile. It would be easier to
be sure such a refactor was correct if we knew which
hosts we could possibly run on...)

That to me all adds up to a position where while I don't
care enough to take active steps to remove TCI from QEMU,
I wouldn't be unhappy to see it go if other people strongly
support removal, and if nobody's interested in trying to
fix its problems.

thanks
-- PMM
