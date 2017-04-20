Received: from eggs.gnu.org ([2001:4830:134:3::10]:55590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d14Rb-0006e0-2K
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d14RW-00035c-4u
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d14RV-00035V-SK
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:15:46 -0400
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<134776c2-a85d-d06f-5f98-2e664f9c8ca9@cn.fujitsu.com>
	<d33b0150-5ed2-56cc-9261-da7deb1d0bfb@redhat.com>
	<58F06AA1.2010301@huawei.com>
	<9b42232a-e86f-2d61-7987-7a0559d6f705@redhat.com>
	<58F4A12C.5070404@huawei.com>
	<f7f4639d-7a08-5120-27f8-346011dc754f@redhat.com>
	<58F5B902.8030105@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c92f4670-5ecc-c048-b017-d78966a89514@redhat.com>
Date: Thu, 20 Apr 2017 13:15:34 +0800
MIME-Version: 1.0
In-Reply-To: <58F5B902.8030105@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: xuquan8@huawei.com, xiecl.fnst@cn.fujitsu.com, dgilbert@redhat.com, lizhijian@cn.fujitsu.com



On 2017=E5=B9=B404=E6=9C=8818=E6=97=A5 14:58, Hailiang Zhang wrote:
> On 2017/4/18 11:55, Jason Wang wrote:
>>
>> On 2017=E5=B9=B404=E6=9C=8817=E6=97=A5 19:04, Hailiang Zhang wrote:
>>> Hi Jason,
>>>
>>> On 2017/4/14 14:38, Jason Wang wrote:
>>>> On 2017=E5=B9=B404=E6=9C=8814=E6=97=A5 14:22, Hailiang Zhang wrote:
>>>>> Hi Jason,
>>>>>
>>>>> On 2017/4/14 13:57, Jason Wang wrote:
>>>>>> On 2017=E5=B9=B402=E6=9C=8822=E6=97=A5 17:31, Zhang Chen wrote:
>>>>>>> On 02/22/2017 11:42 AM, zhanghailiang wrote:
>>>>>>>> While do checkpoint, we need to flush all the unhandled packets,
>>>>>>>> By using the filter notifier mechanism, we can easily to notify
>>>>>>>> every compare object to do this process, which runs inside
>>>>>>>> of compare threads as a coroutine.
>>>>>>> Hi~ Jason and Hailiang.
>>>>>>>
>>>>>>> I will send a patch set later about colo-compare notify=20
>>>>>>> mechanism for
>>>>>>> Xen like this patch.
>>>>>>> I want to add a new chardev socket way in colo-comapre connect=20
>>>>>>> to Xen
>>>>>>> colo, for notify
>>>>>>> checkpoint or failover, Because We have no choice to use this way
>>>>>>> communicate with Xen codes.
>>>>>>> That's means we will have two notify mechanism.
>>>>>>> What do you think about this?
>>>>>>>
>>>>>>>
>>>>>>> Thanks
>>>>>>> Zhang Chen
>>>>>> I was thinking the possibility of using similar way to for colo
>>>>>> compare.
>>>>>> E.g can we use socket? This can saves duplicated codes more or les=
s.
>>>>> Since there are too many sockets used by filter and COLO, (Two unix
>>>>> sockets and two
>>>>>    tcp sockets for each vNIC), I don't want to introduce more ;) ,=20
>>>>> but
>>>>> i'm not sure if it is
>>>>> possible to make it more flexible and optional, abstract these
>>>>> duplicated codes,
>>>>> pass the opened fd (No matter eventfd or socket fd ) as parameter,=20
>>>>> for
>>>>> example.
>>>>> Is this way acceptable ?
>>>>>
>>>>> Thanks,
>>>>> Hailiang
>>>> Yes, that's kind of what I want. We don't want to use two message
>>>> format. Passing a opened fd need management support, we still need a
>>>> fallback if there's no management on top. For qemu/kvm, we can do al=
l
>>>> stuffs transparent to the cli by e.g socketpair() or others, but=20
>>>> the key
>>>> is to have a unified message format.
>>> After a deeper investigation, i think we can re-use most codes, since
>>> there is no
>>> existing way to notify xen (no ?), we still needs notify chardev
>>> socket (Be used to notify xen, it is optional.)
>>> (http://patchwork.ozlabs.org/patch/733431/ "COLO-compare: Add Xen
>>> notify chardev socket handler frame")
>> Yes and actually you can use this for bi-directional communication. Th=
e
>> only differences is the implementation of comparing.
>>
>>> Besides, there is an existing qmp comand 'xen-colo-do-checkpoint',
>> I don't see this in master?
>
> Er, it has been merged already, please see migration/colo.c, void=20
> qmp_xen_colo_do_checkpoint(Error **errp);

Aha, I see. Thanks.

>
>>> we can re-use it to notify
>>> colo-compare objects and other filter objects to do checkpoint, for
>>> the opposite direction, we use
>>> the notify chardev socket (Only for xen).
>> Just want to make sure I understand the design, who will trigger this
>> command? Management?
>
> The command will be issued by XEN (xc_save ?), the original existing=20
> xen-colo-do-checkpoint
> command now only be used to notify block replication to do checkpoint,=20
> we can re-use it for filters too.

So it was called by management. For KVM case, we probably don't need=20
this since the comparing thread are under control of qemu.

>
>> Can we just use the socket?
>
> I don't quite understand ...
> Just as the codes showed bellow, in this scenario,
> XEN notifies colo-compare and fiters do checkpoint by using qmp command=
,

Yes, that's just what I mean. Technically Xen can use socket to do this t=
oo.

Thanks

> and colo-compare notifies XEN about net inconsistency event by using=20
> the new socket.
>
>>> So the codes will be like:
>>> diff --git a/migration/colo.c b/migration/colo.c
>>> index 91da936..813c281 100644
>>> --- a/migration/colo.c
>>> +++ b/migration/colo.c
>>> @@ -224,7 +224,19 @@ ReplicationStatus
>>> *qmp_query_xen_replication_status(Error **errp)
>>>
>>>   void qmp_xen_colo_do_checkpoint(Error **errp)
>>>   {
>>> +    Error *local_err =3D NULL;
>>> +
>>>       replication_do_checkpoint_all(errp);
>>> +    /* Notify colo-compare and other filters to do checkpoint */
>>> +    colo_notify_compares_event(NULL, COLO_CHECKPOINT, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +        return;
>>> +    }
>>> +    colo_notify_filters_event(COLO_CHECKPOINT, &local_err);
>>> +    if (local_err) {
>>> +        error_propagate(errp, local_err);
>>> +    }
>>>   }
>>>
>>>   static void colo_send_message(QEMUFile *f, COLOMessage msg,
>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>> index 24e13f0..de975c5 100644
>>> --- a/net/colo-compare.c
>>> +++ b/net/colo-compare.c
>>> @@ -391,6 +391,9 @@ static void colo_compare_inconsistent_notify(void=
)
>>>   {
>>>       notifier_list_notify(&colo_compare_notifiers,
>>>                   migrate_get_current());
>
> KVM will use this notifier/callback way, and in this way, we can avoid=20
> the redundant socket.
>
>>> +    if (s->notify_dev) {
>>> +       /* Do something, notify remote side through notify dev */
>>> +    }
>>>   }
>
> If we have a notify socket configured, we will send the message about=20
> net inconsistent event.
>
>>>
>>>   void colo_compare_register_notifier(Notifier *notify)
>>>
>>> How about this scenario =EF=BC=9F
>> See my reply above, and we need unify the message format too. Raw stri=
ng
>> is ok but we'd better have something like TLV or others.
>
> Agreed, we need it to be more standard.
>
> Thanks,
> Hailiang
>
>> Thanks
>>
>>>> Thoughts?
>>>>
>>>> Thanks
>>>>
>>>>>> Thanks
>>>>>>
>>>>>>
>>>>>> .
>>>>>>
>>>> .
>>>>
>>>
>>>
>>
>> .
>>
>
>
