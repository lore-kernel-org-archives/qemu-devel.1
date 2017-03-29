Received: from eggs.gnu.org ([2001:4830:134:3::10]:40247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ctBwi-0006Ju-BE
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ctBwe-0007kT-Cp
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:39:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35557
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1ctBwe-0007j5-6u
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 07:39:20 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2TBcj1P143245
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 07:39:18 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29gbdpa2v0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 07:39:17 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 29 Mar 2017 12:39:16 +0100
Date: Wed, 29 Mar 2017 13:39:11 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <da3b6453-650d-5f57-bab6-0b7b4b86d664@redhat.com>
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
	<aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
	<20170329104511.6dfa132c.cornelia.huck@de.ibm.com>
	<da3b6453-650d-5f57-bab6-0b7b4b86d664@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170329133911.10581d99.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] issues of region cache and iommu reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, qemu devel <qemu-devel@nongnu.org>

On Wed, 29 Mar 2017 17:18:00 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2017=E5=B9=B403=E6=9C=8829=E6=97=A5 16:45, Cornelia Huck wrote:
> > On Wed, 29 Mar 2017 10:09:10 +0200
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> >> On 29/03/2017 10:00, Jason Wang wrote:
> >>>
> >>> 1) vtd was reset first
> >>>
> >>> 2) during the reset of virtio-net-pci #1, deletion of msix subregion
> >>> will cause a commit of all memory listeners
> >>>
> >>> 3) virito-net-pci #2's region cache will be update, but since vtd has
> >>> already been reset, it can't get a valid mappings here
> >>>
> >>> Any ideas on how to fix this? Need region cache be aware of IOMMU/IOT=
LB
> >>> state in this case? Or can we simply reset IOMMU as the last one?
> >> Something like this?
> >>
> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >> index 03592c5..73e69ac 100644
> >> --- a/hw/virtio/virtio.c
> >> +++ b/hw/virtio/virtio.c
> >> @@ -176,6 +176,10 @@ err_used:
> >>       address_space_cache_destroy(&new->desc);
> >>   err_desc:
> >>       g_free(new);
> >> +    atomic_rcu_set(&vq->vring.caches, NULL);
> >> +    if (old) {
> >> +        call_rcu(old, virtio_free_region_cache, rcu);
> >> +    }
> > Maybe I'm just confused here, but isn't ->broken enough to prevent
> > further accesses?
>=20
> Looks not (e.g virtio_queue_update_used_idx() that was called by vhost).=
=20

We probably should take care that we don't do things like that for
broken devices. But that ties into the virtio_error() discussion, and
we probably want to revisit that in that context.

> We only have pfn check for all helpers now.

So we'll assert() after that change?

>=20
> > And a reset will unset both ->broken and the caches
> > anyway? What am I missing?
>=20
> Yes, but is it good to store invalid or even wrong mappings in the cache?

Not really; but I'd like to see ->broken as a kind of master indicator
"this device does not work, do not trust/use anything until it has been
reset".
