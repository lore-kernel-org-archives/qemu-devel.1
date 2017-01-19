Received: from eggs.gnu.org ([2001:4830:134:3::10]:53864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU7nA-0002Ao-Q8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU7n7-0002k8-KT
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:09:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cU7n7-0002jX-F8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:09:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-3-git-send-email-mst@redhat.com>
Date: Thu, 19 Jan 2017 09:09:50 +0100
In-Reply-To: <1484772931-16272-3-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Wed, 18 Jan 2017 22:55:44 +0200")
Message-ID: <87vatbii7l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/4] compiler: drop ; after BUILD_BUG_ON
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

> All users include the trailing ;, let's require that
> so that uses such as if (a) QEMU_BUILD_BUG_ON(); do not
> produce unexpected results.
>
> Not a huge problem for QEMU since our style requires the use
> of {} but seems cleaner nevertheless.

I think the actual problem is that it sets a bad example.

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/compiler.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 157698b..2882470 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -86,7 +86,8 @@
>  #define type_check(t1,t2) ((t1*)0 - (t2*)0)
>  
>  #define QEMU_BUILD_BUG_ON(x) \
> -    typedef char glue(qemu_build_bug_on__,__LINE__)[(x)?-1:1] __attribute__((unused));
> +    typedef char glue(qemu_build_bug_on__,__LINE__)[(x) ? -1 : 1] \
> +        __attribute__((unused))
>  
>  #if defined __GNUC__
>  # if !QEMU_GNUC_PREREQ(4, 4)

Preferably with the commit message clarified a bit:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
