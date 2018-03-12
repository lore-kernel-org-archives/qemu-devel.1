Received: from eggs.gnu.org ([2001:4830:134:3::10]:38119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evPbz-0002Mr-U4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evPbV-0005iJ-9j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:43:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evPbU-0005hR-WE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:43:13 -0400
References: <20180312153344.23453-1-nia.alarie@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad11c22e-294b-d7e3-1589-7c4a42351980@redhat.com>
Date: Mon, 12 Mar 2018 10:43:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180312153344.23453-1-nia.alarie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9p: Convert use of atoi to qemu_strtoi
 to allow error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, jim@groklearning.com, groug@kaod.org, joel@jms.id.au

On 03/12/2018 10:33 AM, Nia Alarie wrote:
> Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
> ---
>   hw/9pfs/9p.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

Helping out our CI tools:
Based-on: <20180312124939.20562-1-berrange@redhat.com>

> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 48fa48e720..254385dfa4 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -15,6 +15,7 @@
>   #include <glib/gprintf.h>
>   #include "hw/virtio/virtio.h"
>   #include "qapi/error.h"
> +#include "qemu/cutils.h"
>   #include "qemu/error-report.h"
>   #include "qemu/iov.h"
>   #include "qemu/sockets.h"
> @@ -2213,8 +2214,14 @@ static void coroutine_fn v9fs_create(void *opaque)
>           }
>           v9fs_path_copy(&fidp->path, &path);
>       } else if (perm & P9_STAT_MODE_LINK) {
> -        int32_t ofid = atoi(extension.data);
> -        V9fsFidState *ofidp = get_fid(pdu, ofid);
> +        int ofid;

'unsigned int' and...

> +        V9fsFidState *ofidp;
> +
> +        if (qemu_strtoi(extension.data, NULL, 10, &ofid)) {

qemu_strtoui() might be smarter, per Greg's comments on v1.

> +            err = -EINVAL;
> +            goto out;
> +        }
> +        ofidp = get_fid(pdu, (int32_t)ofid);

This cast is spurious.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
