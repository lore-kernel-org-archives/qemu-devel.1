Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqTn2-0000LK-KG
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 20:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eqTmz-0000bT-C1
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 20:10:44 -0500
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:38558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eqTmz-0000bC-5f
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 20:10:41 -0500
Received: by mail-pg0-x233.google.com with SMTP id l24so6895802pgc.5
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 17:10:40 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Message-Id: <CF70F9DF-6D1E-4541-9BD6-9131BDC832FC@sifive.com>
Date: Tue, 27 Feb 2018 14:10:34 +1300
Subject: [Qemu-devel] QEMU Status Update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: RISC-V Software Developers <sw-dev@lists.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Hi Folks,

Just a quick update regarding the process of submitting the RISC-V QEMU =
port upstream for inclusion in the QEMU 2.12 release this coming April.

We=E2=80=99ve just submitted our first pull request after receiving =
positive feedback from the v6 patch series submitted last week. We =
recently contacted contributors in response to feedback from Red Hat, to =
relicense the code as GPLv2+ which is the main change in this most =
recent v7 patch series:

- http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg06489.html
- http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg05778.html
- http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg06132.html

I=E2=80=99d also like to take this opportunity to point out the =
riscv-qemu wiki where we have moved some of the documentation for the =
port:

- https://github.com/riscv/riscv-qemu/wiki

We no longer have a custom README.md in the repo given the code-base is =
now based on upstream QEMU. I=E2=80=99ve added wiki links to SiFive=E2=80=99=
s freedom-u-sdk which creates build recipes to create qemu and a =
bootable buildroot-based linux image that will run on the freedom U =
series VC707 FPGA, SiFive=E2=80=99s new HiFive Unleashed board and of =
course riscv-qemu. I=E2=80=99ve also added links to the Fedora RISC-V =
Architecture page and the Debian RISC-V Architecture page which have =
additional links to RISC-V Linux packages and root images.

With the current version of riscv-qemu we are able to run Privileged ISA =
v1.9.1 riscv-linux/bbl, on the spike_v1.9.1 machine, Privileged ISA =
v1.10 riscv-linux/bbl on the spike_v1.10 and virt machines, HiFive1 =
binaries on the sifive_e300 machine and we have working MTTCG-enabled =
SMP on the virt machine thanks to work done by Stefan O=E2=80=99Rear and =
Richard Henderson on thread-safe atomics.

There is still a lot of future development work that we can switch our =
attention to once the port is upstream. This is a non-exhaustive list, =
just to give you an idea of future work that needs to be done:

- Allow on-the-fly =E2=80=98misa=E2=80=99 changes, perhaps with =
translation cache flushing
	- Currently the misa flag is read-only
- Support the rules being discussed for enabling and disabling misa C =
flag
	- Currently QEMU allows instruction fetches on half-word =
(16-bit) boundaries when C is disabled
- Disable MMU when misa S flag is not set
	- Currently QEMU allows configuring of the MMU on the E-series =
machine
	- This works because E-series code does not touch the satp =
register
- Add vendor specific cpu models such as =E2=80=99sifive-e31=E2=80=99, =
=E2=80=99sifive-e51=E2=80=99, =E2=80=99sifive-u54=E2=80=99, etc
	- Currently we have =E2=80=98generic-imacs=E2=80=99, =
=E2=80=98generic-imafdcsu=E2=80=99, etc
- Improve device support
	- FIFO and interrupt mode support for the SiFive UART along with =
Linux driver
	- PCI host (GPEX) for the =E2=80=98virt=E2=80=99 machine to =
enable virtio-pci
	- SPI and GPIO devices for the SiFive boards
	- Add generic GPIO based power-off and reset
	- Implement HTIF queuing and fix 32-bit support
- Privileged ISA v1.10 and v1.11
	- Add support for TSR, TW and TVM flags (priv v1.10)
	- Add Hypervisor support (draft priv v1.11)

Thanks to everyone who helped with patch review, testing, patches and =
pull requests. I=E2=80=99d also like to give special thanks to Sagar who =
did a huge amount of the original work on the port.=20

Note: I=E2=80=99m explicitly cross-posting as this email is relevant to =
both the RISC-V software development community and the QEMU development =
community.

Regards,
Michael.=
