Received: from eggs.gnu.org ([2001:4830:134:3::10]:44404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceBuT-0001Zb-F3
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceBuQ-0007gp-C4
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:35:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ceBuQ-0007fd-52
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:35:02 -0500
References: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487147657-166092-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<ce15349b-facb-aed4-4352-1c57890a7f68@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f182b22d-70b9-a48f-5e3c-3fc3ec0e369b@redhat.com>
Date: Thu, 16 Feb 2017 10:34:55 +0800
MIME-Version: 1.0
In-Reply-To: <ce15349b-facb-aed4-4352-1c57890a7f68@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] colo-compare: kick compare thread to
 exit while finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, lizhijian@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, pss.wulizhen@huawei.com



On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 10:25, Zhang Chen wrote:
>> @@ -703,13 +704,11 @@ static void colo_compare_finalize(Object *obj)
>>       qemu_chr_fe_deinit(&s->chr_sec_in);
>>       qemu_chr_fe_deinit(&s->chr_out);
>>   -    g_queue_free(&s->conn_list);
>> +    g_main_loop_quit(s->compare_loop);
>> +    qemu_thread_join(&s->thread);
>>   -    if (qemu_thread_is_self(&s->thread)) {
>> -        /* compare connection */
>> -        g_queue_foreach(&s->conn_list, colo_compare_connection, s);
>> -        qemu_thread_join(&s->thread);
>> -    }
>
> Before free the 's->conn_list', you should flush all queued primary=20
> packets
> and release all queued secondary packets here, so combine this patch=20
> with 3/5 patch as
> one patch is a better choose.
>
> Thanks
> Zhang Chen=20

Yes, agree.

Thanks
