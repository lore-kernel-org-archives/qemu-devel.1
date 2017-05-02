Received: from eggs.gnu.org ([2001:4830:134:3::10]:36057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d5Qtz-0002A4-Cj
	for qemu-devel@nongnu.org; Tue, 02 May 2017 02:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d5Qtv-0004Fk-GE
	for qemu-devel@nongnu.org; Tue, 02 May 2017 02:03:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d5Qtv-0004FT-AG
	for qemu-devel@nongnu.org; Tue, 02 May 2017 02:03:07 -0400
References: <1493189156-14656-1-git-send-email-wangyunjian@huawei.com>
	<ff33adcb-3992-1cd8-346c-90224840d9c3@redhat.com>
	<34EFBCA9F01B0748BEB6B629CE643AE60BB3BFFB@DGGEMA505-MBS.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d49692a0-7b29-0bff-6468-0b06ace28ec1@redhat.com>
Date: Tue, 2 May 2017 14:02:57 +0800
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60BB3BFFB@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: fix wild pointer when remove
 virtio-net queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangyunjian <wangyunjian@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: caihe <caihe@huawei.com>



On 2017=E5=B9=B404=E6=9C=8826=E6=97=A5 18:45, wangyunjian wrote:
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Wednesday, April 26, 2017 5:18 PM
>> To: wangyunjian <wangyunjian@huawei.com>; mst@redhat.com; qemu-devel@n=
ongnu.org
>> Cc: caihe <caihe@huawei.com>
>> Subject: Re: [Qemu-devel] [PATCH] virtio-net: fix wild pointer when re=
move virtio-net queues
>>
>>
>>
>> On 2017=E5=B9=B404=E6=9C=8826=E6=97=A5 14:45, Yunjian Wang wrote:
>>> The tx_bh or tx_timer will free in virtio_net_del_queue() function,
>>> when removing virtio-net queues if the guest doesn't support
>>> multiqueue. But it might be still referenced by
>>> virtio_net_set_status(), which needs to be set NULL. And also the
>>> tx_waiting needs to be set zero to prevent
>>> virtio_net_set_status() accessing tx_bh or tx_timer.
>>>
>>> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
>>> ---
>>>    hw/net/virtio-net.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c index
>>> 7d091c9..98bd683 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -1522,9 +1522,12 @@ static void virtio_net_del_queue(VirtIONet *n,=
 int index)
>>>        if (q->tx_timer) {
>>>            timer_del(q->tx_timer);
>>>            timer_free(q->tx_timer);
>>> +        q->tx_timer =3D NULL;
>>>        } else {
>>>            qemu_bh_delete(q->tx_bh);
>>> +        q->tx_bh =3D NULL;
>>>        }
>>> +    q->tx_waiting =3D 0;
>>>        virtio_del_queue(vdev, index * 2 + 1);
>>>    }
>>>   =20
>> Thanks for the patch.
>>
>> It looks to me that clearing tx_waiting is sufficient or is there any
>> other reason that youneed set tx_timer/tx_bh to NULL?
> It's just coding habit to avoid access wild pointer, such as
> used-after-free porblem, it hard to locate the code that cause the bug.
>
> Thanks

Applied and queued for -stable.

Thanks

>> Thanks
