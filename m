Received: from eggs.gnu.org ([2001:4830:134:3::10]:56833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coovr-0008OC-TQ
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1coovq-0004Ug-Hj
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:16:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1coovq-0004Tk-C7
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:16:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1coovp-0007rF-G1
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 10:16:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 630202E80C8
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 10:16:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Mar 2017 10:07:00 -0000
From: Leo Gaspard <1672365@bugs.launchpad.net>
Reply-To: Bug 1672365 <1672365@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170313123815.23571.92915.malonedeb@gac.canonical.com>
Message-Id: <20170317100700.31950.4879.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1672365] Re: nested 9pfs read fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hmm, actually it looks like a kernel in kernel panic always takes 100%
CPU (just got another unrelated one), so I=C2=A0guess it's not necessarily a
qemu bug but can arise from anywhere in the stack. I'm marking the bug
as invalid as a consequence.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1672365

Title:
  nested 9pfs read fail

Status in QEMU:
  Invalid

Bug description:
  tl;dr: A virtfs read fails. The init being on this virtfs (mounted by
  the initrd), the linux kernel guest is unable to boot, and kernel
  panics. The fact that qemu still takes 100%cpu after the kernel panic
  makes me think it's a qemu bug.

  Here is the setup (some hashes replaced with "..."):
   * A (NixOS) host system, with /nix/store as a btrfs on lvm on cryptsetup
   * Running a qemu-kvm NixOS guest, with /nix/.ro-store as a virtfs mappin=
g to host /nix/store:
  ```
  exec /nix/store/...-qemu-x86-only-for-vm-tests-2.8.0/bin/qemu-kvm \
      -name test \
      -m 8192 \
      -cpu kvm64 \
      -net nic,vlan=3D0,model=3Dvirtio -net user,vlan=3D0 \
      -virtfs local,path=3D/nix/store,security_model=3Dnone,mount_tag=3Dsto=
re \
      -virtfs local,path=3D/tmp/nix-vm..../xchg,security_model=3Dnone,mount=
_tag=3Dxchg \
      -virtfs local,path=3D/tmp/nix-vm..../xchg,security_model=3Dnone,mount=
_tag=3Dshared \
      -drive index=3D0,id=3Ddrive1,file=3D/home/ekleog/nixos/test.qcow2,if=
=3Dvirtio,cache=3Dwriteback,werror=3Dreport \
  -kernel /nix/store/...-nixos-system-test-17.09.git.deee8da/kernel \
  -initrd /nix/store/...-nixos-system-test-17.09.git.deee8da/initrd \
  -append "$(cat /nix/store/...-nixos-system-test-17.09.git.deee8da/kernel-=
params) init=3D/nix/store/...-nixos-system-test-17.09.git.deee8da/init regI=
nfo=3D/nix/store/...-reginfo" \
      -vga std -usbdevice tablet
  ```
   * With /nix/store as an overlayfs between /nix/.ro-store and /nix/.rw-st=
ore
   * Running a qemu-kvm NixOS guest, with /nix/.ro-store as a virtfs mappin=
g to host /nix/store/...-vm-nginx-store:
  ```
  /nix/store/...-qemu-2.8.0/bin/qemu-kvm \
    -name nginx -m 128 -smp 2 -cpu kvm64 \
    -nographic -serial unix:"/var/lib/vm/consoles/nginx/socket.unix",server=
,nowait \
    -drive file=3D"/var/lib/vm/images/nginx.img",if=3Dvirtio,media=3Ddisk \
    -virtfs local,path=3D"/nix/store/...-vm-nginx-store",security_model=3Dn=
one,mount_tag=3Dstore \
    -netdev type=3Dtap,id=3Dnet0,ifname=3Dvm-nginx,script=3Dno,dscript=3Dno=
 -device virtio-net-pci,netdev=3Dnet0,mac=3D56:00:00:00:00:01 \
    -kernel /nix/store/...-nixos-system-nginx-17.09.git.deee8da/kernel \
    -initrd /nix/store/...-nixos-system-nginx-17.09.git.deee8da/initrd \
    -append "$(cat /nix/store/...-nixos-system-nginx-17.09.git.deee8da/kern=
el-params) init=3D/nix/store/...-nixos-system-nginx-17.09.git.deee8da/init =
console=3DttyS0 boot.shell_on_fail" \
    -virtfs local,path=3D"/var/lib/vm/persist/nginx/home",security_model=3D=
mapped-xattr,mount_tag=3D"shared1" \
    -virtfs local,path=3D"/var/lib",security_model=3Dmapped-xattr,mount_tag=
=3D"shared2" \
    -virtfs local,path=3D"/tmp",security_model=3Dmapped-xattr,mount_tag=3D"=
shared3"
  ```
   * With /nix/store as an overlayfs between /nix/.ro-store and /nix/.rw-st=
ore
   * With init in /nix/store

  What happens is that at boot time the inner VM doesn't manage to read
  the init script after the initrd has mounted the 9pfs and overlayfs.

  What makes me think it's a qemu bug is that htop in the outer VM shows
  the inner VM's qemu as using 100% cpu, despite the fact the kernel
  it's running is under kernel panic, thus doing nothing.

  What do you think about this?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1672365/+subscriptions
