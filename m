Received: from eggs.gnu.org ([2001:4830:134:3::10]:44168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cafiT-0001Bq-CL
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cafiP-0001o0-7X
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:36:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cafiO-0001nn-Vp
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:36:05 -0500
References: <1485266748-15340-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1485266748-15340-4-git-send-email-zhang.zhanghailiang@huawei.com>
	<db92d401-b0aa-b78a-d7c9-8fa47b9fe876@redhat.com>
	<5898375C.1080408@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0c417626-194c-83ee-fc37-0d36e4eb5c82@redhat.com>
Date: Mon, 6 Feb 2017 17:35:58 +0800
MIME-Version: 1.0
In-Reply-To: <5898375C.1080408@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org
Cc: xuquan8@huawei.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com



On 2017=E5=B9=B402=E6=9C=8806=E6=97=A5 16:44, Hailiang Zhang wrote:
> On 2017/2/3 12:50, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B401=E6=9C=8824=E6=97=A5 22:05, zhanghailiang wrote:
>>> It's a good idea to use notifier to notify COLO frame of
>>> inconsistent packets comparing.
>>>
>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>> ---
>>>    net/colo-compare.c | 24 ++++++++++++++++++++++--
>>>    net/colo-compare.h |  2 ++
>>>    2 files changed, 24 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>> index 2ad577b..39c394d 100644
>>> --- a/net/colo-compare.c
>>> +++ b/net/colo-compare.c
>>> @@ -30,6 +30,7 @@
>>>    #include "qapi-visit.h"
>>>    #include "net/colo.h"
>>>    #include "net/colo-compare.h"
>>> +#include "migration/migration.h"
>>>
>>>    #define TYPE_COLO_COMPARE "colo-compare"
>>>    #define COLO_COMPARE(obj) \
>>> @@ -38,6 +39,9 @@
>>>    static QTAILQ_HEAD(, CompareState) net_compares =3D
>>>           QTAILQ_HEAD_INITIALIZER(net_compares);
>>>
>>> +static NotifierList colo_compare_notifiers =3D
>>> +    NOTIFIER_LIST_INITIALIZER(colo_compare_notifiers);
>>> +
>>>    #define COMPARE_READ_LEN_MAX NET_BUFSIZE
>>>    #define MAX_QUEUE_SIZE 1024
>>>
>>> @@ -378,6 +382,22 @@ static int colo_old_packet_check_one(Packet=20
>>> *pkt, int64_t *check_time)
>>>        }
>>>    }
>>>
>>> +static void colo_compare_inconsistent_notify(void)
>>> +{
>>> +    notifier_list_notify(&colo_compare_notifiers,
>>> +                migrate_get_current());
>>> +}
>>> +
>>> +void colo_compare_register_notifier(Notifier *notify)
>>> +{
>>> +    notifier_list_add(&colo_compare_notifiers, notify);
>>> +}
>>> +
>>> +void colo_compare_unregister_notifier(Notifier *notify)
>>> +{
>>> +    notifier_remove(notify);
>>> +}
>>> +
>>>    static void colo_old_packet_check_one_conn(void *opaque,
>>>                                               void *user_data)
>>>    {
>>> @@ -392,7 +412,7 @@ static void colo_old_packet_check_one_conn(void=20
>>> *opaque,
>>>        qemu_mutex_unlock(&conn->conn_lock);
>>>        if (result) {
>>>            /* do checkpoint will flush old packet */
>>> -        /* TODO: colo_notify_checkpoint();*/
>>> +        colo_compare_inconsistent_notify();
>>>        }
>>>    }
>>>
>>> @@ -466,7 +486,7 @@ static void colo_compare_connection(void=20
>>> *opaque, void *user_data)
>>>                 */
>>>                trace_colo_compare_main("packet different");
>>>                g_queue_push_tail(&conn->primary_list, pkt);
>>> -            /* TODO: colo_notify_checkpoint();*/
>>> +            colo_compare_inconsistent_notify();
>>>                break;
>>>            }
>>>        }
>>
>> I don't see any users for
>> colo_compare_register_notifier/colo_compare_unregister_notifier, is an=
y
>> patch missed in this series?
>>
>
> No, we will use these functions in later series which integrate COLO=20
> compare
> with COLO frame.
> So, should i move this patch to the series where it is been called ?
> patch 2 has the same problem.=20

Yes, please.

Thanks
