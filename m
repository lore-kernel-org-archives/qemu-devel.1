Received: from eggs.gnu.org ([2001:4830:134:3::10]:37335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1e2lx8-0004eL-6z
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1e2lx5-0001Vj-3w
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:27:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@redhat.com>) id 1e2lx4-0001Uz-Rx
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:27:39 -0400
Message-ID: <1507847249.21121.207.camel@redhat.com>
From: Rik van Riel <riel@redhat.com>
Date: Thu, 12 Oct 2017 18:27:29 -0400
In-Reply-To: <1363955128.19944709.1507846719987.JavaMail.zimbra@redhat.com>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<CAPcyv4i7k6aYK_y4zZtL6p8sW-E_Ft58d2HuxO=dYciqQxaoLg@mail.gmail.com>
	<1567317495.19940236.1507843517318.JavaMail.zimbra@redhat.com>
	<CAPcyv4gkri7t+3Unf0sc9AHMnz-v9G_qV_bJppLjUUNAn7drrQ@mail.gmail.com>
	<1363955128.19944709.1507846719987.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 2/2] KVM: add virtio-pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, KVM list <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Nitesh Narayan Lal <nilal@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ross Zwisler <ross.zwisler@intel.com>, David Hildenbrand <david@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Thu, 2017-10-12 at 18:18 -0400, Pankaj Gupta wrote:
> >=20
> > On Thu, Oct 12, 2017 at 2:25 PM, Pankaj Gupta <pagupta@redhat.com>
> > wrote:
> > >=20
> > > > > =C2=A0 This patch adds virtio-pmem driver for KVM guest.
> > > > > =C2=A0 Guest reads the persistent memory range information
> > > > > =C2=A0 over virtio bus from Qemu and reserves the range
> > > > > =C2=A0 as persistent memory. Guest also allocates a block
> > > > > =C2=A0 device corresponding to the pmem range which later
> > > > > =C2=A0 can be accessed with DAX compatible file systems.
> > > > > =C2=A0 Idea is to use the virtio channel between guest and
> > > > > =C2=A0 host to perform the block device flush for guest pmem
> > > > > =C2=A0 DAX device.
> > > > >=20
> > > > > =C2=A0 There is work to do including DAX file system support
> > > > > =C2=A0 and other advanced features.
> > > > >=20
> > > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > > > ---
> > > > > =C2=A0drivers/virtio/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A010 ++
> > > > > =C2=A0drivers/virtio/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> > > > > =C2=A0drivers/virtio/virtio_pmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
| 322
> > > > > =C2=A0+++++++++++++++++++++++++++++++++++++++
> > > > > =C2=A0include/uapi/linux/virtio_pmem.h |=C2=A0=C2=A055 +++++++
> > > > > =C2=A04 files changed, 388 insertions(+)
> > > > > =C2=A0create mode 100644 drivers/virtio/virtio_pmem.c
> > > > > =C2=A0create mode 100644 include/uapi/linux/virtio_pmem.h
> > > > >=20
> > > > > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > > > > index cff773f15b7e..0192c4bda54b 100644
> > > > > --- a/drivers/virtio/Kconfig
> > > > > +++ b/drivers/virtio/Kconfig
> > > > > @@ -38,6 +38,16 @@ config VIRTIO_PCI_LEGACY
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0If =
unsure, say Y.
> > > > >=20
> > > > > +config VIRTIO_PMEM
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "Virtio pme=
m driver"
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on VIRTIO
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0---help---
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This driver ad=
ds persistent memory range within a
> > > > > KVM guest.

With "Virtio Block Backed Pmem" we could name the config
option VIRTIO_BLOCK_PMEM

The documentation text could make it clear to people that the
image shows up as a disk image on the host, but as a pmem
memory range in the guest.

> > > > I think we need to call this something other than persistent
> > > > memory to
> > > > make it clear that this not memory where the persistence can be
> > > > managed from userspace. The persistence point always requires
> > > >=20
> > So currently /proc/iomem in a guest with a pmem device attached to
> > a
> > namespace looks like this:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0c00000000-13bfffffff : Persistent Memory
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c00000000-13bfffffff : name=
space2.0
> >=20
> > Can we call it "Virtio Shared Memory" to make it clear it is a
> > different beast than typical "Persistent Memory"?=C2=A0=C2=A0You can =
likely
>=20
> I think somewhere we need persistent keyword 'Virtio Persistent
> Memory' or=C2=A0
> so.

Still hoping for better ideas than "Virtio Block Backed Pmem" :)
