Received: from eggs.gnu.org ([209.51.188.92]:36331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gkQQc-0002EH-Fz
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gkQQb-0004jM-Dk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:27:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gkQQb-0004hd-5L
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:27:05 -0500
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-5-xieyongji@baidu.com>
	<ce11d062-1d64-3d35-b617-5c135f1506eb@redhat.com>
	<CAONzpcY6pdSz65Tzj_Ws0M4vskUOXMuaxQ-uYz6NnCvdMgkFOA@mail.gmail.com>
	<a6e0c0b2-bd0b-454c-8280-12e0ec964240@redhat.com>
	<CAONzpcb-TrxZVBtfP=3PCqq-3r1NwX93C4xSd9MsM4DCTZMguA@mail.gmail.com>
	<ed0dc117-89f6-5fd6-a5f6-91f781a6b09e@redhat.com>
	<CAONzpcYS7Knf3-uMCjX47KjWJ315SqXWxJKQ9SDNt0P6jP7axw@mail.gmail.com>
	<de4691ae-e8cb-eaa2-e25f-fb7630a9007b@redhat.com>
	<CAONzpcYWs4j-ieeQWXAMayHCsB1KcQ3nsT5GLdkjx0_E_7k4Xg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b358b695-456e-d829-af5a-e5e9c9c87875@redhat.com>
Date: Fri, 18 Jan 2019 17:26:46 +0800
MIME-Version: 1.0
In-Reply-To: <CAONzpcYWs4j-ieeQWXAMayHCsB1KcQ3nsT5GLdkjx0_E_7k4Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 4/7] libvhost-user: Support
 tracking inflight I/O in shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: zhangyu31@baidu.com, "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@baidu.com>, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, chaiwen@baidu.com, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, nixun@baidu.com, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>


On 2019/1/18 =E4=B8=8B=E5=8D=883:01, Yongji Xie wrote:
> On Fri, 18 Jan 2019 at 12:00, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2019/1/18 =E4=B8=8A=E5=8D=8811:32, Yongji Xie wrote:
>>> On Thu, 17 Jan 2019 at 17:57, Jason Wang <jasowang@redhat.com> wrote:
>>>> On 2019/1/15 =E4=B8=8B=E5=8D=8810:51, Yongji Xie wrote:
>>>>>> Well, this may work but here're my points:
>>>>>>
>>>>>> 1) The code want to recover from backed crash by introducing extra=
 space
>>>>>> to store inflight data, but it still depends on the backend to set=
/get
>>>>>> the inflight state
>>>>>>
>>>>>> 2) Since the backend could be killed at any time, the backend must=
 have
>>>>>> the ability to recover from the partial inflight state
>>>>>>
>>>>>> So it looks to me 1) tends to be self-contradictory and 2) tends t=
o be
>>>>>> recursive. The above lines show how tricky could the code looks li=
ke.
>>>>>>
>>>>>> Solving this at vhost-user level through at backend is probably wr=
ong.
>>>>>> It's time to consider the support from virtio itself.
>>>>>>
>>>>> I agree that supporting this in virtio level may be better. For
>>>>> example, resubmitting inflight I/O once DEVICE_NEEDS_RESET is set i=
n
>>>>> Stefan's proposal. But I still think QEMU should be able to provide
>>>>> this ability too. Supposed that one vhost-user backend need to supp=
ort
>>>>> multiple VMs. We can't enable reconnect ability until all VMs' gues=
t
>>>>> driver support the new feature. It's limited.
>>>> That's the way virtio evolves.
>>>>
>>>>
>>>>>     But if QEMU have the
>>>>> ability to store inflight buffer, the backend could at least have a
>>>>> chance to support this case.
>>>> The problem is, you need a careful designed protocol described somew=
here
>>> That's what we should discuss in detail in this series.
>>
>> Well, I ask some questions for this patch, but it looks like they were
>> still not answered. No?
>>
>>
> Oh, sorry, I missed those questions. Let me try to answer them here.
>
> Q1: If backend get killed in vu_queue_inflight_get() without setting
> vq->inflight->desc[desc_idx] to 1, is there any problem?
>
> The entry which stores the head of this inflight descriptor is not
> lost in avail ring. So we can still get this inflight descriptor from
> avail ring although we didn't set vq->inflight->desc[desc_idx] to 1.


Ok I get this.


> Q2:
> void vu_queue_push()
> {
>      vq->inflight->elem_idx =3D elem->idx;
>      vu_queue_fill();
>      vu_queue_flush();
>      vq->inflight->desc[elem->idx] =3D 0;
>                                                      <-------- Does
> this safe to be killed here?
>      vq->inflight->used_idx =3D vq->vring.used->idx;
> }
>
> Because there are no concurrency between vu_queue_push() and
> vu_queue_pop(), I don't see any problem here.
>
> Basically we just need to make sure this two operations
> (vq->vring.used->idx++ and vq->inflight->desc[elem->idx] =3D 0) are
> atomic. I think there are some approach to achieve that. I'm not sure
> my approach here is good enough, but it should work.


Rethink about this, some findings:

- What you suggest requires strict ordering in some part of=20
vu_queue_push(). E.g it looks to me you need a compiler barrier to make=20
sure used_idx is set before clearing desc[elem->idx]? This a an side=20
effect of introduce new metadata (inflight->elem_idx and=20
inflight->used_idx) to recover from crashing when logging=20
inflgith->desc[] array.

- Modern backends like dpdk do batching aggressively, which means you=20
probably need an array of elem_idx[]. This tends to be more complex=20
since we probably need to negotiate the size of this array and the=20
overhead is probably noticeable.

I don't audit all other places of the codes, but I suspect it would be=20
hard to be 100% correct. And what happens for packed virtqueue?=20
Basically, we don't want to produce tricky codes that is hard to debug=20
in the future. Think in another direction, in order will be supported by=20
virtio 1.1. With that, the inflight descriptors could be much more=20
easier to be deduced like [used_idx, avail_idx)? So it looks to me=20
supporting this from virtio layer is much more easier.

Thoughts?

Thanks


>
>>>> (is vhost-user.txt a good place for this?). And this work will be
>>>> (partial) duplicated for the future support from virtio spec itself.
>>>>
>>> I think the duplicated code is to maintain the inflight descriptor
>>> list which should be in backend. That's not main work in this series.
>>> And backend could choose to include it or not.
>>
>> You need to have a documentation to describe the protocol. Otherwise, =
it
>> would be very hard for other backend to implement.
>>
> Yes, actually now I'm working on adding more detail to vhost-user.txt.
>
> Thanks,
> Yongji
