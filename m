Received: from eggs.gnu.org ([2001:4830:134:3::10]:48967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkbF-0006t7-Ps
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkbD-0005i1-HX
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:19:48 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erkbD-0005hq-Bv
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:19:47 -0500
Received: by mail-oi0-x242.google.com with SMTP id f186so7002355oig.4
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:19:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-5-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-5-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 13:19:26 +0000
Message-ID: <CAFEAcA8HiLCB4YL9Ay2z8XAi6DXN4nrDgqfKst1qtZqqN0SH9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/10] linux-user: init_guest_space:
 Correctly handle guest_start in commpage initialization
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
> init_guest_commpage  needs to check if the mapped space, which ends at
> real_start+real_size overlaps with where it needs to put the commpage,
> which is (assuming sane qemu_host_page_size) guest_base + 0xffff000, where
> guest_base is real_start - guest_start.
>
>     [guest_base][       0xffff0000      ][commpage]
>     [guest_base][guest_start][real_size] [commpage]
>     [       real_start      ][real_size] [commpage]
>                                         ^
>                                  fail if this gap < 0
>
> Since init_guest_commpage wants to do everything relative to guest_base
> (rather than real_start), it obviously needs to be comparing 0xffff0000
> against guest_start+real_size, not just real_size.
>
> This bug has been present since 806d102141b99d4f1e55a97d68b7ea8c8ba3129f in
> 2012, but guest_start is usually 0, and prior to v2.11 real_size was
> usually much smaller than 0xffff0000, so it was uncommon for it to have
> made a difference.
>
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 1a6b660b25..f41cecc3cb 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1882,7 +1882,7 @@ unsigned long init_guest_space(unsigned long host_start,
>  #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
>              /* On 32-bit ARM, we need to also be able to map the commpage.  */
>              int valid = init_guest_commpage(real_start - guest_start,
> -                                            real_size);
> +                                            real_size + guest_start);
>              if (valid == 1) {
>                  break;
>              } else if (valid == -1) {

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
