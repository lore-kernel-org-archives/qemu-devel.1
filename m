Received: from eggs.gnu.org ([2001:4830:134:3::10]:49954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVnm-0005Xj-Ka
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eRVni-0003nk-LM
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:16:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eRVni-0003mS-Eh
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 23:16:14 -0500
Date: Wed, 20 Dec 2017 06:16:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171220061340-mutt-send-email-mst@kernel.org>
References: <1513350170-20168-1-git-send-email-den@openvz.org>
	<1513350170-20168-3-git-send-email-den@openvz.org>
	<20171218133812.GD16653@stefanha-x1.localdomain>
	<2B67BF1C-6489-4A9B-BEE5-08DE9B904C07@intel.com>
	<5E82066E-45E4-4627-8EB5-F995FFCB1ADF@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5E82066E-45E4-4627-8EB5-F995FFCB1ADF@nutanix.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio: fix IO request length in
 virtio SCSI/block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: "Harris, James R" <james.r.harris@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Liu, Changpeng" <changpeng.liu@intel.com>

On Mon, Dec 18, 2017 at 07:35:48PM +0000, Felipe Franciosi wrote:
> >> CCed Felipe (Nutanix) and Jim (SPDK) in case they have comments.
> >=20
> > SPDK vhost-user targets only expect max 128 segments.  They also pre-=
allocate I/O task structures when QEMU connects to the vhost-user device.
> >=20
> > Supporting up to 1022 segments would result in significantly higher m=
emory usage, reduction in I/O queue depth processed by the vhost-user tar=
get, or having to dynamically allocate I/O task structures - none of whic=
h are ideal.
> >=20
> > What if this was just bumped from 126 to 128?  I guess I=E2=80=99m tr=
ying to understand the level of guest and host I/O performance that is ga=
ined with this patch.  One I/O per 512KB vs. one I/O per 4MB - we are sti=
ll only talking about a few hundred IO/s difference.
>=20
> SeaBIOS also makes the assumption that the queue size is not bigger tha=
n 128 elements.
> https://review.coreboot.org/cgit/seabios.git/tree/src/hw/virtio-ring.h#=
n23

And what happens if it's bigger? Looks like a bug to me.


> Perhaps a better approach is to make the value configurable (ie. add th=
e "max_segments" property), but set the default to 128-2. In addition to =
what Jim pointed out, I think there may be other legacy front end drivers=
 which can assume the ring will be at most 128 entries in size.
>=20
> With that, hypervisors can choose to bump the value higher if it's know=
n to be safe for their host+guest configuration.
>=20
> Cheers,
> Felipe

For 1.0 guests can just downgrade to 128 if they want to save memory.
So it might make sense to gate this change on 1.0 enabled by guest.


> >=20
> > -Jim
> >=20
> >=20
>=20
