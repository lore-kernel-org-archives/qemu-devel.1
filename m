Received: from eggs.gnu.org ([2001:4830:134:3::10]:53574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVbGM-0005Hn-Rs
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVbGL-0001Fz-Pb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 07:26:58 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <45f6544a-d384-f3cc-5fd4-c3d5f0268f25@redhat.com>
Date: Wed, 20 Jun 2018 06:26:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180609151758.17343-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 5/6] qapi: new qmp command
 nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block.json | 23 +++++++++++++++++++++++
>   blockdev-nbd.c  | 23 +++++++++++++++++++++++
>   2 files changed, 46 insertions(+)

I'm tempted to temporarily name this x-nbd-server-add-bitmap, until I 
have the counterpart Libvirt patches tested, just in case testing turns 
up any tweaks we need to the interface.

> 
> diff --git a/qapi/block.json b/qapi/block.json
> index c694524002..ddbca2e286 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -269,6 +269,29 @@
>     'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
>   
>   ##
> +# @nbd-server-add-bitmap:
> +#
> +# Expose a dirty bitmap associated with the selected export. The bitmap search
> +# starts at the device attached to the export, and includes all backing files.
> +# The exported bitmap is then locked until the NBD export is removed.

The fact that you search the backing chain is at least consistent with 
your code.

> +#
> +# @name: Export name.
> +#
> +# @bitmap: Bitmap name to search for.
> +#
> +# @bitmap-export-name: How the bitmap will be seen by nbd clients
> +#                      (default @bitmap)

Do we really need the flexibility of naming the bitmap differently to 
the NBD client than we do in qemu?

> +#
> +# Note: the client must use NBD_OPT_SET_META_CONTEXT with a query of
> +# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-name) to access
> +# the exposed bitmap.
> +#
> +# Since: 3.0
> +##
> +  { 'command': 'nbd-server-add-bitmap',
> +    'data': {'name': 'str', 'bitmap': 'str', '*bitmap-export-name': 'str'} }
> +
> +##
>   # @nbd-server-stop:
>   #
>   # Stop QEMU's embedded NBD server, and unregister all devices previously
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 65a84739ed..6b0c50732c 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -220,3 +220,26 @@ void qmp_nbd_server_stop(Error **errp)
>       nbd_server_free(nbd_server);
>       nbd_server = NULL;
>   }
> +
> +void qmp_nbd_server_add_bitmap(const char *name, const char *bitmap,
> +                               bool has_bitmap_export_name,
> +                               const char *bitmap_export_name,
> +                               Error **errp)
> +{
> +    NBDExport *exp;
> +
> +    if (!nbd_server) {
> +        error_setg(errp, "NBD server not running");
> +        return;
> +    }
> +
> +    exp = nbd_export_find(name);
> +    if (exp == NULL) {
> +        error_setg(errp, "Export '%s' is not found", name);
> +        return;
> +    }
> +
> +    nbd_export_bitmap(exp, bitmap,
> +                      has_bitmap_export_name ? bitmap_export_name : bitmap,
> +                      errp);
> +}
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
