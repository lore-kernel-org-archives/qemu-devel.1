Received: from eggs.gnu.org ([2001:4830:134:3::10]:39274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fCFXO-0002b7-HD
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 22:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fCFXL-00010f-C4
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 22:24:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fCFXL-00010Y-5l
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 22:24:31 -0400
Date: Sat, 28 Apr 2018 10:24:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180428022407.GG13269@xz-mi>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
	<2492f7d8-ed63-6f1c-773f-baa223020022@redhat.com>
	<20180427062615.GY9036@xz-mi>
	<ab60c407-12c7-8872-1d7c-d4f933f12979@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab60c407-12c7-8872-1d7c-d4f933f12979@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On Sat, Apr 28, 2018 at 09:43:54AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B404=E6=9C=8827=E6=97=A5 14:26, Peter Xu wrote:
> > On Fri, Apr 27, 2018 at 01:13:02PM +0800, Jason Wang wrote:
> > >=20
> > > On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 12:51, Peter Xu wrote:
> > > > Add a per-iommu big lock to protect IOMMU status.  Currently the =
only
> > > > thing to be protected is the IOTLB cache, since that can be acces=
sed
> > > > even without BQL, e.g., in IO dataplane.
> > > >=20
> > > > Note that device page tables should not need any protection.  The=
 safety
> > > > of that should be provided by guest OS.  E.g., when a page entry =
is
> > > > freed, the guest OS should be responsible to make sure that no de=
vice
> > > > will be using that page any more.
> > > >=20
> > > > Reported-by: Fam Zheng<famz@redhat.com>
> > > > Signed-off-by: Peter Xu<peterx@redhat.com>
> > > > ---
> > > >    include/hw/i386/intel_iommu.h |  8 ++++++++
> > > >    hw/i386/intel_iommu.c         | 31 +++++++++++++++++++++++++++=
++--
> > > >    2 files changed, 37 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/inte=
l_iommu.h
> > > > index 220697253f..1a8ba8e415 100644
> > > > --- a/include/hw/i386/intel_iommu.h
> > > > +++ b/include/hw/i386/intel_iommu.h
> > > > @@ -262,6 +262,14 @@ struct IntelIOMMUState {
> > > >        uint8_t w1cmask[DMAR_REG_SIZE]; /* RW1C(Write 1 to Clear) =
bytes */
> > > >        uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read r=
eturns 0) */
> > > >        uint32_t version;
> > > > +    /*
> > > > +     * Protects IOMMU states in general.  Normally we don't need=
 to
> > > > +     * take this lock when we are with BQL held.  However we hav=
e code
> > > > +     * paths that may run even without BQL.  In those cases, we =
need
> > > > +     * to take the lock when we have access to IOMMU state
> > > > +     * informations, e.g., the IOTLB.
> > > > +     */
> > > > +    QemuMutex iommu_lock;
> > > Some questions:
> > >=20
> > > 1) Do we need to protect context cache too?
> > IMHO the context cache entry should work even without lock.  That's a
> > bit trickly since we have two cases that this cache will be updated:
> >=20
> >    (1) first translation of the address space of a device
> >    (2) invalidation of context entries
> >=20
> > For (2) IMHO we don't need to worry about since guest OS should be
> > controlling that part, say, device should not be doing any translatio=
n
> > (DMA operations) when the context entry is invalidated.
> >=20
> > For (1) the worst case is that the context entry cache be updated
> > multiple times with the same value by multiple threads.  IMHO that'll
> > be fine too.
> >=20
> > But yes for sure we can protect that too with the iommu lock.
> >=20
> > > 2) Can we just reuse qemu BQL here?
> > I would prefer not.  As I mentioned, at least I have spent too much
> > time on fighting BQL already.  I really hope we can start to use
> > isolated locks when capable.  BQL is always the worst choice to me.
>=20
> Just a thought, using BQL may greatly simplify the code actually (consi=
der
> we don't plan to remove BQL now).

Frankly speaking I don't understand why using BQL may greatly simplify
the code... :( IMHO the lock here is really not a complicated one.

Note that IMO BQL is mostly helpful when we really want something to
be run sequentially with some other things _already_ protected by BQL.
In this case, all the stuff is inside VT-d code itself (or other
IOMMUs), why bother taking the BQL to make our life harder?

So, even if we want to provide a general lock for the translation
procedure, I would prefer we add a per AddressSpace lock but not BQL.
However still that will need some extra flag showing that whether we
need the protection of not.  For example, we may need to expliclitly
turn that off for Power and s390.  Would that really worth it?

So my final preference is still current patch - we solve thread-safety
problems in VT-d and IOMMU code.  Again, we really should make sure
all IOMMUs work with multithreads.

>=20
> >=20
> > > 3) I think the issue is common to all other kinds of IOMMU, so can =
we simply
> > > synchronize before calling ->translate() in memory.c. This seems a =
more
> > > common solution.
> > I suspect Power and s390 live well with that.  I think it mean at
> > least these platforms won't have problem in concurrency.  I'm adding
> > DavidG in loop in case there is further comment.  IMHO we should just
> > make sure IOMMU code be thread safe, and we fix problem if there is.
> >=20
> > Thanks,
> >=20
>=20
> Yes, it needs some investigation, but we have other IOMMUs like AMD, an=
d we
> could have a flag to bypass BQL if IOMMU can synchronize by itself.

AMD is still only for experimental.  If we really want to use it in
production IMHO it'll need more testings and tunings not only on
thread-safety but on other stuffs too.  So again, we can just fix them
when needed.  I still don't see it a reason to depend on BQL here.

I'll see what others think about it.

CCing Paolo, Stefan and Fam too.

Thanks,

--=20
Peter Xu
