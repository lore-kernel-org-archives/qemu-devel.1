Received: from eggs.gnu.org ([2001:4830:134:3::10]:55091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eLpw2-0006YU-5e
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:33:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eLpvx-0006Zg-BB
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:33:22 -0500
Date: Mon, 4 Dec 2017 13:32:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171204123258.GC872@localhost.localdomain>
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
	<20171109154049.42386-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109154049.42386-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qmp: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org

Am 09.11.2017 um 16:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Add command for export removing. It is needed for cases when we
> don't want to keep export after the operation on it was completed.
> The other example is temporary node, created with blockdev-add.
> If we want to delete it we should firstly remove corresponding
> NBD export.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block.json | 20 ++++++++++++++++++++
>  blockdev-nbd.c  | 27 +++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/qapi/block.json b/qapi/block.json
> index f093fa3f27..1827940717 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -223,6 +223,26 @@
>  { 'command': 'nbd-server-add', 'data': {'device': 'str', '*writable': 'bool'} }
>  
>  ##
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
> +##
>  # @nbd-server-stop:
>  #
>  # Stop QEMU's embedded NBD server, and unregister all devices previously
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 28f551a7b0..5f66951c33 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -203,6 +203,33 @@ void qmp_nbd_server_add(const char *device, bool has_writable, bool writable,
>      nbd_export_put(exp);
>  }
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

Using nbd_export_find() in order to identify the export, and
nbd_export_set_name(NULL) for force=false means that you can't follow up
with another nbd-server-remove,force=true later if the client just
doesn't want to go away voluntarily.

To be honest, I'm not very happy with the whole NBD interface, even as
it exists today. We're mixing up several things that should really be
kept separate: The export name (this should be configurable and the real
ID of the export that you use with things like nbd-server-remove), the
device/node name (just a pointer to the root node, not to be exposed or
even just stored anywhere) and whether the export is visible for clients.

nbd-server-remove with force=false should make the export invisible for
clients, but still keep the ID assigned so that another
nbd-server-remove with force=true can still be issued. We should also
really have a query-nbd-server that shows all exports with their IDs,
their root node (which may have changed meanwhile - snapshots, block
jobs, filter drivers) and information about the currently connected
client(s).

Maybe it would be worth to clean up the interfaces this way before we
add the first command that actually has to identify an export. The
existing commands should be easy to extend in a backwards compatible
way.

Kevin
