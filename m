Received: from eggs.gnu.org ([208.118.235.92]:36187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf7mE-0008Vk-2f
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf7mC-0007LM-8y
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:31:29 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf7mB-0007Hi-JN
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 13:31:28 -0500
Received: by mail-ot1-x341.google.com with SMTP id t5so30194097otk.1
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 10:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20180908182205.GB409@mornington.dcs.gla.ac.uk>
In-Reply-To: <20180908182205.GB409@mornington.dcs.gla.ac.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 18:31:13 +0000
Message-ID: <CAFEAcA83dVVyQLsADoNBN7feFxnWcVr5r0SPA8PffaG2140yPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: write(fd, NULL,
 0) parity with linux's treatment of same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Garnock-Jones <tony.garnock-jones@glasgow.ac.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-stable <qemu-stable@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Sat, 8 Sep 2018 at 22:04, Tony Garnock-Jones
<tony.garnock-jones@glasgow.ac.uk> wrote:
>
> Bring linux-user write(2) handling into line with linux for the case
> of a 0-byte write with a NULL buffer. Based on a patch originally
> written by Zhuowei Zhang.
>
> Addresses https://bugs.launchpad.net/qemu/+bug/1716292.
>
> From Zhuowei Zhang's patch (https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg08073.html):
>
>     Linux returns success for the special case of calling write with a
>     zero-length NULL buffer: compiling and running
>
>     int main() {
>        ssize_t ret = write(STDOUT_FILENO, NULL, 0);
>        fprintf(stderr, "write returned %ld\n", ret);
>        return 0;
>     }
>
>     gives "write returned 0" when run directly, but "write returned
>     -1" in QEMU.
>
>     This commit checks for this situation and returns success if
>     found.
>
> Subsequent discussion raised the following questions (and my answers):
>
>  - Q. Should TARGET_NR_read pass through to safe_read in this
>       situation too?
>    A. I'm wary of changing unrelated code to the specific problem I'm
>       addressing. TARGET_NR_read is already consistent with Linux for
>       this case.
>
>  - Q. Do pread64/pwrite64 need to be changed similarly?
>    A. Experiment suggests not: both linux and linux-user yield -1 for
>       NULL 0-length reads/writes.

Hi; following up on this, we've just had
https://bugs.launchpad.net/qemu/+bug/1810433 which is
a report of the same NULL/0 bug for pwrite64. Looking at the
kernel code I see that both the write and pwrite64 syscalls
go through the same vfs_write() common function, so their
behaviour for NULL/0 should be identical. Experimentally,
stracing the 1810433 test program gives
 pwrite64(3, NULL, 0, 0)                 = 0
so we do indeed need to special case NULL/0 there as well
as in write().

The extra fix should be straightforward -- does anybody
feel like writing up a patch for it?

thanks
-- PMM
