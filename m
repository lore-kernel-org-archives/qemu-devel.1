Received: from eggs.gnu.org ([2001:4830:134:3::10]:50879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gXHDH-00068t-KA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gXHDD-0005XG-W1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gXHDD-0005Vm-LD
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:58:55 -0500
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
	<20181206085849-mutt-send-email-mst@kernel.org>
	<cf555a3d-0312-0b61-d18a-12ca295520a0@redhat.com>
	<CAONzpcaXTBgPTH0WSfq-=RwHLkuqi1mhKcv4C=0_O67_hV8A2Q@mail.gmail.com>
	<5794e090-9a9b-ca30-1066-ef697c9b67be@redhat.com>
	<CAONzpcZKAXrgbJc6H3d82zUt6VUVSo36HLg__OvuDWoBk9zTvg@mail.gmail.com>
	<7520e2cd-59cc-c133-f913-e7397df684dd@redhat.com>
	<CAONzpcbekTuN80r3Vb3CA7MqYBuVOOmV=6wfCNOb5z6QyrLZvg@mail.gmail.com>
	<cc6a464a-3193-f95b-08e5-c67e95d72dd5@redhat.com>
	<CAONzpcZ_RqUujdSoVCPUHH0A2g4hHY=oM9x-04e-6WugYFQOiw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce6eb03a-8157-bd4a-a467-9c2d6b2fa7fd@redhat.com>
Date: Thu, 13 Dec 2018 10:58:43 +0800
MIME-Version: 1.0
In-Reply-To: <CAONzpcZ_RqUujdSoVCPUHH0A2g4hHY=oM9x-04e-6WugYFQOiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/6] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, zhangyu31@baidu.com, Xie Yongji <xieyongji@baidu.com>, lilin24@baidu.com, qemu-devel@nongnu.org, chaiwen@baidu.com, marcandre.lureau@redhat.com, nixun@baidu.com


On 2018/12/12 =E4=B8=8B=E5=8D=885:18, Yongji Xie wrote:
>>>> Ok, then we can simply forbid increasing the avail_idx in this case?
>>>>
>>>> Basically, it's a question of whether or not it's better to done it =
in
>>>> the level of virtio instead of vhost. I'm pretty sure if we expose
>>>> sufficient information, it could be done without touching vhost-user=
.
>>>> And we won't deal with e.g migration and other cases.
>>>>
>>> OK, I get your point. That's indeed an alternative way. But this feat=
ure seems
>>> to be only useful to vhost-user backend.
>> I admit I could not think of a use case other than vhost-user.
>>
>>
>>>    I'm not sure whether it make sense to
>>> touch virtio protocol for this feature.
>> Some possible advantages:
>>
>> - Feature could be determined and noticed by user or management layer.
>>
>> - There's no need to invent ring layout specific protocol to record in
>> flight descriptors. E.g if my understanding is correct, for this serie=
s
>> and for the example above, it still can not work for packed virtqueue
>> since descriptor id is not sufficient (descriptor could be overwritten
>> by used one). You probably need to have a (partial) copy of descriptor
>> ring for this.
>>
>> - No need to deal with migration, all information was in guest memory.
>>
> Yes, we have those advantages. But seems like handle this in vhost-user
> level could be easier to be maintained in production environment. We ca=
n
> support old guest. And the bug fix will not depend on guest kernel upda=
ting.


Yes. But the my main concern is the layout specific data structure. If=20
it could be done through a generic structure (can it?), it would be=20
fine. Otherwise, I believe we don't want another negotiation about what=20
kind of layout that backend support for reconnect.

Thanks


>
> Thanks,
> Yongji
