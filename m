Received: from eggs.gnu.org ([2001:4830:134:3::10]:45372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cyEYN-0006Bc-OE
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cyEYJ-0005vk-PE
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:27:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cyEYJ-0005tb-Ef
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:27:03 -0400
Date: Wed, 12 Apr 2017 17:26:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170412092653.GH16464@pxdev.xzpeter.org>
References: <20170411101002.28451-1-maxime.coquelin@redhat.com>
	<20170411101002.28451-3-maxime.coquelin@redhat.com>
	<20170411132046.GA16464@pxdev.xzpeter.org>
	<ed46bbd8-222b-3cda-e524-f9dfda8e3770@redhat.com>
	<20170412071708.GE16464@pxdev.xzpeter.org>
	<131237e3-d6e3-804e-5bf4-ce2c281e140f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <131237e3-d6e3-804e-5bf4-ce2c281e140f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 2/2] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, mst@redhat.com, vkaplans@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, virtio-comment@lists.oasis-open.org, qemu-devel@nongnu.org

On Wed, Apr 12, 2017 at 04:54:25PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B404=E6=9C=8812=E6=97=A5 15:17, Peter Xu wrote:
> >On Tue, Apr 11, 2017 at 05:16:19PM +0200, Maxime Coquelin wrote:
> >>On 04/11/2017 03:20 PM, Peter Xu wrote:
> >>>On Tue, Apr 11, 2017 at 12:10:02PM +0200, Maxime Coquelin wrote:
> >[...]
> >
> >>>>+slave is expected to reply with a zero payload, non-zero otherwise=
.
> >>>Is this ack mechanism really necessary? If not, not sure it'll be ni=
ce
> >>>to keep vhost-user/vhost-kernel aligned on this behavior. At least
> >>>that'll simplify vhost-user implementation on QEMU side (iiuc even
> >>>without introducing new functions for update/invalidate operations).
> >>I think this is necessary, and it won't complexify the vhost-user
> >>implementation on QEMU side, since already widely used (see reply-ack
> >>feature).
> >Could you provide file/function/link pointer to the "reply-ack"
> >feature? I failed to find it myself.
> >
> >>This reply-ack mechanism is used to obtain a behaviour closer to kern=
el
> >>backend. Indeed, when QEMU sends a vhost_msg to the kernel backend, i=
t
> >>is blocked in the write() while the message is being processed in the
> >>Kernel. With user backend, QEMU is unblocked from the write() when th=
e
> >>backend has read the message, before it is being processed.
> >>
> >I see. Then I agree with you that we may need a synchronized way to do
> >it. One thing I think of is IOMMU page invalidation - it should be a
> >sync operation to make sure that all the related caches were destroyed
> >when the invalidation command returns in QEMU vIOMMU emulation path.
> >
>=20
> Looks not, if I understand correctly, e.g for Intel IOMMU, when QI is
> enabled, this could be done asynchronously by not waiting for the compl=
etion
> through wait descriptor. Vhost-kernel always implement the invalidation=
 as a
> synchronous one for simplicity, but looks like this is not needed.

IMHO, the point is guest cannot reuse that IOVA only if it sends a
invalidation wait descriptor. If without wait descriptor, the guest
should never release any IOVA range, if so, that'll be dangerous,
because the cache may still be dirty on that range on specific device.

And since guest will for sure use wait descriptor (as long as it wants
to reuse iova addresses), then we should possibly finally need a way
to synchronously invalidate IOTLB, including to vhost-user backends.

--=20
Peter Xu
