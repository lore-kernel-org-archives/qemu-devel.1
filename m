Received: from eggs.gnu.org ([2001:4830:134:3::10]:47424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6gJ-0003wO-1S
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dE6gF-0007MD-R6
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:16:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dE6gF-0007M3-Hr
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:16:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9137680055
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:16:50 +0000 (UTC)
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-4-git-send-email-vyasevic@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <70a3d886-2bd5-9789-1cbd-abfb52573679@redhat.com>
Date: Fri, 26 May 2017 12:16:36 +0800
MIME-Version: 1.0
In-Reply-To: <1495649128-10529-4-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/12] migration: Switch to using
 announcement timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com



On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 02:05, Vladislav Yasevich wrote:
> Switch qemu_announce_self and virtio annoucements to use
> the announcement timer framework.  This makes sure that both
> timers use the same timeouts and number of annoucement attempts
>
> Based on work by Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> ---
>   hw/net/virtio-net.c            | 28 ++++++++++++++++------------
>   include/hw/virtio/virtio-net.h |  3 +--
>   include/migration/vmstate.h    | 17 +++++++++++------
>   include/sysemu/sysemu.h        |  2 +-
>   migration/migration.c          |  2 +-
>   migration/savevm.c             | 28 ++++++++++++++--------------
>   6 files changed, 44 insertions(+), 36 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7d091c9..1c65825 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -25,6 +25,7 @@
>   #include "qapi/qmp/qjson.h"
>   #include "qapi-event.h"
>   #include "hw/virtio/virtio-access.h"
> +#include "migration/migration.h"
>  =20
>   #define VIRTIO_NET_VM_VERSION    11
>  =20
> @@ -115,7 +116,7 @@ static void virtio_net_announce_timer(void *opaque)
>       VirtIONet *n =3D opaque;
>       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>  =20
> -    n->announce_counter--;
> +    n->announce_timer->round--;
>       n->status |=3D VIRTIO_NET_S_ANNOUNCE;
>       virtio_notify_config(vdev);
>   }
> @@ -427,8 +428,8 @@ static void virtio_net_reset(VirtIODevice *vdev)
>       n->nobcast =3D 0;
>       /* multiqueue is disabled by default */
>       n->curr_queues =3D 1;
> -    timer_del(n->announce_timer);
> -    n->announce_counter =3D 0;
> +    timer_del(n->announce_timer->tm);
> +    n->announce_timer->round =3D 0;
>       n->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
>  =20
>       /* Flush any MAC and VLAN filter table state */
> @@ -872,10 +873,10 @@ static int virtio_net_handle_announce(VirtIONet *=
n, uint8_t cmd,
>       if (cmd =3D=3D VIRTIO_NET_CTRL_ANNOUNCE_ACK &&
>           n->status & VIRTIO_NET_S_ANNOUNCE) {
>           n->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
> -        if (n->announce_counter) {
> -            timer_mod(n->announce_timer,
> +        if (n->announce_timer->round) {
> +            timer_mod(n->announce_timer->tm,
>                         qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> -                      self_announce_delay(n->announce_counter));
> +                      self_announce_delay(n->announce_timer));
>           }
>           return VIRTIO_NET_OK;
>       } else {
> @@ -1615,8 +1616,8 @@ static int virtio_net_post_load_device(void *opaq=
ue, int version_id)
>  =20
>       if (virtio_vdev_has_feature(vdev, VIRTIO_NET_F_GUEST_ANNOUNCE) &&
>           virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
> -        n->announce_counter =3D SELF_ANNOUNCE_ROUNDS;
> -        timer_mod(n->announce_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRT=
UAL));
> +        n->announce_timer->round =3D n->announce_timer->params.rounds;
> +        timer_mod(n->announce_timer->tm, qemu_clock_get_ms(QEMU_CLOCK_=
VIRTUAL));
>       }
>  =20
>       return 0;
> @@ -1938,8 +1939,10 @@ static void virtio_net_device_realize(DeviceStat=
e *dev, Error **errp)
>       qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
>       memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
>       n->status =3D VIRTIO_NET_S_LINK_UP;
> -    n->announce_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
> -                                     virtio_net_announce_timer, n);
> +    n->announce_timer =3D qemu_announce_timer_new(qemu_get_announce_pa=
rams(),
> +                                                QEMU_CLOCK_VIRTUAL);
> +    n->announce_timer->tm =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
> +                                          virtio_net_announce_timer, n=
);
>  =20
>       if (n->netclient_type) {
>           /*
> @@ -2001,8 +2004,9 @@ static void virtio_net_device_unrealize(DeviceSta=
te *dev, Error **errp)
>           virtio_net_del_queue(n, i);
>       }
>  =20
> -    timer_del(n->announce_timer);
> -    timer_free(n->announce_timer);
> +    timer_del(n->announce_timer->tm);
> +    timer_free(n->announce_timer->tm);
> +    g_free(n->announce_timer);
>       g_free(n->vqs);
>       qemu_del_nic(n->nic);
>       virtio_cleanup(vdev);
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> index 1eec9a2..51dd4c3 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -94,8 +94,7 @@ typedef struct VirtIONet {
>       char *netclient_name;
>       char *netclient_type;
>       uint64_t curr_guest_offloads;
> -    QEMUTimer *announce_timer;
> -    int announce_counter;
> +    AnnounceTimer *announce_timer;
>       bool needs_vnet_hdr_swap;
>   } VirtIONet;
>  =20
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index a6bf84d..f8aed9b 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1022,8 +1022,6 @@ extern const VMStateInfo vmstate_info_qtailq;
>   #define VMSTATE_END_OF_LIST()                                        =
 \
>       {}
>  =20
> -#define SELF_ANNOUNCE_ROUNDS 5
> -
>   void loadvm_free_handlers(MigrationIncomingState *mis);
>  =20
>   int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> @@ -1071,11 +1069,18 @@ AnnounceTimer *qemu_announce_timer_create(Annou=
nceParameters *params,
>                                             QEMUTimerCB *cb);
>  =20
>   static inline
> -int64_t self_announce_delay(int round)
> +int64_t self_announce_delay(AnnounceTimer *timer)
>   {
> -    assert(round < SELF_ANNOUNCE_ROUNDS && round > 0);
> -    /* delay 50ms, 150ms, 250ms, ... */
> -    return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
> +    int64_t ret;
> +
> +    ret =3D  timer->params.initial +
> +           (timer->params.rounds - timer->round - 1) *
> +           timer->params.step;
> +
> +    if (ret < 0 || ret > timer->params.max) {
> +        ret =3D timer->params.max;
> +    }

Can we move this check to qemu_validate_announce_parameters()?

> +    return ret;
>   }
>  =20
>   void dump_vmstate_json_to_file(FILE *out_fp);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 7fd49c4..2ef1687 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -85,7 +85,7 @@ bool qemu_validate_announce_parameters(AnnounceParame=
ters *params,
>                                          Error **errp);
>   void qemu_set_announce_parameters(AnnounceParameters *announce_params=
,
>                                     AnnounceParameters *params);
> -void qemu_announce_self(void);
> +void qemu_announce_self(AnnounceParameters *params);
>  =20
>   /* Subcommands for QEMU_VM_COMMAND */
>   enum qemu_vm_cmd {
> diff --git a/migration/migration.c b/migration/migration.c
> index 0304c01..987c1cf 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -345,7 +345,7 @@ static void process_incoming_migration_bh(void *opa=
que)
>        * This must happen after all error conditions are dealt with and
>        * we're sure the VM is going to be running on this host.
>        */
> -    qemu_announce_self();
> +    qemu_announce_self(qemu_get_announce_params());
>  =20
>       /* If global state section was not received or we are in running
>          state, we need to obey autostart. Any other state is set with
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 607b090..555157a 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -212,21 +212,19 @@ static void qemu_announce_self_iter(NICState *nic=
, void *opaque)
>       qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
>   }
>  =20
> -
>   static void qemu_announce_self_once(void *opaque)
>   {
> -    static int count =3D SELF_ANNOUNCE_ROUNDS;
> -    QEMUTimer *timer =3D *(QEMUTimer **)opaque;
> +    AnnounceTimer *timer =3D (AnnounceTimer *)opaque;
>  =20
>       qemu_foreach_nic(qemu_announce_self_iter, NULL);
>  =20
> -    if (--count) {
> -        /* delay 50ms, 150ms, 250ms, ... */
> -        timer_mod(timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> -                  self_announce_delay(count));
> +    if (--timer->round) {
> +        timer_mod(timer->tm, qemu_clock_get_ms(timer->type) +
> +                  self_announce_delay(timer));
>       } else {
> -            timer_del(timer);
> -            timer_free(timer);
> +            timer_del(timer->tm);
> +            timer_free(timer->tm);
> +            g_free(timer);
>       }
>   }
>  =20
> @@ -252,11 +250,13 @@ AnnounceTimer *qemu_announce_timer_create(Announc=
eParameters *params,
>       return timer;
>   }
>  =20
> -void qemu_announce_self(void)
> +void qemu_announce_self(AnnounceParameters *params)
>   {
> -    static QEMUTimer *timer;
> -    timer =3D timer_new_ms(QEMU_CLOCK_REALTIME, qemu_announce_self_onc=
e, &timer);
> -    qemu_announce_self_once(&timer);
> +    AnnounceTimer *timer;
> +
> +    timer =3D qemu_announce_timer_create(params, QEMU_CLOCK_REALTIME,
> +                                       qemu_announce_self_once);
> +    qemu_announce_self_once(timer);
>   }
>  =20
>   /***********************************************************/
> @@ -1730,7 +1730,7 @@ static void loadvm_postcopy_handle_run_bh(void *o=
paque)
>        */
>       cpu_synchronize_all_post_init();
>  =20
> -    qemu_announce_self();
> +    qemu_announce_self(qemu_get_announce_params());
>  =20
>       /* Make sure all file formats flush their mutable metadata.
>        * If we get an error here, just don't restart the VM yet. */

Reviewed-by: Jason Wang <jasowang@redhat.com>
