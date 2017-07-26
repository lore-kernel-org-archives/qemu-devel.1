Received: from eggs.gnu.org ([2001:4830:134:3::10]:40136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1daW0k-0004SE-Jv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1daW0f-0005Zq-Lm
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:46:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@redhat.com>) id 1daW0f-0005ZI-C9
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 19:46:33 -0400
Message-ID: <1501112787.4073.49.camel@redhat.com>
From: Rik van Riel <riel@redhat.com>
Date: Wed, 26 Jul 2017 19:46:27 -0400
In-Reply-To: <CAPcyv4hsqrqBxoipUHPAbSctuzbVWCRnT-gN08i9uhXTWY6iPQ@mail.gmail.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
	<1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
	<CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
	<1501016375.26846.21.camel@redhat.com>
	<1063764405.34607875.1501076841865.JavaMail.zimbra@redhat.com>
	<1501104453.26846.45.camel@redhat.com>
	<CAPcyv4hsqrqBxoipUHPAbSctuzbVWCRnT-gN08i9uhXTWY6iPQ@mail.gmail.com>
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>

On Wed, 2017-07-26 at 14:40 -0700, Dan Williams wrote:
> On Wed, Jul 26, 2017 at 2:27 PM, Rik van Riel <riel@redhat.com>
> wrote:
> > On Wed, 2017-07-26 at 09:47 -0400, Pankaj Gupta wrote:
> > > >=20
> > >=20
> > > Just want to summarize here(high level):
> > >=20
> > > This will require implementing new 'virtio-pmem' device which
> > > presents
> > > a DAX address range(like pmem) to guest with read/write(direct
> > > access)
> > > & device flush functionality. Also, qemu should implement
> > > corresponding
> > > support for flush using virtio.
> > >=20
> >=20
> > Alternatively, the existing pmem code, with
> > a flush-only block device on the side, which
> > is somehow associated with the pmem device.
> >=20
> > I wonder which alternative leads to the least
> > code duplication, and the least maintenance
> > hassle going forward.
>=20
> I'd much prefer to have another driver. I.e. a driver that refactors
> out some common pmem details into a shared object and can attach to
> ND_DEVICE_NAMESPACE_{IO,PMEM}. A control device on the side seems
> like
> a recipe for confusion.

At that point, would it make sense to expose these special
virtio-pmem areas to the guest in a slightly different way,
so the regions that need virtio flushing are not bound by
the regular driver, and the regular driver can continue to
work for memory regions that are backed by actual pmem in
the host?

> With a $new_driver in hand you can just do:
>=20
> =C2=A0=C2=A0=C2=A0modprobe $new_driver
> =C2=A0=C2=A0=C2=A0echo $namespace > /sys/bus/nd/drivers/nd_pmem/unbind
> =C2=A0=C2=A0=C2=A0echo $namespace > /sys/bus/nd/drivers/$new_driver/new=
_id
> =C2=A0=C2=A0=C2=A0echo $namespace > /sys/bus/nd/drivers/$new_driver/bin=
d
>=20
> ...and the guest can arrange for $new_driver to be the default, so
> you
> don't need to do those steps each boot of the VM, by doing:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0echo "blacklist nd_pmem" > /etc/modprobe.d/virt=
-dax-flush.conf
> =C2=A0=C2=A0=C2=A0=C2=A0echo "alias nd:t4* $new_driver" >> /etc/modprob=
e.d/virt-dax-
> flush.conf
> =C2=A0=C2=A0=C2=A0=C2=A0echo "alias nd:t5* $new_driver" >> /etc/modprob=
e.d/virt-dax-
> flush.conf
