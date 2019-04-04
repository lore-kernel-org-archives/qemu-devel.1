Received: from eggs.gnu.org ([209.51.188.92]:60753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hC014-00044p-9r
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hBzyn-0004f7-0g
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hBzym-0004WK-L6
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:52:20 -0400
Date: Thu, 4 Apr 2019 06:52:16 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <511760533.17430856.1554375136102.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190404095649.GB8738@angband.pl>
References: <20190403104018.23947-1-pagupta@redhat.com>
	<20190403104018.23947-6-pagupta@redhat.com>
	<20190403220912.GB26298@dastard>
	<1518295599.17367903.1554358350929.JavaMail.zimbra@redhat.com>
	<20190404095649.GB8738@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 5/5] xfs: disable map_sync for async
 flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Dave Chinner <david@fromorbit.com>, darrick wong <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, dan j williams <dan.j.williams@intel.com>, zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>, dave jiang <dave.jiang@intel.com>, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger kernel <adilger.kernel@dilger.ca>, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, cohuck@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>


>=20
> On Thu, Apr 04, 2019 at 02:12:30AM -0400, Pankaj Gupta wrote:
> > > All this ad hoc IS_DAX conditional logic is getting pretty nasty.
> > >=20
> > > xfs_file_mmap(
> > > ....
> > > {
> > > =09struct inode=09*inode =3D file_inode(filp);
> > >=20
> > > =09if (vma->vm_flags & VM_SYNC) {
> > > =09=09if (!IS_DAX(inode))
> > > =09=09=09return -EOPNOTSUPP;
> > > =09=09if (!dax_synchronous(xfs_find_daxdev_for_inode(inode))
> > > =09=09=09return -EOPNOTSUPP;
> > > =09}
> > >=20
> > > =09file_accessed(filp);
> > > =09vma->vm_ops =3D &xfs_file_vm_ops;
> > > =09if (IS_DAX(inode))
> > > =09=09vma->vm_flags |=3D VM_HUGEPAGE;
> > > =09return 0;
> > > }
> >=20
> > Sure, this is better.
>=20
> > > Even better, factor out all the "MAP_SYNC supported" checks into a
> > > helper so that the filesystem code just doesn't have to care about
> > > the details of checking for DAX+MAP_SYNC support....
> >=20
> > o.k. Will add one common helper function for both ext4 & xfs filesystem=
s.
>=20
> Note this pending patch for Goldwyn Rodrigues' patchset for btrfs:
>=20
> https://lore.kernel.org/linux-btrfs/20190328102418.5466-1-kilobyte@angban=
d.pl/
>=20
> We might want to coordinate.

Sure. Good to know.

Thanks for the pointer. Will have a look.

Best regards,
Pankaj=20

>=20
>=20
> Meow!
> --
> =E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
> =E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 Did ya kn=
ow that typing "test -j8" instead of "ctest -j8"
> =E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 will make=
 your testsuite pass much faster, and fix bugs?
> =E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80
>=20
