Received: from eggs.gnu.org ([2001:4830:134:3::10]:48615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkaE-0006Kt-Nd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erkaD-00052c-Ld
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:18:46 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erkaD-000518-Es
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:18:45 -0500
Received: by mail-ot0-x242.google.com with SMTP id t2so8687744otj.4
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:18:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171228180814.9749-2-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
	<20171228180814.9749-2-lukeshu@lukeshu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 13:18:24 +0000
Message-ID: <CAFEAcA-q6ksvp+CgK2PWSaiXUsvjVHL-FpPBRLVVHyRtSTMfGA@mail.gmail.com>
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

Yes, I think on reflection that you're right and we're better off
leaving this arm-specific. If/when we find another target that needs
special handling, we can look at a more generic API then.

> @@ -1845,11 +1835,12 @@ unsigned long init_guest_space(unsigned long host_start,
>      /* If just a starting address is given, then just verify that
>       * address.  */
>      if (host_start && !host_size) {
> +#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
>          if (validate_guest_space(host_start, host_size) == 1) {
> -            return host_start;
> -        } else {
>              return (unsigned long)-1;
>          }
> +#endif
> +        return host_start;

This is accidentally changing behaviour -- if validate_guest_space()
returned 1 we used to return host_start, and now we return -1.
The condition should be "!= 1". This change is made in patch 2,
but it should be done here, to avoid breaking bisection.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
