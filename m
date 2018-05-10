Received: from eggs.gnu.org ([2001:4830:134:3::10]:39639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1fGbD6-0004DR-AU
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@intel.com>) id 1fGbD2-0002Pg-DQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:21:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:29438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@intel.com>) id 1fGbD2-0002P4-2Z
	for qemu-devel@nongnu.org; Wed, 09 May 2018 22:21:32 -0400
From: "He, Junyan" <junyan.he@intel.com>
Date: Thu, 10 May 2018 02:21:26 +0000
Message-ID: <EC8A4E314CF1574AB62C80421BD9833934038054@SHSMSX104.ccr.corp.intel.com>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
In-Reply-To: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V5 0/9] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "rth@twiddle.net" <rth@twiddle.net>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "Zhang, Haozhong" <haozhong.zhang@intel.com>

> > >=20
> > > 2. The migration/ram code is invasive.  Is it really necessary to
> > >    persist data each time pages are loaded from a migration stream?  =
It
> > >    seems simpler to migrate as normal and call pmem_persist() just on=
ce
> > >    after RAM has been migrated but before the migration completes.
> >=20
> > The concern is about the overhead of cache flush.
> >
> > In this patch series, if possible, QEMU will use pmem_mem{set,cpy}_nodr=
ain
> > APIs to copy NVDIMM blocks. Those APIs use movnt (if it's available) an=
d
> > can avoid the subsequent cache flush.
> >=20
> > Anyway, I'll make some microbenchmark to check which one will be better=
.

> The problem is not just the overhead; the problem is the code
> complexity; this series makes all the paths through the migration code
> more complex in places we wouldn't expect to change.

About this issue, I do the job like this:
Disable all haozhong's pmem_drain and  pmem_memset_nodrain  kind function c=
all
and make the cleanup function do the flush job like this:
=09
static int ram_load_cleanup(void *opaque)
{
    RAMBlock *rb;
    RAMBLOCK_FOREACH(rb) {
        if (ramblock_is_pmem(rb)) {
            pmem_persist(rb->host, rb->used_length);
         }
    }

    xbzrle_load_cleanup();
    compress_threads_load_cleanup();

    RAMBLOCK_FOREACH(rb) {
        g_free(rb->receivedmap);
        rb->receivedmap =3D NULL;
    }
    return 0;
}


The migrate info result is:

Haozhong's Manner

(qemu) migrate -d tcp:localhost:4444
(qemu) info migrate
globals:
store-global-state: on
only-migratable: off=20
send-configuration: on
send-section-footer: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks:=
 off compress: off events: off postcopy-ram: off x-colo: off release-ram: o=
ff block: off return-path: off pause-before-switchover: off x-multifd: off =
dirty-bitmaps: off postcopy-blocktime: off
Migration status: completed
total time: 333668 milliseconds
downtime: 17 milliseconds
setup: 50 milliseconds
transferred ram: 10938039 kbytes
throughput: 268.55 mbps
remaining ram: 0 kbytes
total ram: 11027272 kbytes
duplicate: 35533 pages
skipped: 0 pages
normal: 2729095 pages
normal bytes: 10916380 kbytes
dirty sync count: 4
page size: 4 kbytes
(qemu)


flush before complete

QEMU 2.12.50 monitor - type 'help' for more information
(qemu) migrate -d tcp:localhost:4444
(qemu) info migrate
globals:
store-global-state: on
only-migratable: off=20
send-configuration: on
send-section-footer: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks:=
 off compress: off events: off postcopy-ram: off x-colo: off release-ram: o=
ff block: off return-path: off pause-before-switchover: off x-multifd: off =
dirty-bitmaps: off postcopy-blocktime: off
Migration status: completed
total time: 334836 milliseconds
downtime: 17 milliseconds
setup: 49 milliseconds
transferred ram: 10978886 kbytes
throughput: 268.62 mbps
remaining ram: 0 kbytes
total ram: 11027272 kbytes
duplicate: 23149 pages
skipped: 0 pages
normal: 2739314 pages
normal bytes: 10957256 kbytes
dirty sync count: 4
page size: 4 kbytes
(qemu)



So Haozhong's manner seems to be a little faster and I choose to keep that.




-----Original Message-----
From: junyan.he@gmx.com [mailto:junyan.he@gmx.com]=20
Sent: Thursday, May 10, 2018 10:09 AM
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com; imammedo@redhat.com; pbonzini@redhat.com; crosthwa=
ite.peter@gmail.com; rth@twiddle.net; xiaoguangrong.eric@gmail.com; mst@red=
hat.com; quintela@redhat.com; dgilbert@redhat.com; stefanha@redhat.com; He,=
 Junyan <junyan.he@intel.com>; Zhang, Haozhong <haozhong.zhang@intel.com>
Subject: [PATCH V5 0/9] nvdimm: guarantee persistence of QEMU writes to per=
sistent memory

From: Junyan He <junyan.he@intel.com>

QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
live migration. If the backend is on the persistent memory, QEMU needs
to take proper operations to ensure its writes persistent on the
persistent memory. Otherwise, a host power failure may result in the
loss the guest data on the persistent memory.

This v3 patch series is based on Marcel's patch "mem: add share
parameter to memory-backend-ram" [1] because of the changes in patch 1.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html

Previous versions can be found at
V4: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06993.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html

Changes in v5:
* (Patch 9) Add post copy check and output some messages for nvdimm.

Changes in v4:
* (Patch 2) Fix compilation errors found by patchew.

Changes in v3:
* (Patch 5) Add a is_pmem flag to ram_handle_compressed() and handle
PMEM writes in it, so we don't need the _common function.
* (Patch 6) Expose qemu_get_buffer_common so we can remove the
unnecessary qemu_get_buffer_to_pmem wrapper.
* (Patch 8) Add a is_pmem flag to xbzrle_decode_buffer() and handle
PMEM writes in it, so we can remove the unnecessary
xbzrle_decode_buffer_{common, to_pmem}.
* Move libpmem stubs to stubs/pmem.c and fix the compilation failures
of test-{xbzrle,vmstate}.c.

Changes in v2:
* (Patch 1) Use a flags parameter in file ram allocation functions.
* (Patch 2) Add a new option 'pmem' to hostmem-file.
* (Patch 3) Use libpmem to operate on the persistent memory, rather
than re-implementing those operations in QEMU.
* (Patch 5-8) Consider the write persistence in the migration path.

Haozhong Zhang (8):
[1/9] memory, exec: switch file ram allocation functions to 'flags' paramet=
ers
[2/9] hostmem-file: add the 'pmem' option
[3/9] configure: add libpmem support
[4/9] mem/nvdimm: ensure write persistence to PMEM in label emulation
[5/9] migration/ram: ensure write persistence on loading zero pages to PMEM
[6/9] migration/ram: ensure write persistence on loading normal pages to PM=
EM
[7/9] migration/ram: ensure write persistence on loading compressed pages t=
o PMEM
[8/9] migration/ram: ensure write persistence on loading xbzrle pages to PM=
EM
Junyan He (1):
[9/9] migration/ram: Add check and info message to nvdimm post copy.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Junyan He <junyan.he@intel.com>

---
backends/hostmem-file.c             | 27 ++++++++++++++++++++++++++-
configure                           | 35 ++++++++++++++++++++++++++++++++++=
+
docs/nvdimm.txt                     | 14 ++++++++++++++
exec.c                              | 20 ++++++++++++++++----
hw/mem/nvdimm.c                     |  9 ++++++++-
include/exec/memory.h               | 12 ++++++++++--
include/exec/ram_addr.h             | 28 ++++++++++++++++++++++++++--
include/migration/qemu-file-types.h |  2 ++
include/qemu/pmem.h                 | 27 +++++++++++++++++++++++++++
memory.c                            |  8 +++++---
migration/qemu-file.c               | 29 +++++++++++++++++++----------
migration/ram.c                     | 52 ++++++++++++++++++++++++++++++++++=
++++++++----------
migration/ram.h                     |  2 +-
migration/rdma.c                    |  2 +-
migration/xbzrle.c                  |  8 ++++++--
migration/xbzrle.h                  |  3 ++-
numa.c                              |  2 +-
qemu-options.hx                     |  7 +++++++
stubs/Makefile.objs                 |  1 +
stubs/pmem.c                        | 37 ++++++++++++++++++++++++++++++++++=
+++
tests/Makefile.include              |  4 ++--
tests/test-xbzrle.c                 |  4 ++--
22 files changed, 290 insertions(+), 43 deletions(-)
--=20
2.7.4
