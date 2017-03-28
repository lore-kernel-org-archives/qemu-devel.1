Received: from eggs.gnu.org ([2001:4830:134:3::10]:56093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1csgB2-0002Z8-IN
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 21:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1csgAy-000106-Qd
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 21:44:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:63081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1csgAy-0000za-F4
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 21:44:00 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 28 Mar 2017 01:43:53 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B567044@SHSMSX103.ccr.corp.intel.com>
References: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
	<20170327145625.GA24952@lst.de>
In-Reply-To: <20170327145625.GA24952@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: add DISCARD support to
 virtio-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@lst.de>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Monday, March 27, 2017 10:56 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: virtio-dev@lists.oasis-open.org; virtualization@lists.linux-foundatio=
n.org; linux-
> kernel@vger.kernel.org; hch@lst.de; qemu-devel@nongnu.org
> Subject: Re: [PATCH] virtio-blk: add DISCARD support to virtio-blk driver
>=20
> On Tue, Mar 28, 2017 at 04:39:25PM +0800, Changpeng Liu wrote:
> > Currently virtio-blk driver does not provide discard feature flag, so t=
he
> > filesystems which built on top of the block device will not send discar=
d
> > command. This is okay for HDD backend, but it will impact the performan=
ce
> > for SSD backend.
> >
> > Add a feature flag VIRTIO_BLK_F_DISCARD and command
> VIRTIO_BLK_T_DISCARD
> > to extend exist virtio-blk protocol. virtio-blk protocol uses a single
> > 8 bytes descriptor containing type,reserved and sector, currently Linux
> > uses the reserved field as IO priority, here we also re-use the reserve=
d
> > field as number of discard sectors.
>=20
> Do you have a link to the specification for this feature?  At least
> virtio-v1.0 does not seem to specify a discard feature.
Not yet, patch goes first, there are uses who don't want to migrate from vi=
rtio-blk to virtio-scsi,
so this feature seems reasonable, the question is that how we should define=
 the specification to
support this feature.
>=20
> Note that Linux 4.11 and later have support for multi-range discard
> ala ATA TRIM, SCSI UNMAP and NVMe deallocate which might be useful
> here, too.
For support multi-range discard features, the DISCARD command must have dat=
a_in buffer, similar with
SCSI UNMAP and NVMe DEALLOCATE commands, maybe 16 bytes aligned descriptors=
 are required for each
DISCARD command.
>=20
> > +		q->limits.discard_zeroes_data =3D 0;
>=20
> No need to clear this.  Also hopefully this field goes away for 4.12
>=20
> > +		blk_queue_max_discard_segments(q, 1);
>=20
> No need to set this.
