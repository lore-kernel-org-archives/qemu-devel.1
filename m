Received: from eggs.gnu.org ([2001:4830:134:3::10]:48864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebujL-0000eb-IC
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebujH-0007Q8-Fw
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:54:43 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebujH-0007Pt-BM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:54:39 -0500
Received: by mail-qt0-x242.google.com with SMTP id s3so25016929qtb.10
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 12:54:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <bd66250ff262528199614f778a8323ced130a4db.1516221466.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dfa60856-7918-e78a-5610-a1a51cd4c581@amsat.org>
Date: Wed, 17 Jan 2018 17:54:34 -0300
MIME-Version: 1.0
In-Reply-To: <bd66250ff262528199614f778a8323ced130a4db.1516221466.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] linux-user: Fix webkitgtk hangs on
 32-bit x86 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, rth@twiddle.net, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi, alistair23@gmail.com

On 01/17/2018 05:39 PM, Alistair Francis wrote:
> Since commit "linux-user: Tidy and enforce reserved_va initialization"
> (18e80c55bb6ec17c05ec0ba717ec83933c2bfc07) the Yocto webkitgtk build
> hangs when cross compiling for 32-bit x86 on a 64-bit x86 machine using
> musl.
> 
> To fix the issue reduce the MAX_RESERVED_VA macro to be a closer match
> to what it was before the problematic commit.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  linux-user/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 450eb3ce65..c7cc0a184e 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -77,7 +77,7 @@ do {                                                                    \
>        (TARGET_LONG_BITS == 32 || defined(TARGET_ABI32))
>  /* There are a number of places where we assign reserved_va to a variable
>     of type abi_ulong and expect it to fit.  Avoid the last page.  */

If this is only for MUSL shouldn't we think of smth like: ?

#if defined(__GLIBC__) || defined(__UCLIBC__)

> -#   define MAX_RESERVED_VA  (0xfffffffful & TARGET_PAGE_MASK)

#else /* __MUSL__ */

> +#   define MAX_RESERVED_VA  (0x7ffffffful & TARGET_PAGE_MASK)

#endif

>  #  else
>  #   define MAX_RESERVED_VA  (1ul << TARGET_VIRT_ADDR_SPACE_BITS)
>  #  endif
> 
