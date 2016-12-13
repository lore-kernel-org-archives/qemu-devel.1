Received: from eggs.gnu.org ([2001:4830:134:3::10]:43385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGhcy-0008Ab-5B
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGhcu-0001Es-B8
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:35:56 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:7962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cGhcq-00017S-3m
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:35:52 -0500
Message-ID: <584FA4A4.3050507@huawei.com>
Date: Tue, 13 Dec 2016 15:35:00 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <148161327342.226.10077965724854637760@5b492b8a941d>
In-Reply-To: <148161327342.226.10077965724854637760@5b492b8a941d>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 v3 0/6] crypto: add HMAC algorithms
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU-DEV <qemu-devel@nongnu.org>, famz@redhat.com, arei.gonglei@huawei.com, wu.wubin@huawei.com, jianjay.zhou@huawei.com

Hi Daniel,

The error is due to auto-build environment doesn't support both gcrypt and
nettle, and it's glibc(2.28) is too old, so I think I should add no-op in
hmac-glib.c when glibc is older than 2.30. for example:

#include <...>

#if GLIB_CHECK_VERSION(2, 30, 0)
	....
#else
	...(no-op func)
#endif

Do you have any suggestion ?

On 2016/12/13 15:14, no-reply@patchew.org wrote:

> Hi,
> 
> Your series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Subject: [Qemu-devel] [PATCH for-2.9 v3 0/6] crypto: add HMAC algorithms support
> Type: series
> Message-id: 1481612513-28556-1-git-send-email-longpeng2@huawei.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=1
> export J=16
> make docker-test-quick@centos6
> make docker-test-mingw@fedora
> make docker-test-build@min-glib
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/1481612513-28556-1-git-send-email-longpeng2@huawei.com -> patchew/1481612513-28556-1-git-send-email-longpeng2@huawei.com
> Switched to a new branch 'test'
> 3211053 crypto: add HMAC algorithms testcases
> 08d438f crypto: support HMAC algorithms based on nettle
> a8523c2 crypto: support HMAC algorithms based on glibc
> 3b04059 crypto: support HMAC algorithms based on libgcrypt
> 2e5e365 crypto: add HMAC algorithms framework
> 0a56990 configure: add CONFIG_GCRYPT_HMAC item
> 
> === OUTPUT BEGIN ===
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> Cloning into 'dtc'...
> Submodule path 'dtc': checked out '65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf'
>   BUILD   centos6
> make[1]: Entering directory `/var/tmp/patchew-tester-tmp-9oq6lvoc/src'
>   ARCHIVE qemu.tgz
>   ARCHIVE dtc.tgz
>   COPY    RUNNER
>     RUN test-quick in qemu:centos6 
> Packages installed:
> SDL-devel-1.2.14-7.el6_7.1.x86_64
> ccache-3.1.6-2.el6.x86_64
> epel-release-6-8.noarch
> gcc-4.4.7-17.el6.x86_64
> git-1.7.1-4.el6_7.1.x86_64
> glib2-devel-2.28.8-5.el6.x86_64
> libfdt-devel-1.4.0-1.el6.x86_64
> make-3.81-23.el6.x86_64
> package g++ is not installed
> pixman-devel-0.32.8-1.el6.x86_64
> tar-1.23-15.el6_8.x86_64
> zlib-devel-1.2.3-29.el6.x86_64
> 
> Environment variables:
> PACKAGES=libfdt-devel ccache     tar git make gcc g++     zlib-devel glib2-devel SDL-devel pixman-devel     epel-release
> HOSTNAME=c9cf25700fcd
> TERM=xterm
> MAKEFLAGS= -j16
> HISTSIZE=1000
> J=16
> USER=root
> CCACHE_DIR=/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=
> V=
> SHOW_ENV=1
> MAIL=/var/spool/mail/root
> PATH=/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> PWD=/
> LANG=en_US.UTF-8
> TARGET_LIST=
> HISTCONTROL=ignoredups
> SHLVL=1
> HOME=/root
> TEST_DIR=/tmp/qemu-test
> LOGNAME=root
> LESSOPEN=||/usr/bin/lesspipe.sh %s
> FEATURES= dtc
> DEBUG=
> G_BROKEN_FILENAMES=1
> CCACHE_HASHDIR=
> _=/usr/bin/env
> 
> Configure options:
> --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/var/tmp/qemu-build/install
> No C++ compiler available; disabling C++ specific optional code
> Install prefix    /var/tmp/qemu-build/install
> BIOS directory    /var/tmp/qemu-build/install/share/qemu
> binary directory  /var/tmp/qemu-build/install/bin
> library directory /var/tmp/qemu-build/install/lib
> module directory  /var/tmp/qemu-build/install/lib/qemu
> libexec directory /var/tmp/qemu-build/install/libexec
> include directory /var/tmp/qemu-build/install/include
> config directory  /var/tmp/qemu-build/install/etc
> local state directory   /var/tmp/qemu-build/install/var
> Manual directory  /var/tmp/qemu-build/install/share/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /tmp/qemu-test/src
> C compiler        cc
> Host C compiler   cc
> C++ compiler      
> Objective-C compiler cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g 
> QEMU_CFLAGS       -I/usr/include/pixman-1    -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels -Wmissing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-all
> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g 
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          x86_64
> host big endian   no
> target list       x86_64-softmmu aarch64-softmmu
> tcg debug enabled no
> gprof enabled     no
> sparse enabled    no
> strip binaries    yes
> profiler          no
> static build      no
> pixman            system
> SDL support       yes (1.2.14)
> GTK support       no 
> GTK GL support    no
> VTE support       no 
> TLS priority      NORMAL
> GNUTLS support    no
> GNUTLS rnd        no
> libgcrypt         no
> libgcrypt kdf     no
> nettle            no 
> nettle kdf        no
> libtasn1          no
> curses support    no
> virgl support     no
> curl support      no
> mingw32 support   no
> Audio drivers     oss
> Block whitelist (rw) 
> Block whitelist (ro) 
> VirtFS support    no
> VNC support       yes
> VNC SASL support  no
> VNC JPEG support  no
> VNC PNG support   no
> xen support       no
> brlapi support    no
> bluez  support    no
> Documentation     no
> PIE               yes
> vde support       no
> netmap support    no
> Linux AIO support no
> ATTR/XATTR support yes
> Install blobs     yes
> KVM support       yes
> COLO support      yes
> RDMA support      no
> TCG interpreter   no
> fdt support       yes
> preadv support    yes
> fdatasync         yes
> madvise           yes
> posix_madvise     yes
> libcap-ng support no
> vhost-net support yes
> vhost-scsi support yes
> vhost-vsock support yes
> Trace backends    log
> spice support     no 
> rbd support       no
> xfsctl support    no
> smartcard support no
> libusb            no
> usb net redir     no
> OpenGL support    no
> OpenGL dmabufs    no
> libiscsi support  no
> libnfs support    no
> build guest agent yes
> QGA VSS support   no
> QGA w32 disk info no
> QGA MSI support   no
> seccomp support   no
> coroutine backend ucontext
> coroutine pool    yes
> debug stack usage no
> GlusterFS support no
> Archipelago support no
> gcov              gcov
> gcov enabled      no
> TPM support       yes
> libssh2 support   no
> TPM passthrough   yes
> QOM debugging     yes
> lzo support       no
> snappy support    no
> bzip2 support     no
> NUMA host support no
> tcmalloc support  no
> jemalloc support  no
> avx2 optimization no
> replication support yes
>   GEN     x86_64-softmmu/config-devices.mak.tmp
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     qemu-options.def
>   GEN     config-host.h
>   GEN     qmp-commands.h
>   GEN     qapi-visit.h
>   GEN     qapi-types.h
>   GEN     qapi-event.h
>   GEN     qmp-introspect.h
>   GEN     x86_64-softmmu/config-devices.mak
>   GEN     aarch64-softmmu/config-devices.mak
>   GEN     module_block.h
>   GEN     tests/test-qapi-types.h
>   GEN     tests/test-qapi-visit.h
>   GEN     tests/test-qmp-commands.h
>   GEN     tests/test-qapi-event.h
>   GEN     tests/test-qmp-introspect.h
>   GEN     trace/generated-tracers.h
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     config-all-devices.mak
>   CC      tests/qemu-iotests/socket_scm_helper.o
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     qmp-introspect.c
>   GEN     qapi-types.c
>   GEN     qapi-visit.c
>   GEN     qapi-event.c
>   CC      qapi/qapi-visit-core.o
>   CC      qapi/qapi-dealloc-visitor.o
>   CC      qapi/qobject-input-visitor.o
>   CC      qapi/qobject-output-visitor.o
>   CC      qapi/qmp-registry.o
>   CC      qapi/qmp-dispatch.o
>   CC      qapi/string-input-visitor.o
>   CC      qapi/string-output-visitor.o
>   CC      qapi/opts-visitor.o
>   CC      qapi/qapi-clone-visitor.o
>   CC      qapi/qmp-event.o
>   CC      qapi/qapi-util.o
>   CC      qobject/qnull.o
>   CC      qobject/qint.o
>   CC      qobject/qstring.o
>   CC      qobject/qdict.o
>   CC      qobject/qlist.o
>   CC      qobject/qfloat.o
>   CC      qobject/qbool.o
>   CC      qobject/qjson.o
>   CC      qobject/qobject.o
>   CC      qobject/json-lexer.o
>   CC      qobject/json-streamer.o
>   CC      qobject/json-parser.o
>   GEN     trace/generated-tracers.c
>   CC      trace/control.o
>   CC      trace/qmp.o
>   CC      util/osdep.o
>   CC      util/cutils.o
>   CC      util/unicode.o
>   CC      util/qemu-timer-common.o
>   CC      util/bufferiszero.o
>   CC      util/compatfd.o
>   CC      util/event_notifier-posix.o
>   CC      util/mmap-alloc.o
>   CC      util/oslib-posix.o
>   CC      util/qemu-thread-posix.o
>   CC      util/qemu-openpty.o
>   CC      util/memfd.o
>   CC      util/envlist.o
>   CC      util/path.o
>   CC      util/module.o
>   CC      util/bitmap.o
>   CC      util/bitops.o
>   CC      util/hbitmap.o
>   CC      util/fifo8.o
>   CC      util/acl.o
>   CC      util/error.o
>   CC      util/qemu-error.o
>   CC      util/id.o
>   CC      util/iov.o
>   CC      util/qemu-config.o
>   CC      util/qemu-sockets.o
>   CC      util/notify.o
>   CC      util/uri.o
>   CC      util/qemu-option.o
>   CC      util/crc32c.o
>   CC      util/qemu-progress.o
>   CC      util/hexdump.o
>   CC      util/uuid.o
>   CC      util/throttle.o
>   CC      util/getauxval.o
>   CC      util/rcu.o
>   CC      util/readline.o
>   CC      util/qemu-coroutine.o
>   CC      util/qemu-coroutine-lock.o
>   CC      util/qemu-coroutine-io.o
>   CC      util/qemu-coroutine-sleep.o
>   CC      util/coroutine-ucontext.o
>   CC      util/buffer.o
>   CC      util/timed-average.o
>   CC      util/base64.o
>   CC      util/log.o
>   CC      util/qdist.o
>   CC      util/qht.o
>   CC      util/range.o
>   CC      crypto/pbkdf-stub.o
>   CC      stubs/arch-query-cpu-def.o
>   CC      stubs/arch-query-cpu-model-expansion.o
>   CC      stubs/arch-query-cpu-model-comparison.o
>   CC      stubs/arch-query-cpu-model-baseline.o
>   CC      stubs/bdrv-next-monitor-owned.o
>   CC      stubs/blk-commit-all.o
>   CC      stubs/blockdev-close-all-bdrv-states.o
>   CC      stubs/clock-warp.o
>   CC      stubs/cpu-get-clock.o
>   CC      stubs/cpu-get-icount.o
>   CC      stubs/dump.o
>   CC      stubs/error-printf.o
>   CC      stubs/fdset-add-fd.o
>   CC      stubs/fdset-find-fd.o
>   CC      stubs/fdset-get-fd.o
>   CC      stubs/fdset-remove-fd.o
>   CC      stubs/gdbstub.o
>   CC      stubs/get-fd.o
>   CC      stubs/get-next-serial.o
>   CC      stubs/iothread.o
>   CC      stubs/get-vm-name.o
>   CC      stubs/iothread-lock.o
>   CC      stubs/is-daemonized.o
>   CC      stubs/machine-init-done.o
>   CC      stubs/migr-blocker.o
>   CC      stubs/mon-is-qmp.o
>   CC      stubs/monitor-init.o
>   CC      stubs/notify-event.o
>   CC      stubs/qtest.o
>   CC      stubs/replay.o
>   CC      stubs/replay-user.o
>   CC      stubs/reset.o
>   CC      stubs/runstate-check.o
>   CC      stubs/set-fd-handler.o
>   CC      stubs/slirp.o
>   CC      stubs/trace-control.o
>   CC      stubs/sysbus.o
>   CC      stubs/uuid.o
>   CC      stubs/vm-stop.o
>   CC      stubs/vmstate.o
>   CC      stubs/cpus.o
>   CC      stubs/kvm.o
>   CC      stubs/qmp_pc_dimm_device_list.o
>   CC      stubs/target-monitor-defs.o
>   CC      stubs/target-get-monitor-def.o
>   CC      stubs/vhost.o
>   CC      stubs/iohandler.o
>   CC      stubs/smbios_type_38.o
>   CC      stubs/ipmi.o
>   CC      stubs/migration-colo.o
>   CC      stubs/pc_madt_cpu_entry.o
>   CC      contrib/ivshmem-client/ivshmem-client.o
>   CC      contrib/ivshmem-client/main.o
>   CC      contrib/ivshmem-server/ivshmem-server.o
>   CC      contrib/ivshmem-server/main.o
>   CC      qemu-nbd.o
>   CC      async.o
>   CC      thread-pool.o
>   CC      block.o
>   CC      blockjob.o
>   CC      main-loop.o
>   CC      iohandler.o
>   CC      qemu-timer.o
>   CC      aio-posix.o
>   CC      qemu-io-cmds.o
>   CC      replication.o
>   CC      block/raw_bsd.o
>   CC      block/qcow.o
>   CC      block/vdi.o
>   CC      block/vmdk.o
>   CC      block/cloop.o
>   CC      block/bochs.o
>   CC      block/vpc.o
>   CC      block/vvfat.o
>   CC      block/dmg.o
>   CC      block/qcow2.o
>   CC      block/qcow2-refcount.o
>   CC      block/qcow2-cluster.o
>   CC      block/qcow2-snapshot.o
>   CC      block/qcow2-cache.o
>   CC      block/qed.o
>   CC      block/qed-gencb.o
>   CC      block/qed-l2-cache.o
>   CC      block/qed-table.o
>   CC      block/qed-cluster.o
>   CC      block/qed-check.o
>   CC      block/vhdx.o
>   CC      block/vhdx-endian.o
>   CC      block/vhdx-log.o
>   CC      block/quorum.o
>   CC      block/parallels.o
>   CC      block/blkdebug.o
>   CC      block/blkverify.o
>   CC      block/blkreplay.o
>   CC      block/block-backend.o
>   CC      block/snapshot.o
>   CC      block/qapi.o
>   CC      block/raw-posix.o
>   CC      block/null.o
>   CC      block/mirror.o
>   CC      block/commit.o
>   CC      block/io.o
>   CC      block/throttle-groups.o
>   CC      block/nbd.o
>   CC      block/nbd-client.o
>   CC      block/sheepdog.o
>   CC      block/accounting.o
>   CC      block/dirty-bitmap.o
>   CC      block/write-threshold.o
>   CC      block/backup.o
>   CC      block/replication.o
>   CC      block/crypto.o
>   CC      nbd/server.o
>   CC      nbd/client.o
>   CC      nbd/common.o
>   CC      crypto/init.o
>   CC      crypto/hash.o
>   CC      crypto/hash-glib.o
>   CC      crypto/aes.o
>   CC      crypto/hmac.o
>   CC      crypto/hmac-glib.o
>   CC      crypto/desrfb.o
>   CC      crypto/cipher.o
>   CC      crypto/tlscreds.o
>   CC      crypto/tlscredsanon.o
>   CC      crypto/tlscredsx509.o
>   CC      crypto/tlssession.o
>   CC      crypto/secret.o
>   CC      crypto/random-platform.o
>   CC      crypto/pbkdf.o
>   CC      crypto/ivgen.o
>   CC      crypto/ivgen-essiv.o
>   CC      crypto/ivgen-plain64.o
>   CC      crypto/ivgen-plain.o
>   CC      crypto/afsplit.o
>   CC      crypto/xts.o
>   CC      crypto/block.o
>   CC      crypto/block-qcow.o
>   CC      crypto/block-luks.o
>   CC      io/channel.o
>   CC      io/channel-buffer.o
>   CC      io/channel-command.o
>   CC      io/channel-file.o
>   CC      io/channel-socket.o
>   CC      io/channel-tls.o
>   CC      io/channel-websock.o
>   CC      io/channel-watch.o
>   CC      io/channel-util.o
>   CC      io/task.o
>   CC      qom/object.o
>   CC      qom/container.o
>   CC      qom/qom-qobject.o
>   CC      qom/object_interfaces.o
>   GEN     qemu-img-cmds.h
>   CC      qemu-io.o
>   CC      qemu-bridge-helper.o
>   CC      blockdev.o
>   CC      blockdev-nbd.o
>   CC      iothread.o
>   CC      qdev-monitor.o
>   CC      device-hotplug.o
>   CC      os-posix.o
>   CC      qemu-char.o
>   CC      page_cache.o
>   CC      accel.o
>   CC      bt-host.o
>   CC      bt-vhci.o
>   CC      dma-helpers.o
>   CC      vl.o
>   CC      tpm.o
>   CC      device_tree.o
>   GEN     qmp-marshal.c
>   CC      qmp.o
>   CC      hmp.o
>   CC      cpus-common.o
>   CC      audio/audio.o
>   CC      audio/wavaudio.o
>   CC      audio/noaudio.o
>   CC      audio/mixeng.o
>   CC      audio/sdlaudio.o
>   CC      audio/ossaudio.o
>   CC      audio/wavcapture.o
>   CC      backends/rng.o
>   CC      backends/rng-egd.o
>   CC      backends/msmouse.o
>   CC      backends/rng-random.o
>   CC      backends/testdev.o
>   CC      backends/hostmem.o
>   CC      backends/tpm.o
>   CC      backends/hostmem-ram.o
>   CC      backends/hostmem-file.o
>   CC      backends/cryptodev.o
>   CC      backends/cryptodev-builtin.o
>   CC      block/stream.o
>   CC      disas/arm.o
>   CC      disas/i386.o
>   CC      fsdev/qemu-fsdev-dummy.o
>   CC      fsdev/qemu-fsdev-opts.o
>   CC      hw/acpi/core.o
>   CC      hw/acpi/pcihp.o
>   CC      hw/acpi/piix4.o
>   CC      hw/acpi/ich9.o
>   CC      hw/acpi/tco.o
>   CC      hw/acpi/cpu_hotplug.o
>   CC      hw/acpi/memory_hotplug.o
>   CC      hw/acpi/cpu.o
>   CC      hw/acpi/memory_hotplug_acpi_table.o
>   CC      hw/acpi/nvdimm.o
>   CC      hw/acpi/acpi_interface.o
>   CC      hw/acpi/bios-linker-loader.o
>   CC      hw/acpi/aml-build.o
>   CC      hw/acpi/ipmi.o
>   CC      hw/audio/es1370.o
>   CC      hw/audio/sb16.o
>   CC      hw/audio/ac97.o
>   CC      hw/audio/adlib.o
>   CC      hw/audio/fmopl.o
>   CC      hw/audio/gus.o
>   CC      hw/audio/gusemu_hal.o
>   CC      hw/audio/gusemu_mixer.o
>   CC      hw/audio/cs4231a.o
>   CC      hw/audio/intel-hda.o
>   CC      hw/audio/hda-codec.o
>   CC      hw/audio/pcspk.o
>   CC      hw/audio/wm8750.o
>   CC      hw/audio/pl041.o
>   CC      hw/audio/lm4549.o
>   CC      hw/block/block.o
>   CC      hw/audio/marvell_88w8618.o
>   CC      hw/block/cdrom.o
>   CC      hw/block/hd-geometry.o
>   CC      hw/block/fdc.o
>   CC      hw/block/m25p80.o
>   CC      hw/block/nand.o
>   CC      hw/block/pflash_cfi01.o
>   CC      hw/block/pflash_cfi02.o
>   CC      hw/block/ecc.o
>   CC      hw/block/nvme.o
>   CC      hw/block/onenand.o
>   CC      hw/bt/core.o
>   CC      hw/bt/sdp.o
>   CC      hw/bt/l2cap.o
>   CC      hw/bt/hci.o
>   CC      hw/bt/hid.o
> /tmp/qemu-test/src/crypto/hmac-glib.c:43: error: expected specifier-qualifier-list before ‘GHmac’
> /tmp/qemu-test/src/crypto/hmac-glib.c: In function ‘qcrypto_hmac_new’:
> /tmp/qemu-test/src/crypto/hmac-glib.c:74: error: ‘QCryptoHmacGlib’ has no member named ‘ghmac’
> /tmp/qemu-test/src/crypto/hmac-glib.c:74: warning: implicit declaration of function ‘g_hmac_new’
> /tmp/qemu-test/src/crypto/hmac-glib.c:74: warning: nested extern declaration of ‘g_hmac_new’
> /tmp/qemu-test/src/crypto/hmac-glib.c:76: error: ‘QCryptoHmacGlib’ has no member named ‘ghmac’
> /tmp/qemu-test/src/crypto/hmac-glib.c: In function ‘qcrypto_hmac_free’:
> /tmp/qemu-test/src/crypto/hmac-glib.c:99: warning: implicit declaration of function ‘g_hmac_unref’
> /tmp/qemu-test/src/crypto/hmac-glib.c:99: warning: nested extern declaration of ‘g_hmac_unref’
> /tmp/qemu-test/src/crypto/hmac-glib.c:99: error: ‘QCryptoHmacGlib’ has no member named ‘ghmac’
> /tmp/qemu-test/src/crypto/hmac-glib.c: In function ‘qcrypto_hmac_bytesv’:
> /tmp/qemu-test/src/crypto/hmac-glib.c:118: warning: implicit declaration of function ‘g_hmac_update’
> /tmp/qemu-test/src/crypto/hmac-glib.c:118: warning: nested extern declaration of ‘g_hmac_update’
> /tmp/qemu-test/src/crypto/hmac-glib.c:118: error: ‘QCryptoHmacGlib’ has no member named ‘ghmac’
> /tmp/qemu-test/src/crypto/hmac-glib.c:136: warning: implicit declaration of function ‘g_hmac_get_digest’
> /tmp/qemu-test/src/crypto/hmac-glib.c:136: warning: nested extern declaration of ‘g_hmac_get_digest’
> /tmp/qemu-test/src/crypto/hmac-glib.c:136: error: ‘QCryptoHmacGlib’ has no member named ‘ghmac’
> make: *** [crypto/hmac-glib.o] Error 1
> make: *** Waiting for unfinished jobs....
>   CC      hw/bt/hci-csr.o
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-9oq6lvoc/src'
> make: *** [docker-run-test-quick@centos6] Error 2
> === OUTPUT END ===
> 
> Test command exited with code: 2
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org


-- 
Regards,
Longpeng(Mike)
