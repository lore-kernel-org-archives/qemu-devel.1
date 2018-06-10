Received: from eggs.gnu.org ([2001:4830:134:3::10]:58932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS125-0006C5-0e
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 10:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS123-00079M-EE
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 10:09:24 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:42097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fS123-00078d-3S
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 10:09:23 -0400
Received: by mail-wr0-x232.google.com with SMTP id w10-v6so17693352wrk.9
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 07:09:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6ad93c95-8c14-6155-6f0f-6c2dcc46faa8@redhat.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-4-zhangckid@gmail.com>
	<6ad93c95-8c14-6155-6f0f-6c2dcc46faa8@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 10 Jun 2018 22:09:21 +0800
Message-ID: <CAK3tnv+y97x5bmaComkwSKNNnuF9KcghBcJs+EymMEnPpwkJcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V8 03/17] colo-compare: use notifier to
 notify packets comparing result
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

On Mon, Jun 4, 2018 at 2:36 PM, Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2018=E5=B9=B406=E6=9C=8803=E6=97=A5 13:05, Zhang Chen wrote:
>
>> It's a good idea to use notifier to notify COLO frame of
>> inconsistent packets comparing.
>>
>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> ---
>>   net/colo-compare.c | 32 +++++++++++++++++++++++++-------
>>   net/colo-compare.h |  2 ++
>>   2 files changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 7ff3ae8904..05061cd1c4 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -29,6 +29,7 @@
>>   #include "sysemu/iothread.h"
>>   #include "net/colo-compare.h"
>>   #include "migration/colo.h"
>> +#include "migration/migration.h"
>>     #define TYPE_COLO_COMPARE "colo-compare"
>>   #define COLO_COMPARE(obj) \
>> @@ -37,6 +38,9 @@
>>   static QTAILQ_HEAD(, CompareState) net_compares =3D
>>          QTAILQ_HEAD_INITIALIZER(net_compares);
>>   +static NotifierList colo_compare_notifiers =3D
>> +    NOTIFIER_LIST_INITIALIZER(colo_compare_notifiers);
>> +
>>   #define COMPARE_READ_LEN_MAX NET_BUFSIZE
>>   #define MAX_QUEUE_SIZE 1024
>>   @@ -561,8 +565,24 @@ static int colo_old_packet_check_one(Packet *pkt,
>> int64_t *check_time)
>>       }
>>   }
>>   +static void colo_compare_inconsistent_notify(void)
>> +{
>>
>
> Not good at English but inconsistency sounds better here.
>
>
Sorry, I'm not good at English too...
I will change to "inconsistency" in next version.

Thanks
Zhang Chen


> Thanks
>
>
> +    notifier_list_notify(&colo_compare_notifiers,
>> +                migrate_get_current());
>> +}
>> +
>> +void colo_compare_register_notifier(Notifier *notify)
>> +{
>> +    notifier_list_add(&colo_compare_notifiers, notify);
>> +}
>> +
>> +void colo_compare_unregister_notifier(Notifier *notify)
>> +{
>> +    notifier_remove(notify);
>> +}
>> +
>>   static int colo_old_packet_check_one_conn(Connection *conn,
>> -                                          void *user_data)
>> +                                           void *user_data)
>>   {
>>       GList *result =3D NULL;
>>       int64_t check_time =3D REGULAR_PACKET_CHECK_MS;
>> @@ -573,10 +593,7 @@ static int colo_old_packet_check_one_conn(Connectio=
n
>> *conn,
>>         if (result) {
>>           /* Do checkpoint will flush old packet */
>> -        /*
>> -         * TODO: Notify colo frame to do checkpoint.
>> -         * colo_compare_inconsistent_notify();
>> -         */
>> +        colo_compare_inconsistent_notify();
>>           return 0;
>>       }
>>   @@ -620,11 +637,12 @@ static void colo_compare_packet(CompareState *s,
>> Connection *conn,
>>               /*
>>                * If one packet arrive late, the secondary_list or
>>                * primary_list will be empty, so we can't compare it
>> -             * until next comparison.
>> +             * until next comparison. If the packets in the list are
>> +             * timeout, it will trigger a checkpoint request.
>>                */
>>               trace_colo_compare_main("packet different");
>>               g_queue_push_head(&conn->primary_list, pkt);
>> -            /* TODO: colo_notify_checkpoint();*/
>> +            colo_compare_inconsistent_notify();
>>               break;
>>           }
>>       }
>> diff --git a/net/colo-compare.h b/net/colo-compare.h
>> index 1b1ce76aea..22ddd512e2 100644
>> --- a/net/colo-compare.h
>> +++ b/net/colo-compare.h
>> @@ -18,5 +18,7 @@
>>   #define QEMU_COLO_COMPARE_H
>>     void colo_notify_compares_event(void *opaque, int event, Error
>> **errp);
>> +void colo_compare_register_notifier(Notifier *notify);
>> +void colo_compare_unregister_notifier(Notifier *notify);
>>     #endif /* QEMU_COLO_COMPARE_H */
>>
>
>
