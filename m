Received: from eggs.gnu.org ([2001:4830:134:3::10]:46865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gWxzU-0003Du-JB
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gWxzR-0003DN-Cb
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:27:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:5733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gWxzR-0002re-2n
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 01:27:25 -0500
Date: Wed, 12 Dec 2018 14:27:07 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20181212062707.GA33447@tiger-server>
References: <cover.1541425595.git.yi.z.zhang@linux.intel.com>
	<20181205095923.GE20933@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205095923.GE20933@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v5 0/7] nvdimm: support MAP_SYNC for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, yu.c.zhang@linux.intel.com, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, ehabkost@redhat.com

On 2018-12-05 at 09:59:23 +0000, Stefan Hajnoczi wrote:
> On Mon, Nov 05, 2018 at 04:07:50PM +0800, Zhang Yi wrote:
> > Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
> > guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
> > files on ext4/xfs file system mounted with '-o dax').
> > 
> 
> Hi,
> There are a lot of people on CC so probably no one felt responsible to
> review this series quickly.  Feel free to send a "ping" email if your
> patches aren't receiving attention.
> 
> Overall this feature looks fine.  I left a few small comments.
> 
> Thanks,
> Stefan

Thanks your review, Stefan, I will post the next version soon.

> 
> > A description of MAP_SYNC and MAP_SHARED_VALIDATE can be found at
> >     https://patchwork.kernel.org/patch/10028151/
> > 
> > In order to make sure that the file metadata is in sync after a fault 
> > while we are writing a shared DAX supporting backend files, this
> > patch-set enables QEMU to use MAP_SYNC flag for memory-backend-dax-file.
> > 
> > As the DAX vs DMA truncated issue was solved, we refined the code and
> > send out this feature for the v5 version.
> > 
> > A new auto on/off option 'sync' is added to memory-backend-file:
> >  - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> >         'share=off', QEMU will abort
> >  - off: never pass MAP_SYNC to mmap(2)
> >  - auto (default): if MAP_SYNC is supported and 'share=on', work as if
> >         'sync=on'; otherwise, work as if 'sync=off'
> > 
> > Changes in v5:
> >  * Add patch 1 to fix a memory leak issue.
> >  * Refine the patch 4-6
> >  * Remove the patch 3 as we already change the parameter from "shared" to
> >    "flags"
> > 
> > Changes in v4:
> >  * Add patch 1-3 to switch some functions to a single 'flags'
> >    parameters. (Michael S. Tsirkin)
> >  * v3 patch 1-3 become v4 patch 4-6.
> >  * Patch 4: move definitions of MAP_SYNC and MAP_SHARED_VALIDATE to a
> >    new header file under include/standard-headers/linux/. (Michael S. Tsirkin)
> >  * Patch 6: refine the description of the 'sync' option. (Michael S. Tsirkin)
> > 
> > Changes in v3:
> >  * Patch 1: add MAP_SHARED_VALIDATE in both sync=on and sync=auto
> >    cases, and add back the retry mechanism. MAP_SYNC will be ignored
> >    by Linux kernel 4.15 if MAP_SHARED_VALIDATE is missed.
> >  * Patch 1: define MAP_SYNC and MAP_SHARED_VALIDATE as 0 on non-Linux
> >    platforms in order to make qemu_ram_mmap() compile on those platforms.
> >  * Patch 2&3: include more information in error messages of
> >    memory-backend in hope to help user to identify the error.
> >    (Dr. David Alan Gilbert)
> >  * Patch 3: fix typo in the commit message. (Dr. David Alan Gilbert)
> > 
> > Changes in v2:
> >  * Add 'sync' option to control the use of MAP_SYNC. (Eduardo Habkost)
> >  * Remove the unnecessary set of MAP_SHARED_VALIDATE in some cases and
> >    the retry mechanism in qemu_ram_mmap(). (Michael S. Tsirkin)
> >  * Move OS dependent definitions of MAP_SYNC and MAP_SHARED_VALIDATE
> >    to osdep.h. (Michael S. Tsirkin)
> > 
> > Zhang Yi (7):
> >   numa: Fixed the memory leak of numa error message
> >   util/mmap-alloc: switch qemu_ram_mmap() to 'flags' parameter
> >   exec: switch qemu_ram_alloc_from_{file, fd} to the 'flags' parameter
> >   util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap()
> >   util/mmap-alloc: Switch the RAM_SYNC flags to OnOffAuto
> >   hostmem: add more information in error messages
> >   hostmem-file: add 'sync' option
> > 
> >  backends/hostmem-file.c               | 45 +++++++++++++++++++++++++++++++++--
> >  backends/hostmem.c                    |  8 ++++---
> >  docs/nvdimm.txt                       | 20 +++++++++++++++-
> >  exec.c                                |  9 +++----
> >  include/exec/memory.h                 | 18 ++++++++++++++
> >  include/exec/ram_addr.h               |  1 +
> >  include/qemu/mmap-alloc.h             | 20 +++++++++++++++-
> >  include/standard-headers/linux/mman.h | 44 ++++++++++++++++++++++++++++++++++
> >  numa.c                                |  1 +
> >  qemu-options.hx                       | 22 ++++++++++++++++-
> >  util/mmap-alloc.c                     | 26 ++++++++++++++++----
> >  util/oslib-posix.c                    |  4 +++-
> >  12 files changed, 200 insertions(+), 18 deletions(-)
> >  create mode 100644 include/standard-headers/linux/mman.h
> > 
> > -- 
> > 2.7.4
> > 
> > 
