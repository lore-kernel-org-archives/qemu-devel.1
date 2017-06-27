Received: from eggs.gnu.org ([2001:4830:134:3::10]:51846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPurh-00069k-QI
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPurd-0008AW-OK
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:05:29 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPurd-0008AI-IL
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:05:25 -0400
Received: by mail-qt0-x242.google.com with SMTP id m54so2193890qtb.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 11:05:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498582198-6649-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b17a6dac-f3b8-b874-f64c-77e4279923eb@twiddle.net>
Date: Tue, 27 Jun 2017 11:05:20 -0700
MIME-Version: 1.0
In-Reply-To: <1498582198-6649-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Put PPC AT_IGNOREPPC auxv
 entries in the right place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

On 06/27/2017 09:49 AM, Peter Maydell wrote:
> The 32-bit PPC auxv is a bit complicated because in the
> mists of time it used to be 16-aligned rather than directly
> after the environment. Older glibc versions had code to
> try to probe for whether it needed alignment or not:
> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/powerpc/dl-sysdep.c;hb=e84eabb3871c9b39e59323bf3f6b98c2ca9d1cd0
> and the kernel has code which puts some magic entries at
> the bottom to ensure that the alignment probe fails:
> http://elixir.free-electrons.com/linux/latest/source/arch/powerpc/include/asm/elf.h#L158
> 
> QEMU has similar code too, but it was broken by commit
> 7c4ee5bcc82e64, which changed elfload.c from filling in
> the auxv starting at the highest address and working down
> to starting at the lowest address and working up. This
> means that the ARCH_DLINFO hook must now be invoked first
> rather than last, and the entries in it for PPC must
> be reversed so that the magic AT_IGNOREPPC entries come
> at the lowest address in the auxv as they should.
> 
> The effect of this was that if running a guest binary that
> used an old glibc with the alignment probing the guest ld.so
> code would segfault if the size of the guest environment and
> argv happened to put the auxv at an address that triggered
> the alignment code in the guest glibc.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   linux-user/elfload.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>
Tested-by:  Richard Henderson <rth@twiddle.net>


r~
