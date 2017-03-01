Received: from eggs.gnu.org ([2001:4830:134:3::10]:35298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cj5Fk-0007ex-65
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cj5Fg-0008Cc-7S
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cj5Ff-0008CI-VA
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:29:12 -0500
References: <20170301115004.96073-1-pasic@linux.vnet.ibm.com>
	<331bf747-0c32-0f1a-eda0-40e6fa507494@redhat.com>
	<e78274bf-ed9b-3358-0a5d-271854247da1@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b24ba9f9-11f4-d17f-1973-b94e82316518@redhat.com>
Date: Wed, 1 Mar 2017 15:29:09 +0100
MIME-Version: 1.0
In-Reply-To: <e78274bf-ed9b-3358-0a5d-271854247da1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio: fallback from irqfd to
 non-irqfd notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 01/03/2017 14:22, Halil Pasic wrote:
> Here a trace:
>=20
> 135871@1488304024.512533:virtio_blk_req_complete req 0x2aa6b117e10 stat=
us 0
> 135871@1488304024.512541:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2a=
a6b4c0870
> 135871@1488304024.522607:virtio_blk_req_complete req 0x2aa6b118980 stat=
us 0
> 135871@1488304024.522616:virtio_blk_req_complete req 0x2aa6b119260 stat=
us 0
> 135871@1488304024.522627:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2a=
a6b4c0870
> 135871@1488304024.527386:virtio_blk_req_complete req 0x2aa6b118980 stat=
us 0
> 135871@1488304024.527431:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2a=
a6b4c0870
> 135871@1488304024.528611:virtio_guest_notifier_read vdev 0x2aa6b0e61c8 =
vq 0x2aa6b4de880
> 135871@1488304024.528628:virtio_guest_notifier_read vdev 0x2aa6b0e61c8 =
vq 0x2aa6b4de8f8
> 135871@1488304024.528753:virtio_blk_data_plane_stop dataplane 0x2aa6b0e=
5540
>                          ^=3D=3D DATAPLANE STOP =20
> 135871@1488304024.530709:virtio_blk_req_complete req 0x2aa6b117e10 stat=
us 0
> 135871@1488304024.530752:virtio_guest_notifier_read vdev 0x2aa6b0e19d8 =
vq 0x2aa6b4c0870
>                          ^=3D=3D comes from k->set_guest_notifiers(qbus=
->parent, nvqs, false);
>                              in virtio_blk_data_plane_stop and done imm=
ediately after
>                              irqfd is cleaned up by the transport
> 135871@1488304024.530836:virtio_notify_irqfd vdev 0x2aa6b0e19d8 vq 0x2a=
a6b4c0870
> halil: error in event_notifier_set: Bad file descriptor
>                          ^=3D=3D here we have the problem
>=20
> If you want a stacktrace that can be arranged to.
>=20
>> like a reset should cause it (the only call in virtio-blk is from
>> virtio_blk_data_plane_stop), and then the guest doesn't care anymore
>> about interrupts.
> I do not understand this with 'doesn't care anymore about interrupts'.
> I was debugging a virtio-blk device being stuck waiting for a host
> notification (interrupt) after migration.

Ok, this explains it better then.  The issue is that
virtio_blk_data_plane_stop doesn't flush the bottom half, which you want
to do when the caller is, for example, virtio_ccw_vmstate_change.

Does it work if you call to qemu_bh_cancel(s->bh) and notify_guest_bh(s)
after

    blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());

?

Paolo

>> That path also does a qemu_bh_delete, so the notify_guest_bh should no=
t
>> be invoked at all.
>>
> That's only for destroy. I'm migrating.
>=20
> Seems I tried to fix this is the wrong way. Was not too confident about=
 it
> in the first place. Suggestions welcome!
