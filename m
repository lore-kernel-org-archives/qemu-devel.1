Received: from eggs.gnu.org ([2001:4830:134:3::10]:49343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxIdY-00076Z-Nt
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxIdX-00039S-Sq
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:13:24 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fxIdX-00038P-Db
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 17:13:23 -0400
Received: by mail-oi0-x243.google.com with SMTP id k81-v6so9544232oib.9
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 14:13:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180904210036.7317-1-jcmvbkbc@gmail.com>
References: <20180904210036.7317-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Sep 2018 22:13:02 +0100
Message-ID: <CAFEAcA-AyrFVYWkM+_aBQ8eXH-03UZfgiHrB37v=-iM+A=70DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: do setrlimit selectively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 4 September 2018 at 22:00, Max Filippov <jcmvbkbc@gmail.com> wrote:
> When running 32-bit guest on 64-bit host setrlimit guest calls that
> affect memory resources (RLIMIT_{AS,DATA,STACK}) don't always make sense
> as is. They may result in QEMU lockup because mprotect call in
> page_unprotect would fail with ENOMEM error code, causing infinite loop
> of SIGSEGV. E.g. it happens when running libstdc++ testsuite for xtensa
> target on x86_64 host.
>
> Don't call host setrlimit for memory-related resources when running
> 32-bit guest on 64-bit host.

I think the issue here is not related to 32-on-64 but to the fact
that we just pass through the memory rlimits. What we should ideally
be doing is tracking the actual guest memory allocations sufficiently
that we can then apply the rlimits at the QEMU level, so that guest
allocations that breach limits can be failed, without ever causing
QEMU's own alloactions to fail. (There's a bug in launchpad somewhere
about this -- an autoconf test for some obscure printf bug tries
to set a low rlimit and makes QEMU fall over.)

Unfortunately adding tracking of how much memory the guest has
allocated is probably non-trivial...

thanks
-- PMM
