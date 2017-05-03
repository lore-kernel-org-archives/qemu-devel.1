Received: from eggs.gnu.org ([2001:4830:134:3::10]:47283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d5soP-0006t2-A7
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d5soM-0001RD-88
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44647)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d5soM-0001Qx-1O
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:51:14 -0400
References: <CADuF=xUDDOoMeVvPdH3BeqOnG+RONgwyzP5aj1kDeoYL97BtOw@mail.gmail.com>
	<20170502130725.GC22502@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <629ebfb2-29b4-17d7-b6aa-a12a94bc15ab@redhat.com>
Date: Wed, 3 May 2017 19:51:07 +0800
MIME-Version: 1.0
In-Reply-To: <20170502130725.GC22502@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-net - virtio - multiqueue - rx queue
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Sujith Sankar <ssujith@avinetworks.com>
Cc: qemu-devel@nongnu.org



On 2017=E5=B9=B405=E6=9C=8802=E6=97=A5 21:07, Stefan Hajnoczi wrote:
> On Thu, Apr 20, 2017 at 10:07:33AM +0530, Sujith Sankar wrote:
>> I have a question regarding the algorithm used to select rx queue of
>> the VM in the case of multiqueue virtio-net on KVM.
>>
>> Given a 4-tuple, how can we calculate the index of the receive queue
>> that virtio-net is going pick for that flow?  From some of the email
>> threads in some of the relevant forums, it seems RSS is not used.  But
>> documentations/threads do not talk about how a queue is picked.
>>
>> Could you please help me with this?
> CCing Jason Wang, QEMU net maintainer.
>
> Stefan

Automatic flow steering is mandatory in the spec (see 5.1.6.5.5):

"
When multiqueue is enabled, the device MUST use automatic receive=20
steering based on packet flow. Programming of the receive steering=20
classificator is implicit. After the driver transmitted a packet of a=20
flow on transmitqX, the device SHOULD cause incoming packets for that=20
flow to be steered to receiveqX. For uni-directional protocols, or where=20
no packets have been transmitted yet, the device MAY steer a packet to a=20
random queue out of the specified receiveq1=E2=80=A6receiveqn.
"

We plan to add guest visible filters (e.g RSS) support, and may even=20
consider offload it to hardware.

Thanks
