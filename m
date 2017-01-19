Received: from eggs.gnu.org ([2001:4830:134:3::10]:35390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUAul-0007bk-A4
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUAuh-0007Tc-BX
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:29:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cUAuh-0007Sw-6d
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 06:29:55 -0500
Date: Thu, 19 Jan 2017 11:29:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170119112949.GD2085@work-vm>
References: <1484771412-28024-1-git-send-email-mst@redhat.com>
	<1484771412-28024-4-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484771412-28024-4-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] compiler: expression version of
 QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> QEMU_BUILD_BUG_ON uses a typedef in order to be safe
> to use outside functions, but sometimes it's useful
> to have a version that can be used within an expression.
> Following what Linux does, introduce QEMU_BUILD_BUG_ON_ZERO
> that return zero after checking condition at build time.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/compiler.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 1a9eeb9..d2b05dd 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -88,6 +88,8 @@
>  #define QEMU_BUILD_BUG_ON(x) \
>      typedef char glue(qemu_build_bug_on__,__LINE__)[(x)?-1:1] __attribute__((unused))
>  
> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x)?-1:1]) - sizeof(int))
> +

Yes, pretty much the same as:
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07090.html

I'd used -sizeof(int[1])   in the right hand size to match the left, but
I think it should always be the same.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  #if defined __GNUC__
>  # if !QEMU_GNUC_PREREQ(4, 4)
>     /* gcc versions before 4.4.x don't support gnu_printf, so use printf. */
> -- 
> MST
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
