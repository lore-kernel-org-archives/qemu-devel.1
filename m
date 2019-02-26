Received: from eggs.gnu.org ([209.51.188.92]:41871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyaYl-0007PE-9H
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyaYk-0003gm-Ej
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:06:03 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyaYk-0003gG-5w
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:06:02 -0500
Received: by mail-oi1-x244.google.com with SMTP id u128so9999543oie.2
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 03:06:01 -0800 (PST)
MIME-Version: 1.0
References: <201902230335.59138.randrianasulu@gmail.com>
	<201902252029.28990.randrianasulu@gmail.com>
	<6de6b2df-380a-75dd-b3e9-4197ca4db866@redhat.com>
	<201902261158.09086.randrianasulu@gmail.com>
	<e9d2cf10-0c52-a1b6-2be9-e396bd76cf2f@redhat.com>
In-Reply-To: <e9d2cf10-0c52-a1b6-2be9-e396bd76cf2f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 11:05:48 +0000
Message-ID: <CAFEAcA8idrLohrWrieChU1Mm55NVaiEAXYQZEcNP5Dy2QjqeKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Build error with git commit
 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Andrew Randrianasulu <randrianasulu@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 26 Feb 2019 at 09:06, Thomas Huth <thuth@redhat.com> wrote:
> Ok, then that's the problem here: GCC often produces some additional
> "may be unused" warnings with -O3, and we normally only guarantee that
> QEMU compiles without warnings when using the standard -O2 optimization
> level.
> So if you want to compile with -O3, you also have to specify
> --disable-werror (or add -Wno-error=maybe-unitialized to the CFLAGS).
> But unless you have really an urgent need for O3, I'd rather recommend
> to compile with the well-tested O2 optimization level instead.

I think in general we should probably look at fixing warnings
that occur at -O3 when they're reported to us, even if we don't
habitually build that way. But, like using bleeding-edge versions of
gcc or clang, if you use an odd set of optimization flags you might
find you run into warnings we haven't seen yet and need to make them
non-fatal with --disable-werror. (--disable-werror is the default for
releases, so you'll only get compile failures if building from git.)

Actual "QEMU is broken when built with -O3" issues are definitely
worth investigating since they imply either a QEMU bug or a
compiler bug.

PS: in general -O3 is not necessarily going to generate better code
than -O2 if used as a blanket optimization setting -- it can
end up generating larger code that increases icache pressure.
Probably best used carefully and when benchmarking shows that
it's actually an improvement.

thanks
-- PMM
