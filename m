Received: from eggs.gnu.org ([2001:4830:134:3::10]:48985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYCj-0004g9-1F
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clYCf-0002QW-Vh
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:48:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clYCf-0002QD-QZ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:48:17 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D2D51B1775
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 09:48:17 +0000 (UTC)
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
	<f3e9db7e-f3ab-1ae5-4da6-05dbd8d0206f@redhat.com>
	<61938aa1-2698-f55e-ea1c-e7d96da0b5d7@redhat.com>
	<519330901.29898313.1488964226313.JavaMail.zimbra@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cd078952-2971-3303-6f6f-8f07fc5aa7a5@redhat.com>
Date: Wed, 8 Mar 2017 17:48:11 +0800
MIME-Version: 1.0
In-Reply-To: <519330901.29898313.1488964226313.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com



On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 17:10, Paolo Bonzini wrote:
>
> ----- Original Message -----
>> From: "Jason Wang" <jasowang@redhat.com>
>> To: "Paolo Bonzini" <pbonzini@redhat.com>, mst@redhat.com, qemu-devel@=
nongnu.org
>> Cc: peterx@redhat.com
>> Sent: Wednesday, March 8, 2017 7:22:06 AM
>> Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during =
reset
>>
>>
>>
>> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 11:21, Jason Wang wrote:
>>> On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:55, Paolo Bonzini wrote:
>>>> On 07/03/2017 09:47, Jason Wang wrote:
>>>>> We don't destroy region cache during reset which can make the maps
>>>>> of previous driver leaked to a buggy or malicious driver that don't
>>>>> set vring address before starting to use the device.
>>>> I'm still not sure as to how this can happen.  Reset does clear
>>>> desc/used/avail, which should then be checked before accessing the
>>>> caches.
>>> But the code does not check them in fact? (E.g the attached qtest
>>> patch can still pass check-qtest).
>>>
>>> Thanks
>> Ok, the reproducer seems wrong. And I think what you mean is something
>> like the check done in virtio_queue_ready(). But looks like not all
>> virtqueue check for this. One example is virtio_net_handle_ctrl(), and
>> there may be even more. So you want to fix them all?
> Why would virtio_net_handle_ctrl be called when desc =3D=3D 0?  The che=
cks
> are all in common virtio code.
>
> static void virtio_queue_notify_vq(VirtQueue *vq)
> {
>      if (vq->vring.desc && vq->handle_output) {
>          VirtIODevice *vdev =3D vq->vdev;
>
>          if (unlikely(vdev->broken)) {
>              return;
>          }
>
>          trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
>          vq->handle_output(vdev, vq);
>      }
> }
>                                                                        =
                                                                         =
                                1440,29       55%
> Paolo

Right, I miss this.

But I find two possible leaks by auditing the callers of virtqueue_pop():

virtio_input_send() and virtio_balloon_set_status() which will call=20
virtio_balloon_receive_stats().

Thanks
