Received: from eggs.gnu.org ([2001:4830:134:3::10]:38048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cafDg-0002Ph-AN
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cafDb-0008UF-JO
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:04:20 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:4891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cafDa-0008P6-OX
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:04:15 -0500
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485266748-15340-4-git-send-email-zhang.zhanghailiang@huawei.com>
	<db92d401-b0aa-b78a-d7c9-8fa47b9fe876@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <5898375C.1080408@huawei.com>
Date: Mon, 6 Feb 2017 16:44:12 +0800
MIME-Version: 1.0
In-Reply-To: <db92d401-b0aa-b78a-d7c9-8fa47b9fe876@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] colo-compare: use notifier to notify
 inconsistent packets comparing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: xuquan8@huawei.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com

On 2017/2/3 12:50, Jason Wang wrote:
>
>
> On 2017年01月24日 22:05, zhanghailiang wrote:
>> It's a good idea to use notifier to notify COLO frame of
>> inconsistent packets comparing.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> ---
>>    net/colo-compare.c | 24 ++++++++++++++++++++++--
>>    net/colo-compare.h |  2 ++
>>    2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 2ad577b..39c394d 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -30,6 +30,7 @@
>>    #include "qapi-visit.h"
>>    #include "net/colo.h"
>>    #include "net/colo-compare.h"
>> +#include "migration/migration.h"
>>
>>    #define TYPE_COLO_COMPARE "colo-compare"
>>    #define COLO_COMPARE(obj) \
>> @@ -38,6 +39,9 @@
>>    static QTAILQ_HEAD(, CompareState) net_compares =
>>           QTAILQ_HEAD_INITIALIZER(net_compares);
>>
>> +static NotifierList colo_compare_notifiers =
>> +    NOTIFIER_LIST_INITIALIZER(colo_compare_notifiers);
>> +
>>    #define COMPARE_READ_LEN_MAX NET_BUFSIZE
>>    #define MAX_QUEUE_SIZE 1024
>>
>> @@ -378,6 +382,22 @@ static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
>>        }
>>    }
>>
>> +static void colo_compare_inconsistent_notify(void)
>> +{
>> +    notifier_list_notify(&colo_compare_notifiers,
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
>>    static void colo_old_packet_check_one_conn(void *opaque,
>>                                               void *user_data)
>>    {
>> @@ -392,7 +412,7 @@ static void colo_old_packet_check_one_conn(void *opaque,
>>        qemu_mutex_unlock(&conn->conn_lock);
>>        if (result) {
>>            /* do checkpoint will flush old packet */
>> -        /* TODO: colo_notify_checkpoint();*/
>> +        colo_compare_inconsistent_notify();
>>        }
>>    }
>>
>> @@ -466,7 +486,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
>>                 */
>>                trace_colo_compare_main("packet different");
>>                g_queue_push_tail(&conn->primary_list, pkt);
>> -            /* TODO: colo_notify_checkpoint();*/
>> +            colo_compare_inconsistent_notify();
>>                break;
>>            }
>>        }
>
> I don't see any users for
> colo_compare_register_notifier/colo_compare_unregister_notifier, is any
> patch missed in this series?
>

No, we will use these functions in later series which integrate COLO compare
with COLO frame.
So, should i move this patch to the series where it is been called ?
patch 2 has the same problem.

> And is it safe to do notification in colo thread?
>

Yes, the notification callback will be quite simple.

Thanks,
hailiang


> Thanks
>
>> diff --git a/net/colo-compare.h b/net/colo-compare.h
>> index 44f9014..769f55a 100644
>> --- a/net/colo-compare.h
>> +++ b/net/colo-compare.h
>> @@ -16,5 +16,7 @@
>>    #define QEMU_COLO_COMPARE_H
>>
>>    void colo_compare_do_checkpoint(void);
>> +void colo_compare_register_notifier(Notifier *notify);
>> +void colo_compare_unregister_notifier(Notifier *notify);
>>
>>    #endif /* QEMU_COLO_COMPARE_H */
>
>
> .
>
