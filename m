Received: from eggs.gnu.org ([2001:4830:134:3::10]:43997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d2z5c-0007C2-1p
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d2z5Y-00013C-LS
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:57:04 -0400
Received: from [59.151.112.132] (port=9571 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d2z5X-00011C-MX
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:57:00 -0400
References: <1492662763-13852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<58F85316.3010509@huawei.com>
	<3ae2ae80-3388-9fb5-7f63-84f44ac7391b@cn.fujitsu.com>
	<f92f0e5a-e25b-9a2e-af56-5ddf2ed11527@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <6ed64be7-1d7f-f7a9-9039-11340494da09@cn.fujitsu.com>
Date: Tue, 25 Apr 2017 19:57:27 +0800
MIME-Version: 1.0
In-Reply-To: <f92f0e5a-e25b-9a2e-af56-5ddf2ed11527@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Jason Wang <jasowang@redhat.com>, Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com



On 04/20/2017 02:40 PM, Jason Wang wrote:
>
>
> On 2017年04月20日 14:36, Zhang Chen wrote:
>>
>>
>> On 04/20/2017 02:20 PM, Hailiang Zhang wrote:
>>> On 2017/4/20 12:32, Zhang Chen wrote:
>>>> When network traffic heavy, compare_pri_rs_finalize() and
>>>> compare_sec_rs_finalize() have a chance to confilct.
>>>> Both of them call colo_compare_connection() to compare packet,
>>>> But during compare_pri_rs_finalize() comparison, have secondary
>>>> packet come and call compare_sec_rs_finalize(), that packet will be
>>>> handle twice. If packet same, the pkt will be double free.
>>>
>>> Interesting, if I'm right, this should not happen, because, all the 
>>> comparing works
>>> are done in colo compare thread, so there is no chance to access the 
>>> connect_list
>>> concurrently.  Besides, even both of the packets from primary and 
>>> secondary arrive
>>> at the same time, it should only be handle once, we will handle it 
>>> with the later arrived one,
>>> No ?
>>
>> No, In my test often trigger this bug, you can use udp server and 
>> client test it.
>>
>> 13517@1492648526.850246:colo_compare_main : packet same and release 
>> packet
>> 13517@1492648526.850304:colo_compare_main : packet same and release 
>> packet
>> *** glibc detected *** 
>> /home/zhangchen/qemu-colo-apr14/x86_64-softmmu/qemu-system-x86_64: 
>> double free or corruption (out): 0x0000555556a75210 ***
>> ======= Backtrace: =========
>> /lib64/libc.so.6(+0x76628)[0x7ffff53d6628]
>> /lib64/libc.so.6(cfree+0x6c)[0x7ffff53db5cc]
>>
>>
>> Thanks
>> Zhang Chen
>
> I agree that you should check whether or not they are running in the 
> same thread.



I found they are not running in the same thread, and I have reviewed 
relative code but don't find out
why we do same job to pri_chr_in and sec_chr_in then they running in 
different thread.
Anyone can tell me the reason?

Log:

Breakpoint 5, compare_pri_chr_in (opaque=0x7ffff7fd1010, 
buf=0x7ffff3eb0950 "", size=8)
     at net/colo-compare.c:591
591    {
(gdb) info thread
   Id   Target Id         Frame
   18   Thread 0x7fff70bff700 (LWP 27864) "qemu-system-x86" 
0x00007ffff56e4ae7 in sem_timedwait ()
    from /lib64/libpthread.so.0
   9    Thread 0x7fff6f1ff700 (LWP 27748) "qemu-system-x86" 
0x00007ffff56e4a00 in sem_wait ()
    from /lib64/libpthread.so.0
   7    Thread 0x7fff701ff700 (LWP 27746) "qemu-system-x86" 
0x00007ffff56e261c in pthread_cond_wait@@GLIBC_2.3.2 () from 
/lib64/libpthread.so.0
   5    Thread 0x7ffff2dbf700 (LWP 27743) "qemu-system-x86" 
0x00007ffff54320a7 in ioctl ()
    from /lib64/libc.so.6
   4    Thread 0x7ffff35c0700 (LWP 27742) "qemu-system-x86" 
0x00007ffff56e5dbd in sendmsg ()
    from /lib64/libpthread.so.0
* 3    Thread 0x7ffff3eb2700 (LWP 27741) "qemu-system-x86" 
compare_pri_chr_in (opaque=0x7ffff7fd1010,
     buf=0x7ffff3eb0950 "", size=8) at net/colo-compare.c:591
   2    Thread 0x7ffff46b3700 (LWP 27729) "qemu-system-x86" 
0x00007ffff5436789 in syscall ()
    from /lib64/libc.so.6
   1    Thread 0x7ffff7fb7a80 (LWP 27725) "qemu-system-x86" 
0x00007ffff56e5294 in __lll_lock_wait ()
    from /lib64/libpthread.so.0
(gdb)  bt
#0  compare_pri_chr_in (opaque=0x7ffff7fd1010, buf=0x7ffff3eb0950 "", 
size=8) at net/colo-compare.c:591
#1  0x0000555555c60fba in qemu_chr_be_write_impl (s=0x55555684a630, 
buf=0x7ffff3eb0950 "", len=8)
     at chardev/char.c:284
#2  0x0000555555c6102f in qemu_chr_be_write (s=0x55555684a630, 
buf=0x7ffff3eb0950 "", len=8)
     at chardev/char.c:296
#3  0x0000555555c6a056 in tcp_chr_read (chan=0x55555684aa30, 
cond=G_IO_IN, opaque=0x55555684a630)
     at chardev/char-socket.c:414
#4  0x0000555555c83dbc in qio_channel_fd_source_dispatch 
(source=0x5555568d8b80, callback=
     0x555555c69ebf <tcp_chr_read>, user_data=0x55555684a630) at 
io/channel-watch.c:84
#5  0x00007ffff60c460a in g_main_context_dispatch () from 
/usr/lib64/libglib-2.0.so.0
#6  0x00007ffff60c7e88 in ?? () from /usr/lib64/libglib-2.0.so.0
#7  0x00007ffff60c835d in g_main_loop_run () from 
/usr/lib64/libglib-2.0.so.0
#8  0x0000555555b82e22 in colo_compare_thread (opaque=0x7ffff7fd1010) at 
net/colo-compare.c:703
#9  0x00007ffff56de7b6 in start_thread () from /lib64/libpthread.so.0
#10 0x00007ffff5439d6d in clone () from /lib64/libc.so.6
#11 0x0000000000000000 in ?? ()
(gdb) c
Continuing.
[Switching to Thread 0x7ffff7fb7a80 (LWP 27725)]

Breakpoint 6, compare_sec_chr_in (opaque=0x7ffff7fd1010, 
buf=0x7fffffffc590 "", size=1088)
     at net/colo-compare.c:608
608    {
(gdb) info thread
   Id   Target Id         Frame
   18   Thread 0x7fff70bff700 (LWP 27864) "qemu-system-x86" (Exiting) 
0x00007ffff56de9b3 in start_thread
     () from /lib64/libpthread.so.0
   9    Thread 0x7fff6f1ff700 (LWP 27748) "qemu-system-x86" 
0x00007ffff56e4a00 in sem_wait ()
    from /lib64/libpthread.so.0
   7    Thread 0x7fff701ff700 (LWP 27746) "qemu-system-x86" 
0x00007ffff56e261c in pthread_cond_wait@@GLIBC_2.3.2 () from 
/lib64/libpthread.so.0
   5    Thread 0x7ffff2dbf700 (LWP 27743) "qemu-system-x86" 
0x00007ffff54320a7 in ioctl ()
    from /lib64/libc.so.6
   4    Thread 0x7ffff35c0700 (LWP 27742) "qemu-system-x86" 
0x00007ffff54320a7 in ioctl ()
    from /lib64/libc.so.6
   3    Thread 0x7ffff3eb2700 (LWP 27741) "qemu-system-x86" 
0x0000555555b82985 in compare_pri_chr_in (
     opaque=0x7ffff7fd1010, buf=0x7ffff3eb0950 "", size=8) at 
net/colo-compare.c:591
   2    Thread 0x7ffff46b3700 (LWP 27729) "qemu-system-x86" 
0x00007ffff5436789 in syscall ()
    from /lib64/libc.so.6
* 1    Thread 0x7ffff7fb7a80 (LWP 27725) "qemu-system-x86" 
compare_sec_chr_in (opaque=0x7ffff7fd1010,
     buf=0x7fffffffc590 "", size=1088) at net/colo-compare.c:608
(gdb) bt
#0  compare_sec_chr_in (opaque=0x7ffff7fd1010, buf=0x7fffffffc590 "", 
size=1088)
     at net/colo-compare.c:608
#1  0x0000555555c60fba in qemu_chr_be_write_impl (s=0x555556849880, 
buf=0x7fffffffc590 "", len=1088)
     at chardev/char.c:284
#2  0x0000555555c6102f in qemu_chr_be_write (s=0x555556849880, 
buf=0x7fffffffc590 "", len=1088)
     at chardev/char.c:296
#3  0x0000555555c6a056 in tcp_chr_read (chan=0x555556912600, 
cond=G_IO_IN, opaque=0x555556849880)
     at chardev/char-socket.c:414
#4  0x0000555555c83dbc in qio_channel_fd_source_dispatch 
(source=0x555556849e70, callback=
     0x555555c69ebf <tcp_chr_read>, user_data=0x555556849880) at 
io/channel-watch.c:84
#5  0x00007ffff60c460a in g_main_context_dispatch () from 
/usr/lib64/libglib-2.0.so.0
#6  0x0000555555cd63bc in glib_pollfds_poll () at util/main-loop.c:213
#7  0x0000555555cd64d2 in os_host_main_loop_wait (timeout=339699370) at 
util/main-loop.c:261
#8  0x0000555555cd65c1 in main_loop_wait (nonblocking=0) at 
util/main-loop.c:517
#9  0x0000555555958990 in main_loop () at vl.c:1911
#10 0x000055555596051c in main (argc=47, argv=0x7fffffffdb88, envp=0x


>
> Thanks
>
>>
>>>
>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>> ---
>>>>   net/colo-compare.c | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>>> index 54e6d40..686c1b4 100644
>>>> --- a/net/colo-compare.c
>>>> +++ b/net/colo-compare.c
>>>> @@ -79,6 +79,8 @@ typedef struct CompareState {
>>>>        * element type: Connection
>>>>        */
>>>>       GQueue conn_list;
>>>> +    /* compare lock */
>>>> +    QemuMutex compare_lock;
>>>>       /* hashtable to save connection */
>>>>       GHashTable *connection_track_table;
>>>>       /* compare thread, a thread for each NIC */
>>>> @@ -619,7 +621,9 @@ static void 
>>>> compare_pri_rs_finalize(SocketReadState *pri_rs)
>>>>           compare_chr_send(&s->chr_out, pri_rs->buf, 
>>>> pri_rs->packet_len);
>>>>       } else {
>>>>           /* compare connection */
>>>> +        qemu_mutex_lock(&s->compare_lock);
>>>>           g_queue_foreach(&s->conn_list, colo_compare_connection, s);
>>>> +        qemu_mutex_unlock(&s->compare_lock);
>>>>       }
>>>>   }
>>>>   @@ -631,7 +635,9 @@ static void 
>>>> compare_sec_rs_finalize(SocketReadState *sec_rs)
>>>>           trace_colo_compare_main("secondary: unsupported packet in");
>>>>       } else {
>>>>           /* compare connection */
>>>> +        qemu_mutex_lock(&s->compare_lock);
>>>>           g_queue_foreach(&s->conn_list, colo_compare_connection, s);
>>>> +        qemu_mutex_unlock(&s->compare_lock);
>>>>       }
>>>>   }
>>>>   @@ -702,6 +708,7 @@ static void 
>>>> colo_compare_complete(UserCreatable *uc, Error **errp)
>>>>       net_socket_rs_init(&s->sec_rs, compare_sec_rs_finalize);
>>>>         g_queue_init(&s->conn_list);
>>>> +    qemu_mutex_init(&s->compare_lock);
>>>>         s->connection_track_table = 
>>>> g_hash_table_new_full(connection_key_hash,
>>>> connection_key_equal,
>>>> @@ -771,6 +778,7 @@ static void colo_compare_finalize(Object *obj)
>>>>       g_queue_foreach(&s->conn_list, colo_flush_packets, s);
>>>>         g_queue_clear(&s->conn_list);
>>>> +    qemu_mutex_destroy(&s->compare_lock);
>>>>         g_hash_table_destroy(s->connection_track_table);
>>>>       g_free(s->pri_indev);
>>>
>>>
>>>
>>>
>>> .
>>>
>>
>
>
>
> .
>

-- 
Thanks
Zhang Chen
