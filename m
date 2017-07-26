Received: from eggs.gnu.org ([2001:4830:134:3::10]:38327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1daMex-0008DZ-Qk
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1daMeu-0003JA-NE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1daMeu-0003Ia-EJ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:47:28 -0400
Date: Wed, 26 Jul 2017 09:47:21 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1063764405.34607875.1501076841865.JavaMail.zimbra@redhat.com>
In-Reply-To: <1501016375.26846.21.camel@redhat.com>
References: <1455443283.33337333.1500618150787.JavaMail.zimbra@redhat.com>
	<CAPcyv4hpbk0jgp+mA=q05zVBV8ZSZvCvV68JJ4gjE3QhK70d1w@mail.gmail.com>
	<20170724102330.GE652@quack2.suse.cz>
	<1157879323.33809400.1500897967669.JavaMail.zimbra@redhat.com>
	<20170724123752.GN652@quack2.suse.cz>
	<1888117852.34216619.1500992835767.JavaMail.zimbra@redhat.com>
	<CAPcyv4in28F3FOVKp9abvrggxPuXdbGynF5=ZvBXCrywoa06JA@mail.gmail.com>
	<1501016375.26846.21.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Rik van Riel <riel@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, kvm-devel <kvm@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Ross Zwisler <ross.zwisler@intel.com>


>=20
> On Tue, 2017-07-25 at 07:46 -0700, Dan Williams wrote:
> > On Tue, Jul 25, 2017 at 7:27 AM, Pankaj Gupta <pagupta@redhat.com>
> > wrote:
> > >=20
> > > Looks like only way to send flush(blk dev) from guest to host with
> > > nvdimm
> > > is using flush hint addresses. Is this the correct interface I am
> > > looking?
> > >=20
> > > blkdev_issue_flush
> > > =C2=A0submit_bio_wait
> > > =C2=A0 submit_bio
> > > =C2=A0=C2=A0=C2=A0=C2=A0generic_make_request
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmem_make_request
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(bio->bi_opf & REQ_FLUSH)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0nvdimm_flush(nd_region);
> >=20
> > I would inject a paravirtualized version of pmem_make_request() that
> > sends an async flush operation over virtio to the host. Don't try to
> > use flush hint addresses for this, they don't have the proper
> > semantics. The guest should be allowed to issue the flush and receive
> > the completion asynchronously rather than taking a vm exist and
> > blocking on that request.
>=20
> That is my feeling, too. A slower IO device benefits
> greatly from an asynchronous flush mechanism.

Thanks for all the suggestions!

Just want to summarize here(high level):

This will require implementing new 'virtio-pmem' device which presents=20
a DAX address range(like pmem) to guest with read/write(direct access)
& device flush functionality. Also, qemu should implement corresponding
support for flush using virtio.

Thanks,
Pankaj
>=20
> --
> All rights reversed
