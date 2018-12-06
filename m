Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUwAT-0003XV-8T
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUwAN-0005KC-8T
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:06:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUwAJ-0005C4-O1
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:06:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so1588903wmf.5
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 08:06:06 -0800 (PST)
References: <20181205221126.16220-1-paul.burton@mips.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5887a794-7e88-0904-4e35-64234233eb72@redhat.com>
Date: Thu, 6 Dec 2018 17:06:03 +0100
MIME-Version: 1.0
In-Reply-To: <20181205221126.16220-1-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] atomic.h: Set ATOMIC_REG_SIZE=8 for MIPS
 n32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Burton <paul.burton@mips.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paul Burton <pburton@wavecomp.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

On 12/5/18 11:11 PM, Paul Burton wrote:
> ATOMIC_REG_SIZE is currently defined as the default sizeof(void *) for
> all MIPS host builds, including those using the n32 ABI. n32 is the
> MIPS64 ILP32 ABI and as such tcg/mips/tcg-target.h defines
> TCG_TARGET_REG_BITS as 64 for n32 builds. If we attempt to build QEMU
> for an n32 host with support for a 64b target architecture then
> TCG_OVERSIZED_GUEST is 0 and accel/tcg/cputlb.c attempts to use atomic_*
> functions. This fails because ATOMIC_REG_SIZE is 4, causing the calls to
> QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE) in the various
> atomic_* functions to generate errors.
> 
> Fix this by defining ATOMIC_REG_SIZE as 8 for all MIPS64 builds, which
> will cover both n32 (ILP32) & n64 (LP64) ABIs in much the same was as we
> already do for x86_64/x32.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/qemu/atomic.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
> index f6993a8fb1..a6ac188188 100644
> --- a/include/qemu/atomic.h
> +++ b/include/qemu/atomic.h
> @@ -99,9 +99,10 @@
>   * those few cases by hand.
>   *
>   * Note that x32 is fully detected with __x86_64__ + _ILP32, and that for
> - * Sparc we always force the use of sparcv9 in configure.
> + * Sparc we always force the use of sparcv9 in configure. MIPS n32 (ILP32) &
> + * n64 (LP64) ABIs are both detected using __mips64.
>   */
> -#if defined(__x86_64__) || defined(__sparc__)
> +#if defined(__x86_64__) || defined(__sparc__) || defined(__mips64)
>  # define ATOMIC_REG_SIZE  8
>  #else
>  # define ATOMIC_REG_SIZE  sizeof(void *)
> 
