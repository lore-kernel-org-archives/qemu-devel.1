Received: from eggs.gnu.org ([2001:4830:134:3::10]:54351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS41P-00052n-TK
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS41O-00088V-CQ
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:20:55 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fS41O-00087Z-0b
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:20:54 -0400
Received: by mail-wr0-x244.google.com with SMTP id o12-v6so17957126wrm.12
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 10:20:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3714d91c-04a2-fdd7-5399-e50a1ba3fc68@redhat.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-16-zhangckid@gmail.com>
	<3714d91c-04a2-fdd7-5399-e50a1ba3fc68@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 11 Jun 2018 01:20:52 +0800
Message-ID: <CAK3tnvK7CZ=tMuHz46G0aiv-LJ9ngWuskvOMRo1qBL+LnkTDFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V8 15/17] filter-rewriter: handle
 checkpoint and failover event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On Mon, Jun 4, 2018 at 3:42 PM, Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2018=E5=B9=B406=E6=9C=8803=E6=97=A5 13:05, Zhang Chen wrote:
>
>> After one round of checkpoint, the states between PVM and SVM
>> become consistent, so it is unnecessary to adjust the sequence
>> of net packets for old connections, besides, while failover
>> happens, filter-rewriter needs to check if it still needs to
>> adjust sequence of net packets.
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> ---
>>   migration/colo.c      | 13 +++++++++++++
>>   net/filter-rewriter.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/migration/colo.c b/migration/colo.c
>> index 442471e088..0bff21d9e5 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -31,6 +31,7 @@
>>   #include "qapi/qapi-events-migration.h"
>>   #include "qapi/qmp/qerror.h"
>>   #include "sysemu/cpus.h"
>> +#include "net/filter.h"
>>     static bool vmstate_loading;
>>   static Notifier packets_compare_notifier;
>> @@ -82,6 +83,11 @@ static void secondary_vm_do_failover(void)
>>       if (local_err) {
>>           error_report_err(local_err);
>>       }
>> +    /* Notify all filters of all NIC to do checkpoint */
>> +    colo_notify_filters_event(COLO_EVENT_FAILOVER, &local_err);
>> +    if (local_err) {
>> +        error_report_err(local_err);
>> +    }
>>         if (!autostart) {
>>           error_report("\"-S\" qemu option will be ignored in secondary
>> side");
>> @@ -800,6 +806,13 @@ void *colo_process_incoming_thread(void *opaque)
>>               goto out;
>>           }
>>   +        /* Notify all filters of all NIC to do checkpoint */
>> +        colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
>> +        if (local_err) {
>> +            qemu_mutex_unlock_iothread();
>> +            goto out;
>> +        }
>> +
>>
>
> I think the above should belong to another patch.
>
>
>
Yes, I will relocate above code.



>           vmstate_loading =3D false;
>>           vm_start();
>>           trace_colo_vm_state_change("stop", "run");
>> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
>> index 0909a9a8af..f3c306cc89 100644
>> --- a/net/filter-rewriter.c
>> +++ b/net/filter-rewriter.c
>> @@ -20,6 +20,8 @@
>>   #include "qemu/main-loop.h"
>>   #include "qemu/iov.h"
>>   #include "net/checksum.h"
>> +#include "net/colo.h"
>> +#include "migration/colo.h"
>>     #define FILTER_COLO_REWRITER(obj) \
>>       OBJECT_CHECK(RewriterState, (obj), TYPE_FILTER_REWRITER)
>> @@ -277,6 +279,43 @@ static ssize_t colo_rewriter_receive_iov(NetFilterS=
tate
>> *nf,
>>       return 0;
>>   }
>>   +static void reset_seq_offset(gpointer key, gpointer value, gpointer
>> user_data)
>> +{
>> +    Connection *conn =3D (Connection *)value;
>> +
>> +    conn->offset =3D 0;
>> +}
>> +
>> +static gboolean offset_is_nonzero(gpointer key,
>> +                                  gpointer value,
>> +                                  gpointer user_data)
>> +{
>> +    Connection *conn =3D (Connection *)value;
>> +
>> +    return conn->offset ? true : false;
>> +}
>> +
>> +static void colo_rewriter_handle_event(NetFilterState *nf, int event,
>> +                                       Error **errp)
>> +{
>> +    RewriterState *rs =3D FILTER_COLO_REWRITER(nf);
>> +
>> +    switch (event) {
>> +    case COLO_EVENT_CHECKPOINT:
>> +        g_hash_table_foreach(rs->connection_track_table,
>> +                            reset_seq_offset, NULL);
>> +        break;
>> +    case COLO_EVENT_FAILOVER:
>> +        if (!g_hash_table_find(rs->connection_track_table,
>> +                              offset_is_nonzero, NULL)) {
>> +            object_property_set_str(OBJECT(nf), "off", "status", errp);
>> +        }
>>
>
> I may miss something but I think rewriter should not be turned off even
> after failover?
>
>
Yes, after failover, rewriter should maintain the connection that created
before failover and turned off for other connections.
I will fix it in next version.
Very thanks your comments Jason~~~


Thanks
Zhang Chen




> Thanks
>
>
> +        break;
>> +    default:
>> +        break;
>> +    }
>> +}
>> +
>>   static void colo_rewriter_cleanup(NetFilterState *nf)
>>   {
>>       RewriterState *s =3D FILTER_COLO_REWRITER(nf);
>> @@ -332,6 +371,7 @@ static void colo_rewriter_class_init(ObjectClass
>> *oc, void *data)
>>       nfc->setup =3D colo_rewriter_setup;
>>       nfc->cleanup =3D colo_rewriter_cleanup;
>>       nfc->receive_iov =3D colo_rewriter_receive_iov;
>> +    nfc->handle_event =3D colo_rewriter_handle_event;
>>   }
>>     static const TypeInfo colo_rewriter_info =3D {
>>
>
>
