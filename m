Received: from eggs.gnu.org ([209.51.188.92]:46643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBhd3-0000xX-Tz
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBhcw-0000M6-Hy
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:16:38 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBhcq-0008C8-Np
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:16:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id s24so15700470otk.13
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 08:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124948.GA14129@ls3530.dellerweb.de>
In-Reply-To: <20190403124948.GA14129@ls3530.dellerweb.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Apr 2019 22:16:15 +0700
Message-ID: <CAFEAcA8qyunxOtqrWLPsr34fUt5t2kCrXa8hOMti0bYYbZDpyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 3 Apr 2019 at 19:51, Helge Deller <deller@gmx.de> wrote:

[cc'ing Eduardo as the seccomp submaintainer]

> On a non-release architecture, the configure program aborts if the
> --enable-seccomp flag was given (with no way to work around it on the
> command line):
>
> ERROR: User requested feature libseccomp
>         configure was not able to find it.
>         libseccomp is not supported for host cpu parisc64

Surely the workaround is "don't pass --enable-seccomp on
the configure command line" ?

Our general approach with configure arguments is:
 --disable-foo means "don't try to look for or use foo"
 --enable-foo means "use foo, and stop with an error if we can't use
     foo for any reason (eg not found, version too old)"
passing nothing means "look for foo, use it if we can,
     but if we can't then just silently don't use foo"

So I think if the user specifically asks us to use seccomp on a
host architecture where it won't work then configure should fail.

Is the underlying problem here:
 * we use a whitelist of host architectures to enable seccomp for
   and we should not do that (eg blacklist instead, or just allow it
   for any host architecture)?
 * using a whitelist is ok, but we should add some more host archs to it?
 * something else?

What particular host arch are you using?

thanks
-- PMM
