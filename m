Received: from eggs.gnu.org ([209.51.188.92]:60702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go7Fo-0006I0-Id
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go7Fn-0000BF-S2
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:47:12 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:44443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go7Fn-00007h-I4
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:47:11 -0500
Received: by mail-oi1-x22d.google.com with SMTP id m6so12995001oig.11
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 05:47:11 -0800 (PST)
MIME-Version: 1.0
References: <CAChFQ9RDi+VK_EERZsPB6UK_DpL-LDs97A6VivYSbuk=0VKP7A@mail.gmail.com>
In-Reply-To: <CAChFQ9RDi+VK_EERZsPB6UK_DpL-LDs97A6VivYSbuk=0VKP7A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 13:46:57 +0000
Message-ID: <CAFEAcA9gvX_9HDadd1VaC214CLDg7w1dOdCaKXuG5PXxC+-quA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Building nsis installer - cross compile for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adam Baxter <voltagex@voltagex.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On Mon, 28 Jan 2019 at 13:34, Adam Baxter <voltagex@voltagex.org> wrote:
>
> I'm getting stuck trying to build the NSIS installer for Windows
>
>
> export CFLAGS="-Wno-stringop-truncation"
> ./configure --python=$(command -v python3)
> --cross-prefix=x86_64-w64-mingw32- --enable-docs
> echo 3.99.99 > VERSION
> make -j`nproc`
> make -j`nproc` installer
>
> results in:

> File: "/tmp/qemu-nsis\*.bmp" -> no files found.
> Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
>    /oname=outfile one_file_only)
> Error in script "/drone/src/qemu.nsi" on line 122 -- aborting creation process
> make: *** [Makefile:915: qemu-setup-3.99.99.exe] Error 1

I suspect this is because we've recently removed the
qemu-icon.bmp but didn't update the NSIS installer script,
which is now looking for a wildcard that doesn't match anything
(and isn't trying to install the new .png icon files).
If you try this on a commit before a8260d3876389eb52 does it
work?

qemu-icon.bmp seems also to still be listed in the LINKS
in configure which defines what we symlink from the source
tree to the build tree (and again, the png files are not).

thanks
-- PMM
