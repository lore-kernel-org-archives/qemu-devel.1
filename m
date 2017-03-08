Received: from eggs.gnu.org ([2001:4830:134:3::10]:44409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clXve-0007pi-2f
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clXvZ-0006Ig-2D
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:30:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1clXvY-0006IX-Oq
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:30:36 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v289TBUO029873
	for <qemu-devel@nongnu.org>; Wed, 8 Mar 2017 04:30:32 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 292f2vrtt6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 04:30:32 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 8 Mar 2017 09:30:29 -0000
Date: Wed, 8 Mar 2017 10:30:23 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <61938aa1-2698-f55e-ea1c-e7d96da0b5d7@redhat.com>
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
	<f3e9db7e-f3ab-1ae5-4da6-05dbd8d0206f@redhat.com>
	<61938aa1-2698-f55e-ea1c-e7d96da0b5d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170308103023.5e0d9d81.cornelia.huck@de.ibm.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

On Wed, 8 Mar 2017 14:22:06 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 11:21, Jason Wang wrote:
> >
> > On 2017=E5=B9=B403=E6=9C=8807=E6=97=A5 18:55, Paolo Bonzini wrote:
> >>
> >> On 07/03/2017 09:47, Jason Wang wrote:
> >>> We don't destroy region cache during reset which can make the maps
> >>> of previous driver leaked to a buggy or malicious driver that don't
> >>> set vring address before starting to use the device.
> >> I'm still not sure as to how this can happen.  Reset does clear
> >> desc/used/avail, which should then be checked before accessing the=20
> >> caches.
> >
> > But the code does not check them in fact? (E.g the attached qtest=20
> > patch can still pass check-qtest).
> >
> > Thanks=20
>=20
> Ok, the reproducer seems wrong. And I think what you mean is something=20
> like the check done in virtio_queue_ready(). But looks like not all=20
> virtqueue check for this. One example is virtio_net_handle_ctrl(), and=20

Shouldn't the check for desc in virtio_queue_notify_vq() already take
care of that?

> there may be even more. So you want to fix them all?

Obviously not speaking for Paolo, but I think the virtio core should
have be audited for missing guards.
