Received: from eggs.gnu.org ([2001:4830:134:3::10]:39205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epICj-0004Z3-65
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epICi-0007Ld-5p
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:36:21 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epICh-0007Is-VF
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:36:20 -0500
Received: by mail-pl0-x242.google.com with SMTP id w21so5356508plp.11
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:36:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-2-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-2-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 18:35:58 +0000
Message-ID: <CAFEAcA-WGk0Jkvamr3s_sAzLeUS1VrW7UHuUBnU-xDOEpEh95A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/10] linux-user: Use #if to only call
 validate_guest_space for 32-bit ARM target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 28 December 2017 at 18:08, Luke Shumaker <lukeshu@lukeshu.com> wrote:
> From: Luke Shumaker <lukeshu@parabola.nu>
>
> Instead of defining a bogus validate_guest_space that always returns 1 on
> targets other than 32-bit ARM, use #if blocks to only call it on 32-bit ARM
> targets.  This makes the "normal" flow control clearer.
>
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 20f3d8c2c3..cac991159c 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -354,7 +354,6 @@ enum {
>
>  /* The commpage only exists for 32 bit kernels */
>
> -#define TARGET_HAS_VALIDATE_GUEST_SPACE
>  /* Return 1 if the proposed guest space is suitable for the guest.
>   * Return 0 if the proposed guest space isn't suitable, but another
>   * address space should be tried.
> @@ -1823,15 +1822,6 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
>      return sp;
>  }
>
> -#ifndef TARGET_HAS_VALIDATE_GUEST_SPACE
> -/* If the guest doesn't have a validation function just agree */
> -static int validate_guest_space(unsigned long guest_base,
> -                                unsigned long guest_size)
> -{
> -    return 1;
> -}
> -#endif
> -
>  unsigned long init_guest_space(unsigned long host_start,
>                                 unsigned long host_size,
>                                 unsigned long guest_start,
> @@ -1845,11 +1835,12 @@ unsigned long init_guest_space(unsigned long host_start,
>      /* If just a starting address is given, then just verify that
>       * address.  */
>      if (host_start && !host_size) {
> +#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)

I would strongly prefer us not to add new "these targets do
this" ifdefs, please. The current approach means that any
target can say it needs an implementation of this hook by
providing one and defining the TARGET_HAS_VALIDATE_GUEST_SPACE
macro to say so. I think that's a better approach.

thanks
-- PMM
