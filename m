Received: from eggs.gnu.org ([2001:4830:134:3::10]:38114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejUbF-0003gL-Cl
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejUbA-0007fV-LK
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:37:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ejUbA-0007fP-Fk
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:37:36 -0500
Date: Wed, 7 Feb 2018 18:37:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180207183717.GW2665@work-vm>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
	<20180207073331.14158-8-haozhong.zhang@intel.com>
	<20180207115406.GD2665@work-vm>
	<20180207121525.5pyrld36k5xbm373@hz-desktop>
	<20180207130355.GH2665@work-vm>
	<20180207132023.yuf2lp3jrhg2qytz@hz-desktop>
	<20180207132412.GJ2665@work-vm>
	<CAPcyv4j7s6M6RNKKOQqrOkovsp0Z4uAXFjURBeG5QSp_-uzm+w@mail.gmail.com>
	<20180207180848.GU2665@work-vm>
	<CAPcyv4jyxDwfODnKL-jvbMboCQVQv41+ts98PkyjP8n_Vn_+nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jyxDwfODnKL-jvbMboCQVQv41+ts98PkyjP8n_Vn_+nw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/8] migration/ram: ensure write
 persistence on loading compressed pages to PMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

* Dan Williams (dan.j.williams@intel.com) wrote:
> On Wed, Feb 7, 2018 at 10:08 AM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > * Dan Williams (dan.j.williams@intel.com) wrote:
> >> On Wed, Feb 7, 2018 at 5:24 AM, Dr. David Alan Gilbert
> >> <dgilbert@redhat.com> wrote:
> >> > * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> >> >> On 02/07/18 13:03 +0000, Dr. David Alan Gilbert wrote:
> >> >> > * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> >> >> > > On 02/07/18 11:54 +0000, Dr. David Alan Gilbert wrote:
> >> >> > > > * Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> >> >> > > > > When loading a compressed page to persistent memory, flush CPU cache
> >> >> > > > > after the data is decompressed. Combined with a call to pmem_drain()
> >> >> > > > > at the end of memory loading, we can guarantee those compressed pages
> >> >> > > > > are persistently loaded to PMEM.
> >> >> > > >
> >> >> > > > Can you explain why this can use the flush and doesn't need the special
> >> >> > > > memset?
> >> >> > >
> >> >> > > The best approach to ensure the write persistence is to operate pmem
> >> >> > > all via libpmem, e.g., pmem_memcpy_nodrain() + pmem_drain(). However,
> >> >> > > the write to pmem in this case is performed by uncompress() which is
> >> >> > > implemented out of QEMU and libpmem. It may or may not use libpmem,
> >> >> > > which is not controlled by QEMU. Therefore, we have to use the less
> >> >> > > optimal approach, that is to flush cache for all pmem addresses that
> >> >> > > uncompress() may have written, i.e.,/e.g., memcpy() and/or memset() in
> >> >> > > uncompress(), and pmem_flush() + pmem_drain() in QEMU.
> >> >> >
> >> >> > In what way is it less optimal?
> >> >> > If that's a legal thing to do, then why not just do a pmem_flush +
> >> >> > pmem_drain right at the end of the ram loading and leave all the rest of
> >> >> > the code untouched?
> >> >>
> >> >> For example, the implementation pmem_memcpy_nodrain() prefers to use
> >> >> movnt instructions w/o flush to write pmem if those instructions are
> >> >> available, and falls back to memcpy() + flush if movnt are not
> >> >> available, so I suppose the latter is less optimal.
> >> >
> >> > But if you use normal memcpy calls to copy a few GB of RAM in an
> >> > incoming migrate and then do a single flush at the end, isn't that
> >> > better?
> >>
> >> Not really, because now you've needlessly polluted the cache and are
> >> spending CPU looping over the cachelines that could have been bypassed
> >> with movnt.
> >
> > What's different in the pmem case?   Isn't what you've said true in the
> > normal migrate case as well?
> >
> 
> In the normal migrate case the memory is volatile so once the copy is
> globally visiable you're done. In the pmem case the migration is not
> complete until the persistent state is synchronized.
> 
> Note, I'm talking in generalities because I don't know the deeper
> details of the migrate flow.

On the receive side of a migrate, during a normal precopy migrate
(without xbzrle) nothing is going to be reading that RAM until
the whole RAM load has completed anyway - so we're not benefiting from
it being in the caches either.

In the pmem case, again since nothing is going to be reading from that
RAM until the end anyway, why bother flushing as we go as opposed to at
the end?

Note, I'm also talking generalities because I don't know the deeper
details of the pmem flow. Hmm.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
