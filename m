Received: from eggs.gnu.org ([2001:4830:134:3::10]:45567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cr4oL-0007iq-RA
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cr4oH-0005Ct-Pa
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:38:01 -0400
Date: Thu, 23 Mar 2017 15:37:53 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170323153753.GF13825@redhat.com>
References: <20170322144525.18964-1-eblake@redhat.com>
	<20170322144525.18964-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20170322144525.18964-3-eblake@redhat.com>
Subject: [Qemu-devel] Possible regression (was: Re: [PATCH v3 2/3] qom:
 Avoid unvisited 'id'/'qom-type' in user_creatable_add_opts)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, qemu-stable@nongnu.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2017 at 09:45:24AM -0500, Eric Blake wrote:
> A regression in commit 15c2f669e caused us to silently ignore
> excess input to the QemuOpts visitor.  Later, commit ea4641
> accidentally abused that situation, by removing "qom-type" and
> "id" from the corresponding QDict but leaving them defined in
> the QemuOpts, when using the pair of containers to create a
> user-defined object. Note that since we are already traversing
> two separate items (a QDict and a QemuOpts), we are already
> able to flag bogus arguments, as in:
> 
> $ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio -object memory-backend-ram,id=mem1,size=4k,bogus=huh
> qemu-system-x86_64: -object memory-backend-ram,id=mem1,size=4k,bogus=huh: Property '.bogus' not found
> 
> So the only real concern is that when we re-enable strict checking
> in the QemuOpts visitor, we do not want to start flagging the two
> leftover keys as unvisited.  Rearrange the code to clean out the
> QemuOpts listing in advance, rather than removing items from the
> QDict.  Since "qom-type" is usually an automatic implicit default,
> we don't have to restore it (this does mean that once instantiated,
> QemuOpts is not necessarily an accurate representation of the
> original command line - but this is not the first place to do that);
> however "id" has to be put back (requiring us to cast away a const).
> 
> [As a side note, hmp_object_add() turns a QDict into a QemuOpts,
> then calls user_creatable_add_opts() which converts QemuOpts into
> a new QDict. There are probably a lot of wasteful conversions like
> this, but cleaning them up is a much bigger task than the immediate
> regression fix.]
> 
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

This commit causes a problem for libguestfs:

  [02192ms] /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
  [...]
      -object rng-random,filename=/dev/urandom,id=rng0 \
      -device virtio-rng-pci,rng=rng0 \
  [...]
  qemu-system-x86_64: -object rng-random,filename=/dev/urandom,id=rng0: Parameter 'qom-type' is missing

(The full log is attached).  I don't know if we should be including
the qom-type parameter here, and if we should what it should be set to.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log

./run test-tool/libguestfs-test-tool -t 60
     ************************************************************
     *                    IMPORTANT NOTICE
     *
     * When reporting bugs, include the COMPLETE, UNEDITED
     * output below in your bug report.
     *
     ************************************************************
LD_LIBRARY_PATH=/home/rjones/d/libguestfs/ruby/ext/guestfs:/home/rjones/d/libguestfs/lib/.libs:/home/rjones/d/libguestfs/java/.libs:/home/rjones/d/libguestfs/gobject/.libs
SUPERMIN_KERNEL=/home/rjones/d/linux/arch/x86/boot/bzImage
LIBGUESTFS_BACKEND=direct
LIBGUESTFS_CACHEDIR=/home/rjones/d/libguestfs/tmp
LIBGUESTFS_HV=/home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64
LIBGUESTFS_TMPDIR=/home/rjones/d/libguestfs/tmp
LIBGUESTFS_PATH=/home/rjones/d/libguestfs/appliance
SUPERMIN_MODULES=/tmp/lib/modules/4.11.0-rc3+
PATH=/home/rjones/d/libguestfs/v2v:/home/rjones/d/libguestfs/tools:/home/rjones/d/libguestfs/test-tool:/home/rjones/d/libguestfs/sysprep:/home/rjones/d/libguestfs/sparsify:/home/rjones/d/libguestfs/resize:/home/rjones/d/libguestfs/rescue:/home/rjones/d/libguestfs/p2v:/home/rjones/d/libguestfs/make-fs:/home/rjones/d/libguestfs/inspector:/home/rjones/d/libguestfs/get-kernel:/home/rjones/d/libguestfs/fuse:/home/rjones/d/libguestfs/format:/home/rjones/d/libguestfs/fish:/home/rjones/d/libguestfs/erlang:/home/rjones/d/libguestfs/edit:/home/rjones/d/libguestfs/diff:/home/rjones/d/libguestfs/dib:/home/rjones/d/libguestfs/df:/home/rjones/d/libguestfs/customize:/home/rjones/d/libguestfs/cat:/home/rjones/d/libguestfs/builder:/home/rjones/d/libguestfs/align:/usr/libexec/python2-sphinx:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/rjones/.local/bin:/home/rjones/bin
XDG_RUNTIME_DIR=/run/user/1000
SELinux: Enforcing
guestfs_get_append: (null)
guestfs_get_autosync: 1
guestfs_get_backend: direct
guestfs_get_backend_settings: []
guestfs_get_cachedir: /home/rjones/d/libguestfs/tmp
guestfs_get_hv: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64
guestfs_get_memsize: 500
guestfs_get_network: 0
guestfs_get_path: /home/rjones/d/libguestfs/appliance
guestfs_get_pgroup: 0
guestfs_get_program: libguestfs-test-tool
guestfs_get_recovery_proc: 1
guestfs_get_smp: 1
guestfs_get_sockdir: /run/user/1000
guestfs_get_tmpdir: /home/rjones/d/libguestfs/tmp
guestfs_get_trace: 0
guestfs_get_verbose: 1
host_cpu: x86_64
Launching appliance, timeout set to 60 seconds.
libguestfs: launch: program=libguestfs-test-tool
libguestfs: launch: version=1.37.6
libguestfs: launch: backend registered: unix
libguestfs: launch: backend registered: uml
libguestfs: launch: backend registered: libvirt
libguestfs: launch: backend registered: direct
libguestfs: launch: backend=direct
libguestfs: launch: tmpdir=/home/rjones/d/libguestfs/tmp/libguestfstZZFOk
libguestfs: launch: umask=0002
libguestfs: launch: euid=1000
libguestfs: begin building supermin appliance
libguestfs: run supermin
libguestfs: command: run: /usr/bin/supermin
libguestfs: command: run: \ --build
libguestfs: command: run: \ --verbose
libguestfs: command: run: \ --if-newer
libguestfs: command: run: \ --lock /home/rjones/d/libguestfs/tmp/.guestfs-1000/lock
libguestfs: command: run: \ --copy-kernel
libguestfs: command: run: \ -f ext2
libguestfs: command: run: \ --host-cpu x86_64
libguestfs: command: run: \ /home/rjones/d/libguestfs/appliance/supermin.d
libguestfs: command: run: \ -o /home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d
supermin: version: 5.1.17
supermin: rpm: detected RPM version 4.13
supermin: package handler: fedora/rpm
supermin: acquiring lock on /home/rjones/d/libguestfs/tmp/.guestfs-1000/lock
supermin: build: /home/rjones/d/libguestfs/appliance/supermin.d
supermin: reading the supermin appliance
supermin: build: visiting /home/rjones/d/libguestfs/appliance/supermin.d/base.tar.gz type gzip base image (tar)
supermin: build: visiting /home/rjones/d/libguestfs/appliance/supermin.d/daemon.tar.gz type gzip base image (tar)
supermin: build: visiting /home/rjones/d/libguestfs/appliance/supermin.d/excludefiles type uncompressed excludefiles
supermin: build: visiting /home/rjones/d/libguestfs/appliance/supermin.d/hostfiles type uncompressed hostfiles
supermin: build: visiting /home/rjones/d/libguestfs/appliance/supermin.d/init.tar.gz type gzip base image (tar)
supermin: build: visiting /home/rjones/d/libguestfs/appliance/supermin.d/packages type uncompressed packages
supermin: build: visiting /home/rjones/d/libguestfs/appliance/supermin.d/udev-rules.tar.gz type gzip base image (tar)
supermin: build: visiting /home/rjones/d/libguestfs/appliance/supermin.d/zz-packages-dib type uncompressed packages
supermin: build: visiting /home/rjones/d/libguestfs/appliance/supermin.d/zz-packages-xfs type uncompressed packages
supermin: mapping package names to installed packages
supermin: resolving full list of package dependencies
supermin: build: 199 packages, including dependencies
supermin: build: 32878 files
supermin: build: 6136 files, after matching excludefiles
supermin: build: 6146 files, after adding hostfiles
supermin: build: 6127 files, after removing unreadable files
supermin: build: 6156 files, after munging
supermin: kernel: SUPERMIN_KERNEL environment variable /home/rjones/d/linux/arch/x86/boot/bzImage
supermin: kernel: SUPERMIN_KERNEL version 4.11.0-rc3+
supermin: kernel: SUPERMIN_MODULES environment variable = /tmp/lib/modules/4.11.0-rc3+
supermin: kernel: kernel_version 4.11.0-rc3+
supermin: kernel: modules /tmp/lib/modules/4.11.0-rc3+
supermin: ext2: creating empty ext2 filesystem '/home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d.ry5zvnen/root'
supermin: ext2: populating from base image
supermin: ext2: copying files from host filesystem
supermin: warning: /usr/libexec/dbus-1/dbus-daemon-launch-helper: Permission denied (ignored)
Some distro files are not public readable, so supermin cannot copy them
into the appliance.  This is a problem with your Linux distro.  Please ask
your distro to stop doing pointless security by obscurity.
You can ignore these warnings.  You *do not* need to use sudo.
supermin: warning: /usr/libexec/utempter/utempter: Permission denied (ignored)
supermin: warning: /usr/sbin/build-locale-archive: Permission denied (ignored)
supermin: warning: /usr/sbin/glibc_post_upgrade.x86_64: Permission denied (ignored)
supermin: warning: /usr/sbin/unix_update: Permission denied (ignored)
supermin: warning: /var/lib/systemd/random-seed: Permission denied (ignored)
supermin: ext2: copying kernel modules
supermin: ext2: creating minimal initrd '/home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d.ry5zvnen/initrd'
supermin: ext2: wrote 19 modules to minimal initrd
supermin: renaming /home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d.ry5zvnen to /home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d
libguestfs: finished building supermin appliance
libguestfs: begin testing qemu features
libguestfs: checking for previously cached test results of /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64, in /home/rjones/d/libguestfs/tmp/.guestfs-1000
libguestfs: command: run: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64
libguestfs: command: run: \ -display none
libguestfs: command: run: \ -help
libguestfs: qemu version 2.8
libguestfs: command: run: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64
libguestfs: command: run: \ -display none
libguestfs: command: run: \ -machine accel=kvm:tcg
libguestfs: command: run: \ -device ?
libguestfs: saving test results
libguestfs: finished testing qemu features
[02192ms] /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 \
    -global virtio-blk-pci.scsi=off \
    -nodefconfig \
    -enable-fips \
    -nodefaults \
    -display none \
    -machine accel=kvm:tcg \
    -cpu host \
    -m 500 \
    -no-reboot \
    -rtc driftfix=slew \
    -no-hpet \
    -global kvm-pit.lost_tick_policy=discard \
    -kernel /home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d/kernel \
    -initrd /home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d/initrd \
    -object rng-random,filename=/dev/urandom,id=rng0 \
    -device virtio-rng-pci,rng=rng0 \
    -device virtio-scsi-pci,id=scsi \
    -drive file=/home/rjones/d/libguestfs/tmp/libguestfstZZFOk/scratch.1,cache=unsafe,format=raw,id=hd0,if=none \
    -device scsi-hd,drive=hd0 \
    -drive file=/home/rjones/d/libguestfs/tmp/.guestfs-1000/appliance.d/root,snapshot=on,id=appliance,cache=unsafe,if=none,format=raw \
    -device scsi-hd,drive=appliance \
    -device virtio-serial-pci \
    -serial stdio \
    -device sga \
    -chardev socket,path=/run/user/1000/libguestfspgU74E/guestfsd.sock,id=channel0 \
    -device virtserialport,chardev=channel0,name=org.libguestfs.channel.0 \
    -append 'panic=1 console=ttyS0 edd=off udevtimeout=6000 udev.event-timeout=6000 no_timer_check printk.time=1 cgroup_disable=memory usbcore.nousb cryptomgr.notests tsc=reliable 8250.nr_uarts=1 root=/dev/sdb selinux=0 guestfs_verbose=1 TERM=xterm-256color'
qemu-system-x86_64: -object rng-random,filename=/dev/urandom,id=rng0: Parameter 'qom-type' is missing
libguestfs: error: appliance closed the connection unexpectedly, see earlier error messages
libguestfs: child_cleanup: 0x556ca1412b60: child process died
libguestfs: sending SIGTERM to process 11520
libguestfs: error: /home/rjones/d/qemu/x86_64-softmmu/qemu-system-x86_64 exited with error status 1, see debug messages above
libguestfs: error: guestfs_launch failed, see earlier error messages
libguestfs: closing guestfs handle 0x556ca1412b60 (state 0)
libguestfs: command: run: rm
libguestfs: command: run: \ -rf /home/rjones/d/libguestfs/tmp/libguestfstZZFOk
libguestfs: command: run: rm
libguestfs: command: run: \ -rf /run/user/1000/libguestfspgU74E
make: *** [Makefile:2490: quickcheck] Error 1

--YZ5djTAD1cGYuMQK--
