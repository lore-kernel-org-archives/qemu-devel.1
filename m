Received: from eggs.gnu.org ([2001:4830:134:3::10]:59013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS12N-0006OD-2A
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 10:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS12L-0007Ud-Ek
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 10:09:43 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:45399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fS12L-0007TE-3s
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 10:09:41 -0400
Received: by mail-wr0-x231.google.com with SMTP id o12-v6so17685403wrm.12
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 07:09:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <96b6dd17-bbb6-48e9-54c8-6495c8a56c98@redhat.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-15-zhangckid@gmail.com>
	<96b6dd17-bbb6-48e9-54c8-6495c8a56c98@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 10 Jun 2018 22:09:39 +0800
Message-ID: <CAK3tnv+GkZGVEGeswayaO0esSCWonwwgm30FL3QriOSDscsuvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V8 14/17] filter: Add handle_event method
 for NetFilterClass
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

On Mon, Jun 4, 2018 at 2:57 PM, Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2018=E5=B9=B406=E6=9C=8803=E6=97=A5 13:05, Zhang Chen wrote:
>
>> Filter needs to process the event of checkpoint/failover or
>> other event passed by COLO frame.
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> ---
>>   include/net/filter.h |  5 +++++
>>   net/filter.c         | 17 +++++++++++++++++
>>   net/net.c            | 28 ++++++++++++++++++++++++++++
>>   3 files changed, 50 insertions(+)
>>
>> diff --git a/include/net/filter.h b/include/net/filter.h
>> index 435acd6f82..49da666ac0 100644
>> --- a/include/net/filter.h
>> +++ b/include/net/filter.h
>> @@ -38,6 +38,8 @@ typedef ssize_t (FilterReceiveIOV)(NetFilterState *nc,
>>     typedef void (FilterStatusChanged) (NetFilterState *nf, Error **errp=
);
>>   +typedef void (FilterHandleEvent) (NetFilterState *nf, int event, Erro=
r
>> **errp);
>> +
>>   typedef struct NetFilterClass {
>>       ObjectClass parent_class;
>>   @@ -45,6 +47,7 @@ typedef struct NetFilterClass {
>>       FilterSetup *setup;
>>       FilterCleanup *cleanup;
>>       FilterStatusChanged *status_changed;
>> +    FilterHandleEvent *handle_event;
>>       /* mandatory */
>>       FilterReceiveIOV *receive_iov;
>>   } NetFilterClass;
>> @@ -77,4 +80,6 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState
>> *sender,
>>                                       int iovcnt,
>>                                       void *opaque);
>>   +void colo_notify_filters_event(int event, Error **errp);
>> +
>>   #endif /* QEMU_NET_FILTER_H */
>> diff --git a/net/filter.c b/net/filter.c
>> index 2fd7d7d663..0f17eba143 100644
>> --- a/net/filter.c
>> +++ b/net/filter.c
>> @@ -17,6 +17,8 @@
>>   #include "net/vhost_net.h"
>>   #include "qom/object_interfaces.h"
>>   #include "qemu/iov.h"
>> +#include "net/colo.h"
>> +#include "migration/colo.h"
>>     static inline bool qemu_can_skip_netfilter(NetFilterState *nf)
>>   {
>> @@ -245,11 +247,26 @@ static void netfilter_finalize(Object *obj)
>>       g_free(nf->netdev_id);
>>   }
>>   +static void dummy_handle_event(NetFilterState *nf, int event, Error
>> **errp)
>> +{
>> +    switch (event) {
>> +    case COLO_EVENT_CHECKPOINT:
>> +        break;
>> +    case COLO_EVENT_FAILOVER:
>> +        object_property_set_str(OBJECT(nf), "off", "status", errp);
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +}
>> +
>>   static void netfilter_class_init(ObjectClass *oc, void *data)
>>   {
>>       UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
>> +    NetFilterClass *nfc =3D NETFILTER_CLASS(oc);
>>         ucc->complete =3D netfilter_complete;
>> +    nfc->handle_event =3D dummy_handle_event;
>>   }
>>     static const TypeInfo netfilter_info =3D {
>> diff --git a/net/net.c b/net/net.c
>> index efb9eaf779..378cd2f9ec 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -1329,6 +1329,34 @@ void hmp_info_network(Monitor *mon, const QDict
>> *qdict)
>>       }
>>   }
>>   +void colo_notify_filters_event(int event, Error **errp)
>> +{
>> +    NetClientState *nc, *peer;
>> +    NetClientDriver type;
>> +    NetFilterState *nf;
>> +    NetFilterClass *nfc =3D NULL;
>> +    Error *local_err =3D NULL;
>> +
>> +    QTAILQ_FOREACH(nc, &net_clients, next) {
>> +        peer =3D nc->peer;
>> +        type =3D nc->info->type;
>> +        if (!peer || type !=3D NET_CLIENT_DRIVER_TAP) {
>> +            continue;
>>
>
> I think when COLO is enabled, qemu should reject all other types of
> backends.


Yes, you are right.
May be we should add a assert here? Because we can not get backend info whe=
n
colo-compare start up.
Have any idea?


>
>
> +        }
>> +        QTAILQ_FOREACH(nf, &nc->filters, next) {
>> +            nfc =3D  NETFILTER_GET_CLASS(OBJECT(nf));
>> +            if (!nfc->handle_event) {
>> +                continue;
>> +            }
>>
>
> Is this still necessary?
>
>
Yes, may be user will use other filter(like filter-buffer) with COLO at
same time.

Thanks
Zhang Chen



> Thanks
>
>
> +            nfc->handle_event(nf, event, &local_err);
>> +            if (local_err) {
>> +                error_propagate(errp, local_err);
>> +                return;
>> +            }
>> +        }
>> +    }
>> +}
>> +
>>   void qmp_set_link(const char *name, bool up, Error **errp)
>>   {
>>       NetClientState *ncs[MAX_QUEUE_NUM];
>>
>
>
