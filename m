Received: from eggs.gnu.org ([2001:4830:134:3::10]:48819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkah-0006Yb-88
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkag-0005TX-6U
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:19:15 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erkag-0005TM-1H
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:19:14 -0500
Received: by mail-ot0-x242.google.com with SMTP id m22so8659587otf.10
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:19:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-3-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-3-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 13:18:53 +0000
Message-ID: <CAFEAcA-Znfg7KaiAqCGFF4UQqK_iBctP0d9g4ykGCH+BU1G+rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/10] linux-user: Rename
 validate_guest_space => init_guest_commpage
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
> init_guest_commpage is a much more honest description of what the function
> does.  validate_guest_space not only suggests that the function has no
> side-effects, but also introduces confusion as to why it is only needed on
> 32-bit ARM targets.
>
> Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
> ---
>  linux-user/elfload.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index cac991159c..453394239c 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -362,8 +362,8 @@ enum {
>   * The guest code may leave a page mapped and populate it if the
>   * address is suitable.
>   */
> -static int validate_guest_space(unsigned long guest_base,
> -                                unsigned long guest_size)
> +static int init_guest_commpage(unsigned long guest_base,
> +                               unsigned long guest_size)
>  {
>      unsigned long real_start, test_page_addr;
>
> @@ -1836,7 +1836,7 @@ unsigned long init_guest_space(unsigned long host_start,
>       * address.  */
>      if (host_start && !host_size) {
>  #if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
> -        if (validate_guest_space(host_start, host_size) == 1) {
> +        if (init_guest_commpage(host_start, host_size) != 1) {

this is the bit that includes the '==' to '!=' change that should
be in patch 1.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
