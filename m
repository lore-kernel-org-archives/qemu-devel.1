Received: from eggs.gnu.org ([2001:4830:134:3::10]:47895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQWQ-00063v-AD
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQWP-0004Sf-EC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:29:54 -0500
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
	<20180308184636.178534-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <764ddb1e-541a-7b74-65bf-936c12ed5add@redhat.com>
Date: Fri, 9 Mar 2018 16:29:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180308184636.178534-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] nbd/server: refactor nbd_trip: split
 out nbd_handle_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Split out request handling logic.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 129 +++++++++++++++++++++++++++++++----------------------------
>   1 file changed, 67 insertions(+), 62 deletions(-)
> 

> +
> +    switch (request->type) {
> +    case NBD_CMD_READ:
> +        return nbd_do_cmd_read(client, request, data, errp);
> +
> +    case NBD_CMD_WRITE:
> +        flags = 0;
> +        if (request->flags & NBD_CMD_FLAG_FUA) {
> +            flags |= BDRV_REQ_FUA;
> +        }
> +        ret = blk_pwrite(exp->blk, request->from + exp->dev_offset,
> +                         data, request->len, flags);
> +
> +        return nbd_send_generic_reply(client, request->handle, ret,
> +                                      "writing to file failed", errp);
> +    case NBD_CMD_WRITE_ZEROES:

Inconsistent spacing between return and the next case label.

But switching whitespace is trivial, so

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
