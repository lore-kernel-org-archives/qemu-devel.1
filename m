Received: from eggs.gnu.org ([2001:4830:134:3::10]:40346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2X9M-0006dm-I0
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2X9J-0002W1-CY
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:07:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3472
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2X9I-0002Ve-Pn
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 02:07:01 -0400
References: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492674416-9408-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<fc7ef530-72c1-8d81-bb56-8a15d6ae1b66@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58FD95ED.9040604@huawei.com>
Date: Mon, 24 Apr 2017 14:06:37 +0800
MIME-Version: 1.0
In-Reply-To: <fc7ef530-72c1-8d81-bb56-8a15d6ae1b66@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] colo-compare: Check main_loop value
 before call g_main_loop_quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, zhangchen.fnst@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, weidong.huang@huawei.com

On 2017/4/24 12:13, Jason Wang wrote:
>
> On 2017年04月20日 15:46, zhanghailiang wrote:
>> If some errors happen before main_loop is initialized in colo
>> compare thread, qemu will go into finalizing process where
>> we call g_main_loop_quit(s->main_loop), if main_loop is NULL, there
>> will be an error report:
>> "(process:14861): GLib-CRITICAL **: g_main_loop_quit: assertion 'loop != NULL' failed".
>>
>> We need to check if main_loop is NULL or not before call g_main_loop_quit().
> Do we need check and fail early in colo_compare_thread() too?

Yes, we need to check there too, will add the check in next version, thanks.

> Thanks
>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> ---
>>    net/colo-compare.c | 4 +++-
>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index a6bf419..d6a5e4c 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -770,7 +770,9 @@ static void colo_compare_finalize(Object *obj)
>>                                 s->worker_context, true);
>>        qemu_chr_fe_deinit(&s->chr_out);
>>    
>> -    g_main_loop_quit(s->compare_loop);
>> +    if (s->compare_loop) {
>> +        g_main_loop_quit(s->compare_loop);
>> +    }
>>        qemu_thread_join(&s->thread);
>>    
>>        /* Release all unhandled packets after compare thead exited */
>
> .
>
