Received: from eggs.gnu.org ([209.51.188.92]:44144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwOzy-00080W-Ri
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwOzx-0003Vx-4i
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:21:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gwOzs-0003NQ-Nq
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:21:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B87389ACC
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:20:49 +0000 (UTC)
References: <20190220092214.2384-1-quintela@redhat.com>
	<20190220092214.2384-4-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c4b5f139-8111-6dfd-3ea2-5534991a86a6@redhat.com>
Date: Wed, 20 Feb 2019 11:20:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190220092214.2384-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v13 3/3] tests: Add basic migration precopy
 tcp test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 20/02/2019 10.22, Juan Quintela wrote:
> Not sharing code from precopy/unix because we have to read back the
> tcp parameter.
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/migration-test.c | 109 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 104 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index b0670efde7..a27f095b28 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -20,6 +20,9 @@
>  #include "qemu/sockets.h"
>  #include "chardev/char.h"
>  #include "sysemu/sysemu.h"
> +#include "qapi/qapi-visit-sockets.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qobject-output-visitor.h"
>  
>  #include "migration/migration-test.h"
>  
> @@ -332,15 +335,67 @@ static void cleanup(const char *filename)
>      g_free(path);
>  }
>  
> +static char *SocketAddress_to_str(SocketAddress *addr)
> +{
> +    switch (addr->type) {
> +    case SOCKET_ADDRESS_TYPE_INET:
> +        return g_strdup_printf("tcp:%s:%s",
> +                               addr->u.inet.host,
> +                               addr->u.inet.port);
> +        break;
> +    case SOCKET_ADDRESS_TYPE_UNIX:
> +        return g_strdup_printf("unix:%s",
> +                               addr->u.q_unix.path);
> +        break;
> +    case SOCKET_ADDRESS_TYPE_FD:
> +        return g_strdup_printf("fd:%s", addr->u.fd.str);
> +        break;
> +    default:
> +        abort();
> +    }
> +}

You could also remove the "break" statements after the return statements
in this function. Apart from that:

Acked-by: Thomas Huth <thuth@redhat.com>
