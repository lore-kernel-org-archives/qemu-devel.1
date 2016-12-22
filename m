Received: from eggs.gnu.org ([2001:4830:134:3::10]:51370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cJxJD-0006fj-AS
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cJxJ8-0004KH-Ez
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:56:59 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60870)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cJxJ7-0004IZ-Uz
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:56:54 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <1479092066-20810-1-git-send-email-jasowang@redhat.com>
	<1479092066-20810-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1479092066-20810-2-git-send-email-jasowang@redhat.com>
Date: Thu, 22 Dec 2016 09:56:53 +0300
Message-ID: <000301d25c20$94152bd0$bc3f8370$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PULL V2 1/3] record/replay: add network support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Jason Wang' <jasowang@redhat.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

Hi, Jason!

Please don't forget this for 2.9.

Pavel Dovgalyuk

> -----Original Message-----
> From: Jason Wang [mailto:jasowang@redhat.com]
> Sent: Monday, November 14, 2016 5:54 AM
> To: peter.maydell@linaro.org
> Cc: qemu-devel@nongnu.org; Pavel Dovgalyuk; Jason Wang
> Subject: [PULL V2 1/3] record/replay: add network support
> 
> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> This patch adds support of recording and replaying network packets in
> irount rr mode.
> 
> Record and replay for network interactions is performed with the network filter.
> Each backend must have its own instance of the replay filter as follows:
>  -netdev user,id=net1 -device rtl8139,netdev=net1
>  -object filter-replay,id=replay,netdev=net1
> 
> Replay network filter is used to record and replay network packets. While
> recording the virtual machine this filter puts all packets coming from
> the outer world into the log. In replay mode packets from the log are
> injected into the network device. All interactions with network backend
> in replay mode are disabled.
> 
> v5 changes:
>  - using iov_to_buf function instead of loop
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  docs/replay.txt          |  14 +++++++
>  include/sysemu/replay.h  |  12 ++++++
>  net/Makefile.objs        |   1 +
>  net/filter-replay.c      |  92 ++++++++++++++++++++++++++++++++++++++++++
>  replay/Makefile.objs     |   1 +
>  replay/replay-events.c   |  11 +++++
>  replay/replay-internal.h |  10 +++++
>  replay/replay-net.c      | 102 +++++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay.c          |   2 +-
>  vl.c                     |   3 +-
>  10 files changed, 246 insertions(+), 2 deletions(-)
>  create mode 100644 net/filter-replay.c
>  create mode 100644 replay/replay-net.c
> 
> diff --git a/docs/replay.txt b/docs/replay.txt
> index 779c6c0..347b2ff 100644
> --- a/docs/replay.txt
> +++ b/docs/replay.txt
> @@ -195,3 +195,17 @@ Queue is flushed at checkpoints and information about processed requests
>  is recorded to the log. In replay phase the queue is matched with
>  events read from the log. Therefore block devices requests are processed
>  deterministically.
> +
> +Network devices
> +---------------
> +
> +Record and replay for network interactions is performed with the network filter.
> +Each backend must have its own instance of the replay filter as follows:
> + -netdev user,id=net1 -device rtl8139,netdev=net1
> + -object filter-replay,id=replay,netdev=net1
> +
> +Replay network filter is used to record and replay network packets. While
> +recording the virtual machine this filter puts all packets coming from
> +the outer world into the log. In replay mode packets from the log are
> +injected into the network device. All interactions with network backend
> +in replay mode are disabled.
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index f80d6d2..abb35ca 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -39,6 +39,8 @@ enum ReplayCheckpoint {
>  };
>  typedef enum ReplayCheckpoint ReplayCheckpoint;
> 
> +typedef struct ReplayNetState ReplayNetState;
> +
>  extern ReplayMode replay_mode;
> 
>  /* Replay process control functions */
> @@ -137,4 +139,14 @@ void replay_char_read_all_save_error(int res);
>  /*! Writes character read_all execution result into the replay log. */
>  void replay_char_read_all_save_buf(uint8_t *buf, int offset);
> 
> +/* Network */
> +
> +/*! Registers replay network filter attached to some backend. */
> +ReplayNetState *replay_register_net(NetFilterState *nfs);
> +/*! Unregisters replay network filter. */
> +void replay_unregister_net(ReplayNetState *rns);
> +/*! Called to write network packet to the replay log. */
> +void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
> +                             const struct iovec *iov, int iovcnt);
> +
>  #endif
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> index 2a80df5..2e2fd43 100644
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -19,3 +19,4 @@ common-obj-y += filter-mirror.o
>  common-obj-y += colo-compare.o
>  common-obj-y += colo.o
>  common-obj-y += filter-rewriter.o
> +common-obj-y += filter-replay.o
> diff --git a/net/filter-replay.c b/net/filter-replay.c
> new file mode 100644
> index 0000000..cff65f8
> --- /dev/null
> +++ b/net/filter-replay.c
> @@ -0,0 +1,92 @@
> +/*
> + * filter-replay.c
> + *
> + * Copyright (c) 2010-2016 Institute for System Programming
> + *                         of the Russian Academy of Sciences.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "clients.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +#include "qemu/iov.h"
> +#include "qemu/log.h"
> +#include "qemu/timer.h"
> +#include "qapi/visitor.h"
> +#include "net/filter.h"
> +#include "sysemu/replay.h"
> +
> +#define TYPE_FILTER_REPLAY "filter-replay"
> +
> +#define FILTER_REPLAY(obj) \
> +    OBJECT_CHECK(NetFilterReplayState, (obj), TYPE_FILTER_REPLAY)
> +
> +struct NetFilterReplayState {
> +    NetFilterState nfs;
> +    ReplayNetState *rns;
> +};
> +typedef struct NetFilterReplayState NetFilterReplayState;
> +
> +static ssize_t filter_replay_receive_iov(NetFilterState *nf,
> +                                         NetClientState *sndr,
> +                                         unsigned flags,
> +                                         const struct iovec *iov,
> +                                         int iovcnt, NetPacketSent *sent_cb)
> +{
> +    NetFilterReplayState *nfrs = FILTER_REPLAY(nf);
> +    switch (replay_mode) {
> +    case REPLAY_MODE_RECORD:
> +        if (nf->netdev == sndr) {
> +            replay_net_packet_event(nfrs->rns, flags, iov, iovcnt);
> +            return iov_size(iov, iovcnt);
> +        }
> +        return 0;
> +    case REPLAY_MODE_PLAY:
> +        /* Drop all packets in replay mode.
> +           Packets from the log will be injected by the replay module. */
> +        return iov_size(iov, iovcnt);
> +    default:
> +        /* Pass all the packets. */
> +        return 0;
> +    }
> +}
> +
> +static void filter_replay_instance_init(Object *obj)
> +{
> +    NetFilterReplayState *nfrs = FILTER_REPLAY(obj);
> +    nfrs->rns = replay_register_net(&nfrs->nfs);
> +}
> +
> +static void filter_replay_instance_finalize(Object *obj)
> +{
> +    NetFilterReplayState *nfrs = FILTER_REPLAY(obj);
> +    replay_unregister_net(nfrs->rns);
> +}
> +
> +static void filter_replay_class_init(ObjectClass *oc, void *data)
> +{
> +    NetFilterClass *nfc = NETFILTER_CLASS(oc);
> +
> +    nfc->receive_iov = filter_replay_receive_iov;
> +}
> +
> +static const TypeInfo filter_replay_info = {
> +    .name = TYPE_FILTER_REPLAY,
> +    .parent = TYPE_NETFILTER,
> +    .class_init = filter_replay_class_init,
> +    .instance_init = filter_replay_instance_init,
> +    .instance_finalize = filter_replay_instance_finalize,
> +    .instance_size = sizeof(NetFilterReplayState),
> +};
> +
> +static void filter_replay_register_types(void)
> +{
> +    type_register_static(&filter_replay_info);
> +}
> +
> +type_init(filter_replay_register_types);
> diff --git a/replay/Makefile.objs b/replay/Makefile.objs
> index c8ad3eb..b2afd40 100644
> --- a/replay/Makefile.objs
> +++ b/replay/Makefile.objs
> @@ -5,3 +5,4 @@ common-obj-y += replay-time.o
>  common-obj-y += replay-input.o
>  common-obj-y += replay-char.o
>  common-obj-y += replay-snapshot.o
> +common-obj-y += replay-net.o
> diff --git a/replay/replay-events.c b/replay/replay-events.c
> index c513913..94a6dcc 100644
> --- a/replay/replay-events.c
> +++ b/replay/replay-events.c
> @@ -54,6 +54,9 @@ static void replay_run_event(Event *event)
>      case REPLAY_ASYNC_EVENT_BLOCK:
>          aio_bh_call(event->opaque);
>          break;
> +    case REPLAY_ASYNC_EVENT_NET:
> +        replay_event_net_run(event->opaque);
> +        break;
>      default:
>          error_report("Replay: invalid async event ID (%d) in the queue",
>                      event->event_kind);
> @@ -189,6 +192,9 @@ static void replay_save_event(Event *event, int checkpoint)
>          case REPLAY_ASYNC_EVENT_BLOCK:
>              replay_put_qword(event->id);
>              break;
> +        case REPLAY_ASYNC_EVENT_NET:
> +            replay_event_net_save(event->opaque);
> +            break;
>          default:
>              error_report("Unknown ID %" PRId64 " of replay event", event->id);
>              exit(1);
> @@ -252,6 +258,11 @@ static Event *replay_read_event(int checkpoint)
>              read_id = replay_get_qword();
>          }
>          break;
> +    case REPLAY_ASYNC_EVENT_NET:
> +        event = g_malloc0(sizeof(Event));
> +        event->event_kind = read_event_kind;
> +        event->opaque = replay_event_net_load();
> +        return event;
>      default:
>          error_report("Unknown ID %d of replay event", read_event_kind);
>          exit(1);
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index 9117e44..c26d079 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -50,6 +50,7 @@ enum ReplayAsyncEventKind {
>      REPLAY_ASYNC_EVENT_INPUT_SYNC,
>      REPLAY_ASYNC_EVENT_CHAR_READ,
>      REPLAY_ASYNC_EVENT_BLOCK,
> +    REPLAY_ASYNC_EVENT_NET,
>      REPLAY_ASYNC_COUNT
>  };
> 
> @@ -161,6 +162,15 @@ void replay_event_char_read_save(void *opaque);
>  /*! Reads char event read from the file. */
>  void *replay_event_char_read_load(void);
> 
> +/* Network devices */
> +
> +/*! Called to run network event. */
> +void replay_event_net_run(void *opaque);
> +/*! Writes network event to the file. */
> +void replay_event_net_save(void *opaque);
> +/*! Reads network from the file. */
> +void *replay_event_net_load(void);
> +
>  /* VMState-related functions */
> 
>  /* Registers replay VMState.
> diff --git a/replay/replay-net.c b/replay/replay-net.c
> new file mode 100644
> index 0000000..80b7054
> --- /dev/null
> +++ b/replay/replay-net.c
> @@ -0,0 +1,102 @@
> +/*
> + * replay-net.c
> + *
> + * Copyright (c) 2010-2016 Institute for System Programming
> + *                         of the Russian Academy of Sciences.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/replay.h"
> +#include "replay-internal.h"
> +#include "sysemu/sysemu.h"
> +#include "net/net.h"
> +#include "net/filter.h"
> +#include "qemu/iov.h"
> +
> +struct ReplayNetState {
> +    NetFilterState *nfs;
> +    int id;
> +};
> +
> +typedef struct NetEvent {
> +    uint8_t id;
> +    uint32_t flags;
> +    uint8_t *data;
> +    size_t size;
> +} NetEvent;
> +
> +static NetFilterState **network_filters;
> +static int network_filters_count;
> +
> +ReplayNetState *replay_register_net(NetFilterState *nfs)
> +{
> +    ReplayNetState *rns = g_new0(ReplayNetState, 1);
> +    rns->nfs = nfs;
> +    rns->id = network_filters_count++;
> +    network_filters = g_realloc(network_filters,
> +                                network_filters_count
> +                                    * sizeof(*network_filters));
> +    network_filters[network_filters_count - 1] = nfs;
> +    return rns;
> +}
> +
> +void replay_unregister_net(ReplayNetState *rns)
> +{
> +    network_filters[rns->id] = NULL;
> +    g_free(rns);
> +}
> +
> +void replay_net_packet_event(ReplayNetState *rns, unsigned flags,
> +                             const struct iovec *iov, int iovcnt)
> +{
> +    NetEvent *event = g_new(NetEvent, 1);
> +    event->flags = flags;
> +    event->data = g_malloc(iov_size(iov, iovcnt));
> +    event->size = iov_size(iov, iovcnt);
> +    event->id = rns->id;
> +    iov_to_buf(iov, iovcnt, 0, event->data, event->size);
> +
> +    replay_add_event(REPLAY_ASYNC_EVENT_NET, event, NULL, 0);
> +}
> +
> +void replay_event_net_run(void *opaque)
> +{
> +    NetEvent *event = opaque;
> +    struct iovec iov = {
> +        .iov_base = (void *)event->data,
> +        .iov_len = event->size
> +    };
> +
> +    assert(event->id < network_filters_count);
> +
> +    qemu_netfilter_pass_to_next(network_filters[event->id]->netdev,
> +        event->flags, &iov, 1, network_filters[event->id]);
> +
> +    g_free(event->data);
> +    g_free(event);
> +}
> +
> +void replay_event_net_save(void *opaque)
> +{
> +    NetEvent *event = opaque;
> +
> +    replay_put_byte(event->id);
> +    replay_put_dword(event->flags);
> +    replay_put_array(event->data, event->size);
> +}
> +
> +void *replay_event_net_load(void)
> +{
> +    NetEvent *event = g_new(NetEvent, 1);
> +
> +    event->id = replay_get_byte();
> +    event->flags = replay_get_dword();
> +    replay_get_array_alloc(&event->data, &event->size);
> +
> +    return event;
> +}
> diff --git a/replay/replay.c b/replay/replay.c
> index c797aea..7f27cf1 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -21,7 +21,7 @@
> 
>  /* Current version of the replay mechanism.
>     Increase it when file format changes. */
> -#define REPLAY_VERSION              0xe02004
> +#define REPLAY_VERSION              0xe02005
>  /* Size of replay log header */
>  #define HEADER_SIZE                 (sizeof(uint32_t) + sizeof(uint64_t))
> 
> diff --git a/vl.c b/vl.c
> index d77dd86..a23de18 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2859,7 +2859,8 @@ static bool object_create_initial(const char *type)
>          g_str_equal(type, "filter-mirror") ||
>          g_str_equal(type, "filter-redirector") ||
>          g_str_equal(type, "colo-compare") ||
> -        g_str_equal(type, "filter-rewriter")) {
> +        g_str_equal(type, "filter-rewriter") ||
> +        g_str_equal(type, "filter-replay")) {
>          return false;
>      }
> 
> --
> 2.7.4
