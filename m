Received: from eggs.gnu.org ([209.51.188.92]:50210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxzjU-0001uV-QS
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxzjU-00011U-0v
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:46:40 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxzjT-0000zp-Aa
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:46:39 -0500
Received: by mail-oi1-x22a.google.com with SMTP id e7so5624822oia.8
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 11:46:38 -0800 (PST)
MIME-Version: 1.0
References: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
In-Reply-To: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 Feb 2019 19:46:27 +0000
Message-ID: <CAFEAcA8VzJRMSThWQ=CgNbB8BY0EAmi77oAJuHQt5iQnkiZmzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] x86 segment limits enforcement with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sun, 24 Feb 2019 at 19:37, Stephen Checkoway
<stephen.checkoway@oberlin.edu> wrote:
> I think that something about adding the tcg_gen_brcond_tl is causing values to become dead and then qemu aborts.

Yep -- all "TCG temporaries" are dead at the end
of a basic block, and brcond ends a basic block.
Only globals and "local temporaries" stay live
across brcond. This is documented in tcg/README,
though it doesn't spell it out very explicitly.

This makes brcond pretty painful to use and
almost impossible to introduce into the middle
of some existing sequence of generated code.
I haven't looked at what the best way to do what
you're trying to do here is, though.

By the way, don't do this:
+    dc->A1 = tcg_temp_new();

The current use of a small number of tcg temps
in the i386 translate.c code is an antipattern
that is a relic from a very old version of the
code. It's much better to simply create new
temporaries in the code at the point where you
need them and then free them once you're done.

thanks
-- PMM
