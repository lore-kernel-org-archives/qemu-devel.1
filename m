Received: from eggs.gnu.org ([209.51.188.92]:46181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gtRll-0004e1-IL
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gtRlk-0002kx-MF
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:42:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gtRli-0002bU-NP
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 01:42:11 -0500
References: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
	<20190211095049-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b775d7dc-4def-6d7c-ebff-d0b18169c52b@redhat.com>
Date: Tue, 12 Feb 2019 14:41:51 +0800
MIME-Version: 1.0
In-Reply-To: <20190211095049-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Anton Kuchin <antonkuchin@yandex-team.ru>
Cc: qemu-devel@nongnu.org


On 2019/2/11 =E4=B8=8B=E5=8D=8810:52, Michael S. Tsirkin wrote:
> On Mon, Feb 11, 2019 at 04:40:44PM +0300, Anton Kuchin wrote:
>> As far as I can see currently IOThread offloading is used only for blo=
ck
>> devices and all others are emulated by main thread.
>>
>> I expect that network devices can also benefit from processing in sepa=
rate
>> thread but I couldn't find any recent work in this direction. I'm goin=
g to
>> implement a PoC but I want to ask if you know any previous attempts an=
d do
>> you know why it can be a total waste of time. Are there fundamental
>> obstacles that prevent network emulation handling in IOThread?
> No but vhost-net is there. Unlike block where you gain lots of
> functionality such as snapshots there seems to be little to
> be gained by doing it in userspace.


I think all the three (vhost-net, vhost-user, vhost-dataplane) have=20
their own advantages. E.g compared to vhost-user, vhost dataplane in=20
qemu has the following advantages:

- Qemu dataplane could be much safer, e.g there's no need to share all=20
its memory to another process.

- Easy to develop, there's no need for the backend to know anything=20
about virtio. This will reduce the pain of maintaining compatibility,=20
version etc. New features was limited to the changes of qemu itself.

- Faster access of VM metadata, Device IOTLB and RSS/Steering could be=20
function calls instead of complex vhost-user protocol. I'm pretty sure=20
we will hit more similar issues in the future.

And I can consider some use cases:

- link dpdk to qemu

- implement fast userspace backend like AF_XDP, netmap, packet socket or=20
other (or even achieve this through dpdk pmd)

Thanks
