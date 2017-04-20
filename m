Received: from eggs.gnu.org ([2001:4830:134:3::10]:39906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15h4-000323-Uu
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15h1-00044p-Hj
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:35:54 -0400
Received: from [59.151.112.132] (port=35471 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15h0-00042Z-Ir
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:35:51 -0400
References: <1492662763-13852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<58F85316.3010509@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <3ae2ae80-3388-9fb5-7f63-84f44ac7391b@cn.fujitsu.com>
Date: Thu, 20 Apr 2017 14:36:04 +0800
MIME-Version: 1.0
In-Reply-To: <58F85316.3010509@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] COLO-compare: Add compare_lock aviod
 comparison conflict
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com



On 04/20/2017 02:20 PM, Hailiang Zhang wrote:
> On 2017/4/20 12:32, Zhang Chen wrote:
>> When network traffic heavy, compare_pri_rs_finalize() and
>> compare_sec_rs_finalize() have a chance to confilct.
>> Both of them call colo_compare_connection() to compare packet,
>> But during compare_pri_rs_finalize() comparison, have secondary
>> packet come and call compare_sec_rs_finalize(), that packet will be
>> handle twice. If packet same, the pkt will be double free.
>
> Interesting, if I'm right, this should not happen, because, all the 
> comparing works
> are done in colo compare thread, so there is no chance to access the 
> connect_list
> concurrently.  Besides, even both of the packets from primary and 
> secondary arrive
> at the same time, it should only be handle once, we will handle it 
> with the later arrived one,
> No ?

No, In my test often trigger this bug, you can use udp server and client 
test it.

13517@1492648526.850246:colo_compare_main : packet same and release packet
13517@1492648526.850304:colo_compare_main : packet same and release packet
*** glibc detected *** 
/home/zhangchen/qemu-colo-apr14/x86_64-softmmu/qemu-system-x86_64: 
double free or corruption (out): 0x0000555556a75210 ***
======= Backtrace: =========
/lib64/libc.so.6(+0x76628)[0x7ffff53d6628]
/lib64/libc.so.6(cfree+0x6c)[0x7ffff53db5cc]


Thanks
Zhang Chen

>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/colo-compare.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 54e6d40..686c1b4 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -79,6 +79,8 @@ typedef struct CompareState {
>>        * element type: Connection
>>        */
>>       GQueue conn_list;
>> +    /* compare lock */
>> +    QemuMutex compare_lock;
>>       /* hashtable to save connection */
>>       GHashTable *connection_track_table;
>>       /* compare thread, a thread for each NIC */
>> @@ -619,7 +621,9 @@ static void 
>> compare_pri_rs_finalize(SocketReadState *pri_rs)
>>           compare_chr_send(&s->chr_out, pri_rs->buf, 
>> pri_rs->packet_len);
>>       } else {
>>           /* compare connection */
>> +        qemu_mutex_lock(&s->compare_lock);
>>           g_queue_foreach(&s->conn_list, colo_compare_connection, s);
>> +        qemu_mutex_unlock(&s->compare_lock);
>>       }
>>   }
>>   @@ -631,7 +635,9 @@ static void 
>> compare_sec_rs_finalize(SocketReadState *sec_rs)
>>           trace_colo_compare_main("secondary: unsupported packet in");
>>       } else {
>>           /* compare connection */
>> +        qemu_mutex_lock(&s->compare_lock);
>>           g_queue_foreach(&s->conn_list, colo_compare_connection, s);
>> +        qemu_mutex_unlock(&s->compare_lock);
>>       }
>>   }
>>   @@ -702,6 +708,7 @@ static void colo_compare_complete(UserCreatable 
>> *uc, Error **errp)
>>       net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize);
>>         g_queue_init(&s->conn_list);
>> +    qemu_mutex_init(&s->compare_lock);
>>         s->connection_track_table = 
>> g_hash_table_new_full(connection_key_hash,
>> connection_key_equal,
>> @@ -771,6 +778,7 @@ static void colo_compare_finalize(Object *obj)
>>       g_queue_foreach(&s->conn_list, colo_flush_packets, s);
>>         g_queue_clear(&s->conn_list);
>> +    qemu_mutex_destroy(&s->compare_lock);
>>         g_hash_table_destroy(s->connection_track_table);
>>       g_free(s->pri_indev);
>
>
>
>
> .
>

-- 
Thanks
Zhang Chen
