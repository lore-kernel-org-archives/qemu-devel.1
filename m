Received: from eggs.gnu.org ([2001:4830:134:3::10]:53073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3i8j-0006fL-Cx
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3i8f-00033J-AZ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:03:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3i8f-00032i-1C
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:03:13 -0400
Date: Thu, 27 Apr 2017 13:02:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170427120215.GG2082@work-vm>
References: <20170425220451.6028-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425220451.6028-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/41] Migration cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, peter.maydell@linaro.org

* Juan Quintela (quintela@redhat.com) wrote:

High level question:
  A lot of this is splitting migration.h which is a GPLv2 licensed file, and you're
carefully copying the authorship (Anthony) to each new header file and also the license.
Can we fix the license while we're at it?
The migration.c has the clause saying contributions after 2012-01-13 are GPL2 or later
but we don't seem to have it in the header.

I suggest for any case where you split it out to a new header and all the contributions
in that header are from one easily contactable person, that you ask.

Dave

> 
> In this second version:
> - Move inclnude files to migration/ instead of include/migration/
> - Split misc patches to other series
> - Split MigrationParams to other series
> - Split HMP commands to other series
> - Make migration.h private
> - Create include/migration/misc.h for functions that don't belong anywhere else
> - Create include/migration/register.h for functions that register new vmsdescriptions
> - Create global_state.c for that VMState Description
> - Make savevm.c target indepedent
> - Exported functions reorganization to minimize the number of changes
> - Remove migration stuff from sysemu/sysemu.h (Why was it there in the 1st place.)
> - Split vmstate-types.c from vmstate.c (now there is only the interpreter there).
> 
> 
> ToDo:
> - RAMBlocks are defined in ram_addr_t, which includes ramlists.h
>   Clearly we should be able to have a better organization here, but it is eluding me.
> - Lots of files include sysemu/sysemu.h because runstate_* functions
>   are there, I think they deserve their own file.
> - Split qmp commands from migration.c
> - Reorganize savevm.c and migration.c to have less dependencies between them.
> 
> Please, comment.
> 
> [v1]
> This is a cleanup on top of my previous series.  It does:
> - create one .h file for each migration/* file
> - export with meaningful include names the migration functions that we export
> - untangle the includes mess (migration.h in8cluded vmstate.h who
>   included qemu-file.h).  Fixed all callers.
> - once there, old MigrationParams are gone.  Now block migration can be configured
>   with migration capabilities like everything else in migration (old command line
>   parameters  are maintained, but on top of this)
> - start moving hmp* functions to monitor.c
> 
> ToDo:
> - move the two remaining hmp commands to monitor.c
> 
>   really I should move them to block/* something, because they all use
>   block functions, nothing from migration.c.
> 
> - savevm.c/vmstate.c/migration.c: they are still tangled, but I wanted
>   to send the easy parts for review.
> 
> - half of the savevm.c functions are still exported from
>   sysemu/sysemu.h moving that to a different file, have to think about
>   it to make patches easier to understand.
> 
> - split capabilities/qmp commands/... from migration.c they don't
>   belong there, and once they are out it would be easier to untangle
>   the remaining bits.
> 
> - goal is still untangle normal migration/xbzrle/compression and rdma,
>   they are still too untangled together.
> 
> - I can still remove some includes that are not needed, but with the
>   current code, it gets really complicated until there is more cleanup there.
> 
> 
> Please, comment.
> 
> Juan Quintela (41):
>   migration: Create migration/blocker.h
>   migration: Split migration/channel.c for channel operations
>   migration: Remove MigrationState from migration_channel_incomming()
>   migration: Export qemu-file-channel.c functions in its own file
>   migration: Remove migration.h from colo.h
>   migration: Move colo.h to migration/
>   migration: Move failover.h to migration/colo-failover.h
>   migration: Move page_cache.c to migration/
>   migration: Move qjson.h to migration/
>   migration: Move postcopy-ram.h to migration/
>   migration: Split vmstate-types.c from vmstate.c
>   migration: Remove qemu-file.h from vmstate.h
>   migration: Remove vmstate.h from migration.h
>   migration: migration.h was not needed
>   migration: Create include for migration snapshots
>   migration: Rename {save,load}_vmstate to {save,load}_snapshot
>   migration: Create savevm.h for functions exported from savevm.c
>   migration: Split qemu-file.h
>   migration: Remove unneeded includes of migration/vmstate.h
>   migration: Export exec.c functions in its own file
>   migration: Export fd.c functions in its own file
>   migration: Export socket.c functions in its own file
>   migration: Export tls.c functions in its own file
>   migration: Export ram.c functions in its own file
>   migration: Export rdma.c functions in its own file
>   migration: Move include/migration/block.h into migration/
>   migration: Move self_announce_delay() to misc.h
>   migration: Split registration functions from vmstate.h
>   migration: loadvm_free_handlers is only used in migration/
>   migration: Move dump_vmsate_json_to_file() to misc.h
>   migration: Move postcopy stuff to postcopy-ram.c
>   migration: Move constants to savevm.h
>   migration: Commands are only used inside migration.c
>   migration: ram_control_* are implemented in qemu_file
>   migration: create global_state.c
>   migration: Move more exported functions to migration/misc.h
>   migration: Move last funtions to misc.h
>   migration: Move migration.h to migration/
>   exec: Create include for target_page_size()
>   migration: Make savevm.c target independent
>   migration: Remove unneeded includes
> 
>  MAINTAINERS                                        |   4 +-
>  Makefile.objs                                      |   1 -
>  Makefile.target                                    |   2 +-
>  block/qcow.c                                       |   2 +-
>  block/qed.c                                        |   1 -
>  block/vdi.c                                        |   2 +-
>  block/vhdx.c                                       |   2 +-
>  block/vmdk.c                                       |   2 +-
>  block/vpc.c                                        |   2 +-
>  block/vvfat.c                                      |   2 +-
>  exec.c                                             |  10 +
>  hmp.c                                              |   5 +-
>  hw/9pfs/9p.c                                       |   2 +-
>  hw/core/qdev.c                                     |   1 -
>  hw/display/qxl.c                                   |   2 +-
>  hw/display/virtio-gpu.c                            |   2 +-
>  hw/i2c/i2c-ddc.c                                   |   1 +
>  hw/i386/pc_piix.c                                  |   3 +-
>  hw/i386/pc_q35.c                                   |   1 -
>  hw/intc/arm_gic_kvm.c                              |   2 +-
>  hw/intc/arm_gicv3_its_kvm.c                        |   2 +-
>  hw/intc/arm_gicv3_kvm.c                            |   2 +-
>  hw/intc/s390_flic.c                                |   1 -
>  hw/intc/s390_flic_kvm.c                            |   1 -
>  hw/misc/ivshmem.c                                  |   2 +-
>  hw/net/virtio-net.c                                |   1 +
>  hw/net/vmxnet3.c                                   |   1 +
>  hw/ppc/spapr.c                                     |   4 +-
>  hw/s390x/s390-skeys.c                              |   2 +-
>  hw/s390x/s390-virtio-ccw.c                         |   1 +
>  hw/scsi/vhost-scsi.c                               |   2 +-
>  hw/virtio/vhost-user.c                             |   1 -
>  hw/virtio/vhost-vsock.c                            |   1 -
>  hw/virtio/vhost.c                                  |   2 +-
>  hw/virtio/virtio.c                                 |   1 -
>  include/block/block_int.h                          |   4 +-
>  include/exec/target_page.h                         |  22 +
>  include/hw/acpi/memory_hotplug.h                   |   1 -
>  include/hw/acpi/pcihp.h                            |   1 -
>  include/hw/hw.h                                    |   1 +
>  include/hw/pci/shpc.h                              |   1 -
>  include/migration/blocker.h                        |  35 ++
>  include/migration/global_state.h                   |  26 +
>  include/migration/migration.h                      | 353 -----------
>  include/migration/misc.h                           |  53 ++
>  include/migration/qemu-file-types.h                | 164 +++++
>  include/migration/register.h                       |  64 ++
>  include/migration/snapshot.h                       |  20 +
>  include/migration/vmstate.h                        |  62 --
>  include/net/net.h                                  |   1 -
>  include/sysemu/sysemu.h                            |  51 --
>  migration/Makefile.objs                            |   6 +-
>  migration/block.c                                  |  14 +-
>  {include/migration => migration}/block.h           |   1 -
>  migration/channel.c                                |  72 +++
>  migration/channel.h                                |  24 +
>  migration/colo-comm.c                              |   4 +-
>  migration/colo-failover.c                          |   6 +-
>  .../failover.h => migration/colo-failover.h        |   0
>  migration/colo.c                                   |   8 +-
>  {include/migration => migration}/colo.h            |   4 -
>  migration/exec.c                                   |   6 +-
>  migration/exec.h                                   |  20 +
>  migration/fd.c                                     |   6 +-
>  migration/fd.h                                     |  20 +
>  migration/global_state.c                           | 142 +++++
>  migration/migration.c                              | 261 ++------
>  migration/migration.h                              | 167 +++++
>  page_cache.c => migration/page_cache.c             |   0
>  {include/migration => migration}/page_cache.h      |   0
>  migration/postcopy-ram.c                           |  28 +-
>  {include/migration => migration}/postcopy-ram.h    |  26 +
>  migration/qemu-file-channel.c                      |   4 +-
>  migration/qemu-file-channel.h                      |  21 +
>  migration/qemu-file.c                              |   6 +-
>  {include/migration => migration}/qemu-file.h       | 178 +-----
>  migration/qjson.c                                  |   2 +-
>  {include/migration => migration}/qjson.h           |   0
>  migration/ram.c                                    |  15 +-
>  migration/ram.h                                    |  55 ++
>  migration/rdma.c                                   |   8 +-
>  migration/rdma.h                                   |  22 +
>  migration/savevm.c                                 |  65 +-
>  migration/savevm.h                                 |  58 ++
>  migration/socket.c                                 |   9 +-
>  migration/socket.h                                 |  25 +
>  migration/tls.c                                    |   6 +-
>  migration/tls.h                                    |  27 +
>  migration/vmstate-types.c                          | 677 +++++++++++++++++++++
>  migration/vmstate.c                                | 676 +-------------------
>  migration/xbzrle.c                                 |   2 +-
>  {include/migration => migration}/xbzrle.h          |   0
>  monitor.c                                          |   1 -
>  qdev-monitor.c                                     |   2 +-
>  replay/replay-snapshot.c                           |   5 +-
>  slirp/slirp.c                                      |   1 +
>  stubs/migr-blocker.c                               |   2 +-
>  target/alpha/cpu.c                                 |   1 -
>  target/hppa/cpu.c                                  |   1 -
>  target/i386/kvm.c                                  |   2 +-
>  target/s390x/cpu.c                                 |   1 -
>  target/tilegx/cpu.c                                |   1 -
>  tests/Makefile.include                             |   4 +-
>  tests/test-vmstate.c                               |   6 +-
>  tests/test-xbzrle.c                                |   2 +-
>  ui/spice-core.c                                    |   2 +-
>  vl.c                                               |   7 +-
>  xen-common.c                                       |   3 +-
>  108 files changed, 2027 insertions(+), 1617 deletions(-)
>  create mode 100644 include/exec/target_page.h
>  create mode 100644 include/migration/blocker.h
>  create mode 100644 include/migration/global_state.h
>  delete mode 100644 include/migration/migration.h
>  create mode 100644 include/migration/misc.h
>  create mode 100644 include/migration/qemu-file-types.h
>  create mode 100644 include/migration/register.h
>  create mode 100644 include/migration/snapshot.h
>  rename {include/migration => migration}/block.h (95%)
>  create mode 100644 migration/channel.c
>  create mode 100644 migration/channel.h
>  rename include/migration/failover.h => migration/colo-failover.h (100%)
>  rename {include/migration => migration}/colo.h (88%)
>  create mode 100644 migration/exec.h
>  create mode 100644 migration/fd.h
>  create mode 100644 migration/global_state.c
>  create mode 100644 migration/migration.h
>  rename page_cache.c => migration/page_cache.c (100%)
>  rename {include/migration => migration}/page_cache.h (100%)
>  rename {include/migration => migration}/postcopy-ram.h (72%)
>  create mode 100644 migration/qemu-file-channel.h
>  rename {include/migration => migration}/qemu-file.h (62%)
>  rename {include/migration => migration}/qjson.h (100%)
>  create mode 100644 migration/ram.h
>  create mode 100644 migration/rdma.h
>  create mode 100644 migration/savevm.h
>  create mode 100644 migration/socket.h
>  create mode 100644 migration/tls.h
>  create mode 100644 migration/vmstate-types.c
>  rename {include/migration => migration}/xbzrle.h (100%)
> 
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
