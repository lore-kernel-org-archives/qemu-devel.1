Received: from eggs.gnu.org ([2001:4830:134:3::10]:46149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceC6G-0001HW-CC
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceC6B-0003tQ-Lo
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:47:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ceC6B-0003sy-Cy
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:47:11 -0500
References: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487147657-166092-4-git-send-email-zhang.zhanghailiang@huawei.com>
	<09a2bc10-d8dd-a2c0-f545-6b08a871d91a@redhat.com>
	<58A511D2.6020102@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <485b2b76-3efb-45d0-155f-7d56f80f3df6@redhat.com>
Date: Thu, 16 Feb 2017 10:47:04 +0800
MIME-Version: 1.0
In-Reply-To: <58A511D2.6020102@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] colo-compare: release all unhandled
 packets in finalize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, pss.wulizhen@huawei.com



On 2017=E5=B9=B402=E6=9C=8816=E6=97=A5 10:43, Hailiang Zhang wrote:
> On 2017/2/16 10:34, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B402=E6=9C=8815=E6=97=A5 16:34, zhanghailiang wrote:
>>> We should release all unhandled packets before finalize colo compare.
>>> Besides, we need to free connection_track_table, or there will be
>>> a memory leak bug.
>>>
>>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>> ---
>>>    net/colo-compare.c | 20 ++++++++++++++++++++
>>>    1 file changed, 20 insertions(+)
>>>
>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>> index a16e2d5..809bad3 100644
>>> --- a/net/colo-compare.c
>>> +++ b/net/colo-compare.c
>>> @@ -676,6 +676,23 @@ static void colo_compare_complete(UserCreatable=20
>>> *uc, Error **errp)
>>>        return;
>>>    }
>>>
>>> +static void colo_release_packets(void *opaque, void *user_data)
>>> +{
>>> +    CompareState *s =3D user_data;
>>> +    Connection *conn =3D opaque;
>>> +    Packet *pkt =3D NULL;
>>> +
>>> +    while (!g_queue_is_empty(&conn->primary_list)) {
>>> +        pkt =3D g_queue_pop_head(&conn->primary_list);
>>> +        compare_chr_send(&s->chr_out, pkt->data, pkt->size);
>>
>> Any reason to send packets here?
>>
>
> Yes, considering the usage case which we shut COLO for
> the VM to make it as a normal VM without FT.
> We need to remove all the filter objects. In this case,
> IMHO, it is necessary to release the unhandled packets.
>
>
> Thanks.

Right, I see. All other patches looks good let's squash this into 2.

Thanks

>
>> Thanks
>>
>>> +        packet_destroy(pkt, NULL);
>>> +    }
>>> +    while (!g_queue_is_empty(&conn->secondary_list)) {
>>> +        pkt =3D g_queue_pop_head(&conn->secondary_list);
>>> +        packet_destroy(pkt, NULL);
>>> +    }
>>> +}
>>> +
>>>    static void colo_compare_class_init(ObjectClass *oc, void *data)
>>>    {
>>>        UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
>>> @@ -707,9 +724,12 @@ static void colo_compare_finalize(Object *obj)
>>>        g_main_loop_quit(s->compare_loop);
>>>        qemu_thread_join(&s->thread);
>>>
>>> +    /* Release all unhandled packets after compare thead exited */
>>> +    g_queue_foreach(&s->conn_list, colo_release_packets, s);
>>>
>>>        g_queue_free(&s->conn_list);
>>>
>>> +    g_hash_table_destroy(s->connection_track_table);
>>>        g_free(s->pri_indev);
>>>        g_free(s->sec_indev);
>>>        g_free(s->outdev);
>>
>>
>> .
>>
>
