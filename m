Received: from eggs.gnu.org ([209.51.188.92]:49494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gtRry-0006ZW-Af
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gtRrs-000871-HQ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:48:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gtRrs-000867-B6
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:48:32 -0500
References: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <078dfb4d-2467-6a2c-1964-a463839e8183@redhat.com>
Date: Tue, 12 Feb 2019 14:48:22 +0800
MIME-Version: 1.0
In-Reply-To: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Is IOThread for virtio-net a good idea?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-devel@nongnu.org
Cc: mst@redhat.com


On 2019/2/11 =E4=B8=8B=E5=8D=889:40, Anton Kuchin wrote:
> As far as I can see currently IOThread offloading is used only for=20
> block devices and all others are emulated by main thread.
>
> I expect that network devices can also benefit from processing in=20
> separate thread but I couldn't find any recent work in this direction.=20
> I'm going to implement a PoC but I want to ask if you know any=20
> previous attempts and do you know why it can be a total waste of time.=20
> Are there fundamental obstacles that prevent network emulation=20
> handling in IOThread?
>

I think there're no obstacles.

The only question is whether or not you need to support legacy=20
networking backends. If the answer is yes, you need to convert them not=20
to assume context of Main Loop. But I don't think it's worth to support=20
them. We should focus on high speed solution like linking dpdk.

Another issue is the virtio implementation. Dpdk has virtio library=20
which is pretty optimized, we should consider to use it. But last time I=20
check the code, it was tightly coupled with AF_UNIX transport of=20
vhost-user. We may want to decouple it out of dpdk. Of course we can do=20
it our own as well. (Yes I know there's a vhost-user implementation, but=20
it was not optimized for performance).

I do have some prototype that is based on vhost-scsi-dataplane with a=20
TAP backend. I can send it to you if you wish.

Thanks
