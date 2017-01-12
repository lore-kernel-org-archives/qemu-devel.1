Received: from eggs.gnu.org ([2001:4830:134:3::10]:44110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRi84-000284-Nf
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRi82-0004Z1-M2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:21:32 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRi82-0004Yn-Hs
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:21:30 -0500
Received: by mail-qt0-x242.google.com with SMTP id l7so2944760qtd.3
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 08:21:30 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170112040534.15179-1-rth@twiddle.net>
	<CAFEAcA_zdUzt1E307v2W1e4C+YksEEN9aAot5GAacSSrt-R1Jw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f0ac3e3a-5246-f489-8fca-eb77dea216bd@twiddle.net>
Date: Thu, 12 Jan 2017 08:21:26 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_zdUzt1E307v2W1e4C+YksEEN9aAot5GAacSSrt-R1Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 01/12/2017 02:35 AM, Peter Maydell wrote:
> On 12 January 2017 at 04:05, Richard Henderson <rth@twiddle.net> wrote:
>> If the interp_prefix is a complete chroot, it may have a *lot* of files.
>> Setting up the cache for this is quite expensive.  Instead, use the *at
>> versions of various syscalls to attempt the operation in the prefix.
>>
>
> Presumably this also fixes the completely broken handling of
> symlinks in the interp_prefix tree?

Presumably.

> Unfortunately patch will break bsd-user as it stands,
> because bsd-user also calls init_paths. There's also a
> usage in tests/tcg/.

Oops, yes.

> Awkward problem: I suspect you'll find this breaks a few
> guest programs which don't like the fact that there's now
> an open fd which doesn't belong to the guest. (For instance
> IIRC some LTP test programs do "check that the rlimit on
> number of open files hits after opening exactly N files".)

Hum.  Probably.  I don't see how I can avoid that.

> Incidentally it's a shame C doesn't make it easier to
> abstract out the repeated pattern
>
>         switch (PATHNAME[0]) {
>         case '/':
>             ret = SOMEFN(interp_dirfd, PATHNAME + 1, STUFF);
>             if (ret == 0 || errno != ENOENT) {
>                 break;
>             }
>             /* fallthru */
>         default:
>             ret = SOMEFN(FD, PATHNAME, STUFF);
>             break;
>         }
>
> (and the variant which uses a 2nd function).
>
> A macro would get awkwardly heavily parameterised, I think.

I did briefly play with such a macro, and I found it to be uglier than just 
replicating the pattern.


r~
