Received: from eggs.gnu.org ([2001:4830:134:3::10]:49306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fG49U-0004jP-38
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fG49O-0005VU-Ai
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:03:40 -0400
Date: Tue, 8 May 2018 17:03:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180508150309.GC4065@localhost.localdomain>
References: <1514187226.13662.28.camel@intel.com>
	<6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] Some question about savem/qcow2
 incremental snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: He Junyan <junyan.he@intel.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu block <qemu-block@nongnu.org>, stefanha@redhat.com

Am 08.05.2018 um 16:41 hat Eric Blake geschrieben:
> On 12/25/2017 01:33 AM, He Junyan wrote:
> > hi all:
> >=20
> > I am now focusing on snapshot optimization for Intel NVDimm kind
> > memory. Different from the normal memory, the NVDimm may be 128G, 256=
G
> > or even more for just one guest, and its speed is slower than the
> > normal memory. So sometimes it may take several minutes to complete
> > just one snapshot saving. Even with compression enabled, the=A0snapsh=
ot
> > point may consume more than 30G disk space.
> > We decide to add incremental kind snapshot saving to resolve this. Ju=
st
> > store difference between snapshot points to save time and disk space.
> > But the current snapshot/save_vm framework seems not to support this.
> > We need to add snapshot dependency and extra operations when we LOAD
> > and DELETE the snapshot point.
> > Is that possible to modify the savevm framework and add some
> > incremental snapshot support to QCOW2 format?
>=20
> In general, the list has tended to focus on external snapshots rather t=
han
> internal; where persistent bitmaps have been the proposed mechanism for
> tracking incremental differences between snapshots.  But yes, it is
> certainly feasible that patches to improve internal snapshots to take
> advantage of incremental relationships may prove useful.  You will need=
 to
> document all enhancements to the qcow2 file format and get that approve=
d
> first, as interoperability demands that others reading the same spec wo=
uld
> be able to interpret the image you create that is utilizing an internal
> snapshot with an incremental diff.

Snapshots are incremental by their very nature. That is, the snapshot of
the disk content is incremental. We don't diff VM state. Persistent
bitmaps are a completely separate thing.

I may be misunderstanding the problem, but to me it sounds as if the
content of the nvdimm device ended up in the VM state, which is stored
in a (non-nvdimm) qcow2 image. Having the nvdimm in the VM state is
certainly not the right approach. Instead, it needs to be treated like
a block device.

What I believe you really need is two things:

1. Stop the nvdimm from ending up in the VM state. This should be fairly
   easy.

2. Make the nvdimm device use the QEMU block layer so that it is backed
   by a non-raw disk image (such as a qcow2 file representing the
   content of the nvdimm) that supports snapshots.

   This part is hard because it requires some completely new
   infrastructure such as mapping clusters of the image file to guest
   pages, and doing cluster allocation (including the copy on write
   logic) by handling guest page faults.

I think it makes sense to invest some effort into such interfaces, but
be prepared for a long journey.

Kevin
