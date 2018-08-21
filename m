Received: from eggs.gnu.org ([2001:4830:134:3::10]:40416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1frxX4-0008PG-Ch
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1frxWw-0004cr-2s
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:40:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1frxWs-0004RB-SB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 23:40:27 -0400
References: <20180811205924.4113-1-zhangckid@gmail.com>
	<20180811205924.4113-18-zhangckid@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b49f9e4-a910-36a4-3c31-29d7bec4598d@redhat.com>
Date: Tue, 21 Aug 2018 11:40:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180811205924.4113-18-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V11 17/20] filter-rewriter: handle
 checkpoint and failover event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>



On 2018=E5=B9=B408=E6=9C=8812=E6=97=A5 04:59, Zhang Chen wrote:
> After one round of checkpoint, the states between PVM and SVM
> become consistent, so it is unnecessary to adjust the sequence
> of net packets for old connections, besides, while failover
> happens, filter-rewriter will into failover mode that needn't
> handle the new TCP connection.
>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   net/colo-compare.c    | 12 ++++-----
>   net/colo.c            |  8 ++++++
>   net/colo.h            |  2 ++
>   net/filter-rewriter.c | 57 ++++++++++++++++++++++++++++++++++++++++++=
+
>   4 files changed, 73 insertions(+), 6 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index b8c0240725..462e822be6 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -116,6 +116,12 @@ enum {
>       SECONDARY_IN,
>   };
>  =20
> +static void colo_compare_inconsistency_notify(void)
> +{
> +    notifier_list_notify(&colo_compare_notifiers,
> +                migrate_get_current());
> +}
> +
>   static int compare_chr_send(CompareState *s,
>                               const uint8_t *buf,
>                               uint32_t size,
> @@ -562,12 +568,6 @@ static int colo_old_packet_check_one(Packet *pkt, =
int64_t *check_time)
>       }
>   }
>  =20
> -static void colo_compare_inconsistency_notify(void)
> -{
> -    notifier_list_notify(&colo_compare_notifiers,
> -                migrate_get_current());
> -}
> -

This part of changes seems unnecessary?

>   void colo_compare_register_notifier(Notifier *notify)
>   {
>       notifier_list_add(&colo_compare_notifiers, notify);
> diff --git a/net/colo.c b/net/colo.c
> index 97c8fc928f..49176bf07b 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -221,3 +221,11 @@ Connection *connection_get(GHashTable *connection_=
track_table,
>  =20
>       return conn;
>   }
> +
> +bool connection_has_tracked(GHashTable *connection_track_table,
> +                            ConnectionKey *key)
> +{
> +    Connection *conn =3D g_hash_table_lookup(connection_track_table, k=
ey);
> +
> +    return conn ? true : false;
> +}
> diff --git a/net/colo.h b/net/colo.h
> index 0277e0e9ba..11c5226488 100644
> --- a/net/colo.h
> +++ b/net/colo.h
> @@ -98,6 +98,8 @@ void connection_destroy(void *opaque);
>   Connection *connection_get(GHashTable *connection_track_table,
>                              ConnectionKey *key,
>                              GQueue *conn_list);
> +bool connection_has_tracked(GHashTable *connection_track_table,
> +                            ConnectionKey *key);
>   void connection_hashtable_reset(GHashTable *connection_track_table);
>   Packet *packet_new(const void *data, int size, int vnet_hdr_len);
>   void packet_destroy(void *opaque, void *user_data);
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index f18a71bf2e..c463a0c1d0 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -20,11 +20,15 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/iov.h"
>   #include "net/checksum.h"
> +#include "net/colo.h"
> +#include "migration/colo.h"
>  =20
>   #define FILTER_COLO_REWRITER(obj) \
>       OBJECT_CHECK(RewriterState, (obj), TYPE_FILTER_REWRITER)
>  =20
>   #define TYPE_FILTER_REWRITER "filter-rewriter"
> +#define FAILOVER_MODE_ON  true
> +#define FAILOVER_MODE_OFF false
>  =20
>   typedef struct RewriterState {
>       NetFilterState parent_obj;
> @@ -32,8 +36,14 @@ typedef struct RewriterState {
>       /* hashtable to save connection */
>       GHashTable *connection_track_table;
>       bool vnet_hdr;
> +    bool failover_mode;
>   } RewriterState;
>  =20
> +static void filter_rewriter_failover_mode(RewriterState *s)
> +{
> +    s->failover_mode =3D FAILOVER_MODE_ON;
> +}
> +
>   static void filter_rewriter_flush(NetFilterState *nf)
>   {
>       RewriterState *s =3D FILTER_COLO_REWRITER(nf);
> @@ -269,6 +279,13 @@ static ssize_t colo_rewriter_receive_iov(NetFilter=
State *nf,
>                */
>               reverse_connection_key(&key);
>           }
> +
> +        /* After failover we needn't change new TCP packet */
> +        if (s->failover_mode &&
> +            connection_has_tracked(s->connection_track_table, &key)) {

I think you mean !connection_has_tracked() here?

> +            goto out;
> +        }
> +
>           conn =3D connection_get(s->connection_track_table,
>                                 &key,
>                                 NULL);
> @@ -302,11 +319,49 @@ static ssize_t colo_rewriter_receive_iov(NetFilte=
rState *nf,
>           }
>       }
>  =20
> +out:
>       packet_destroy(pkt, NULL);
>       pkt =3D NULL;
>       return 0;
>   }
>  =20
> +static void reset_seq_offset(gpointer key, gpointer value, gpointer us=
er_data)
> +{
> +    Connection *conn =3D (Connection *)value;
> +
> +    conn->offset =3D 0;
> +}
> +
> +static gboolean offset_is_nonzero(gpointer key,
> +                                  gpointer value,
> +                                  gpointer user_data)
> +{
> +    Connection *conn =3D (Connection *)value;
> +
> +    return conn->offset ? true : false;
> +}
> +
> +static void colo_rewriter_handle_event(NetFilterState *nf, int event,
> +                                       Error **errp)
> +{
> +    RewriterState *rs =3D FILTER_COLO_REWRITER(nf);
> +
> +    switch (event) {
> +    case COLO_EVENT_CHECKPOINT:
> +        g_hash_table_foreach(rs->connection_track_table,
> +                            reset_seq_offset, NULL);
> +        break;
> +    case COLO_EVENT_FAILOVER:
> +        if (!g_hash_table_find(rs->connection_track_table,
> +                              offset_is_nonzero, NULL)) {
> +            filter_rewriter_failover_mode(rs);
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +}

So I think instead of having a generic filter notifier chain, rewriter=20
can register notifier to COLO instead. This avoid touching filter core=20
codes.

Thanks

> +
>   static void colo_rewriter_cleanup(NetFilterState *nf)
>   {
>       RewriterState *s =3D FILTER_COLO_REWRITER(nf);
> @@ -350,6 +405,7 @@ static void filter_rewriter_init(Object *obj)
>       RewriterState *s =3D FILTER_COLO_REWRITER(obj);
>  =20
>       s->vnet_hdr =3D false;
> +    s->failover_mode =3D FAILOVER_MODE_OFF;
>       object_property_add_bool(obj, "vnet_hdr_support",
>                                filter_rewriter_get_vnet_hdr,
>                                filter_rewriter_set_vnet_hdr, NULL);
> @@ -362,6 +418,7 @@ static void colo_rewriter_class_init(ObjectClass *o=
c, void *data)
>       nfc->setup =3D colo_rewriter_setup;
>       nfc->cleanup =3D colo_rewriter_cleanup;
>       nfc->receive_iov =3D colo_rewriter_receive_iov;
> +    nfc->handle_event =3D colo_rewriter_handle_event;
>   }
>  =20
>   static const TypeInfo colo_rewriter_info =3D {
