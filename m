Received: from eggs.gnu.org ([2001:4830:134:3::10]:54437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU7q3-0003MI-KV
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:12:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU7q0-0004pd-GU
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:12:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cU7q0-0004p9-AX
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:12:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-4-git-send-email-mst@redhat.com>
Date: Thu, 19 Jan 2017 09:12:49 +0100
In-Reply-To: <1484772931-16272-4-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Wed, 18 Jan 2017 22:55:52 +0200")
Message-ID: <87r33zii2m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/4] compiler: expression version of
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> QEMU_BUILD_BUG_ON uses a typedef in order to be safe
> to use outside functions, but sometimes it's useful
> to have a version that can be used within an expression.
> Following what Linux does, introduce QEMU_BUILD_BUG_ON_ZERO
> that return zero after checking condition at build time.

Following Linux's example makes sense, but I can't help but wonder
whether we need both QEMU_BUILD_BUG_ON_ZERO() and QEMU_BUILD_BUG_ON().

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/compiler.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 2882470..f4cf13b 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -89,6 +89,8 @@
>      typedef char glue(qemu_build_bug_on__,__LINE__)[(x) ? -1 : 1] \
>          __attribute__((unused))
>  
> +#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x) ? -1 : 1]) - sizeof(int))
> +
>  #if defined __GNUC__
>  # if !QEMU_GNUC_PREREQ(4, 4)
>     /* gcc versions before 4.4.x don't support gnu_printf, so use printf. */

More so since your QEMU_BUILD_BUG_ON_ZERO seems easier to understand: no
token pasting.

Anyway,
Reviewed-by: Markus Armbruster <armbru@redhat.com>
