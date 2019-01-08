Received: from eggs.gnu.org ([209.51.188.92]:41685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ggeyA-0003uo-LU
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ggey9-0005Sr-KS
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:10:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ggey9-0005Os-B9
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 19:10:09 -0500
Date: Mon, 7 Jan 2019 19:10:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190107190855-mutt-send-email-mst@kernel.org>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<1546900184-27403-4-git-send-email-venu.busireddy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546900184-27403-4-git-send-email-venu.busireddy@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] virtio_net: Add a query command for
 FAILOVER_STANDBY_CHANGED event.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Mon, Jan 07, 2019 at 05:29:42PM -0500, Venu Busireddy wrote:
> Add a query command to check the status of the FAILOVER_STANDBY_CHANGED
> state of the virtio_net devices.
> 
> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> ---
>  hw/net/virtio-net.c            | 16 +++++++++++
>  include/hw/virtio/virtio-net.h |  1 +
>  include/net/net.h              |  2 ++
>  net/net.c                      | 61 ++++++++++++++++++++++++++++++++++++++++++
>  qapi/net.json                  | 46 +++++++++++++++++++++++++++++++
>  5 files changed, 126 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7b1bcde..a4e07ac 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -263,9 +263,11 @@ static void virtio_net_failover_notify_event(VirtIONet *n, uint8_t status)
>           */
>          if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
>                  (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK))) {
> +            n->standby_enabled = true;
>              qapi_event_send_failover_standby_changed(!!ncn, ncn, path, true);
>          } else if ((!(status & VIRTIO_CONFIG_S_DRIVER_OK)) &&
>                  (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +            n->standby_enabled = false;
>              qapi_event_send_failover_standby_changed(!!ncn, ncn, path, false);
>          }
>      }

Here too, we are sending an endless stream of events.

Instead, let's send one "changed" event without data,
and then be silent until management runs the query command.




> @@ -448,6 +450,19 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetClientState *nc)
>      return info;
>  }
>  
> +static StandbyStatusInfo *virtio_net_query_standby_status(NetClientState *nc)
> +{
> +    StandbyStatusInfo *info;
> +    VirtIONet *n = qemu_get_nic_opaque(nc);
> +
> +    info = g_malloc0(sizeof(*info));
> +    info->device = g_strdup(n->netclient_name);
> +    info->path = g_strdup(object_get_canonical_path(OBJECT(n->qdev)));
> +    info->enabled = n->standby_enabled;
> +
> +    return info;
> +}
> +
>  static void virtio_net_reset(VirtIODevice *vdev)
>  {
>      VirtIONet *n = VIRTIO_NET(vdev);
> @@ -1923,6 +1938,7 @@ static NetClientInfo net_virtio_info = {
>      .receive = virtio_net_receive,
>      .link_status_changed = virtio_net_set_link_status,
>      .query_rx_filter = virtio_net_query_rxfilter,
> +    .query_standby_status = virtio_net_query_standby_status,
>  };
>  
>  static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int idx)
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index 4d7f3c8..9071e96 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -103,6 +103,7 @@ typedef struct VirtIONet {
>      int announce_counter;
>      bool needs_vnet_hdr_swap;
>      bool mtu_bypass_backend;
> +    bool standby_enabled;
>  } VirtIONet;
>  
>  void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
> diff --git a/include/net/net.h b/include/net/net.h
> index ec13702..61e8513 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -50,6 +50,7 @@ typedef void (NetCleanup) (NetClientState *);
>  typedef void (LinkStatusChanged)(NetClientState *);
>  typedef void (NetClientDestructor)(NetClientState *);
>  typedef RxFilterInfo *(QueryRxFilter)(NetClientState *);
> +typedef StandbyStatusInfo *(QueryStandbyStatus)(NetClientState *);
>  typedef bool (HasUfo)(NetClientState *);
>  typedef bool (HasVnetHdr)(NetClientState *);
>  typedef bool (HasVnetHdrLen)(NetClientState *, int);
> @@ -71,6 +72,7 @@ typedef struct NetClientInfo {
>      NetCleanup *cleanup;
>      LinkStatusChanged *link_status_changed;
>      QueryRxFilter *query_rx_filter;
> +    QueryStandbyStatus *query_standby_status;
>      NetPoll *poll;
>      HasUfo *has_ufo;
>      HasVnetHdr *has_vnet_hdr;
> diff --git a/net/net.c b/net/net.c
> index 1f7d626..fbf288e 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1320,6 +1320,67 @@ RxFilterInfoList *qmp_query_rx_filter(bool has_name, const char *name,
>      return filter_list;
>  }
>  
> +StandbyStatusInfoList *qmp_query_standby_status(bool has_device,
> +                                                const char *device,
> +                                                Error **errp)
> +{
> +    NetClientState *nc;
> +    StandbyStatusInfoList *status_list = NULL, *last_entry = NULL;
> +
> +    QTAILQ_FOREACH(nc, &net_clients, next) {
> +        StandbyStatusInfoList *entry;
> +        StandbyStatusInfo *info;
> +
> +        if (has_device && strcmp(nc->name, device) != 0) {
> +            continue;
> +        }
> +
> +        /* only query standby status information of NIC */
> +        if (nc->info->type != NET_CLIENT_DRIVER_NIC) {
> +            if (has_device) {
> +                error_setg(errp, "net client(%s) isn't a NIC", device);
> +                return NULL;
> +            }
> +            continue;
> +        }
> +
> +        /*
> +         * only query information on queue 0 since the info is per nic,
> +         * not per queue.
> +         */
> +        if (nc->queue_index != 0) {
> +            continue;
> +        }
> +
> +        if (nc->info->query_standby_status) {
> +            info = nc->info->query_standby_status(nc);
> +            entry = g_malloc0(sizeof(*entry));
> +            entry->value = info;
> +
> +            if (!status_list) {
> +                status_list = entry;
> +            } else {
> +                last_entry->next = entry;
> +            }
> +            last_entry = entry;
> +        } else if (has_device) {
> +            error_setg(errp, "net client(%s) doesn't support"
> +                       " standby status querying", device);
> +            return NULL;
> +        }
> +
> +        if (has_device) {
> +            break;
> +        }
> +    }
> +
> +    if (status_list == NULL && has_device) {
> +        error_setg(errp, "invalid net client name: %s", device);
> +    }
> +
> +    return status_list;
> +}
> +
>  void hmp_info_network(Monitor *mon, const QDict *qdict)
>  {
>      NetClientState *nc, *peer;
> diff --git a/qapi/net.json b/qapi/net.json
> index 6a6d6fe..633ac87 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -711,3 +711,49 @@
>  ##
>  { 'event': 'FAILOVER_STANDBY_CHANGED',
>    'data': {'*device': 'str', 'path': 'str', 'enabled': 'bool'} }
> +
> +##
> +# @StandbyStatusInfo:
> +#
> +# Standby status information for a virtio_net device.
> +#
> +# @device: Indicates the virtio_net device.
> +#
> +# @path: Indicates the device path.
> +#
> +# @enabled: true if the virtio_net driver is loaded.
> +#           false if the virtio_net driver is unloaded or the guest rebooted.
> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'StandbyStatusInfo',
> +  'data': {'device': 'str', 'path': 'str', 'enabled': 'bool'} }
> +
> +##
> +# @query-standby-status:
> +#
> +# Return Standby status information for all virtio_net devices,
> +#        or for the given virtio_net device.
> +#
> +# @device: Name of the virtio_net device.
> +#
> +# Returns: List of @StandbyStatusInfo for all virtio_net devices,
> +#          or for the given virtio_net device.
> +#          Returns an error if the given @device doesn't exist.
> +#
> +# Since: 4.0
> +#
> +# Example:
> +#
> +# -> { "execute": "query-standby-status", "arguments": { "device": "net0" } }
> +# <- { "return": [
> +#                  { 'device': 'net0',
> +#                    'path': '/machine/peripheral/net0/virtio-backend',
> +#                    'enabled': 'true'
> +#                  }
> +#                ]
> +#    }
> +#
> +##
> +{ 'command': 'query-standby-status', 'data': { '*device': 'str' },
> +  'returns': ['StandbyStatusInfo'] }
