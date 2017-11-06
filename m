Received: from eggs.gnu.org ([2001:4830:134:3::10]:48901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBf0I-0005hs-4i
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBf0E-0004Lz-Et
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:51:42 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBf0E-0004LZ-6v
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:51:38 -0500
Received: by mail-wr0-x242.google.com with SMTP id u97so669847wrc.1
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 02:51:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106005656.GC84093@humpty.home.comstyle.com>
References: <20171106005656.GC84093@humpty.home.comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 10:51:16 +0000
Message-ID: <CAFEAcA_2i0p9C3amtoB0o9Y4K83aCP7Gkw1cDqmLjrkLwJTZxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] osdep: Deal with TIME_MAX and OpenBSD
 64-bit time_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2017 at 00:56, Brad Smith <brad@comstyle.com> wrote:
> Define TIME_MAX to LLONG_MAX for OpenBSD since OpenBSD uses 64-bit time_t.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
>
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 6855b94bbf..824714049b 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -132,8 +132,12 @@ extern int daemon(int, int);
>  #define ESHUTDOWN 4099
>  #endif
>  #ifndef TIME_MAX
> +#ifdef __OpenBSD__
> +#define TIME_MAX LLONG_MAX
> +#else
>  #define TIME_MAX LONG_MAX
>  #endif
> +#endif

I'm not really a fan of adding new OS-specific #ifdefs --
what if one of the other BSDs uses or switches to 64-bit
time_t for 32-bit platforms? Is there some way we can detect
this generically at compile time (possibly in configure) ?

thanks
-- PMM
