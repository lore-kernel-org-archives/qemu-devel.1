Received: from eggs.gnu.org ([2001:4830:134:3::10]:39466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRwpW-0008II-F1
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eRwpV-0006rM-EE
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:07:54 -0500
References: <20171221013600.17648-1-eblake@redhat.com>
	<20171221013600.17648-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <47a78a6e-cc5b-5ac5-1f80-222ecb4ee8c4@virtuozzo.com>
Date: Thu, 21 Dec 2017 12:07:39 +0300
MIME-Version: 1.0
In-Reply-To: <20171221013600.17648-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] STOP Re: [PULL 4/4] qmp: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

no, I've updated it, we discussed with Kevin that this approach is bad

21.12.2017 04:36, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Add command for export removing. It is needed for cases when we
> don't want to keep export after the operation on it was completed.
> The other example is temporary node, created with blockdev-add.
> If we want to delete it we should firstly remove corresponding
> NBD export.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <20171109154049.42386-3-vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   qapi/block.json | 20 ++++++++++++++++++++
>   blockdev-nbd.c  | 27 +++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
>
> diff --git a/qapi/block.json b/qapi/block.json
> index f093fa3f27..1827940717 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -222,6 +222,26 @@
>   ##
>   { 'command': 'nbd-server-add', 'data': {'device': 'str', '*writable': 'bool'} }
>
> +##
> +# @nbd-server-remove:
> +#
> +# Stop exporting block node through QEMU's embedded NBD server.
> +#
> +# @device: The device name or node name of the exported node. Should be equal
> +#          to @device parameter for corresponding nbd-server-add command call.
> +#
> +# @force: Whether active connections to the export should be closed. If this
> +#         parameter is false the export is only removed from named exports list,
> +#         so new connetions are impossible and it would be freed after all
> +#         clients are disconnected (default false).
> +#
> +# Returns: error if the server is not running or the device is not marked for
> +#          export.
> +#
> +# Since: 2.12
> +##
> +{ 'command': 'nbd-server-remove', 'data': {'device': 'str', '*force': 'bool'} }
> +
>   ##
>   # @nbd-server-stop:
>   #
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 28f551a7b0..5f66951c33 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -203,6 +203,33 @@ void qmp_nbd_server_add(const char *device, bool has_writable, bool writable,
>       nbd_export_put(exp);
>   }
>
> +void qmp_nbd_server_remove(const char *device, bool has_force, bool force,
> +                           Error **errp)
> +{
> +    NBDExport *exp;
> +
> +    if (!nbd_server) {
> +        error_setg(errp, "NBD server not running");
> +        return;
> +    }
> +
> +    exp = nbd_export_find(device);
> +    if (exp == NULL) {
> +        error_setg(errp, "'%s' is not exported", device);
> +        return;
> +    }
> +
> +    if (!has_force) {
> +        force = false;
> +    }
> +
> +    if (force) {
> +        nbd_export_close(exp);
> +    } else {
> +        nbd_export_set_name(exp, NULL);
> +    }
> +}
> +
>   void qmp_nbd_server_stop(Error **errp)
>   {
>       nbd_export_close_all();


-- 
Best regards,
Vladimir
