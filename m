Received: from eggs.gnu.org ([2001:4830:134:3::10]:58994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhcQ-0003b8-Ei
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyhcP-0007qQ-H0
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:33:46 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b6eccd8-90ee-3475-5005-df9f59f59709@redhat.com>
Date: Wed, 21 Mar 2018 12:33:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180321121940.39426-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] qapi: new qmp command
 nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/21/2018 07:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block.json | 27 +++++++++++++++++++++++++++
>   blockdev-nbd.c  | 23 +++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/qapi/block.json b/qapi/block.json
> index c694524002..4afbbcd7b7 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -269,6 +269,33 @@
>     'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
>   
>   ##
> +# @nbd-server-add-bitmap:
> +#
> +# Export dirty bitmap through selected export. Bitmaps are searched for in
> +# device attached to the export and in all its backings. Exported bitmap
> +# is locked until NBD export is removed.

Expose a dirty bitmap associated with the selected export.  The bitmap 
search starts at the device attached to the export, and includes all 
backing files.  The exported bitmap is then locked until the NBD export 
is removed.

> +#
> +# @name: Export name.
> +#
> +# @bitmap: Bitmap name to search.

s/search./search for./

> +#
> +# @bitmap-export-name: How the bitmap will be seen by nbd clients
> +#                      (default @bitmap)

Maybe mention that the client must use NBD_OPT_SET_META_CONTEXT with a 
query of "qemu-dirty-bitmap:NAME" (where NAME matches 
bitmap-export-name) to access the exposed bitmap.  (May need to be 
adjusted by my suggestion to use just the namespace "qemu:")

> +#
> +#
> +# Returns: error on one of the following conditions:
> +#           - the server is not running
> +#           - export is not found
> +#           - bitmap is not found
> +#           - bitmap is disabled
> +#           - bitmap is locked

Do we really need to list all the error conditions?  My worry is that a 
list this specific might go stale, compared to the obvious default that 
the command succeeds only if it was able to expose the bitmap and that 
the error message is specific enough for a human to figure out what to 
fix if it failed.

> +#
> +# Since: 2.13
> +##
> +  { 'command': 'nbd-server-add-bitmap',
> +    'data': {'name': 'str', 'bitmap': 'str', '*bitmap-export-name': 'str'} }
> +

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
