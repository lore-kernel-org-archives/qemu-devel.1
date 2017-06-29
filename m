Received: from eggs.gnu.org ([2001:4830:134:3::10]:48914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQWwa-0003GN-P2
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQWwZ-00034F-TV
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:45:04 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQWwZ-00030f-MQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:45:03 -0400
Received: by mail-wm0-x233.google.com with SMTP id b184so9899095wme.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 03:45:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b17a6dac-f3b8-b874-f64c-77e4279923eb@twiddle.net>
References: <1498582198-6649-1-git-send-email-peter.maydell@linaro.org>
	<b17a6dac-f3b8-b874-f64c-77e4279923eb@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 11:44:39 +0100
Message-ID: <CAFEAcA_3QLkR4Zk=RGwH=gUU72FSU+8-2zwB+aQSyE+w76+sEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

On 27 June 2017 at 19:05, Richard Henderson <rth@twiddle.net> wrote:
> On 06/27/2017 09:49 AM, Peter Maydell wrote:
>>
>> The 32-bit PPC auxv is a bit complicated because in the
>> mists of time it used to be 16-aligned rather than directly
>> after the environment. Older glibc versions had code to
>> try to probe for whether it needed alignment or not:
>>
>> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/powerpc/dl-sysdep.c;hb=e84eabb3871c9b39e59323bf3f6b98c2ca9d1cd0
>> and the kernel has code which puts some magic entries at
>> the bottom to ensure that the alignment probe fails:
>>
>> http://elixir.free-electrons.com/linux/latest/source/arch/powerpc/include/asm/elf.h#L158
>>
>> QEMU has similar code too, but it was broken by commit
>> 7c4ee5bcc82e64, which changed elfload.c from filling in
>> the auxv starting at the highest address and working down
>> to starting at the lowest address and working up. This
>> means that the ARCH_DLINFO hook must now be invoked first
>> rather than last, and the entries in it for PPC must
>> be reversed so that the magic AT_IGNOREPPC entries come
>> at the lowest address in the auxv as they should.
>>
>> The effect of this was that if running a guest binary that
>> used an old glibc with the alignment probing the guest ld.so
>> code would segfault if the size of the guest environment and
>> argv happened to put the auxv at an address that triggered
>> the alignment code in the guest glibc.
>>
>> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
>> ---
>>   linux-user/elfload.c | 23 ++++++++++++-----------
>>   1 file changed, 12 insertions(+), 11 deletions(-)
>
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Tested-by:  Richard Henderson <rth@twiddle.net>

Thanks; applied directly to master since this has been
causing my mergebuild tests to fail (some recent environment
change result in it triggering this week...)

thanks
-- PMM
