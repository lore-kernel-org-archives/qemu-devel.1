Received: from eggs.gnu.org ([2001:4830:134:3::10]:52807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clvy6-0002Yw-JF
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clvy3-0004YB-DT
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:10:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clvy3-0004WA-6u
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:10:47 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42F143B709
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 11:10:47 +0000 (UTC)
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
	<f3e9db7e-f3ab-1ae5-4da6-05dbd8d0206f@redhat.com>
	<61938aa1-2698-f55e-ea1c-e7d96da0b5d7@redhat.com>
	<519330901.29898313.1488964226313.JavaMail.zimbra@redhat.com>
	<cd078952-2971-3303-6f6f-8f07fc5aa7a5@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef9a6ab7-9022-910d-97ea-6651263db902@redhat.com>
Date: Thu, 9 Mar 2017 12:10:44 +0100
MIME-Version: 1.0
In-Reply-To: <cd078952-2971-3303-6f6f-8f07fc5aa7a5@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com



On 08/03/2017 10:48, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 17:10, Paolo Bonzini wrote:
>>
>> ----- Original Message -----
>>> From: "Jason Wang" <jasowang@redhat.com>
>>> To: "Paolo Bonzini" <pbonzini@redhat.com>, mst@redhat.com,
>>> qemu-devel@nongnu.org
>>> Cc: peterx@redhat.com
>>> Sent: Wednesday, March 8, 2017 7:22:06 AM
>>> Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during
>>> reset
>>>
>>>
>>>
>>> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 11:21, Jason Wang wrote:
>>>> On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:55, Paolo Bonzini wrote:
>>>>> On 07/03/2017 09:47, Jason Wang wrote:
>>>>>> We don't destroy region cache during reset which can make the maps
>>>>>> of previous driver leaked to a buggy or malicious driver that don'=
t
>>>>>> set vring address before starting to use the device.
>>>>> I'm still not sure as to how this can happen.  Reset does clear
>>>>> desc/used/avail, which should then be checked before accessing the
>>>>> caches.
>>>> But the code does not check them in fact? (E.g the attached qtest
>>>> patch can still pass check-qtest).
>>>>
>>>> Thanks
>>> Ok, the reproducer seems wrong. And I think what you mean is somethin=
g
>>> like the check done in virtio_queue_ready(). But looks like not all
>>> virtqueue check for this. One example is virtio_net_handle_ctrl(), an=
d
>>> there may be even more. So you want to fix them all?
>> Why would virtio_net_handle_ctrl be called when desc =3D=3D 0?  The ch=
ecks
>> are all in common virtio code.

>=20
> Right, I miss this.
>=20
> But I find two possible leaks by auditing the callers of virtqueue_pop(=
):
>=20
> virtio_input_send() and virtio_balloon_set_status() which will call
> virtio_balloon_receive_stats().

Ok, this is good!  I think we should check vq->vring.desc in
virtio_queue_empty and virtio_queue_empty_rcu, and that should do it.
It will cover virtqueue_pop too.

virtqueue_get_avail_bytes is always preceded or followed by
virtio_queue_empty, virtio_queue_ready or virtqueue_pop, but perhaps we
should add a check there too.

Paolo

Paolo
