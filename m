Received: from eggs.gnu.org ([2001:4830:134:3::10]:36003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erlRH-00080g-E1
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erlRG-0003Tb-3V
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:13:35 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erlRF-0003TR-TJ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 09:13:34 -0500
Received: by mail-ot0-x244.google.com with SMTP id w2so8824070otg.2
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 06:13:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-11-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-11-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 14:13:12 +0000
Message-ID: <CAFEAcA9joyBcXSOqDu=hWRUZPKA1wEKMpYhRr5+p0YCKQOs5Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/10] linux-user: init_guest_space: Try to
 make ARM space+commpage continuous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luke Shumaker <lukeshu@lukeshu.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Paul Brook <paul@codesourcery.com>, Laurent Vivier <laurent@vivier.eu>

On 28 December 2017 at 18:08, Luke Shumaker <lukeshu@lukeshu.com> wrote:
> From: Luke Shumaker <lukeshu@parabola.nu>
>
> At a fixed distance after the usable memory that init_guest_space maps, for
> 32-bit ARM targets we also need to map a commpage.  The normal
> init_guest_space logic doesn't keep this in mind when searching for an
> address range.
>
> If !host_start, then try to find a big continuous segment where we can put
> both the usable memory and the commpage; we then munmap that segment and
> set current_start to that address; and let the normal code mmap the usable
> memory and the commpage separately.  That is: if we don't have hint of
> where to start looking for memory, come up with one that is better than
> NULL.  Depending on host_size and guest_start, there may or may not be a
> gap between the usable memory and the commpage, so this is slightly more
> restrictive than it needs to be; but it's only a hint, so that's OK.
>
> We only do that for !host start, because if host_start, then either:
>  - we got an address passed in with -B, in which case we don't want to
>    interfere with what the user said;
>  - or host_start is based off of the ELF image's loaddr.  The check "if
>    (host_start && real_start != current_start)" suggests that we really
>    want lowest available address that is >= loaddr.  I don't know why that
>    is, but I'm trusting that Paul Brook knew what he was doing when he
>    wrote the original version of that check in
>    c581deda322080e8beb88b2e468d4af54454e4b3 way back in 2010.
>
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 7736ea2c3a..cd3a7d877d 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1857,6 +1857,55 @@ unsigned long init_guest_space(unsigned long host_start,
>
>      /* Otherwise, a non-zero size region of memory needs to be mapped
>       * and validated.  */
> +
> +#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
> +    /* On 32-bit ARM, we need to map not just the usable memory, but
> +     * also the commpage.  Try to find a suitable place by allocating
> +     * a big chunk for all of it.  If host_start, then the naive
> +     * strategy probably does good enough.
> +     */
> +    if (!host_start) {
> +        unsigned long guest_full_size, host_full_size, real_start;
> +
> +        guest_full_size =
> +            (0xffff0f00 & qemu_host_page_mask) + qemu_host_page_size;

I think this is probably more clearly written as 0x100000000ULL,
since rounding down to the host-page-size then adding the host-page-size
gets us the full 32-bit size of the guest address space.

That shows up that there's a potential problem here if the host
is 32-bit, because in that case guest_full_size (being only unsigned
long) will be 0, and we'll end up trying an mmap with an incorrect size.

> +        host_full_size = guest_full_size - guest_start;
> +        real_start = (unsigned long)
> +            mmap(NULL, host_full_size, PROT_NONE, flags, -1, 0);

I think the general approach is right, though. Sorry it took so long
for us to get to reviewing this patchset.

Incidentally, this code would be rather less complicated if it didn't
have to account for qemu_host_page_size not actually being the host
page size (since then you couldn't get a return from mmap() that wasn't
aligned properly). Does anybody know why we allow the user to specify
it on the command line? (git revision history doesn't help, it just says
there's been a -pagesize argument since commit 54936004fddc5 in 2003,
right back when mmap emulation was first added...)

thanks
-- PMM
