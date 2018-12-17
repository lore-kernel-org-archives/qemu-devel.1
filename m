Received: from eggs.gnu.org ([2001:4830:134:3::10]:45702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gYlr2-000258-UD
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 00:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gYlqz-0006PH-ON
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 00:54:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:34203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gYlqz-0006IS-4m
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 00:54:09 -0500
Date: Mon, 17 Dec 2018 13:53:54 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20181217055354.GA67329@tiger-server>
References: <cover.1544598069.git.yi.z.zhang@linux.intel.com>
	<20181212100106-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212100106-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH V6 0/6] nvdimm: support MAP_SYNC for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xiaoguangrong.eric@gmail.com, dan.j.williams@intel.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com

On 2018-12-12 at 10:06:13 -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 12, 2018 at 04:11:44PM +0800, Zhang Yi wrote:
> > Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
> > guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
> > files on ext4/xfs file system mounted with '-o dax').
> > 
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
> 
> Can this change be limited to a real DAX device?
> Then you won't need to bother with flags at all.
Thanks Micheal's review,

For real dax device, we still need to have a option to turn sync off.
> 
> And am I mistaken in thinking that this will affect all
> guest memory with share=on? Or do I misunderstand?

Only file-backend memory with share=on.
> 
> 
> 
> > Changes in v6:
> >  * Pankaj: 3/7 are squashed with 2/7
> >  * Pankaj: 7/7 update comments to "consistent filesystem metadata".
> >  * Pankaj, Igor: 1/7 Added Reviewed-by in patch-1/7
> >  * Stefan, 4/7 move the include header from "/linux/mman.h" to "osdep.h"
> >  * Stefan, 5/7 Add missing "munmap"
> >  * Stefan, 2/7 refine the shared/flag.
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
> > Zhang Yi (6):
> >   numa: Fixed the memory leak of numa error message
> >   util/mmap-alloc: switch qemu_ram_mmap() to 'flags' parameter
> >   util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap()
> >   util/mmap-alloc: Switch the RAM_SYNC flags to OnOffAuto
> >   hostmem: add more information in error messages
> >   hostmem-file: add 'sync' option
> > 
> >  backends/hostmem-file.c   | 45 +++++++++++++++++++++++++++++++++++++++++++--
> >  backends/hostmem.c        |  8 +++++---
> >  docs/nvdimm.txt           | 20 +++++++++++++++++++-
> >  exec.c                    |  9 +++++----
> >  include/exec/memory.h     | 18 ++++++++++++++++++
> >  include/exec/ram_addr.h   |  1 +
> >  include/qemu/mmap-alloc.h | 20 +++++++++++++++++++-
> >  include/qemu/osdep.h      | 29 +++++++++++++++++++++++++++++
> >  numa.c                    |  1 +
> >  qemu-options.hx           | 22 +++++++++++++++++++++-
> >  util/mmap-alloc.c         | 26 +++++++++++++++++++++-----
> >  util/oslib-posix.c        |  8 +++++++-
> >  12 files changed, 189 insertions(+), 18 deletions(-)
> > 
> > -- 
> > 2.7.4
