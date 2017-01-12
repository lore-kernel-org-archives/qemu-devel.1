Received: from eggs.gnu.org ([2001:4830:134:3::10]:46418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRcjz-0007uq-Ey
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRcjx-0004L2-0W
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:36:19 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:33597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRcjw-0004Kt-Qq
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:36:16 -0500
Received: by mail-ua0-x230.google.com with SMTP id i68so11133094uad.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:36:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112040534.15179-1-rth@twiddle.net>
References: <20170112040534.15179-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 10:35:55 +0000
Message-ID: <CAFEAcA_zdUzt1E307v2W1e4C+YksEEN9aAot5GAacSSrt-R1Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] linux-user: Use *at functions instead of
 caching interp_prefix contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 12 January 2017 at 04:05, Richard Henderson <rth@twiddle.net> wrote:
> If the interp_prefix is a complete chroot, it may have a *lot* of files.
> Setting up the cache for this is quite expensive.  Instead, use the *at
> versions of various syscalls to attempt the operation in the prefix.
>

Presumably this also fixes the completely broken handling of
symlinks in the interp_prefix tree?

Unfortunately patch will break bsd-user as it stands,
because bsd-user also calls init_paths. There's also a
usage in tests/tcg/.

Awkward problem: I suspect you'll find this breaks a few
guest programs which don't like the fact that there's now
an open fd which doesn't belong to the guest. (For instance
IIRC some LTP test programs do "check that the rlimit on
number of open files hits after opening exactly N files".)

Incidentally it's a shame C doesn't make it easier to
abstract out the repeated pattern

        switch (PATHNAME[0]) {
        case '/':
            ret = SOMEFN(interp_dirfd, PATHNAME + 1, STUFF);
            if (ret == 0 || errno != ENOENT) {
                break;
            }
            /* fallthru */
        default:
            ret = SOMEFN(FD, PATHNAME, STUFF);
            break;
        }

(and the variant which uses a 2nd function).

A macro would get awkwardly heavily parameterised, I think.

thanks
-- PMM
