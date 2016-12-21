Received: from eggs.gnu.org ([2001:4830:134:3::10]:48860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJjd4-0001Je-97
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cJjd0-0007Kr-3j
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:20:34 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:37792 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cJjcz-0007KJ-Jt
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 11:20:30 -0500
References: <148233416746.76.5563361069168284370@790289a7ca88>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4ce3059a-614e-0479-6315-c090fc6d243c@virtuozzo.com>
Date: Wed, 21 Dec 2016 19:20:19 +0300
MIME-Version: 1.0
In-Reply-To: <148233416746.76.5563361069168284370@790289a7ca88>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 00/24] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

Last patch breaks it.

Fix will look like

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b9f3d62..dd987a1 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -79,7 +79,7 @@ typedef struct Qcow2BitmapTable {
  } Qcow2BitmapTable;
  typedef QSIMPLEQ_HEAD(Qcow2BitmapTableList, Qcow2BitmapTable)=20
Qcow2BitmapTableList;

-typedef struct Qcow2Bitmap {
+struct Qcow2Bitmap {
      Qcow2BitmapTable table;
      uint32_t flags;
      uint8_t granularity_bits;
@@ -88,7 +88,7 @@ typedef struct Qcow2Bitmap {
      BdrvDirtyBitmap *dirty_bitmap;

      QSIMPLEQ_ENTRY(Qcow2Bitmap) entry;
-} Qcow2Bitmap;
+};

  typedef enum BitmapType {
      BT_DIRTY_TRACKING_BITMAP =3D 1



21.12.2016 18:29, no-reply@patchew.org wrote:
> Hi,
>
> Your series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>
> Type: series
> Message-id: 1482332102-131788-1-git-send-email-vsementsov@virtuozzo.com
> Subject: [Qemu-devel] [PATCH v10 00/24] qcow2: persistent dirty bitmaps
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=3D1
> export J=3D16
> make docker-test-quick@centos6
> make docker-test-mingw@fedora
> make docker-test-build@min-glib
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> ef76b98 qcow2-bitmap: cache bitmap list in BDRVQcow2State
> a357743 qcow2: add .bdrv_remove_persistent_dirty_bitmap
> 8310147 block/dirty-bitmap: deep release dirty bitmaps
> 089c498 qcow2-bitmap: refcounts
> fbfe535 qcow2-refcount: rename inc_refcounts() and make it public
> 275eed2 iotests: test qcow2 persistent dirty bitmap
> 96a9ce0 qmp: add x-debug-block-dirty-bitmap-sha256
> 3e6dd36 qmp: add autoload parameter to block-dirty-bitmap-add
> b5418b0 qmp: add persistent flag to block-dirty-bitmap-add
> f624bc8 qcow2: add .bdrv_can_store_new_dirty_bitmap
> 4d9d7ac block: add bdrv_can_store_new_dirty_bitmap
> 87d58da qcow2: add .bdrv_store_persistent_dirty_bitmaps()
> 5fbebdd block/dirty-bitmap: add bdrv_dirty_bitmap_next()
> 731f771 block: introduce persistent dirty bitmaps
> 714509e block/dirty-bitmap: add autoload field to BdrvDirtyBitmap
> 7ff58fc qcow2: add .bdrv_load_autoloading_dirty_bitmaps
> 7a56b01 block: introduce auto-loading bitmaps
> 566981a qcow2: add bitmaps extension
> ec285c1 block/dirty-bitmap: add deserialize_ones func
> d4759b3 block: fix bdrv_dirty_bitmap_granularity signature
> e5331b0 tests: add hbitmap iter test
> e1b9104 hbitmap: improve dirty iter
> 7dc36ce specs/qcow2: do not use wording 'bitmap header'
> 3a6086b specs/qcow2: fix bitmap granularity qemu-specific note
>
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for pat=
h 'dtc'
> Cloning into 'dtc'...
> Submodule path 'dtc': checked out '65cc4d2748a2c2e6f27f1cf39e07a5dbabd8=
0ebf'
>    BUILD   centos6
> make[1]: Entering directory `/var/tmp/patchew-tester-tmp-xcliqr1_/src'
>    ARCHIVE qemu.tgz
>    ARCHIVE dtc.tgz
>    COPY    RUNNER
>      RUN test-quick in qemu:centos6
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
> PACKAGES=3Dlibfdt-devel ccache     tar git make gcc g++     zlib-devel =
glib2-devel SDL-devel pixman-devel     epel-release
> HOSTNAME=3D0ca1e1148429
> TERM=3Dxterm
> MAKEFLAGS=3D -j16
> HISTSIZE=3D1000
> J=3D16
> USER=3Droot
> CCACHE_DIR=3D/var/tmp/ccache
> EXTRA_CONFIGURE_OPTS=3D
> V=3D
> SHOW_ENV=3D1
> MAIL=3D/var/spool/mail/root
> PATH=3D/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin=
:/usr/sbin:/usr/bin:/sbin:/bin
> PWD=3D/
> LANG=3Den_US.UTF-8
> TARGET_LIST=3D
> HISTCONTROL=3Dignoredups
> SHLVL=3D1
> HOME=3D/root
> TEST_DIR=3D/tmp/qemu-test
> LOGNAME=3Droot
> LESSOPEN=3D||/usr/bin/lesspipe.sh %s
> FEATURES=3D dtc
> DEBUG=3D
> G_BROKEN_FILENAMES=3D1
> CCACHE_HASHDIR=3D
> _=3D/usr/bin/env
>
> Configure options:
> --enable-werror --target-list=3Dx86_64-softmmu,aarch64-softmmu --prefix=
=3D/var/tmp/qemu-build/install
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
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
> QEMU_CFLAGS       -I/usr/include/pixman-1    -pthread -I/usr/include/gl=
ib-2.0 -I/usr/lib64/glib-2.0/include   -fPIE -DPIE -m64 -mcx16 -D_GNU_SOU=
RCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wre=
dundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-str=
ict-aliasing -fno-common -fwrapv  -Wendif-labels -Wmissing-include-dirs -=
Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -=
Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype=
-limits -fstack-protector-all
> LDFLAGS           -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -=
g
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
>    GEN     x86_64-softmmu/config-devices.mak.tmp
>    GEN     aarch64-softmmu/config-devices.mak.tmp
>    GEN     config-host.h
>    GEN     qemu-options.def
>    GEN     qmp-commands.h
>    GEN     qapi-types.h
>    GEN     qapi-visit.h
>    GEN     qapi-event.h
>    GEN     qmp-introspect.h
>    GEN     x86_64-softmmu/config-devices.mak
>    GEN     aarch64-softmmu/config-devices.mak
>    GEN     module_block.h
>    GEN     tests/test-qapi-types.h
>    GEN     tests/test-qapi-visit.h
>    GEN     tests/test-qmp-commands.h
>    GEN     tests/test-qapi-event.h
>    GEN     tests/test-qmp-introspect.h
>    GEN     config-all-devices.mak
>    GEN     trace/generated-tracers.h
>    GEN     trace/generated-tcg-tracers.h
>    GEN     trace/generated-helpers-wrappers.h
>    GEN     trace/generated-helpers.h
>    CC      tests/qemu-iotests/socket_scm_helper.o
>    GEN     qga/qapi-generated/qga-qapi-types.h
>    GEN     qga/qapi-generated/qga-qapi-visit.h
>    GEN     qga/qapi-generated/qga-qmp-commands.h
>    GEN     qga/qapi-generated/qga-qapi-types.c
>    GEN     qga/qapi-generated/qga-qapi-visit.c
>    GEN     qga/qapi-generated/qga-qmp-marshal.c
>    GEN     qmp-introspect.c
>    GEN     qapi-types.c
>    GEN     qapi-visit.c
>    GEN     qapi-event.c
>    CC      qapi/qapi-visit-core.o
>    CC      qapi/qobject-output-visitor.o
>    CC      qapi/qapi-dealloc-visitor.o
>    CC      qapi/qobject-input-visitor.o
>    CC      qapi/qmp-registry.o
>    CC      qapi/qmp-dispatch.o
>    CC      qapi/string-output-visitor.o
>    CC      qapi/opts-visitor.o
>    CC      qapi/string-input-visitor.o
>    CC      qapi/qmp-event.o
>    CC      qapi/qapi-clone-visitor.o
>    CC      qapi/qapi-util.o
>    CC      qobject/qnull.o
>    CC      qobject/qint.o
>    CC      qobject/qstring.o
>    CC      qobject/qdict.o
>    CC      qobject/qlist.o
>    CC      qobject/qfloat.o
>    CC      qobject/qbool.o
>    CC      qobject/qjson.o
>    CC      qobject/qobject.o
>    CC      qobject/json-lexer.o
>    CC      qobject/json-streamer.o
>    CC      qobject/json-parser.o
>    GEN     trace/generated-tracers.c
>    CC      trace/control.o
>    CC      trace/qmp.o
>    CC      util/osdep.o
>    CC      util/cutils.o
>    CC      util/unicode.o
>    CC      util/qemu-timer-common.o
>    CC      util/bufferiszero.o
>    CC      util/compatfd.o
>    CC      util/event_notifier-posix.o
>    CC      util/mmap-alloc.o
>    CC      util/oslib-posix.o
>    CC      util/qemu-openpty.o
>    CC      util/qemu-thread-posix.o
>    CC      util/memfd.o
>    CC      util/envlist.o
>    CC      util/path.o
>    CC      util/module.o
>    CC      util/bitmap.o
>    CC      util/bitops.o
>    CC      util/hbitmap.o
>    CC      util/fifo8.o
>    CC      util/acl.o
>    CC      util/error.o
>    CC      util/qemu-error.o
>    CC      util/id.o
>    CC      util/iov.o
>    CC      util/qemu-config.o
>    CC      util/qemu-sockets.o
>    CC      util/uri.o
>    CC      util/notify.o
>    CC      util/qemu-option.o
>    CC      util/qemu-progress.o
>    CC      util/hexdump.o
>    CC      util/crc32c.o
>    CC      util/uuid.o
>    CC      util/throttle.o
>    CC      util/getauxval.o
>    CC      util/readline.o
>    CC      util/rcu.o
>    CC      util/qemu-coroutine.o
>    CC      util/qemu-coroutine-lock.o
>    CC      util/qemu-coroutine-io.o
>    CC      util/qemu-coroutine-sleep.o
>    CC      util/coroutine-ucontext.o
>    CC      util/buffer.o
>    CC      util/timed-average.o
>    CC      util/base64.o
>    CC      util/log.o
>    CC      util/qdist.o
>    CC      util/qht.o
>    CC      util/range.o
>    CC      crypto/pbkdf-stub.o
>    CC      stubs/arch-query-cpu-def.o
>    CC      stubs/arch-query-cpu-model-expansion.o
>    CC      stubs/arch-query-cpu-model-comparison.o
>    CC      stubs/arch-query-cpu-model-baseline.o
>    CC      stubs/bdrv-next-monitor-owned.o
>    CC      stubs/blk-commit-all.o
>    CC      stubs/blockdev-close-all-bdrv-states.o
>    CC      stubs/cpu-get-clock.o
>    CC      stubs/clock-warp.o
>    CC      stubs/cpu-get-icount.o
>    CC      stubs/dump.o
>    CC      stubs/error-printf.o
>    CC      stubs/fdset-add-fd.o
>    CC      stubs/fdset-find-fd.o
>    CC      stubs/fdset-get-fd.o
>    CC      stubs/fdset-remove-fd.o
>    CC      stubs/gdbstub.o
>    CC      stubs/get-fd.o
>    CC      stubs/get-next-serial.o
>    CC      stubs/get-vm-name.o
>    CC      stubs/iothread.o
>    CC      stubs/is-daemonized.o
>    CC      stubs/iothread-lock.o
>    CC      stubs/machine-init-done.o
>    CC      stubs/migr-blocker.o
>    CC      stubs/mon-is-qmp.o
>    CC      stubs/monitor-init.o
>    CC      stubs/notify-event.o
>    CC      stubs/qtest.o
>    CC      stubs/replay.o
>    CC      stubs/reset.o
>    CC      stubs/replay-user.o
>    CC      stubs/runstate-check.o
>    CC      stubs/set-fd-handler.o
>    CC      stubs/slirp.o
>    CC      stubs/sysbus.o
>    CC      stubs/trace-control.o
>    CC      stubs/uuid.o
>    CC      stubs/vm-stop.o
>    CC      stubs/vmstate.o
>    CC      stubs/cpus.o
>    CC      stubs/kvm.o
>    CC      stubs/qmp_pc_dimm_device_list.o
>    CC      stubs/target-monitor-defs.o
>    CC      stubs/target-get-monitor-def.o
>    CC      stubs/vhost.o
>    CC      stubs/iohandler.o
>    CC      stubs/smbios_type_38.o
>    CC      stubs/ipmi.o
>    CC      stubs/pc_madt_cpu_entry.o
>    CC      stubs/migration-colo.o
>    CC      contrib/ivshmem-client/ivshmem-client.o
>    CC      contrib/ivshmem-client/main.o
>    CC      contrib/ivshmem-server/ivshmem-server.o
>    CC      contrib/ivshmem-server/main.o
>    CC      qemu-nbd.o
>    CC      async.o
>    CC      thread-pool.o
>    CC      block.o
>    CC      blockjob.o
>    CC      main-loop.o
>    CC      iohandler.o
>    CC      qemu-timer.o
>    CC      aio-posix.o
>    CC      qemu-io-cmds.o
>    CC      replication.o
>    CC      block/raw_bsd.o
>    CC      block/qcow.o
>    CC      block/vdi.o
>    CC      block/vmdk.o
>    CC      block/cloop.o
>    CC      block/bochs.o
>    CC      block/vpc.o
>    CC      block/vvfat.o
>    CC      block/dmg.o
>    CC      block/qcow2.o
>    CC      block/qcow2-refcount.o
>    CC      block/qcow2-cluster.o
>    CC      block/qcow2-snapshot.o
>    CC      block/qcow2-cache.o
>    CC      block/qcow2-bitmap.o
>    CC      block/qed.o
>    CC      block/qed-gencb.o
>    CC      block/qed-l2-cache.o
>    CC      block/qed-table.o
>    CC      block/qed-cluster.o
>    CC      block/qed-check.o
>    CC      block/vhdx.o
>    CC      block/vhdx-endian.o
> /tmp/qemu-test/src/block/qcow2-bitmap.c:91: error: redefinition of type=
def =E2=80=98Qcow2Bitmap=E2=80=99
> /tmp/qemu-test/src/block/qcow2.h:245: note: previous declaration of =E2=
=80=98Qcow2Bitmap=E2=80=99 was here
> make: *** [block/qcow2-bitmap.o] Error 1
> make: *** Waiting for unfinished jobs....
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-xcliqr1_/src'
> make: *** [docker-run-test-quick@centos6] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org


--=20
Best regards,
Vladimir
