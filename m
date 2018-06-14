Received: from eggs.gnu.org ([2001:4830:134:3::10]:35771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRnj-0008M8-0T
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTRnf-0003C0-VY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:56:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTRnf-0003Bu-Ri
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:56:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1527186303-192100-1-git-send-email-mst@redhat.com>
	<1527186303-192100-2-git-send-email-mst@redhat.com>
Date: Thu, 14 Jun 2018 14:56:23 +0200
In-Reply-To: <1527186303-192100-2-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 24 May 2018 21:25:26 +0300")
Message-ID: <87y3fhjzm0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 1/3] osdep: add wait.h compat macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Max Reitz <mreitz@redhat.com>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Man page for WCOREDUMP says:
>
>   WCOREDUMP(wstatus) returns true if the child produced a core dump.
>   This macro should be employed only if WIFSIGNALED returned true.
>
>   This  macro  is  not  specified  in POSIX.1-2001 and is not
>   available on some UNIX implementations (e.g., AIX, SunOS).  Therefore,
>   enclose its use inside #ifdef WCOREDUMP ... #endif.
>
> Let's do exactly this.

Sorry to nitpick, but you're not doing "exactly this", you're providing
a stub:

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/qemu/osdep.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 4165806..afc28e5 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -108,6 +108,16 @@ extern int daemon(int, int);
>  #include "qemu/typedefs.h"
>  
>  /*
> + * According to waitpid man page:
> + * WCOREDUMP
> + *  This  macro  is  not  specified  in POSIX.1-2001 and is not
> + *  available on some UNIX implementations (e.g., AIX, SunOS).
> + *  Therefore, enclose its use inside #ifdef WCOREDUMP ... #endif.
> + */
> +#ifndef WCOREDUMP
> +#define WCOREDUMP(status) 0
> +#endif
> +/*
>   * We have a lot of unaudited code that may fail in strange ways, or
>   * even be a security risk during migration, if you disable assertions
>   * at compile-time.  You may comment out these safety checks if you

Suggest to drop the last sentence from the comment, and have the commit
message state you're providing a stub.
