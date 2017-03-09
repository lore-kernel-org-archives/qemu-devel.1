Received: from eggs.gnu.org ([2001:4830:134:3::10]:38733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clwaA-0007YJ-Ef
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:50:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clwa7-0002EG-Au
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:50:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1clwa7-0002DX-19
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:50:07 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v29BiRuF134332
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 06:50:04 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 292hvrp3j9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 06:50:04 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 9 Mar 2017 11:50:01 -0000
Date: Thu, 9 Mar 2017 12:49:56 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <ef9a6ab7-9022-910d-97ea-6651263db902@redhat.com>
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
	<f3e9db7e-f3ab-1ae5-4da6-05dbd8d0206f@redhat.com>
	<61938aa1-2698-f55e-ea1c-e7d96da0b5d7@redhat.com>
	<519330901.29898313.1488964226313.JavaMail.zimbra@redhat.com>
	<cd078952-2971-3303-6f6f-8f07fc5aa7a5@redhat.com>
	<ef9a6ab7-9022-910d-97ea-6651263db902@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170309124956.421d2775.cornelia.huck@de.ibm.com>
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com

On Thu, 9 Mar 2017 12:10:44 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 08/03/2017 10:48, Jason Wang wrote:
> >=20
> >=20
> > On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 17:10, Paolo Bonzini wrote:
> >>
> >> ----- Original Message -----
> >>> From: "Jason Wang" <jasowang@redhat.com>
> >>> To: "Paolo Bonzini" <pbonzini@redhat.com>, mst@redhat.com,
> >>> qemu-devel@nongnu.org
> >>> Cc: peterx@redhat.com
> >>> Sent: Wednesday, March 8, 2017 7:22:06 AM
> >>> Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during
> >>> reset
> >>>
> >>>
> >>>
> >>> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 11:21, Jason Wang wrote:
> >>>> On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:55, Paolo Bonzini wrote:
> >>>>> On 07/03/2017 09:47, Jason Wang wrote:
> >>>>>> We don't destroy region cache during reset which can make the maps
> >>>>>> of previous driver leaked to a buggy or malicious driver that don't
> >>>>>> set vring address before starting to use the device.
> >>>>> I'm still not sure as to how this can happen.  Reset does clear
> >>>>> desc/used/avail, which should then be checked before accessing the
> >>>>> caches.
> >>>> But the code does not check them in fact? (E.g the attached qtest
> >>>> patch can still pass check-qtest).
> >>>>
> >>>> Thanks
> >>> Ok, the reproducer seems wrong. And I think what you mean is something
> >>> like the check done in virtio_queue_ready(). But looks like not all
> >>> virtqueue check for this. One example is virtio_net_handle_ctrl(), and
> >>> there may be even more. So you want to fix them all?
> >> Why would virtio_net_handle_ctrl be called when desc =3D=3D 0?  The ch=
ecks
> >> are all in common virtio code.
>=20
> >=20
> > Right, I miss this.
> >=20
> > But I find two possible leaks by auditing the callers of virtqueue_pop(=
):
> >=20
> > virtio_input_send() and virtio_balloon_set_status() which will call
> > virtio_balloon_receive_stats().
>=20
> Ok, this is good!  I think we should check vq->vring.desc in
> virtio_queue_empty and virtio_queue_empty_rcu, and that should do it.
> It will cover virtqueue_pop too.

Yes, virtio_queue_empty{_rcu} should check for !desc.

> virtqueue_get_avail_bytes is always preceded or followed by
> virtio_queue_empty, virtio_queue_ready or virtqueue_pop, but perhaps we
> should add a check there too.

virtqueue_get_avail_bytes is an exported interface, so I think it
should check as well.

virtqueue_fill and virtqueue_flush as well, I think. Better safe than
sorry.
