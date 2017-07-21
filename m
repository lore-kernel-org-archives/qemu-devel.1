Received: from eggs.gnu.org ([2001:4830:134:3::10]:54161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1dYYb7-00032m-F7
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1dYYb6-0000uX-KF
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:08:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@redhat.com>) id 1dYYb6-0000rp-E3
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:08:04 -0400
Message-ID: <1500645635.4073.25.camel@redhat.com>
From: Rik van Riel <riel@redhat.com>
Date: Fri, 21 Jul 2017 10:00:35 -0400
In-Reply-To: <46101617.33460557.1500643755247.JavaMail.zimbra@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<945864462.33340808.1500620194836.JavaMail.zimbra@redhat.com>
	<20170721121241.GA18014@stefanha-x1.localdomain>
	<46101617.33460557.1500643755247.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] KVM "fake DAX" flushing interface - discussion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, Dan Williams <dan.j.williams@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On Fri, 2017-07-21 at 09:29 -0400, Pankaj Gupta wrote:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Flush hint address traps from guest=
 to host and do an
> > > entire fsync
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0on backing file which its=
elf is costly.
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- Can be used to flush specific pages=
 on host backing disk.
> > > We can
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0send data(pages informati=
on) equal to cache-line
> > > size(limitation)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0and tell host to sync cor=
responding pages instead of
> > > entire disk
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sync.
> >=20
> > Are you sure?=C2=A0=C2=A0Your previous point says only the entire dev=
ice can
> > be
> > synced.=C2=A0=C2=A0The NVDIMM Adress Flush Hints interface does not i=
nvolve
> > address range information.
>=20
> Just syncing entire block device should be simple but costly.

Costly depends on just how fast the backing IO device is.

If the backing IO is a spinning disk, doing targeted range
syncs will certainly be faster.

On the other hand, if the backing IO is one of the latest
generation SSD devices, it may be faster to have just one
hypercall and flush everything, than it would be to have
separate sync calls for each range that we want flushed.

Should we design our interfaces for yesterday's storage
devices, or for tomorrow's storage devices?
