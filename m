Received: from eggs.gnu.org ([2001:4830:134:3::10]:47126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5soW-0001YZ-V9
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5soW-00045X-3U
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:55:57 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5soV-00045D-Ub
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:55:56 -0400
Received: by mail-oi0-x241.google.com with SMTP id l190-v6so11004804oig.9
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 05:55:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3147e65b-b6ff-a49e-fc40-21396dcbea0c@twiddle.net>
References: <20180409140714.26841-1-peter.maydell@linaro.org>
	<3147e65b-b6ff-a49e-fc40-21396dcbea0c@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:55:34 +0100
Message-ID: <CAFEAcA_NUrah3b3E0W2T8UzsX05MBUXXv2pFMzPbb=UcyWf4TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] linux-user/signal.c: Ensure
 AArch64 signal frame isn't too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henwood <richard.henwood@arm.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 9 April 2018 at 23:05, Richard Henderson <rth@twiddle.net> wrote:
> On 04/10/2018 12:07 AM, Peter Maydell wrote:
>> In particular the dash shell
>> would segfault if the frame wasn't as big enough.
>
> Ah, that was the critical difference in my failure to replicate -- the fedora
> sysroot doesn't have dash.  As you say, the patch matches the kernel so,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> That said, what the hell is dash doing that relies on this?

I figured out what's going on, and it's not particularly weird.

The memory map at the point where we take the signal is:
4000000000-4000001000 ---p 00000000 00:00 0
4000001000-4000801000 rw-p 00000000 00:00 0
4000801000-400081d000 r-xp 00000000 08:05 24190917
  /srv/chroot/xenial-aarch64/lib/aarch64-linux-gnu/ld-2.23.so

(conveniently guest_base == 0, so host and guest addresses are
identical).

Guest SP is 0x4000800590. Without this patch, we end up with
layout.total_size == 0x480 and frame_addr == 0x4000800110.

However, the range we try to lock for writing with
lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)
is always sizeof struct target_rt_sigframe, which is 0x1250.
So we try to lock from 0x4000800110 to 0x4000801360, which
extends beyond the rw ram block and into the read-only following
memory section which has ld-2.23.so in it.

So this patch fixes the problem for non-SVE guests
by bringing the size of the signal frame we allocate on the
stack back into line with the size of the lump of memory we
verify as being writable.

It does suggest that there's another bug here that will only
manifest if we're using SVE and end up with a larger signal
frame than the default -- we will in that case do the
lock_user on a lump of memory that's smaller than we're
actually going to try to write to, because it won't include
the extra part. Do we need to switch to using lock_user and
unlock_user and passing them layout.total_size, rather than
relying on the "lock size of this struct" functions?
(I think this is not a bugfix required for 2.12, because
nothing enables ARM_FEATURE_SVE yet, and without that feature
bit we won't ever create a signal frame that's larger than
sizeof(struct target_rt_sigframe).)

thanks
-- PMM
