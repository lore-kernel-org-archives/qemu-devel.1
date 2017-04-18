Received: from eggs.gnu.org ([2001:4830:134:3::10]:33598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d0I09-0004SJ-DV
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d0I06-00030j-99
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:32:17 -0400
Received: from [59.151.112.132] (port=11141 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d0I05-0002y0-Bt
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 21:32:14 -0400
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<134776c2-a85d-d06f-5f98-2e664f9c8ca9@cn.fujitsu.com>
	<d33b0150-5ed2-56cc-9261-da7deb1d0bfb@redhat.com>
	<58F06AA1.2010301@huawei.com>
	<9b42232a-e86f-2d61-7987-7a0559d6f705@redhat.com>
	<58F4A12C.5070404@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <03b8406c-77ce-7517-f8db-ddf31cbb686e@cn.fujitsu.com>
Date: Tue, 18 Apr 2017 09:32:17 +0800
MIME-Version: 1.0
In-Reply-To: <58F4A12C.5070404@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/15] colo-compare: implement the process
 of checkpoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, dgilbert@redhat.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com



On 04/17/2017 07:04 PM, Hailiang Zhang wrote:
> Hi Jason,
>
> On 2017/4/14 14:38, Jason Wang wrote:
>>
>> On 2017年04月14日 14:22, Hailiang Zhang wrote:
>>> Hi Jason,
>>>
>>> On 2017/4/14 13:57, Jason Wang wrote:
>>>> On 2017年02月22日 17:31, Zhang Chen wrote:
>>>>> On 02/22/2017 11:42 AM, zhanghailiang wrote:
>>>>>> While do checkpoint, we need to flush all the unhandled packets,
>>>>>> By using the filter notifier mechanism, we can easily to notify
>>>>>> every compare object to do this process, which runs inside
>>>>>> of compare threads as a coroutine.
>>>>> Hi~ Jason and Hailiang.
>>>>>
>>>>> I will send a patch set later about colo-compare notify mechanism for
>>>>> Xen like this patch.
>>>>> I want to add a new chardev socket way in colo-comapre connect to Xen
>>>>> colo, for notify
>>>>> checkpoint or failover, Because We have no choice to use this way
>>>>> communicate with Xen codes.
>>>>> That's means we will have two notify mechanism.
>>>>> What do you think about this?
>>>>>
>>>>>
>>>>> Thanks
>>>>> Zhang Chen
>>>> I was thinking the possibility of using similar way to for colo 
>>>> compare.
>>>> E.g can we use socket? This can saves duplicated codes more or less.
>>> Since there are too many sockets used by filter and COLO, (Two unix
>>> sockets and two
>>>   tcp sockets for each vNIC), I don't want to introduce more ;) , but
>>> i'm not sure if it is
>>> possible to make it more flexible and optional, abstract these
>>> duplicated codes,
>>> pass the opened fd (No matter eventfd or socket fd ) as parameter, for
>>> example.
>>> Is this way acceptable ?
>>>
>>> Thanks,
>>> Hailiang
>> Yes, that's kind of what I want. We don't want to use two message
>> format. Passing a opened fd need management support, we still need a
>> fallback if there's no management on top. For qemu/kvm, we can do all
>> stuffs transparent to the cli by e.g socketpair() or others, but the key
>> is to have a unified message format.
>
> After a deeper investigation, i think we can re-use most codes, since 
> there is no
> existing way to notify xen (no ?), we still needs notify chardev 
> socket (Be used to notify xen, it is optional.)
> (http://patchwork.ozlabs.org/patch/733431/ "COLO-compare: Add Xen 
> notify chardev socket handler frame")
>
> Besides, there is an existing qmp comand 'xen-colo-do-checkpoint', we 
> can re-use it to notify
> colo-compare objects and other filter objects to do checkpoint, for 
> the opposite direction, we use
> the notify chardev socket (Only for xen).
>
> So the codes will be like:
> diff --git a/migration/colo.c b/migration/colo.c
> index 91da936..813c281 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -224,7 +224,19 @@ ReplicationStatus 
> *qmp_query_xen_replication_status(Error **errp)
>
>  void qmp_xen_colo_do_checkpoint(Error **errp)
>  {
> +    Error *local_err = NULL;
> +
>      replication_do_checkpoint_all(errp);
> +    /* Notify colo-compare and other filters to do checkpoint */
> +    colo_notify_compares_event(NULL, COLO_CHECKPOINT, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    colo_notify_filters_event(COLO_CHECKPOINT, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
>  }
>
>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 24e13f0..de975c5 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -391,6 +391,9 @@ static void colo_compare_inconsistent_notify(void)
>  {
>      notifier_list_notify(&colo_compare_notifiers,
>                  migrate_get_current());
> +    if (s->notify_dev) {
> +       /* Do something, notify remote side through notify dev */
> +    }
>  }
>
>  void colo_compare_register_notifier(Notifier *notify)
>
> How about this scenario ？

I agree this way, maybe rename qmp_xen_colo_do_checkpoint()
to qmp_remote_colo_do_checkpoint() is more generic.

Thanks
Zhang Chen

>
>> Thoughts?
>>
>> Thanks
>>
>>>> Thanks
>>>>
>>>>
>>>> .
>>>>
>>>
>>
>> .
>>
>
>
>
>
> .
>

-- 
Thanks
Zhang Chen
