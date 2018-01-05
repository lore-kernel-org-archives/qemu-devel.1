Received: from eggs.gnu.org ([2001:4830:134:3::10]:34588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eXI5o-0001s1-1j
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 21:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eXI5i-0004Pv-6F
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 21:50:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:42054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eXI5g-0004Nn-QO
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 21:50:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eXI5f-00054z-LV
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 02:50:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9F5B62E80C3
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 02:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jan 2018 02:44:54 -0000
From: Ping Li <1740364@bugs.launchpad.net>
Reply-To: Bug 1740364 <1740364@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151444692163.26459.1330629893044006612.malonedeb@gac.canonical.com>
Message-Id: <151512029457.2799.7813958810864461287.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1740364] Re: qemu-img: fails to get shared
 'write' lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The behaviour should be expected. Since qemu 2.10, image locking is
enabled which make multiple QEMU processes cannot write to the same
image, even if boot snapshot and backing file at the same time are
not allowed. =

You could get image info with the option "-U" as below:
$qemu-img info -U $ImageName
The reason qcow2 is not allowed is because metadata has to be read =

from the image file, and it is not safe if the image is being used =

by the VM, because it may update metadata while we read it, =

resulting in inconsistent or wrong output.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1740364

Title:
  qemu-img: fails to get shared 'write' lock

Status in QEMU:
  New

Bug description:
  Description of problem:
  Somewhere in F27 (did not see it happening before), I'm getting while run=
ning libguestfs (via libvirt or direct), a qemu-img failure. Note: multiple=
 qcow2 snapshots are on the same backing file, and a parallel libguestfs co=
mmand is running on all. However, it seems to be failing to get a lock on t=
he leaf, which is unique, non-shared.

  The VM is up and running. I'm not sure why qemu-img is even trying to get=
 a write lock on it. Even 'info' fails:
  ykaul@ykaul ovirt-system-tests]$ qemu-img info /home/ykaul/ovirt-system-t=
ests/deployment-basic-suite-master/default/images/lago-basic-suite-master-h=
ost-1_root.qcow2
  qemu-img: Could not open '/home/ykaul/ovirt-system-tests/deployment-basic=
-suite-master/default/images/lago-basic-suite-master-host-1_root.qcow2': Fa=
iled to get shared "write" lock
  Is another process using the image?
  [ykaul@ykaul ovirt-system-tests]$ lsof |grep qcow2
  [ykaul@ykaul ovirt-system-tests]$ file /home/ykaul/ovirt-system-tests/dep=
loyment-basic-suite-master/default/images/lago-basic-suite-master-host-1_ro=
ot.qcow2
  /home/ykaul/ovirt-system-tests/deployment-basic-suite-master/default/imag=
es/lago-basic-suite-master-host-1_root.qcow2: QEMU QCOW Image (v3), has bac=
king file (path /var/lib/lago/store/phx_repo:el7.4-base:v1), 6442450944 byt=
es

  =

  And it's OK if I kill the VM of course.


  =

  Version-Release number of selected component (if applicable):
  [ykaul@ykaul ovirt-system-tests]$ rpm -qa |grep qemu
  qemu-block-nfs-2.10.1-2.fc27.x86_64
  qemu-block-dmg-2.10.1-2.fc27.x86_64
  qemu-guest-agent-2.10.1-2.fc27.x86_64
  qemu-system-x86-core-2.10.1-2.fc27.x86_64
  qemu-block-curl-2.10.1-2.fc27.x86_64
  qemu-img-2.10.1-2.fc27.x86_64
  qemu-common-2.10.1-2.fc27.x86_64
  qemu-kvm-2.10.1-2.fc27.x86_64
  qemu-block-ssh-2.10.1-2.fc27.x86_64
  qemu-block-iscsi-2.10.1-2.fc27.x86_64
  libvirt-daemon-driver-qemu-3.7.0-3.fc27.x86_64
  qemu-block-gluster-2.10.1-2.fc27.x86_64
  ipxe-roms-qemu-20161108-2.gitb991c67.fc26.noarch
  qemu-system-x86-2.10.1-2.fc27.x86_64
  qemu-block-rbd-2.10.1-2.fc27.x86_64

  =

  How reproducible:
  Sometimes.

  Steps to Reproduce:
  1. Running Lago (ovirt-system-tests) on my laptop, it happens quite a lot.

  Additional info:
  libguestfs: trace: set_verbose true
  libguestfs: trace: set_verbose =3D 0
  libguestfs: trace: set_backend "direct"
  libguestfs: trace: set_backend =3D 0
  libguestfs: create: flags =3D 0, handle =3D 0x7f1314006430, program =3D p=
ython2
  libguestfs: trace: set_program "lago"
  libguestfs: trace: set_program =3D 0
  libguestfs: trace: add_drive_ro "/home/ykaul/ovirt-system-tests/deploymen=
t-basic-suite-master/default/images/lago-basic-suite-master-host-1_root.qco=
w2"
  libguestfs: trace: add_drive "/home/ykaul/ovirt-system-tests/deployment-b=
asic-suite-master/default/images/lago-basic-suite-master-host-1_root.qcow2"=
 "readonly:true"
  libguestfs: creating COW overlay to protect original drive content
  libguestfs: trace: get_tmpdir
  libguestfs: trace: get_tmpdir =3D "/tmp"
  libguestfs: trace: disk_create "/tmp/libguestfsWrA7Dh/overlay1.qcow2" "qc=
ow2" -1 "backingfile:/home/ykaul/ovirt-system-tests/deployment-basic-suite-=
master/default/images/lago-basic-suite-master-host-1_root.qcow2"
  libguestfs: command: run: qemu-img
  libguestfs: command: run: \ create
  libguestfs: command: run: \ -f qcow2
  libguestfs: command: run: \ -o backing_file=3D/home/ykaul/ovirt-system-te=
sts/deployment-basic-suite-master/default/images/lago-basic-suite-master-ho=
st-1_root.qcow2
  libguestfs: command: run: \ /tmp/libguestfsWrA7Dh/overlay1.qcow2
  qemu-img: /tmp/libguestfsWrA7Dh/overlay1.qcow2: Failed to get shared "wri=
te" lock
  Is another process using the image?
  Could not open backing image to determine size.
  libguestfs: trace: disk_create =3D -1 (error)
  libguestfs: trace: add_drive =3D -1 (error)
  libguestfs: trace: add_drive_ro =3D -1 (error)

  =

  And:
  [ykaul@ykaul ovirt-system-tests]$ strace qemu-img info /home/ykaul/ovirt-=
system-tests/deployment-basic-suite-master/default/images/lago-basic-suite-=
master-host-1_root.qcow2
  execve("/usr/bin/qemu-img", ["qemu-img", "info", "/home/ykaul/ovirt-syste=
m-tests/d"...], 0x7fffb36ccfc0 /* 59 vars */) =3D 0
  brk(NULL)                               =3D 0x562790488000
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7f20cea08000
  access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or di=
rectory)
  openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
  fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D93275, ...}) =3D 0
  mmap(NULL, 93275, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f20ce9f1000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libz.so.1", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320#\0\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D94232, ...}) =3D 0
  mmap(NULL, 2187272, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20ce5cc000
  mprotect(0x7f20ce5e2000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20ce7e1000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x15000) =3D 0x7f20ce7e1000
  mmap(0x7f20ce7e2000, 8, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_A=
NONYMOUS, -1, 0) =3D 0x7f20ce7e2000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libaio.so.1", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200\5\0\0\0\0\0\0=
"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D6312, ...}) =3D 0
  mmap(NULL, 2101328, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20ce3ca000
  mprotect(0x7f20ce3cb000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20ce5ca000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0) =3D 0x7f20ce5ca000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libgmodule-2.0.so.0", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360\20\0\0\0\0\0\=
0"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D15264, ...}) =3D 0
  mmap(NULL, 2109528, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20ce1c6000
  mprotect(0x7f20ce1c9000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20ce3c8000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x2000) =3D 0x7f20ce3c8000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libglib-2.0.so.0", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320\256\1\0\0\0\0=
\0"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1145520, ...}) =3D 0
  mmap(NULL, 3223752, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cdeb2000
  mprotect(0x7f20cdfc3000, 2097152, PROT_NONE) =3D 0
  mmap(0x7f20ce1c3000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x111000) =3D 0x7f20ce1c3000
  mmap(0x7f20ce1c5000, 200, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x7f20ce1c5000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libgthread-2.0.so.0", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\6\0\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D6832, ...}) =3D 0
  mmap(NULL, 2101256, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cdcb0000
  mprotect(0x7f20cdcb1000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cdeb0000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0) =3D 0x7f20cdeb0000
  mmap(0x7f20cdeb1000, 8, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_A=
NONYMOUS, -1, 0) =3D 0x7f20cdeb1000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/librt.so.1", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\240!\0\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D43696, ...}) =3D 0
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7f20ce9ef000
  mmap(NULL, 2128800, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cdaa8000
  mprotect(0x7f20cdaaf000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cdcae000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x6000) =3D 0x7f20cdcae000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libcap-ng.so.0", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\25\0\0\0\0\0\0=
"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D23544, ...}) =3D 0
  mmap(NULL, 2117640, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cd8a2000
  mprotect(0x7f20cd8a6000, 2097152, PROT_NONE) =3D 0
  mmap(0x7f20cdaa6000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x4000) =3D 0x7f20cdaa6000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libnettle.so.6", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\220\233\0\0\0\0\0=
\0"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D229728, ...}) =3D 0
  mmap(NULL, 2322496, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cd66a000
  mprotect(0x7f20cd6a0000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cd89f000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_DENYWRITE, 3, 0x35000) =3D 0x7f20cd89f000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libgnutls.so.30", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@\336\2\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1516168, ...}) =3D 0
  mmap(NULL, 3599400, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cd2fb000
  mprotect(0x7f20cd45c000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cd65b000, 57344, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_DENYWRITE, 3, 0x160000) =3D 0x7f20cd65b000
  mmap(0x7f20cd669000, 3112, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_ANONYMOUS, -1, 0) =3D 0x7f20cd669000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libutil.so.1", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0p\16\0\0\0\0\0\0".=
.., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D14344, ...}) =3D 0
  mmap(NULL, 2105608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cd0f8000
  mprotect(0x7f20cd0fa000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cd2f9000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x1000) =3D 0x7f20cd2f9000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libstdc++.so.6", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\301\10\0\0\0\0\=
0"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1586584, ...}) =3D 0
  mmap(NULL, 3694592, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20ccd72000
  mprotect(0x7f20cceea000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cd0e9000, 49152, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_DENYWRITE, 3, 0x177000) =3D 0x7f20cd0e9000
  mmap(0x7f20cd0f5000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_ANONYMOUS, -1, 0) =3D 0x7f20cd0f5000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libm.so.6", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\200x\0\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1503544, ...}) =3D 0
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7f20ce9ed000
  mmap(NULL, 3490600, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cca1d000
  mprotect(0x7f20ccb71000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20ccd70000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x153000) =3D 0x7f20ccd70000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libgcc_s.so.1", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\300*\0\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D92800, ...}) =3D 0
  mmap(NULL, 2188336, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cc806000
  mprotect(0x7f20cc81c000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cca1b000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x15000) =3D 0x7f20cca1b000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libpthread.so.0", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\220a\0\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D153128, ...}) =3D 0
  mmap(NULL, 2221160, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cc5e7000
  mprotect(0x7f20cc601000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cc800000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x19000) =3D 0x7f20cc800000
  mmap(0x7f20cc802000, 13416, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_ANONYMOUS, -1, 0) =3D 0x7f20cc802000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0 \21\2\0\0\0\0\0".=
.., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D2245824, ...}) =3D 0
  mmap(NULL, 4074112, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cc204000
  mprotect(0x7f20cc3de000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cc5dd000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_DENYWRITE, 3, 0x1d9000) =3D 0x7f20cc5dd000
  mmap(0x7f20cc5e3000, 14976, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_ANONYMOUS, -1, 0) =3D 0x7f20cc5e3000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libdl.so.2", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\16\0\0\0\0\0\0".=
.., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D19264, ...}) =3D 0
  mmap(NULL, 2109680, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cc000000
  mprotect(0x7f20cc003000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cc202000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x2000) =3D 0x7f20cc202000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libpcre.so.1", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\26\0\0\0\0\0\0=
"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D471816, ...}) =3D 0
  mmap(NULL, 2564360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cbd8d000
  mprotect(0x7f20cbdfe000, 2097152, PROT_NONE) =3D 0
  mmap(0x7f20cbffe000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x71000) =3D 0x7f20cbffe000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libp11-kit.so.0", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\271\2\0\0\0\0\0=
"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1261200, ...}) =3D 0
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7f20ce9eb000
  mmap(NULL, 3334480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cba5e000
  mprotect(0x7f20cbb78000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cbd77000, 86016, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_DENYWRITE, 3, 0x119000) =3D 0x7f20cbd77000
  mmap(0x7f20cbd8c000, 336, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x7f20cbd8c000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libidn2.so.0", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\240\26\0\0\0\0\0\=
0"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D118104, ...}) =3D 0
  mmap(NULL, 2211856, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cb841000
  mprotect(0x7f20cb85d000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cba5c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x1b000) =3D 0x7f20cba5c000
  mmap(0x7f20cba5d000, 16, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_=
ANONYMOUS, -1, 0) =3D 0x7f20cba5d000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libunistring.so.2", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\17\1\0\0\0\0\0=
"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1513480, ...}) =3D 0
  mmap(NULL, 3608840, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cb4cf000
  mprotect(0x7f20cb63c000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cb83b000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_DENYWRITE, 3, 0x16c000) =3D 0x7f20cb83b000
  mmap(0x7f20cb840000, 264, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x7f20cb840000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libtasn1.so.6", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260,\0\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D77536, ...}) =3D 0
  mmap(NULL, 2171592, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cb2bc000
  mprotect(0x7f20cb2cd000, 2097152, PROT_NONE) =3D 0
  mmap(0x7f20cb4cd000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x11000) =3D 0x7f20cb4cd000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libhogweed.so.4", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360w\0\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D188072, ...}) =3D 0
  mmap(NULL, 2281480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cb08e000
  mprotect(0x7f20cb0ba000, 2097152, PROT_NONE) =3D 0
  mmap(0x7f20cb2ba000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x2c000) =3D 0x7f20cb2ba000
  mmap(0x7f20cb2bb000, 8, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_A=
NONYMOUS, -1, 0) =3D 0x7f20cb2bb000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libgmp.so.10", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@\305\0\0\0\0\0\0"=
..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D495800, ...}) =3D 0
  mmap(NULL, 2584736, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cae16000
  mprotect(0x7f20cae8c000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cb08b000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|M=
AP_DENYWRITE, 3, 0x75000) =3D 0x7f20cb08b000
  close(3)                                =3D 0
  openat(AT_FDCWD, "/lib64/libffi.so.6", O_RDONLY|O_CLOEXEC) =3D 3
  read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\300\27\0\0\0\0\0\=
0"..., 832) =3D 832
  fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D31896, ...}) =3D 0
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7f20ce9e9000
  mmap(NULL, 2127048, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)=
 =3D 0x7f20cac0e000
  mprotect(0x7f20cac15000, 2093056, PROT_NONE) =3D 0
  mmap(0x7f20cae14000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DENYWRITE, 3, 0x6000) =3D 0x7f20cae14000
  close(3)                                =3D 0
  mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x7f20ce9e7000
  mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)=
 =3D 0x7f20ce9e4000
  arch_prctl(ARCH_SET_FS, 0x7f20ce9e4900) =3D 0
  mprotect(0x7f20cc5dd000, 16384, PROT_READ) =3D 0
  mprotect(0x7f20cae14000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cb08b000, 8192, PROT_READ) =3D 0
  mprotect(0x7f20cd89f000, 8192, PROT_READ) =3D 0
  mprotect(0x7f20cb2ba000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cb4cd000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cb83b000, 16384, PROT_READ) =3D 0
  mprotect(0x7f20cba5c000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cc800000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cc202000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cbd77000, 45056, PROT_READ) =3D 0
  mprotect(0x7f20cbffe000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cca1b000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20ccd70000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cd0e9000, 40960, PROT_READ) =3D 0
  mprotect(0x7f20cd2f9000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20ce7e1000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cd65b000, 53248, PROT_READ) =3D 0
  mprotect(0x7f20cdaa6000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cdcae000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20ce1c3000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20cdeb0000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20ce3c8000, 4096, PROT_READ) =3D 0
  mprotect(0x7f20ce5ca000, 4096, PROT_READ) =3D 0
  mprotect(0x56278f387000, 24576, PROT_READ) =3D 0
  mprotect(0x7f20cea0a000, 4096, PROT_READ) =3D 0
  munmap(0x7f20ce9f1000, 93275)           =3D 0
  set_tid_address(0x7f20ce9e4bd0)         =3D 4326
  set_robust_list(0x7f20ce9e4be0, 24)     =3D 0
  rt_sigaction(SIGRTMIN, {sa_handler=3D0x7f20cc5ecc10, sa_mask=3D[], sa_fla=
gs=3DSA_RESTORER|SA_SIGINFO, sa_restorer=3D0x7f20cc5f9a80}, NULL, 8) =3D 0
  rt_sigaction(SIGRT_1, {sa_handler=3D0x7f20cc5eccb0, sa_mask=3D[], sa_flag=
s=3DSA_RESTORER|SA_RESTART|SA_SIGINFO, sa_restorer=3D0x7f20cc5f9a80}, NULL,=
 8) =3D 0
  rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) =3D 0
  prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=3D8192*1024, rlim_max=3DRLIM64=
_INFINITY}) =3D 0
  futex(0x7f20cbd8c0c0, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
  brk(NULL)                               =3D 0x562790488000
  brk(0x5627904a9000)                     =3D 0x5627904a9000
  brk(0x5627904ca000)                     =3D 0x5627904ca000
  getrandom("\xc2", 1, GRND_NONBLOCK)     =3D 1
  stat("/etc/crypto-policies/back-ends/gnutls.config", {st_mode=3DS_IFREG|0=
644, st_size=3D465, ...}) =3D 0
  openat(AT_FDCWD, "/etc/crypto-policies/back-ends/gnutls.config", O_RDONLY=
) =3D 3
  fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D465, ...}) =3D 0
  lseek(3, 0, SEEK_CUR)                   =3D 0
  fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D465, ...}) =3D 0
  read(3, "SYSTEM=3DNONE:+AEAD:+SHA1:+SHA256:"..., 4096) =3D 465
  read(3, "", 4096)                       =3D 0
  close(3)                                =3D 0
  rt_sigaction(SIGPIPE, {sa_handler=3DSIG_IGN, sa_mask=3D[PIPE], sa_flags=
=3DSA_RESTORER|SA_RESTART, sa_restorer=3D0x7f20cc23b6f0}, {sa_handler=3DSIG=
_DFL, sa_mask=3D[], sa_flags=3D0}, 8) =3D 0
  readlink("/proc/self/exe", "/usr/bin/qemu-img", 4095) =3D 17
  prctl(PR_SET_TIMERSLACK, 1)             =3D 0
  rt_sigprocmask(SIG_BLOCK, [BUS USR1 ALRM IO], NULL, 8) =3D 0
  signalfd(-1, [BUS ALRM IO], 8)          =3D 3
  fcntl(3, F_GETFD)                       =3D 0
  fcntl(3, F_SETFD, FD_CLOEXEC)           =3D 0
  fcntl(3, F_GETFL)                       =3D 0x2 (flags O_RDWR)
  fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK)    =3D 0
  epoll_create1(EPOLL_CLOEXEC)            =3D 4
  eventfd2(0, EFD_CLOEXEC|EFD_NONBLOCK)   =3D 5
  epoll_create1(EPOLL_CLOEXEC)            =3D 6
  eventfd2(0, EFD_CLOEXEC|EFD_NONBLOCK)   =3D 7
  futex(0x7f20ce1c4e88, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
  eventfd2(0, EFD_CLOEXEC|EFD_NONBLOCK)   =3D 8
  brk(NULL)                               =3D 0x5627904ca000
  brk(0x5627904eb000)                     =3D 0x5627904eb000
  openat(AT_FDCWD, "/home/ykaul/ovirt-system-tests/deployment-basic-suite-m=
aster/default/images/lago-basic-suite-master-host-1_root.qcow2", O_RDONLY|O=
_NONBLOCK|O_CLOEXEC) =3D 9
  fstat(9, {st_mode=3DS_IFREG|0666, st_size=3D43122688, ...}) =3D 0
  close(9)                                =3D 0
  stat("/home/ykaul/ovirt-system-tests/deployment-basic-suite-master/defaul=
t/images/lago-basic-suite-master-host-1_root.qcow2", {st_mode=3DS_IFREG|066=
6, st_size=3D43122688, ...}) =3D 0
  openat(AT_FDCWD, "/dev/urandom", O_RDONLY) =3D 9
  read(9, "\364\275^\0\226\321$\2337\356\311\301li\305\206", 16) =3D 16
  close(9)                                =3D 0
  futex(0x7f20ce1c4e88, FUTEX_WAKE_PRIVATE, 2147483647) =3D 0
  openat(AT_FDCWD, "/dev/null", O_RDWR)   =3D 9
  fcntl(9, F_OFD_GETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D0=
, l_len=3D0, l_pid=3D0}) =3D 0
  close(9)                                =3D 0
  openat(AT_FDCWD, "/home/ykaul/ovirt-system-tests/deployment-basic-suite-m=
aster/default/images/lago-basic-suite-master-host-1_root.qcow2", O_RDONLY|O=
_CLOEXEC) =3D 9
  openat(AT_FDCWD, "/home/ykaul/ovirt-system-tests/deployment-basic-suite-m=
aster/default/images/lago-basic-suite-master-host-1_root.qcow2", O_RDONLY|O=
_CLOEXEC) =3D 10
  fstat(9, {st_mode=3DS_IFREG|0666, st_size=3D43122688, ...}) =3D 0
  lseek(9, 0, SEEK_END)                   =3D 43122688
  fstat(9, {st_mode=3DS_IFREG|0666, st_size=3D43122688, ...}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_GETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
200, l_len=3D1, l_pid=3D0}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
101, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
102, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
103, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
104, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
200, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
201, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
202, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
203, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
204, l_len=3D1}) =3D 0
  rt_sigprocmask(SIG_BLOCK, NULL, [BUS USR1 ALRM IO], 8) =3D 0
  mmap(NULL, 1052672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x7f20ce8e3000
  mprotect(0x7f20ce8e3000, 4096, PROT_NONE) =3D 0
  rt_sigprocmask(SIG_SETMASK, [BUS USR1 ALRM IO], [BUS USR1 ALRM IO], 8) =
=3D 0
  ppoll([{fd=3D7, events=3DPOLLIN|POLLERR|POLLHUP}], 1, {tv_sec=3D0, tv_nse=
c=3D0}, NULL, 8) =3D 0 (Timeout)
  rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [BUS USR1 ALRM IO], 8) =3D 0
  mmap(NULL, 8392704, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0=
) =3D 0x7f20ca40d000
  mprotect(0x7f20ca40e000, 8388608, PROT_READ|PROT_WRITE) =3D 0
  clone(child_stack=3D0x7f20cac0cdf0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES=
|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|=
CLONE_CHILD_CLEARTID, parent_tidptr=3D0x7f20cac0d9d0, tls=3D0x7f20cac0d700,=
 child_tidptr=3D0x7f20cac0d9d0) =3D 4327
  rt_sigprocmask(SIG_SETMASK, [BUS USR1 ALRM IO], NULL, 8) =3D 0
  futex(0x5627904beb20, FUTEX_WAKE_PRIVATE, 1) =3D 1
  ppoll([{fd=3D7, events=3DPOLLIN|POLLERR|POLLHUP}], 1, NULL, NULL, 8) =3D =
1 ([{fd=3D7, revents=3DPOLLIN}])
  read(7, "\1\0\0\0\0\0\0\0", 512)        =3D 8
  ppoll([{fd=3D7, events=3DPOLLIN|POLLERR|POLLHUP}], 1, {tv_sec=3D0, tv_nse=
c=3D0}, NULL, 8) =3D 0 (Timeout)
  fcntl(10, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
201, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
203, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_GETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
200, l_len=3D1, l_pid=3D0}) =3D 0
  fcntl(10, F_OFD_GETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D2, l_pid=3D18446744073709551615}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
101, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
102, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
103, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
104, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
200, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
201, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
202, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
203, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
204, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
101, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
102, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
103, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
104, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
200, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
201, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
202, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
203, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
204, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_RDLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
100, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
101, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
102, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
103, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
104, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
200, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
201, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
202, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
203, l_len=3D1}) =3D 0
  fcntl(10, F_OFD_SETLK, {l_type=3DF_UNLCK, l_whence=3DSEEK_SET, l_start=3D=
204, l_len=3D1}) =3D 0
  ppoll([{fd=3D7, events=3DPOLLIN|POLLERR|POLLHUP}], 1, {tv_sec=3D0, tv_nse=
c=3D0}, NULL, 8) =3D 0 (Timeout)
  rt_sigprocmask(SIG_BLOCK, NULL, [BUS USR1 ALRM IO], 8) =3D 0
  mmap(NULL, 1052672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x7f20ca30c000
  mprotect(0x7f20ca30c000, 4096, PROT_NONE) =3D 0
  rt_sigprocmask(SIG_SETMASK, [BUS USR1 ALRM IO], [BUS USR1 ALRM IO], 8) =
=3D 0
  ppoll([{fd=3D7, events=3DPOLLIN|POLLERR|POLLHUP}], 1, {tv_sec=3D0, tv_nse=
c=3D0}, NULL, 8) =3D 0 (Timeout)
  ppoll([{fd=3D7, events=3DPOLLIN|POLLERR|POLLHUP}], 1, {tv_sec=3D0, tv_nse=
c=3D0}, NULL, 8) =3D 0 (Timeout)
  close(9)                                =3D 0
  close(10)                               =3D 0
  ppoll([{fd=3D7, events=3DPOLLIN|POLLERR|POLLHUP}], 1, {tv_sec=3D0, tv_nse=
c=3D0}, NULL, 8) =3D 0 (Timeout)
  rt_sigprocmask(SIG_BLOCK, NULL, [BUS USR1 ALRM IO], 8) =3D 0
  mmap(NULL, 1052672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, =
0) =3D 0x7f20ca20b000
  mprotect(0x7f20ca20b000, 4096, PROT_NONE) =3D 0
  rt_sigprocmask(SIG_SETMASK, [BUS USR1 ALRM IO], [BUS USR1 ALRM IO], 8) =
=3D 0
  ppoll([{fd=3D7, events=3DPOLLIN|POLLERR|POLLHUP}], 1, {tv_sec=3D0, tv_nse=
c=3D0}, NULL, 8) =3D 0 (Timeout)
  ppoll([{fd=3D7, events=3DPOLLIN|POLLERR|POLLHUP}], 1, {tv_sec=3D0, tv_nse=
c=3D0}, NULL, 8) =3D 0 (Timeout)
  fstat(2, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 1), ...}) =3D 0
  write(2, "qemu-img: Could not open '/home/"..., 180qemu-img: Could not op=
en '/home/ykaul/ovirt-system-tests/deployment-basic-suite-master/default/im=
ages/lago-basic-suite-master-host-1_root.qcow2': Failed to get shared "writ=
e" lock
  ) =3D 180
  write(2, "Is another process using the ima"..., 36Is another process usin=
g the image?
  ) =3D 36
  exit_group(1)                           =3D ?
  +++ exited with 1 +++

  =

  [ykaul@ykaul ovirt-system-tests]$ stat /home/ykaul/ovirt-system-tests/dep=
loyment-basic-suite-master/default/images/lago-basic-suite-master-host-1_ro=
ot.qcow2
    File: /home/ykaul/ovirt-system-tests/deployment-basic-suite-master/defa=
ult/images/lago-basic-suite-master-host-1_root.qcow2
    Size: 43122688  	Blocks: 84112      IO Block: 4096   regular file
  Device: fd03h/64771d	Inode: 4718904     Links: 1
  Access: (0666/-rw-rw-rw-)  Uid: (  107/    qemu)   Gid: (  107/    qemu)
  Context: system_u:object_r:svirt_image_t:s0:c635,c936
  Access: 2017-12-28 09:28:17.892598375 +0200
  Modify: 2017-12-28 09:31:10.456906255 +0200
  Change: 2017-12-28 09:31:10.456906255 +0200

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1740364/+subscriptions
