Received: from eggs.gnu.org ([2001:4830:134:3::10]:55276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU7xU-0004rd-0A
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU7xS-0008EQ-J3
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:20:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cU7xS-0008E6-7Y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:20:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-5-git-send-email-mst@redhat.com>
Date: Thu, 19 Jan 2017 09:20:31 +0100
In-Reply-To: <1484772931-16272-5-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Wed, 18 Jan 2017 22:55:55 +0200")
Message-ID: <87lgu7ihps.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/4] ARRAY_SIZE: check that argument is
 an array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Sergey Fedorov <serge.fdrv@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> It's a familiar pattern: some code uses ARRAY_SIZE, then refactoring
> changes the argument from an array to a pointer to a dynamically
> allocated buffer.  Code keeps compiling but any ARRAY_SIZE calls now
> return the size of the pointer divided by element size.
>
> Let's add build time checks to ARRAY_SIZE before we allow more
> of these in the code-base.

Yes, please!

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/osdep.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 689f253..24bfda0 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -199,7 +199,13 @@ extern int daemon(int, int);
>  #endif
>  
>  #ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +/*
> + * &(x)[0] is always a pointer - if it's same type as x then the argument is a
> + * pointer, not an array as expected.
> + */
> +#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + QEMU_BUILD_BUG_ON_ZERO( \
> +                        __builtin_types_compatible_p(typeof(x), \
> +                                                     typeof(&(x)[0]))))

Please break the line near the operator, not within one of its operands:

   #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0]))			\
                          + QEMU_BUILD_BUG_ON_ZERO(			\
                               __builtin_types_compatible_p(typeof(x),	\
                                                            typeof(&(x)[0]))))
>  #endif
>  
>  int qemu_daemon(int nochdir, int noclose);

With the confusing line break tiedied up:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
