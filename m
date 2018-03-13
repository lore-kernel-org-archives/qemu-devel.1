Received: from eggs.gnu.org ([2001:4830:134:3::10]:41569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evgM4-0004lL-Im
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evgM0-0004qJ-0u
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:36:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1evgLz-0004pl-R1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 05:36:19 -0400
Date: Tue, 13 Mar 2018 09:36:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180313093600.GA3548@work-vm>
References: <20180228072558.7434-1-haozhong.zhang@intel.com>
	<20180312153954.GA24440@stefanha-x1.localdomain>
	<20180313001150.gtbs4jz4degeblba@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313001150.gtbs4jz4degeblba@hz-desktop>
Subject: Re: [Qemu-devel] [PATCH v4 0/8] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>

* Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> On 03/12/18 15:39 +0000, Stefan Hajnoczi wrote:
> > On Wed, Feb 28, 2018 at 03:25:50PM +0800, Haozhong Zhang wrote:
> > > QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
> > > live migration. If the backend is on the persistent memory, QEMU needs
> > > to take proper operations to ensure its writes persistent on the
> > > persistent memory. Otherwise, a host power failure may result in the
> > > loss the guest data on the persistent memory.
> > > 
> > > This v3 patch series is based on Marcel's patch "mem: add share
> > > parameter to memory-backend-ram" [1] because of the changes in patch 1.
> > > 
> > > [1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html
> > > 
> > > Previous versions can be found at
> > > v3: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
> > > v2: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
> > > v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html
> > > 
> > > Changes in v4:
> > >  * (Patch 2) Fix compilation errors found by patchew.
> > > 
> > > Changes in v3:
> > >  * (Patch 5) Add a is_pmem flag to ram_handle_compressed() and handle
> > >    PMEM writes in it, so we don't need the _common function.
> > >  * (Patch 6) Expose qemu_get_buffer_common so we can remove the
> > >    unnecessary qemu_get_buffer_to_pmem wrapper.
> > >  * (Patch 8) Add a is_pmem flag to xbzrle_decode_buffer() and handle
> > >    PMEM writes in it, so we can remove the unnecessary
> > >    xbzrle_decode_buffer_{common, to_pmem}.
> > >  * Move libpmem stubs to stubs/pmem.c and fix the compilation failures
> > >    of test-{xbzrle,vmstate}.c.
> > > 
> > > Changes in v2:
> > >  * (Patch 1) Use a flags parameter in file ram allocation functions.
> > >  * (Patch 2) Add a new option 'pmem' to hostmem-file.
> > >  * (Patch 3) Use libpmem to operate on the persistent memory, rather
> > >    than re-implementing those operations in QEMU.
> > >  * (Patch 5-8) Consider the write persistence in the migration path.
> > > 
> > > Haozhong Zhang (8):
> > >   [1/8] memory, exec: switch file ram allocation functions to 'flags' parameters
> > >   [2/8] hostmem-file: add the 'pmem' option
> > >   [3/8] configure: add libpmem support
> > >   [4/8] mem/nvdimm: ensure write persistence to PMEM in label emulation
> > >   [5/8] migration/ram: ensure write persistence on loading zero pages to PMEM
> > >   [6/8] migration/ram: ensure write persistence on loading normal pages to PMEM
> > >   [7/8] migration/ram: ensure write persistence on loading compressed pages to PMEM
> > >   [8/8] migration/ram: ensure write persistence on loading xbzrle pages to PMEM
> > > 
> > >  backends/hostmem-file.c             | 27 +++++++++++++++++++-
> > >  configure                           | 35 ++++++++++++++++++++++++++
> > >  docs/nvdimm.txt                     | 14 +++++++++++
> > >  exec.c                              | 20 ++++++++++++---
> > >  hw/mem/nvdimm.c                     |  9 ++++++-
> > >  include/exec/memory.h               | 12 +++++++--
> > >  include/exec/ram_addr.h             | 28 +++++++++++++++++++--
> > >  include/migration/qemu-file-types.h |  2 ++
> > >  include/qemu/pmem.h                 | 27 ++++++++++++++++++++
> > >  memory.c                            |  8 +++---
> > >  migration/qemu-file.c               | 29 ++++++++++++++--------
> > >  migration/ram.c                     | 49 +++++++++++++++++++++++++++----------
> > >  migration/ram.h                     |  2 +-
> > >  migration/rdma.c                    |  2 +-
> > >  migration/xbzrle.c                  |  8 ++++--
> > >  migration/xbzrle.h                  |  3 ++-
> > >  numa.c                              |  2 +-
> > >  qemu-options.hx                     |  9 ++++++-
> > >  stubs/Makefile.objs                 |  1 +
> > >  stubs/pmem.c                        | 37 ++++++++++++++++++++++++++++
> > >  tests/Makefile.include              |  4 +--
> > >  tests/test-xbzrle.c                 |  4 +--
> > >  22 files changed, 285 insertions(+), 47 deletions(-)
> > >  create mode 100644 include/qemu/pmem.h
> > >  create mode 100644 stubs/pmem.c
> > 
> > A few thoughts:
> > 
> > 1. Can you use pmem_is_pmem() to auto-detect the pmem=on|off value?
> 
> The manpage [1] of pmem_is_pmem says:
> 
>  "The result of pmem_is_pmem() query is only valid for the mappings
>   created using pmem_map_file().  For other memory regions, in
>   particular those created by a direct call to mmap(2), pmem_is_pmem()
>   always returns false, even if the queried range is entirely
>   persistent memory."
> 
> QEMU is using mmap for NVDIMM mapping, so pmem_is_pmem does not work.
> 
> [1] http://pmem.io/pmdk/manpages/linux/master/libpmem/pmem_is_pmem.3#caveats
> 
> > 
> > 2. The migration/ram code is invasive.  Is it really necessary to
> >    persist data each time pages are loaded from a migration stream?  It
> >    seems simpler to migrate as normal and call pmem_persist() just once
> >    after RAM has been migrated but before the migration completes.
> 
> The concern is about the overhead of cache flush.
> 
> In this patch series, if possible, QEMU will use pmem_mem{set,cpy}_nodrain
> APIs to copy NVDIMM blocks. Those APIs use movnt (if it's available) and
> can avoid the subsequent cache flush.
> 
> Anyway, I'll make some microbenchmark to check which one will be better.

The problem is not just the overhead; the problem is the code
complexity; this series makes all the paths through the migration code
more complex in places we wouldn't expect to change.

> 
> > 
> > 3. This is independent of this patch series and can be done later.
> >    NVDIMM seems incompatible with post-copy live migration.  It would be
> >    good to have a postcopy_add_blocker() API so that a nice error
> >    message is printed if post-copy live migration is attempted.
> 
> Post-copy with NVDIMM currently fails with message "Postcopy on shared
> RAM (...) is not yet supported". Is it enough?

Once shared support arrives (see my patch series) that check goes
though; it might get trapped by one of the other checks though as well;
I'll need to try simulated pmem to find out.

Dave

> > 
> > The code itself seems fine though:
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Thanks,
> Haozhong
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
