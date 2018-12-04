Received: from eggs.gnu.org ([2001:4830:134:3::10]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gU0S9-0001mx-M6
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 21:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gU0S4-0006JI-KX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 21:28:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gU0S4-0006IE-84
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 21:28:44 -0500
References: <20181203100608.28538-1-jasowang@redhat.com>
	<CAFEAcA-n+vJ505AF1xzq6y4HUab8ivX-4sQ29jBXsogfZh0=FQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eaf87c46-3306-876c-8fb5-6b4f391c3f00@redhat.com>
Date: Tue, 4 Dec 2018 10:28:32 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-n+vJ505AF1xzq6y4HUab8ivX-4sQ29jBXsogfZh0=FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 for 3.1 0/4] Fix possible OOB during
 queuing packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, P J P <ppandit@redhat.com>, Li Qiang <liq3ea@163.com>, Li Qiang <liq3ea@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>


On 2018/12/4 =E4=B8=8A=E5=8D=8812:18, Peter Maydell wrote:
> On Mon, 3 Dec 2018 at 10:06, Jason Wang <jasowang@redhat.com> wrote:
>> Hi:
>>
>> This series tries to fix a possible OOB during queueing packets
>> through qemu_net_queue_append_iov(). This could happen when it tries
>> to queue a packet whose size is larger than INT_MAX which may lead
>> integer overflow. We've fixed similar issue in the past during
>> qemu_net_queue_deliver_iov() by ignoring large packets there. Let's
>> just move the check earlier to qemu_sendv_packet_async() and reduce
>> the limitation to NET_BUFSIZE. A simple qtest were also added this.
>>
>> Please review.
> I did a test build and run, and the new test generates warning
> messages during "make check":
>    /ppc64/virtio/net/pci/large_tx:
> qemu-system-ppc64: warning: hub 0 is not connected to host network
> (similarly for /i386/ and /x86_64/).
>
> thank
> -- PMM


This is intended, we don't need any host networking device. This makes=20
it very simpler and easier to trigger the queuing at hub. I can add a=20
patch to suppress this warning if qtest is enabled.

Thanks
