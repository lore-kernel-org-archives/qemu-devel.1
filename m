Received: from eggs.gnu.org ([209.51.188.92]:39458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjoOt-0004ND-8n
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjoOq-0005MV-AB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:50:46 -0500
Date: Wed, 16 Jan 2019 17:50:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190116175014.6f6eafe4.cohuck@redhat.com>
In-Reply-To: <1547467955-17245-1-git-send-email-thuth@redhat.com>
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 14 Jan 2019 13:12:35 +0100
Thomas Huth <thuth@redhat.com> wrote:

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
>      /* Need to use a TImode type to get an even register pair for DLGR.  */
>      unsigned __int128 n = (unsigned __int128)n1 << 64 | n0;
>      asm("dlgr %0, %1" : "+r"(n) : "r"(d));

Ok, so what's the deal with this patch now? Fix compilation now,
optimize later?

If yes, should I pick it as an s390x build fix (I plan to send a pull
request later this week), or will the fpu maintainers pick it?
