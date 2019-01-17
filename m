Received: from eggs.gnu.org ([209.51.188.92]:57549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gk4Uc-0005rl-CH
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gk4UW-0003Po-Pp
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:01:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gk4UW-0003N0-Jq
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:01:40 -0500
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-5-xieyongji@baidu.com>
	<ce11d062-1d64-3d35-b617-5c135f1506eb@redhat.com>
	<CAONzpcY6pdSz65Tzj_Ws0M4vskUOXMuaxQ-uYz6NnCvdMgkFOA@mail.gmail.com>
	<a6e0c0b2-bd0b-454c-8280-12e0ec964240@redhat.com>
	<20190115105548-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3ead48a9-9cf9-33f6-b258-7068265c1a99@redhat.com>
Date: Thu, 17 Jan 2019 18:01:16 +0800
MIME-Version: 1.0
In-Reply-To: <20190115105548-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <elohimes@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>


On 2019/1/15 =E4=B8=8B=E5=8D=8811:58, Michael S. Tsirkin wrote:
> On Tue, Jan 15, 2019 at 03:52:21PM +0800, Jason Wang wrote:
>> Well, this may work but here're my points:
>>
>> 1) The code want to recover from backed crash by introducing extra spa=
ce to
>> store inflight data, but it still depends on the backend to set/get th=
e
>> inflight state
>>
>> 2) Since the backend could be killed at any time, the backend must hav=
e the
>> ability to recover from the partial inflight state
>>
>> So it looks to me 1) tends to be self-contradictory and 2) tends to be
>> recursive. The above lines show how tricky could the code looks like.
> This is a well studied field. Basically you make sure you commit with a=
n
> atomic write.  Restartable sequences allow accelerating this even
> further.


I'm not sure I get this. But the issue is to exactly deduce all the=20
inflight descriptors even if backend could be killed when doing the=20
logging. If we could not be 100% accurate, it's have much less value.


>
>> Solving this at vhost-user level through at backend is probably wrong.=
 It's
>> time to consider the support from virtio itself.
>>
>> Thanks
> I think both approaches have their space.


But there will be a lot of duplicated work if we decide to support it=20
from virtio.

Thanks


>
> -- MST
