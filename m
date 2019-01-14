Received: from eggs.gnu.org ([209.51.188.92]:51744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1A4-0008VH-Mz
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1A2-0000HY-49
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:16:11 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj1A0-0000GZ-QL
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:16:10 -0500
Received: by mail-wm1-f49.google.com with SMTP id g67so8593820wmd.2
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 04:16:08 -0800 (PST)
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
Date: Mon, 14 Jan 2019 13:16:06 +0100
MIME-Version: 1.0
In-Reply-To: <1547467955-17245-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] include/fpu/softfloat: Fix compilation
 with Clang on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

On 1/14/19 1:12 PM, Thomas Huth wrote:
> Clang v7.0.1 does not like the __int128 variable type for inline
> assembly on s390x:
> 
> In file included from fpu/softfloat.c:97:
> include/fpu/softfloat-macros.h:647:9: error: inline asm error:
>  This value type register class is not natively supported!
>     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>         ^
> 
> Disable this code part there now when compiling with Clang, so that
> the generic code gets used instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/fpu/softfloat-macros.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
> index b1d772e..bd5b641 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -641,7 +641,7 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>      uint64_t q;
>      asm("divq %4" : "=a"(q), "=d"(*r) : "0"(n0), "1"(n1), "rm"(d));
>      return q;
> -#elif defined(__s390x__)
> +#elif defined(__s390x__) && !defined(__clang__)

Can we rather check if __int128 is natively supported? So this part get
compiled once Clang do support it, else we'll never use it...

>      /* Need to use a TImode type to get an even register pair for DLGR.  */
>      unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
>      asm("dlgr %0, %1" : "+r"(n) : "r"(d));
> 
