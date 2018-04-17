Received: from eggs.gnu.org ([2001:4830:134:3::10]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8Qkq-0004j5-TN
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8Qkp-0001ER-K1
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:34:40 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8Qkp-0001E4-Dt
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:34:39 -0400
Received: by mail-oi0-x241.google.com with SMTP id p62-v6so1603606oie.10
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 06:34:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOuPqTE8GsN_+REWzSt4DOiqddSbZC-kOH=WnYG3U8ge3GsLoA@mail.gmail.com>
References: <CAOuPqTE8GsN_+REWzSt4DOiqddSbZC-kOH=WnYG3U8ge3GsLoA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 14:34:18 +0100
Message-ID: <CAFEAcA_Hti-FYqEse7ubdNyVr3fPHO==e6MDv9Ym4KVYJcYTwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Patch for ARM memory barriers and getdent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Henry Wertz <hwertz10@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <Laurent@vivier.eu>

On 16 April 2018 at 19:44, Henry Wertz <hwertz10@gmail.com> wrote:
> Please find submitted a patch for ARM memory barriers.  This patch is
> against qemu-2.12-rc2 but I do believe it should apply for anything from
> 2.11.x to current.

Hi Henry; thanks for these patches. Please could you provide
a Signed-off-by: line for them? This says you're happy for us
to apply them to QEMU under our license, and we can't do anything
with them without one. The top part of
https://wiki.qemu.org/Contribute/SubmitAPatch
has more detail.

> I found with qemu 2.11.x or newer that I would get an illegal instruction
> error running some Intel binaries on my ARM chromebook.  On investigation,
> I found it was quitting on memory barriers.
> qemu instruction:
> mb $0x31
> was translating as:
> 0x604050cc:  5bf07ff5  blpl     #0x600250a8
>
> After patch it gives:
> 0x604050cc:  f57ff05b  dmb      ish
>
> In short, I found INSN_DMB_ISH (memory barrier for ARMv7) appeared to be
> correct based on online docs, but due to some endian-related shenanigans it
> had to be byte-swapped to suit qemu; it appears INSN_DMB_MCR (memory
> barrier for ARMv6) also should be byte swapped  (and this patch does so).
> I have not checked for correctness of aarch64's barrier instruction.

Yeah, this definitely looks like a bug -- I can't see how the code
as it stands could ever have worked (it was added in commit 40f191ab8226fdada).

> -------------------------------
> Please find submitted a patch for getdents (this system call stands for
> "get directory entries",

You'll probably have better luck if you submit patches as separate
emails rather than all in one -- the set of people who care about
reviewing TCG backend patches is different from the people who
look after the linux-user syscall emulation code.

> it is passed a file descriptor pointing to a
> directory and returns a struct with info on the entries in that
> directory.)  This patch is against qemu-2.10 series but continues to apply
> cleanly on current as of April 15 2018.  If you are running a 32-bit binary
> on 64-bit target current qemu will convert he getdents struct, but it will
> NOT in the case of 64-bit binary on 32-bit host.

In general, 64-bit binary on a 32-bit host is not supported by linux-user.
Various things are likely to go wrong for anything but the simplest
of guest binaries. You need a 64-bit host to reliably use linux-user
for a 64-bit guest binary.

I think your change isn't sufficient to handle the "target 32 bits
and host 64 bits" case, because the 64-on-32 code path that you're
using for it uses the guest's buffer size as the size of the
host buffer it allocates to pass to the host syscall. That's ok
if the host is 64 bits, because the host struct linux_dirent will
be bigger than the target's struct linux_dirent, and so we can
guarantee to fit all the host's structures into the target's
buffer (with unused space left over at the end). If you try to
use the same code for "target 64 bits and host 32 bits" then we
may have more host dirent structures in the host buffer than we
can fit into the guest buffer, and we'll end up overrunning the
end of the guest's buffer. I don't see an obvious way to support
64-on-32 here, because the record sizes are variable, not fixed,
so you can't tell in advance what sized host buffer you'd need to
be able to fit the results from the kernel into the guest's buffer.
Maybe I'm missing a clever trick?

thanks
-- PMM
