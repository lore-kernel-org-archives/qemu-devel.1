Received: from eggs.gnu.org ([209.51.188.92]:55580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gk4Ql-00049z-3a
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gk4Qk-0006Di-Bg
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:57:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gk4Qk-0006CY-63
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:57:46 -0500
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-5-xieyongji@baidu.com>
	<ce11d062-1d64-3d35-b617-5c135f1506eb@redhat.com>
	<CAONzpcY6pdSz65Tzj_Ws0M4vskUOXMuaxQ-uYz6NnCvdMgkFOA@mail.gmail.com>
	<a6e0c0b2-bd0b-454c-8280-12e0ec964240@redhat.com>
	<CAONzpcb-TrxZVBtfP=3PCqq-3r1NwX93C4xSd9MsM4DCTZMguA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ed0dc117-89f6-5fd6-a5f6-91f781a6b09e@redhat.com>
Date: Thu, 17 Jan 2019 17:57:29 +0800
MIME-Version: 1.0
In-Reply-To: <CAONzpcb-TrxZVBtfP=3PCqq-3r1NwX93C4xSd9MsM4DCTZMguA@mail.gmail.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>, Stefan Hajnoczi <stefanha@gmail.com>


On 2019/1/15 =E4=B8=8B=E5=8D=8810:51, Yongji Xie wrote:
>> Well, this may work but here're my points:
>>
>> 1) The code want to recover from backed crash by introducing extra spa=
ce
>> to store inflight data, but it still depends on the backend to set/get
>> the inflight state
>>
>> 2) Since the backend could be killed at any time, the backend must hav=
e
>> the ability to recover from the partial inflight state
>>
>> So it looks to me 1) tends to be self-contradictory and 2) tends to be
>> recursive. The above lines show how tricky could the code looks like.
>>
>> Solving this at vhost-user level through at backend is probably wrong.
>> It's time to consider the support from virtio itself.
>>
> I agree that supporting this in virtio level may be better. For
> example, resubmitting inflight I/O once DEVICE_NEEDS_RESET is set in
> Stefan's proposal. But I still think QEMU should be able to provide
> this ability too. Supposed that one vhost-user backend need to support
> multiple VMs. We can't enable reconnect ability until all VMs' guest
> driver support the new feature. It's limited.


That's the way virtio evolves.


>   But if QEMU have the
> ability to store inflight buffer, the backend could at least have a
> chance to support this case.


The problem is, you need a careful designed protocol described somewhere=20
(is vhost-user.txt a good place for this?). And this work will be=20
(partial) duplicated for the future support from virtio spec itself.


> Maybe backend could have other way to
> avoid the tricky code.


I'm not sure, but it was probably not easy.

Thanks


>
> Thanks,
