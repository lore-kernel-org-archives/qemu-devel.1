Received: from eggs.gnu.org ([2001:4830:134:3::10]:59546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNex8-0005pq-Ux
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dNex5-0008CS-RT
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:41:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dNex5-0008CA-Iw
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:41:43 -0400
Date: Wed, 21 Jun 2017 15:41:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170621153055-mutt-send-email-mst@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
	<1497977049.20270.100.camel@redhat.com>
	<7b626551-6d1b-c8d5-4ef7-e357399e78dc@redhat.com>
	<1497979740.20270.102.camel@redhat.com>
	<20170620212107-mutt-send-email-mst@kernel.org>
	<1497988260.20270.109.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1497988260.20270.109.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rik van Riel <riel@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, Nitesh Narayan Lal <nilal@redhat.com>

On Tue, Jun 20, 2017 at 03:51:00PM -0400, Rik van Riel wrote:
> On Tue, 2017-06-20 at 21:26 +0300, Michael S. Tsirkin wrote:
> > On Tue, Jun 20, 2017 at 01:29:00PM -0400, Rik van Riel wrote:
> > > I agree with that.=A0=A0Let me go into some more detail of
> > > what Nitesh is implementing:
> > >=20
> > > 1) In arch_free_page, the being-freed page is added
> > > =A0=A0=A0to a per-cpu set of freed pages.
> > > 2) Once that set is full, arch_free_pages goes into a
> > > =A0=A0=A0slow path, which:
> > > =A0=A0=A02a) Iterates over the set of freed pages, and
> > > =A0=A0=A02b) Checks whether they are still free, and
> > > =A0=A0=A02c) Adds the still free pages to a list that is
> > > =A0=A0=A0=A0=A0=A0=A0to be passed to the hypervisor, to be MADV_FRE=
Ed.
> > > =A0=A0=A02d) Makes that hypercall.
> > >=20
> > > Meanwhile all arch_alloc_pages has to do is make sure it
> > > does not allocate a page while it is currently being
> > > MADV_FREEd on the hypervisor side.
> > >=20
> > > The code Wei is working on looks like it could be=A0
> > > suitable for steps (2c) and (2d) above. Nitesh already
> > > has code for steps 1 through 2b.
> >=20
> > So my question is this: Wei posted these numbers for balloon
> > inflation times:
> > inflating 7GB of an 8GB idle guest:
> >=20
> > 	1) allocating pages (6.5%)
> > 	2) sending PFNs to host (68.3%)
> > 	3) address translation (6.1%)
> > 	4) madvise (19%)
> >=20
> > 	It takes about 4126ms for the inflating process to complete.
> >=20
> > It seems that this is an excessive amount of time to stay
> > under a lock. What are your estimates for Nitesh's work?
>=20
> That depends on the batch size used for step
> (2c), and is something that we should be able
> to tune for decent performance.

I am not really sure how you intend to do this. Who will
drop and retake the lock? How do you make progress
instead of restarting from the beginning?
How do you combine multiple pages in a single s/g?

All these were issues that Wei's patches solved,
granted in a very limited manner (migration-specific)
but OTOH without a lot of tuning.


> What seems to matter is that things are batched.
> There are many ways to achieve that.

True, this is what the patches are trying to achieve.  So far this
approach was the 1st more or less workable way do achieve that,
previous ones got us nowhere.


> --=20
> All rights reversed
