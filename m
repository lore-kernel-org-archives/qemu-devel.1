Received: from eggs.gnu.org ([2001:4830:134:3::10]:50746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4D-0004BT-Np
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKp4A-0000Mb-8M
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKp49-0000Ly-Rl
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 12:53:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 13:52:58 -0300
Message-Id: <20170613165313.20954-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 00/15] Error API: Flag errors in *errp even if
 errors are being ignored
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Rationale
---------

I'm often bothered by the fact that we can't write the following:

    foo(arg, errp);
    if (*errp) {
        handle the error...
        error_propagate(errp, err);
    }

because errp can be NULL.

I understand the reason we need to support errp==NULL, as it
makes life simpler for callers that don't want any extra error
information.  However, this has the cost of making the functions
that report errors more complex and error-prone.

(Evidence of that: the 34 ERR_IS_* cases handled by the "use
ERR_IS_* macros" patches in the series.  Where existing code will
crash or behave differently if errp is NULL.)

I considered suggesting forbidding NULL errp, and just changing
all callers that use NULL to have an err variable and call
error_free(), but this would mean changing 690 function callers
that pass NULL errp as argument.

Here I'm proposing a mechanism to have the best of both worlds:
allow callers to ignore errors easily while allowing functions to
propagate errors without an intermediate local_err variable.

The Proposal
------------

I'm proposing replacing NULL errp with a special macro:
IGNORE_ERRORS.  The macro will trigger special behavior in the
error API that will make it not save any error information in the
error pointer, but still keep track of boolean error state in
*errp.

This will allow us to simplify the documented method to propagate errors
from:

    Error *err = NULL;
    foo(arg, &err);
    if (err) {
        handle the error...
        error_propagate(errp, err);
    }

to:

    foo(arg, errp);
    if (ERR_IS_SET(errp)) {
        handle the error...
    }

This will allow us to stop using local_err variables and
error_propagate() on hundreds of cases.

Implementation
--------------

This replaces NULL errp arguments on function calls with a
IGNORE_ERRORS macro.  Checks for (!errp) are replaced by
ERR_IS_IGNORED(errp).  Checks for (*errp) are replaced by
ERR_IS_SET(errp).  No extra changes are required on function
callers.

Then IGNORE_ERRORS is implemend as:

  (& { &ignored_error_unset })

When error_set() is called and IGNORE_ERRORS was used, we set
error state using:

  *errp = &ignored_error_set;

This way, we can make ERR_IS_SET work even if errp was
IGNORE_ERRORS.  The ERR_IS_* macros are reimplemented as:

  #define ERR_IS_SET(e) (*(e) && *(e) != &ignored_error_unset)
  #define ERR_IS_IGNORED(e) (!(e) || *(e) == &ignored_error_unset || *(e) == &ignored_error_set)

Ensuring errp is never NULL
---------------------------

The last patch on this series changes the (Error **errp)
parameters in functions to (Error *errp[static 1]), just to help
validate the existing code, as clang warns about NULL arguments
on that case.  I don't think we should apply that patch, though,
because the "[static 1]" syntax confuses Coccinelle.

I have a branch where I experimented with the idea of replacing
(Error **errp) parameters with an opaque type (void*, or a struct
type).  I gave up when I noticed it would require touching all
callers to replace &err with a wrapper macro to convert to the
right type.  Suggestions to make NULL errp easier to detect at
build time are welcome.

(Probably the easiest solution for that is to add assert(errp)
lines to the ERR_IS_*() macros.)

Desirable side-effects
----------------------

Some of additional benefits from parts of this series:

* Making code that ignore error information more visible and
  greppable (using IGNORE_ERRORS).  I believe many of those cases
  are actually bugs and should use &error_abort or &error_fatal
  instead.

* Making code that depends on errp more visible and
  greppable (using ERR_IS_* macros).  Some of those cases are
  also likely to be bugs, and need to be investigated.

TODO
----

* Simplify more cases of local_error/error_propagate() to use
  errp directly.
* Update API documentation and code examples.
* Add a mechanism to ensure errp is never NULL.

Git branch
----------

This series depend on a few extra cleanups that I didn't submit
to qemu-devel yet.  A git branch including this series is
available at:

  git://github.com/ehabkost/qemu-hacks.git work/err-api-rework-ignore-ptr-v1

Eduardo Habkost (15):
  tests: Test cases for error API
  error: New IGNORE_ERRORS macro
  Add qapi/error.h includes on files that will need it
  [coccinelle] Use IGNORE_ERRORS instead of NULL as errp argument
  qapi: Use IGNORE_ERRORS instead of NULL on generated code
  test-qapi-util: Use IGNORE_ERRORS instead of NULL
  Manual changes to use IGNORE_ERRORS instead of NULL
  error: New ERR_IS_* macros for checking Error** values
  [coccinelle] Use ERR_IS_* macros
  test-qapi-util: Use ERR_IS_* macros
  Manual changes to use ERR_IS_* macros
  error: Make IGNORED_ERRORS not a NULL pointer
  rdma: Simplify var declaration to avoid confusing Coccinelle
  [coccinelle] Eliminate unnecessary local_err/error_propagate() usage
  [test only] Use 'Error *err[static 1]' instead of 'Error **errp' to
    catch NULL errp arguments

 include/qapi/visitor.h                  |  47 ++++---
 scripts/qapi-commands.py                |   6 +-
 scripts/qapi-types.py                   |   3 +-
 block/nbd-client.h                      |   2 +-
 block/qcow2.h                           |   8 +-
 block/vhdx.h                            |   2 +-
 crypto/blockpriv.h                      |   4 +-
 crypto/hmac.h                           |  10 +-
 crypto/tlscredspriv.h                   |   4 +-
 hw/9pfs/9p.h                            |   4 +-
 hw/block/dataplane/virtio-blk.h         |   2 +-
 hw/s390x/s390-virtio.h                  |   2 +-
 hw/timer/m48t59-internal.h              |   2 +-
 hw/usb/hcd-ehci.h                       |   4 +-
 hw/vfio/pci.h                           |   4 +-
 hw/xen/xen-host-pci-device.h            |   2 +-
 hw/xen/xen_pt.h                         |   4 +-
 include/block/aio.h                     |   4 +-
 include/block/block.h                   |  69 ++++++----
 include/block/block_backup.h            |   2 +-
 include/block/block_int.h               |  19 +--
 include/block/blockjob.h                |  11 +-
 include/block/blockjob_int.h            |   3 +-
 include/block/dirty-bitmap.h            |   8 +-
 include/block/nbd.h                     |  13 +-
 include/block/qapi.h                    |   7 +-
 include/block/snapshot.h                |  12 +-
 include/chardev/char-fd.h               |   2 +-
 include/chardev/char-fe.h               |   4 +-
 include/chardev/char-win.h              |   3 +-
 include/chardev/char.h                  |   9 +-
 include/crypto/afsplit.h                |   4 +-
 include/crypto/block.h                  |  10 +-
 include/crypto/cipher.h                 |   8 +-
 include/crypto/hash.h                   |  12 +-
 include/crypto/init.h                   |   2 +-
 include/crypto/ivgen.h                  |   2 +-
 include/crypto/pbkdf.h                  |   4 +-
 include/crypto/random.h                 |   4 +-
 include/crypto/secret.h                 |   6 +-
 include/crypto/tlssession.h             |   6 +-
 include/exec/memory.h                   |  12 +-
 include/exec/ram_addr.h                 |  12 +-
 include/hw/acpi/acpi.h                  |   4 +-
 include/hw/acpi/cpu.h                   |   7 +-
 include/hw/acpi/cpu_hotplug.h           |   3 +-
 include/hw/acpi/ich9.h                  |   9 +-
 include/hw/acpi/memory_hotplug.h        |   6 +-
 include/hw/acpi/pcihp.h                 |   4 +-
 include/hw/audio/pcspk.h                |   3 +-
 include/hw/block/block.h                |   4 +-
 include/hw/boards.h                     |   2 +-
 include/hw/char/serial.h                |   2 +-
 include/hw/hotplug.h                    |   8 +-
 include/hw/i386/pc.h                    |   2 +-
 include/hw/isa/isa.h                    |   6 +-
 include/hw/loader.h                     |   3 +-
 include/hw/mem/pc-dimm.h                |  10 +-
 include/hw/nmi.h                        |   2 +-
 include/hw/pci/msi.h                    |   2 +-
 include/hw/pci/msix.h                   |   4 +-
 include/hw/pci/pci.h                    |   2 +-
 include/hw/pci/pcie.h                   |   5 +-
 include/hw/pci/pcie_aer.h               |   2 +-
 include/hw/pci/shpc.h                   |   5 +-
 include/hw/ppc/pnv_xscom.h              |   2 +-
 include/hw/ppc/xics.h                   |   7 +-
 include/hw/qdev-core.h                  |   8 +-
 include/hw/qdev-properties.h            |  10 +-
 include/hw/s390x/css.h                  |   4 +-
 include/hw/scsi/scsi.h                  |   3 +-
 include/hw/smbios/smbios.h              |   2 +-
 include/hw/usb.h                        |   8 +-
 include/hw/vfio/vfio-common.h           |   5 +-
 include/hw/virtio/vhost-scsi-common.h   |   2 +-
 include/hw/virtio/virtio-bus.h          |   2 +-
 include/hw/virtio/virtio-scsi.h         |   6 +-
 include/hw/xen/xen.h                    |   2 +-
 include/io/channel-command.h            |   2 +-
 include/io/channel-file.h               |   2 +-
 include/io/channel-socket.h             |  14 +-
 include/io/channel-tls.h                |   4 +-
 include/io/channel-util.h               |   2 +-
 include/io/channel.h                    |  20 +--
 include/io/dns-resolver.h               |   2 +-
 include/io/task.h                       |   2 +-
 include/migration/blocker.h             |   2 +-
 include/migration/failover.h            |   2 +-
 include/migration/migration.h           |   4 +-
 include/migration/snapshot.h            |   4 +-
 include/migration/vmstate.h             |   5 +-
 include/monitor/monitor.h               |   6 +-
 include/monitor/qdev.h                  |   4 +-
 include/net/net.h                       |   6 +-
 include/qapi/error.h                    |  23 +++-
 include/qapi/qmp/json-parser.h          |   3 +-
 include/qapi/qmp/qdict.h                |   2 +-
 include/qapi/qmp/qjson.h                |   5 +-
 include/qapi/qobject-input-visitor.h    |   2 +-
 include/qapi/util.h                     |   2 +-
 include/qemu/base64.h                   |   2 +-
 include/qemu/config-file.h              |   4 +-
 include/qemu/log.h                      |   4 +-
 include/qemu/main-loop.h                |   2 +-
 include/qemu/option.h                   |  30 ++--
 include/qemu/sockets.h                  |  33 +++--
 include/qemu/throttle.h                 |   2 +-
 include/qom/cpu.h                       |   4 +-
 include/qom/object.h                    |  89 ++++++------
 include/qom/object_interfaces.h         |  12 +-
 include/qom/qom-qobject.h               |   4 +-
 include/sysemu/arch_init.h              |   8 +-
 include/sysemu/block-backend.h          |  19 +--
 include/sysemu/cpus.h                   |   4 +-
 include/sysemu/cryptodev.h              |   8 +-
 include/sysemu/device_tree.h            |   6 +-
 include/sysemu/hostmem.h                |   2 +-
 include/sysemu/memory_mapping.h         |   2 +-
 include/sysemu/numa.h                   |   5 +-
 include/sysemu/qtest.h                  |   3 +-
 include/sysemu/sysemu.h                 |  10 +-
 include/sysemu/tpm_backend.h            |   2 +-
 include/ui/console.h                    |  14 +-
 include/ui/input.h                      |   2 +-
 include/ui/qemu-spice.h                 |   2 +-
 migration/block.h                       |   2 +-
 migration/exec.h                        |   5 +-
 migration/fd.h                          |   4 +-
 migration/rdma.h                        |   5 +-
 migration/savevm.h                      |   2 +-
 migration/socket.h                      |   9 +-
 migration/tls.h                         |   4 +-
 nbd/nbd-internal.h                      |   6 +-
 net/clients.h                           |  20 +--
 net/tap_int.h                           |   5 +-
 qga/guest-agent-core.h                  |   4 +-
 qga/vss-win32.h                         |   2 +-
 replication.h                           |   8 +-
 target/i386/cpu.h                       |   2 +-
 target/ppc/cpu.h                        |   5 +-
 target/s390x/cpu.h                      |  10 +-
 target/s390x/cpu_models.h               |   9 +-
 qapi/qapi-visit-core.c                  |  64 +++++----
 arch_init.c                             |   2 +-
 backends/cryptodev-builtin.c            |  15 +-
 backends/cryptodev.c                    |  24 ++--
 backends/hostmem-file.c                 |  11 +-
 backends/hostmem-ram.c                  |   2 +-
 backends/hostmem.c                      |  45 +++---
 backends/rng-egd.c                      |   9 +-
 backends/rng-random.c                   |   8 +-
 backends/rng.c                          |  15 +-
 backends/tpm.c                          |  15 +-
 balloon.c                               |   6 +-
 block.c                                 | 150 ++++++++++----------
 block/backup.c                          |  13 +-
 block/blkdebug.c                        |  33 +++--
 block/blkreplay.c                       |   2 +-
 block/blkverify.c                       |   4 +-
 block/block-backend.c                   |  31 +++--
 block/bochs.c                           |   4 +-
 block/cloop.c                           |   4 +-
 block/commit.c                          |  35 +++--
 block/crypto.c                          |  32 ++---
 block/curl.c                            |  10 +-
 block/dirty-bitmap.c                    |   9 +-
 block/dmg.c                             |   6 +-
 block/file-posix.c                      |  52 +++----
 block/file-win32.c                      |  18 +--
 block/gluster.c                         |  23 ++--
 block/io.c                              |  13 +-
 block/iscsi.c                           |  58 ++++----
 block/mirror.c                          |  30 ++--
 block/nbd-client.c                      |  12 +-
 block/nbd.c                             |  36 +++--
 block/nfs.c                             |  37 ++---
 block/null.c                            |   4 +-
 block/parallels.c                       |  12 +-
 block/qapi.c                            |  19 ++-
 block/qcow.c                            |  15 +-
 block/qcow2-cluster.c                   |   2 +-
 block/qcow2-refcount.c                  |   8 +-
 block/qcow2-snapshot.c                  |   4 +-
 block/qcow2.c                           |  44 +++---
 block/qed.c                             |  21 +--
 block/quorum.c                          |  11 +-
 block/raw-format.c                      |  20 +--
 block/rbd.c                             |  29 ++--
 block/replication.c                     |  46 +++----
 block/sheepdog.c                        |  65 ++++-----
 block/snapshot.c                        |  14 +-
 block/ssh.c                             |  43 +++---
 block/stream.c                          |  10 +-
 block/vdi.c                             |   7 +-
 block/vhdx-log.c                        |   4 +-
 block/vhdx.c                            |  13 +-
 block/vmdk.c                            |  33 +++--
 block/vpc.c                             |  11 +-
 block/vvfat.c                           |  12 +-
 block/vxhs.c                            |   6 +-
 block/write-threshold.c                 |   2 +-
 blockdev-nbd.c                          |  13 +-
 blockdev.c                              | 184 ++++++++++++-------------
 blockjob.c                              |  35 +++--
 bootdevice.c                            |  27 ++--
 bsd-user/elfload.c                      |   4 +-
 chardev/baum.c                          |   2 +-
 chardev/char-console.c                  |   2 +-
 chardev/char-fd.c                       |   4 +-
 chardev/char-fe.c                       |   4 +-
 chardev/char-file.c                     |   4 +-
 chardev/char-io.c                       |   3 +-
 chardev/char-mux.c                      |   4 +-
 chardev/char-null.c                     |   2 +-
 chardev/char-parallel.c                 |   8 +-
 chardev/char-pipe.c                     |   8 +-
 chardev/char-pty.c                      |   4 +-
 chardev/char-ringbuf.c                  |   8 +-
 chardev/char-serial.c                   |   6 +-
 chardev/char-socket.c                   |  30 ++--
 chardev/char-stdio.c                    |   4 +-
 chardev/char-udp.c                      |   8 +-
 chardev/char-win-stdio.c                |   2 +-
 chardev/char-win.c                      |   3 +-
 chardev/char.c                          |  25 ++--
 chardev/msmouse.c                       |   2 +-
 chardev/spice.c                         |   8 +-
 chardev/wctablet.c                      |   2 +-
 cpus.c                                  |  12 +-
 crypto/afsplit.c                        |   6 +-
 crypto/block-luks.c                     |  22 +--
 crypto/block-qcow.c                     |  10 +-
 crypto/block.c                          |  14 +-
 crypto/cipher-builtin.c                 |  24 ++--
 crypto/cipher-gcrypt.c                  |   8 +-
 crypto/cipher-nettle.c                  |   8 +-
 crypto/cipher.c                         |   2 +-
 crypto/hash-gcrypt.c                    |   2 +-
 crypto/hash-glib.c                      |   2 +-
 crypto/hash-nettle.c                    |   2 +-
 crypto/hash.c                           |  10 +-
 crypto/hmac-gcrypt.c                    |   4 +-
 crypto/hmac-glib.c                      |   8 +-
 crypto/hmac-nettle.c                    |   4 +-
 crypto/hmac.c                           |   6 +-
 crypto/init.c                           |   2 +-
 crypto/ivgen-essiv.c                    |   4 +-
 crypto/ivgen-plain.c                    |   4 +-
 crypto/ivgen-plain64.c                  |   4 +-
 crypto/ivgen.c                          |   4 +-
 crypto/pbkdf-gcrypt.c                   |   2 +-
 crypto/pbkdf-nettle.c                   |   2 +-
 crypto/pbkdf-stub.c                     |   2 +-
 crypto/pbkdf.c                          |   4 +-
 crypto/random-gcrypt.c                  |   4 +-
 crypto/random-gnutls.c                  |   4 +-
 crypto/random-platform.c                |   4 +-
 crypto/secret.c                         |  50 +++----
 crypto/tlscreds.c                       |  28 ++--
 crypto/tlscredsanon.c                   |  14 +-
 crypto/tlscredsx509.c                   |  44 +++---
 crypto/tlssession.c                     |  18 +--
 device_tree.c                           |   8 +-
 dump.c                                  | 207 ++++++++++------------------
 exec.c                                  |  40 +++---
 fsdev/qemu-fsdev-throttle.c             |   3 +-
 gdbstub.c                               |   2 +-
 hmp.c                                   |  68 ++++-----
 hw/9pfs/9p.c                            |   4 +-
 hw/9pfs/virtio-9p-device.c              |   7 +-
 hw/9pfs/xen-9p-backend.c                |  12 +-
 hw/acpi/acpi-stub.c                     |   2 +-
 hw/acpi/core.c                          |   6 +-
 hw/acpi/cpu.c                           |   9 +-
 hw/acpi/cpu_hotplug.c                   |   7 +-
 hw/acpi/ich9.c                          |  51 +++----
 hw/acpi/memory_hotplug.c                |  19 +--
 hw/acpi/nvdimm.c                        |  17 +--
 hw/acpi/pcihp.c                         |   4 +-
 hw/acpi/piix4.c                         |  28 ++--
 hw/acpi/vmgenid.c                       |  12 +-
 hw/arm/allwinner-a10.c                  |  30 ++--
 hw/arm/armv7m.c                         |  30 ++--
 hw/arm/aspeed.c                         |   4 +-
 hw/arm/aspeed_soc.c                     |  25 ++--
 hw/arm/bcm2835_peripherals.c            |  33 +++--
 hw/arm/bcm2836.c                        |   5 +-
 hw/arm/digic.c                          |  30 ++--
 hw/arm/exynos4210.c                     |   2 +-
 hw/arm/fsl-imx25.c                      |  63 ++++-----
 hw/arm/fsl-imx31.c                      |  58 ++++----
 hw/arm/fsl-imx6.c                       | 110 +++++++--------
 hw/arm/highbank.c                       |   2 +-
 hw/arm/integratorcp.c                   |   4 +-
 hw/arm/musicpal.c                       |   4 +-
 hw/arm/pxa2xx.c                         |   2 +-
 hw/arm/pxa2xx_gpio.c                    |   2 +-
 hw/arm/realview.c                       |   2 +-
 hw/arm/spitz.c                          |   4 +-
 hw/arm/stm32f205_soc.c                  |   2 +-
 hw/arm/strongarm.c                      |   2 +-
 hw/arm/tosa.c                           |   2 +-
 hw/arm/versatilepb.c                    |   2 +-
 hw/arm/vexpress.c                       |  13 +-
 hw/arm/virt.c                           |  62 +++++----
 hw/arm/xilinx_zynq.c                    |   2 +-
 hw/arm/xlnx-zynqmp.c                    |  14 +-
 hw/arm/z2.c                             |   2 +-
 hw/audio/ac97.c                         |   2 +-
 hw/audio/adlib.c                        |   2 +-
 hw/audio/cs4231a.c                      |   2 +-
 hw/audio/es1370.c                       |   2 +-
 hw/audio/gus.c                          |   2 +-
 hw/audio/intel-hda.c                    |   6 +-
 hw/audio/marvell_88w8618.c              |   2 +-
 hw/audio/milkymist-ac97.c               |   2 +-
 hw/audio/pcspk.c                        |   2 +-
 hw/audio/pl041.c                        |   2 +-
 hw/audio/sb16.c                         |   2 +-
 hw/block/block.c                        |   4 +-
 hw/block/dataplane/virtio-blk.c         |   2 +-
 hw/block/fdc.c                          |  37 ++---
 hw/block/m25p80.c                       |   2 +-
 hw/block/nand.c                         |   2 +-
 hw/block/nvme.c                         |   2 +-
 hw/block/pflash_cfi01.c                 |   8 +-
 hw/block/pflash_cfi02.c                 |   8 +-
 hw/block/virtio-blk.c                   |  27 ++--
 hw/bt/hci-csr.c                         |   2 +-
 hw/char/bcm2835_aux.c                   |   2 +-
 hw/char/cadence_uart.c                  |   2 +-
 hw/char/debugcon.c                      |  10 +-
 hw/char/digic-uart.c                    |   2 +-
 hw/char/escc.c                          |   2 +-
 hw/char/etraxfs_ser.c                   |   2 +-
 hw/char/exynos4210_uart.c               |   2 +-
 hw/char/imx_serial.c                    |   2 +-
 hw/char/ipoctal232.c                    |   2 +-
 hw/char/lm32_juart.c                    |   2 +-
 hw/char/lm32_uart.c                     |   2 +-
 hw/char/mcf_uart.c                      |   2 +-
 hw/char/milkymist-uart.c                |   2 +-
 hw/char/parallel.c                      |   2 +-
 hw/char/pl011.c                         |   2 +-
 hw/char/serial-isa.c                    |   2 +-
 hw/char/serial-pci.c                    |  16 +--
 hw/char/serial.c                        |   2 +-
 hw/char/spapr_vty.c                     |   2 +-
 hw/char/stm32f2xx_usart.c               |   2 +-
 hw/char/terminal3270.c                  |   2 +-
 hw/char/virtio-console.c                |   4 +-
 hw/char/virtio-serial-bus.c             |  22 +--
 hw/char/xilinx_uartlite.c               |   2 +-
 hw/core/bus.c                           |  19 +--
 hw/core/generic-loader.c                |   4 +-
 hw/core/hotplug.c                       |   8 +-
 hw/core/loader.c                        |   3 +-
 hw/core/machine.c                       |  99 +++++++------
 hw/core/nmi.c                           |   2 +-
 hw/core/or-irq.c                        |   2 +-
 hw/core/platform-bus.c                  |   8 +-
 hw/core/qdev-properties-system.c        |  52 +++----
 hw/core/qdev-properties.c               | 112 +++++++--------
 hw/core/qdev.c                          |  61 ++++----
 hw/core/sysbus.c                        |   6 +-
 hw/cpu/a15mpcore.c                      |  10 +-
 hw/cpu/a9mpcore.c                       |  30 ++--
 hw/cpu/arm11mpcore.c                    |  23 ++--
 hw/cpu/core.c                           |  24 ++--
 hw/cpu/realview_mpcore.c                |  13 +-
 hw/display/ads7846.c                    |   2 +-
 hw/display/bcm2835_fb.c                 |   2 +-
 hw/display/cg3.c                        |   2 +-
 hw/display/cirrus_vga.c                 |   4 +-
 hw/display/exynos4210_fimd.c            |   2 +-
 hw/display/jazz_led.c                   |   2 +-
 hw/display/milkymist-tmu2.c             |   2 +-
 hw/display/milkymist-vgafb.c            |   2 +-
 hw/display/pl110.c                      |   2 +-
 hw/display/qxl.c                        |  12 +-
 hw/display/sm501.c                      |   4 +-
 hw/display/ssd0323.c                    |   2 +-
 hw/display/tcx.c                        |   2 +-
 hw/display/vga-isa.c                    |   2 +-
 hw/display/vga-pci.c                    |  16 ++-
 hw/display/virtio-gpu-pci.c             |   3 +-
 hw/display/virtio-gpu.c                 |  14 +-
 hw/display/virtio-vga.c                 |   9 +-
 hw/display/vmware_vga.c                 |   2 +-
 hw/display/xlnx_dp.c                    |   4 +-
 hw/dma/bcm2835_dma.c                    |   2 +-
 hw/dma/i82374.c                         |   2 +-
 hw/dma/i8257.c                          |   2 +-
 hw/dma/pl330.c                          |   2 +-
 hw/dma/pxa2xx_dma.c                     |   2 +-
 hw/dma/rc4030.c                         |   4 +-
 hw/dma/sparc32_dma.c                    |   2 +-
 hw/dma/xilinx_axidma.c                  |   2 +-
 hw/gpio/bcm2835_gpio.c                  |   2 +-
 hw/gpio/gpio_key.c                      |   2 +-
 hw/gpio/imx_gpio.c                      |   2 +-
 hw/gpio/omap_gpio.c                     |   4 +-
 hw/i2c/aspeed_i2c.c                     |   2 +-
 hw/i2c/imx_i2c.c                        |   2 +-
 hw/i2c/omap_i2c.c                       |   2 +-
 hw/i2c/smbus_ich9.c                     |   2 +-
 hw/i386/acpi-build.c                    |  51 ++++---
 hw/i386/amd_iommu.c                     |   2 +-
 hw/i386/intel_iommu.c                   |   4 +-
 hw/i386/kvm/apic.c                      |   4 +-
 hw/i386/kvm/clock.c                     |   2 +-
 hw/i386/kvm/i8254.c                     |   2 +-
 hw/i386/kvm/i8259.c                     |   2 +-
 hw/i386/kvm/ioapic.c                    |   2 +-
 hw/i386/kvm/pci-assign.c                |  29 ++--
 hw/i386/kvmvapic.c                      |   2 +-
 hw/i386/pc.c                            |  84 ++++++-----
 hw/i386/pc_q35.c                        |  16 ++-
 hw/i386/x86-iommu.c                     |   2 +-
 hw/i386/xen/xen-hvm.c                   |   4 +-
 hw/i386/xen/xen_apic.c                  |   2 +-
 hw/i386/xen/xen_platform.c              |   2 +-
 hw/i386/xen/xen_pvdevice.c              |   2 +-
 hw/ide/ahci.c                           |   2 +-
 hw/ide/cmd646.c                         |   2 +-
 hw/ide/core.c                           |   2 +-
 hw/ide/ich.c                            |   5 +-
 hw/ide/isa.c                            |   2 +-
 hw/ide/macio.c                          |   2 +-
 hw/ide/microdrive.c                     |   2 +-
 hw/ide/mmio.c                           |   2 +-
 hw/ide/piix.c                           |   2 +-
 hw/ide/qdev.c                           |  12 +-
 hw/ide/via.c                            |   2 +-
 hw/input/adb.c                          |   6 +-
 hw/input/pckbd.c                        |   2 +-
 hw/input/virtio-input-hid.c             |   9 +-
 hw/input/virtio-input-host.c            |   5 +-
 hw/input/virtio-input.c                 |  20 ++-
 hw/input/vmmouse.c                      |   2 +-
 hw/intc/apic.c                          |   4 +-
 hw/intc/apic_common.c                   |  18 ++-
 hw/intc/arm_gic.c                       |   8 +-
 hw/intc/arm_gic_common.c                |   2 +-
 hw/intc/arm_gic_kvm.c                   |  13 +-
 hw/intc/arm_gicv2m.c                    |   2 +-
 hw/intc/arm_gicv3.c                     |   8 +-
 hw/intc/arm_gicv3_common.c              |   5 +-
 hw/intc/arm_gicv3_its_kvm.c             |   8 +-
 hw/intc/arm_gicv3_kvm.c                 |  13 +-
 hw/intc/armv7m_nvic.c                   |   8 +-
 hw/intc/aspeed_vic.c                    |   2 +-
 hw/intc/exynos4210_gic.c                |   3 +-
 hw/intc/grlib_irqmp.c                   |   2 +-
 hw/intc/i8259.c                         |   2 +-
 hw/intc/i8259_common.c                  |   2 +-
 hw/intc/ioapic.c                        |   2 +-
 hw/intc/ioapic_common.c                 |   2 +-
 hw/intc/mips_gic.c                      |   2 +-
 hw/intc/nios2_iic.c                     |   2 +-
 hw/intc/omap_intc.c                     |   4 +-
 hw/intc/openpic.c                       |   2 +-
 hw/intc/openpic_kvm.c                   |   2 +-
 hw/intc/realview_gic.c                  |   8 +-
 hw/intc/s390_flic.c                     |   4 +-
 hw/intc/s390_flic_kvm.c                 |   5 +-
 hw/intc/xics.c                          |   8 +-
 hw/intc/xics_kvm.c                      |   8 +-
 hw/intc/xics_pnv.c                      |   2 +-
 hw/intc/xics_spapr.c                    |   5 +-
 hw/ipack/ipack.c                        |   8 +-
 hw/ipack/tpci200.c                      |   2 +-
 hw/ipmi/ipmi.c                          |   5 +-
 hw/ipmi/ipmi_bmc_extern.c               |   2 +-
 hw/ipmi/ipmi_bmc_sim.c                  |   2 +-
 hw/ipmi/isa_ipmi_bt.c                   |   6 +-
 hw/ipmi/isa_ipmi_kcs.c                  |   4 +-
 hw/isa/i82378.c                         |   2 +-
 hw/isa/isa-bus.c                        |   2 +-
 hw/isa/lpc_ich9.c                       |  13 +-
 hw/isa/pc87312.c                        |   2 +-
 hw/isa/piix4.c                          |   2 +-
 hw/isa/vt82c686.c                       |   8 +-
 hw/mem/nvdimm.c                         |   8 +-
 hw/mem/pc-dimm.c                        |  24 ++--
 hw/microblaze/petalogix_ml605_mmu.c     |  14 +-
 hw/mips/boston.c                        |   2 +-
 hw/mips/cps.c                           |   2 +-
 hw/mips/gt64xxx_pci.c                   |   2 +-
 hw/mips/mips_malta.c                    |   3 +-
 hw/misc/applesmc.c                      |   2 +-
 hw/misc/arm11scu.c                      |   2 +-
 hw/misc/arm_sysctl.c                    |   2 +-
 hw/misc/aspeed_scu.c                    |   2 +-
 hw/misc/aspeed_sdmc.c                   |   2 +-
 hw/misc/auxbus.c                        |   3 +-
 hw/misc/bcm2835_mbox.c                  |   2 +-
 hw/misc/bcm2835_property.c              |   2 +-
 hw/misc/debugexit.c                     |   2 +-
 hw/misc/eccmemctl.c                     |   2 +-
 hw/misc/edu.c                           |   7 +-
 hw/misc/hyperv_testdev.c                |   2 +-
 hw/misc/imx6_src.c                      |   2 +-
 hw/misc/ivshmem.c                       |  49 ++++---
 hw/misc/macio/cuda.c                    |   2 +-
 hw/misc/macio/macio.c                   |  45 +++---
 hw/misc/max111x.c                       |   4 +-
 hw/misc/mips_cmgcr.c                    |   2 +-
 hw/misc/mips_cpc.c                      |   2 +-
 hw/misc/mips_itu.c                      |   2 +-
 hw/misc/pc-testdev.c                    |   2 +-
 hw/misc/pci-testdev.c                   |   2 +-
 hw/misc/pvpanic.c                       |   5 +-
 hw/misc/sga.c                           |   2 +-
 hw/misc/tmp105.c                        |  12 +-
 hw/misc/unimp.c                         |   2 +-
 hw/misc/vmport.c                        |   2 +-
 hw/net/allwinner_emac.c                 |   2 +-
 hw/net/cadence_gem.c                    |   2 +-
 hw/net/dp8393x.c                        |   8 +-
 hw/net/e1000.c                          |   5 +-
 hw/net/e1000e.c                         |  11 +-
 hw/net/eepro100.c                       |   5 +-
 hw/net/fsl_etsec/etsec.c                |   2 +-
 hw/net/ftgmac100.c                      |   2 +-
 hw/net/imx_fec.c                        |   2 +-
 hw/net/lance.c                          |   3 +-
 hw/net/mcf_fec.c                        |   2 +-
 hw/net/ne2000-isa.c                     |  10 +-
 hw/net/ne2000.c                         |   5 +-
 hw/net/pcnet-pci.c                      |   5 +-
 hw/net/rocker/qmp-norocker.c            |   9 +-
 hw/net/rocker/rocker.c                  |   5 +-
 hw/net/rocker/rocker_of_dpa.c           |   2 +-
 hw/net/rtl8139.c                        |   5 +-
 hw/net/spapr_llan.c                     |   5 +-
 hw/net/virtio-net.c                     |  10 +-
 hw/net/vmxnet3.c                        |  11 +-
 hw/net/xilinx_axienet.c                 |   2 +-
 hw/net/xilinx_ethlite.c                 |   2 +-
 hw/nvram/fw_cfg.c                       |  21 ++-
 hw/nvram/mac_nvram.c                    |   4 +-
 hw/nvram/spapr_nvram.c                  |   2 +-
 hw/pci-bridge/dec.c                     |   4 +-
 hw/pci-bridge/gen_pcie_root_port.c      |   2 +-
 hw/pci-bridge/ioh3420.c                 |   2 +-
 hw/pci-bridge/pci_bridge_dev.c          |   4 +-
 hw/pci-bridge/pci_expander_bridge.c     |  16 +--
 hw/pci-bridge/pcie_root_port.c          |   2 +-
 hw/pci-host/apb.c                       |   4 +-
 hw/pci-host/bonito.c                    |   2 +-
 hw/pci-host/gpex.c                      |   5 +-
 hw/pci-host/grackle.c                   |   2 +-
 hw/pci-host/piix.c                      |  28 ++--
 hw/pci-host/ppce500.c                   |   2 +-
 hw/pci-host/prep.c                      |   6 +-
 hw/pci-host/q35.c                       |  39 +++---
 hw/pci-host/uninorth.c                  |   9 +-
 hw/pci-host/versatile.c                 |   4 +-
 hw/pci-host/xilinx-pcie.c               |   7 +-
 hw/pci/msi.c                            |   2 +-
 hw/pci/msix.c                           |   4 +-
 hw/pci/pci-stub.c                       |   2 +-
 hw/pci/pci.c                            |  44 +++---
 hw/pci/pcie.c                           |  10 +-
 hw/pci/pcie_aer.c                       |   2 +-
 hw/pci/shpc.c                           |  22 ++-
 hw/pcmcia/pxa2xx.c                      |   3 +-
 hw/ppc/e500.c                           |  11 +-
 hw/ppc/mac_newworld.c                   |   2 +-
 hw/ppc/mac_oldworld.c                   |   2 +-
 hw/ppc/pnv.c                            |  52 +++----
 hw/ppc/pnv_core.c                       |  25 ++--
 hw/ppc/pnv_lpc.c                        |   2 +-
 hw/ppc/pnv_occ.c                        |   2 +-
 hw/ppc/pnv_psi.c                        |   5 +-
 hw/ppc/pnv_xscom.c                      |   2 +-
 hw/ppc/prep.c                           |   9 +-
 hw/ppc/prep_systemio.c                  |   2 +-
 hw/ppc/rs6000_mc.c                      |   2 +-
 hw/ppc/spapr.c                          |  89 ++++++------
 hw/ppc/spapr_cpu_core.c                 |   9 +-
 hw/ppc/spapr_drc.c                      |  66 +++++----
 hw/ppc/spapr_hcall.c                    |   2 +-
 hw/ppc/spapr_iommu.c                    |   7 +-
 hw/ppc/spapr_pci.c                      |  30 ++--
 hw/ppc/spapr_rng.c                      |   6 +-
 hw/ppc/spapr_rtc.c                      |   9 +-
 hw/ppc/spapr_vio.c                      |   2 +-
 hw/s390x/3270-ccw.c                     |   2 +-
 hw/s390x/ccw-device.c                   |   2 +-
 hw/s390x/css-bridge.c                   |   8 +-
 hw/s390x/css.c                          |  18 ++-
 hw/s390x/event-facility.c               |  12 +-
 hw/s390x/ipl.c                          |   7 +-
 hw/s390x/s390-ccw.c                     |   7 +-
 hw/s390x/s390-pci-bus.c                 |  20 +--
 hw/s390x/s390-skeys.c                   |  16 ++-
 hw/s390x/s390-virtio-ccw.c              |  49 +++----
 hw/s390x/s390-virtio.c                  |   4 +-
 hw/s390x/sclp.c                         |   9 +-
 hw/s390x/virtio-ccw.c                   |  61 ++++----
 hw/scsi/esp-pci.c                       |  10 +-
 hw/scsi/esp.c                           |   2 +-
 hw/scsi/lsi53c895a.c                    |   4 +-
 hw/scsi/megasas.c                       |   4 +-
 hw/scsi/mptsas.c                        |   2 +-
 hw/scsi/scsi-bus.c                      |  34 ++---
 hw/scsi/scsi-disk.c                     |  24 ++--
 hw/scsi/scsi-generic.c                  |   2 +-
 hw/scsi/spapr_vscsi.c                   |   2 +-
 hw/scsi/vhost-scsi-common.c             |   2 +-
 hw/scsi/vhost-scsi.c                    |  17 +--
 hw/scsi/virtio-scsi-dataplane.c         |   2 +-
 hw/scsi/virtio-scsi.c                   |  22 +--
 hw/scsi/vmw_pvscsi.c                    |  10 +-
 hw/sd/pl181.c                           |   2 +-
 hw/sd/sd.c                              |   4 +-
 hw/sd/sdhci.c                           |   4 +-
 hw/sd/ssi-sd.c                          |   2 +-
 hw/sh4/sh_pci.c                         |   2 +-
 hw/smbios/smbios-stub.c                 |   2 +-
 hw/smbios/smbios.c                      |   2 +-
 hw/sparc/sun4m.c                        |   4 +-
 hw/sparc64/sun4u.c                      |   6 +-
 hw/ssi/aspeed_smc.c                     |   2 +-
 hw/ssi/imx_spi.c                        |   2 +-
 hw/ssi/ssi.c                            |   2 +-
 hw/ssi/xilinx_spips.c                   |   4 +-
 hw/timer/a9gtimer.c                     |   2 +-
 hw/timer/altera_timer.c                 |   2 +-
 hw/timer/arm_mptimer.c                  |   2 +-
 hw/timer/arm_timer.c                    |   2 +-
 hw/timer/aspeed_timer.c                 |   2 +-
 hw/timer/hpet.c                         |   2 +-
 hw/timer/i8254.c                        |   2 +-
 hw/timer/i8254_common.c                 |   2 +-
 hw/timer/imx_epit.c                     |   2 +-
 hw/timer/imx_gpt.c                      |   2 +-
 hw/timer/lm32_timer.c                   |   2 +-
 hw/timer/m48t59-isa.c                   |   2 +-
 hw/timer/m48t59.c                       |   4 +-
 hw/timer/mc146818rtc.c                  |  14 +-
 hw/timer/milkymist-sysctl.c             |   2 +-
 hw/timer/pxa2xx_timer.c                 |   2 +-
 hw/timer/xilinx_timer.c                 |   2 +-
 hw/tpm/tpm_tis.c                        |   2 +-
 hw/usb/bus.c                            |  64 ++++-----
 hw/usb/dev-audio.c                      |   4 +-
 hw/usb/dev-bluetooth.c                  |   4 +-
 hw/usb/dev-hid.c                        |  13 +-
 hw/usb/dev-hub.c                        |   4 +-
 hw/usb/dev-mtp.c                        |   2 +-
 hw/usb/dev-network.c                    |   6 +-
 hw/usb/dev-serial.c                     |   8 +-
 hw/usb/dev-smartcard-reader.c           |   4 +-
 hw/usb/dev-storage.c                    |  18 +--
 hw/usb/dev-uas.c                        |   4 +-
 hw/usb/dev-wacom.c                      |   4 +-
 hw/usb/hcd-ehci-pci.c                   |   7 +-
 hw/usb/hcd-ehci-sysbus.c                |   2 +-
 hw/usb/hcd-ehci.c                       |   6 +-
 hw/usb/hcd-ohci.c                       |  18 +--
 hw/usb/hcd-uhci.c                       |  10 +-
 hw/usb/hcd-xhci.c                       |   4 +-
 hw/usb/host-libusb.c                    |   6 +-
 hw/usb/redirect.c                       |   6 +-
 hw/vfio/amd-xgbe.c                      |   2 +-
 hw/vfio/calxeda-xgmac.c                 |   2 +-
 hw/vfio/ccw.c                           |  14 +-
 hw/vfio/common.c                        |   7 +-
 hw/vfio/pci-quirks.c                    |   6 +-
 hw/vfio/pci.c                           |  35 +++--
 hw/vfio/platform.c                      |   9 +-
 hw/virtio/vhost-vsock.c                 |   8 +-
 hw/virtio/virtio-balloon.c              |  25 ++--
 hw/virtio/virtio-bus.c                  |   2 +-
 hw/virtio/virtio-crypto-pci.c           |   5 +-
 hw/virtio/virtio-crypto.c               |  12 +-
 hw/virtio/virtio-mmio.c                 |   2 +-
 hw/virtio/virtio-pci.c                  |  48 ++++---
 hw/virtio/virtio-rng.c                  |  20 +--
 hw/virtio/virtio.c                      |  24 ++--
 hw/watchdog/watchdog.c                  |   3 +-
 hw/watchdog/wdt_aspeed.c                |   2 +-
 hw/watchdog/wdt_diag288.c               |   4 +-
 hw/watchdog/wdt_i6300esb.c              |   2 +-
 hw/watchdog/wdt_ib700.c                 |   2 +-
 hw/xen/xen-host-pci-device.c            |  12 +-
 hw/xen/xen_backend.c                    |   4 +-
 hw/xen/xen_pt.c                         |   2 +-
 hw/xen/xen_pt_config_init.c             |   4 +-
 hw/xen/xen_pt_graphics.c                |   2 +-
 hw/xen/xen_pvdev.c                      |   3 +-
 io/channel-buffer.c                     |  10 +-
 io/channel-command.c                    |  16 +--
 io/channel-file.c                       |  12 +-
 io/channel-socket.c                     |  30 ++--
 io/channel-tls.c                        |  18 +--
 io/channel-util.c                       |   2 +-
 io/channel-websock.c                    |  26 ++--
 io/channel.c                            |  20 +--
 io/dns-resolver.c                       |   6 +-
 io/task.c                               |   2 +-
 iothread.c                              |   8 +-
 linux-user/elfload.c                    |   4 +-
 linux-user/uname.c                      |   3 +-
 memory.c                                |  21 +--
 memory_mapping.c                        |   2 +-
 migration/block.c                       |   3 +-
 migration/colo-failover.c               |   4 +-
 migration/colo.c                        |  38 +++--
 migration/exec.c                        |   5 +-
 migration/fd.c                          |   5 +-
 migration/migration.c                   |  43 +++---
 migration/qemu-file-channel.c           |  11 +-
 migration/ram.c                         |   4 +-
 migration/rdma.c                        |  40 +++---
 migration/savevm.c                      |  14 +-
 migration/socket.c                      |  18 +--
 migration/tls.c                         |   6 +-
 monitor.c                               |  57 ++++----
 nbd/client.c                            |  29 ++--
 nbd/common.c                            |   2 +-
 nbd/server.c                            |  22 +--
 net/colo-compare.c                      |  25 ++--
 net/dump.c                              |  19 +--
 net/filter-buffer.c                     |  11 +-
 net/filter-mirror.c                     |  22 +--
 net/filter-rewriter.c                   |   2 +-
 net/filter.c                            |  30 ++--
 net/hub.c                               |   2 +-
 net/l2tpv3.c                            |   2 +-
 net/net.c                               |  31 +++--
 net/netmap.c                            |   5 +-
 net/slirp.c                             |   2 +-
 net/socket.c                            |   2 +-
 net/tap-bsd.c                           |  10 +-
 net/tap-linux.c                         |   5 +-
 net/tap-solaris.c                       |   7 +-
 net/tap-stub.c                          |   5 +-
 net/tap-win32.c                         |   2 +-
 net/tap.c                               |  21 ++-
 net/vde.c                               |   2 +-
 net/vhost-user.c                        |   7 +-
 numa.c                                  |  21 +--
 qapi/opts-visitor.c                     |  28 ++--
 qapi/qapi-clone-visitor.c               |  20 +--
 qapi/qapi-dealloc-visitor.c             |  22 +--
 qapi/qapi-util.c                        |   2 +-
 qapi/qmp-dispatch.c                     |   5 +-
 qapi/qobject-input-visitor.c            |  50 ++++---
 qapi/qobject-output-visitor.c           |  20 +--
 qapi/string-input-visitor.c             |  25 ++--
 qapi/string-output-visitor.c            |  14 +-
 qdev-monitor.c                          |  35 +++--
 qemu-img.c                              |  28 ++--
 qemu-io.c                               |   2 +-
 qemu-nbd.c                              |   7 +-
 qga/commands-posix.c                    | 222 ++++++++++++++----------------
 qga/commands-win32.c                    | 101 +++++++-------
 qga/commands.c                          |  16 +--
 qga/main.c                              |   4 +-
 qga/vss-win32.c                         |   2 +-
 qmp.c                                   |  87 ++++++------
 qobject/json-parser.c                   |   5 +-
 qobject/qdict.c                         |   4 +-
 qobject/qjson.c                         |   5 +-
 qom/container.c                         |   3 +-
 qom/cpu.c                               |  10 +-
 qom/object.c                            | 237 +++++++++++++++-----------------
 qom/object_interfaces.c                 |  15 +-
 qom/qom-qobject.c                       |   4 +-
 qtest.c                                 |   3 +-
 replication.c                           |  32 ++---
 stubs/arch-query-cpu-def.c              |   2 +-
 stubs/arch-query-cpu-model-baseline.c   |   2 +-
 stubs/arch-query-cpu-model-comparison.c |   2 +-
 stubs/arch-query-cpu-model-expansion.c  |   2 +-
 stubs/migr-blocker.c                    |   2 +-
 stubs/monitor.c                         |   2 +-
 stubs/uuid.c                            |   2 +-
 stubs/vmgenid.c                         |   2 +-
 stubs/vmstate.c                         |   2 +-
 stubs/xen-hvm.c                         |   4 +-
 target/alpha/cpu.c                      |  10 +-
 target/arm/cpu.c                        |   8 +-
 target/arm/cpu64.c                      |   9 +-
 target/arm/helper.c                     |   2 +-
 target/arm/monitor.c                    |   2 +-
 target/cris/cpu.c                       |   8 +-
 target/hppa/cpu.c                       |  10 +-
 target/i386/arch_memory_mapping.c       |   2 +-
 target/i386/cpu.c                       | 133 +++++++++---------
 target/lm32/cpu.c                       |   8 +-
 target/m68k/cpu.c                       |   8 +-
 target/m68k/helper.c                    |   3 +-
 target/microblaze/cpu.c                 |   8 +-
 target/microblaze/translate.c           |   3 +-
 target/mips/cpu.c                       |   8 +-
 target/mips/translate.c                 |   3 +-
 target/moxie/cpu.c                      |   8 +-
 target/nios2/cpu.c                      |  10 +-
 target/openrisc/cpu.c                   |   8 +-
 target/ppc/compat.c                     |   5 +-
 target/ppc/kvm.c                        |   4 +-
 target/ppc/translate_init.c             |  35 ++---
 target/s390x/cpu.c                      |  14 +-
 target/s390x/cpu_models.c               |  79 ++++++-----
 target/s390x/helper.c                   |   7 +-
 target/s390x/kvm.c                      |  10 +-
 target/sh4/cpu.c                        |   8 +-
 target/sparc/cpu.c                      |  14 +-
 target/tilegx/cpu.c                     |  10 +-
 target/tricore/cpu.c                    |   8 +-
 target/unicore32/cpu.c                  |   8 +-
 target/xtensa/cpu.c                     |   8 +-
 target/xtensa/helper.c                  |   3 +-
 tests/check-qom-proplist.c              |  29 ++--
 tests/io-channel-helpers.c              |   4 +-
 tests/test-char.c                       |   2 +-
 tests/test-crypto-block.c               |   6 +-
 tests/test-crypto-hash.c                |   3 +-
 tests/test-crypto-tlscredsx509.c        |   4 +-
 tests/test-crypto-tlssession.c          |   2 +-
 tests/test-io-channel-socket.c          |   2 +-
 tests/test-io-channel-tls.c             |  13 +-
 tests/test-logging.c                    |   3 +-
 tests/test-qapi-util.c                  | 101 +++++++++++++-
 tests/test-qdev-global-props.c          |   9 +-
 tests/test-qemu-opts.c                  |   6 +-
 tests/test-qmp-commands.c               |  17 +--
 tests/test-qmp-event.c                  |   3 +-
 tests/test-string-input-visitor.c       |  12 +-
 tests/test-visitor-serialization.c      |  25 ++--
 tpm.c                                   |  10 +-
 trace/qmp.c                             |   8 +-
 ui/console.c                            |  12 +-
 ui/gtk.c                                |  15 +-
 ui/input-legacy.c                       |   2 +-
 ui/input-linux.c                        |  20 +--
 ui/input.c                              |   6 +-
 ui/spice-core.c                         |   7 +-
 ui/vnc-auth-sasl.c                      |   6 +-
 ui/vnc.c                                |  38 ++---
 util/aio-posix.c                        |   3 +-
 util/aio-win32.c                        |   3 +-
 util/async.c                            |   2 +-
 util/base64.c                           |   2 +-
 util/error.c                            |  29 ++--
 util/keyval.c                           |   9 +-
 util/log.c                              |   4 +-
 util/main-loop.c                        |   2 +-
 util/qemu-config.c                      |  28 ++--
 util/qemu-option.c                      |  68 +++++----
 util/qemu-sockets.c                     |  79 ++++++-----
 util/throttle.c                         |   2 +-
 vl.c                                    |  99 +++++++------
 tests/Makefile.include                  |   2 +-
 859 files changed, 5107 insertions(+), 4988 deletions(-)

-- 
2.11.0.259.g40922b1
