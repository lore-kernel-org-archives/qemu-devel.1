Received: from eggs.gnu.org ([209.51.188.92]:36533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gpOXV-0005xc-Js
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 21:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gpOXT-0001WE-NW
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 21:26:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gpOXR-0001QP-R9
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 21:26:43 -0500
References: <20190122083152.10705-1-xieyongji@baidu.com>
	<20190122083152.10705-4-xieyongji@baidu.com>
	<09287313-0f6e-38a3-be36-9bf65bba7b9d@redhat.com>
	<CAONzpcaQhfSa-Uw2-r_XTqvw8fYq_haJ6zKR-9NkK=fBkZky0w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <03d8aa2d-e72d-4aa7-c83d-8252b0ebbc8a@redhat.com>
Date: Fri, 1 Feb 2019 10:26:10 +0800
MIME-Version: 1.0
In-Reply-To: <CAONzpcaQhfSa-Uw2-r_XTqvw8fYq_haJ6zKR-9NkK=fBkZky0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/6] libvhost-user: Support tracking
 inflight I/O in shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, nixun@baidu.com, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>


On 2019/1/30 =E4=B8=8A=E5=8D=8811:58, Yongji Xie wrote:
> On Wed, 30 Jan 2019 at 10:32, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2019/1/22 =E4=B8=8B=E5=8D=884:31, elohimes@gmail.com wrote:
>>> +static int
>>> +vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
>>> +{
>>> +    if (!has_feature(dev->protocol_features,
>>> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (unlikely(!vq->inflight)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    vq->inflight->desc[desc_idx].inuse =3D 1;
>>> +
>>> +    vq->inflight->desc[desc_idx].avail_idx =3D vq->last_avail_idx;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int
>>> +vu_queue_inflight_pre_put(VuDev *dev, VuVirtq *vq, int desc_idx)
>>> +{
>>> +    if (!has_feature(dev->protocol_features,
>>> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (unlikely(!vq->inflight)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    vq->inflight->desc[desc_idx].used_idx =3D vq->used_idx;
>>> +
>>> +    barrier();
>>> +
>>> +    vq->inflight->desc[desc_idx].version++;
>>> +
>>> +    return 0;
>>> +}
>>
>> You probably need WRITE_ONCE() semantic (e.g volatile) to make sure th=
e
>> value reach memory.
>>
> Is it enough to declare those variables as volatile?
>
> Thanks,
> Yongji


I think so.

Thanks
