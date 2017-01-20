Received: from eggs.gnu.org ([2001:4830:134:3::10]:46229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTqR-0004oI-Gz
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTqO-0001KF-FU
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:42:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUTqO-0001Jo-99
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:42:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-3-git-send-email-mst@redhat.com>
Date: Fri, 20 Jan 2017 08:42:41 +0100
In-Reply-To: <1484859998-25074-3-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 19 Jan 2017 23:07:29 +0200")
Message-ID: <87wpdq2n4e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/4] compiler: rework BUG_ON using a
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> There are theoretical concerns that some compilers might not trigger
> build failures on attempts to define an array of size -1 and make it a
> variable sized array instead. Let rewrite using a struct with a negative
> bit field size instead as there are no dynamic bit field sizes.  This is
> similar to what Linux does.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/compiler.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 7512082..c6f673e 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -85,9 +85,12 @@
>  #define typeof_field(type, field) typeof(((type *)0)->field)
>  #define type_check(t1,t2) ((t1*)0 - (t2*)0)
>  
> -#define QEMU_BUILD_BUG_ON(x) \
> -    typedef char glue(qemu_build_bug_on__, __LINE__)[(x) ? -1 : 1] \
> -        __attribute__((unused))
> +#define QEMU_BUILD_BUG_ON_STRUCT(x) \
> +    struct { \
> +        int qemu_build_bug_on : (x) ? -1 : 1; \
> +    }

The qemu_build_bug_on name space pollution is harmless, but quite
unnecessary: the name can be simply omitted (unnamed bit-field).

> +#define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
> +    glue(qemu_build_bug_on__, __LINE__) __attribute__((unused))
>  
>  #if defined __GNUC__
>  # if !QEMU_GNUC_PREREQ(4, 4)
