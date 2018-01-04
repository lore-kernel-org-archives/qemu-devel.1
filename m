Received: from eggs.gnu.org ([2001:4830:134:3::10]:38676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eX8nU-00041z-T8
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1eX8nQ-0005pk-1C
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:55:16 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:43553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <antonynpavlov@gmail.com>)
	id 1eX8nP-0005oe-N9
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:55:11 -0500
Received: by mail-lf0-x243.google.com with SMTP id o26so2421663lfc.10
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 08:55:11 -0800 (PST)
Date: Thu, 4 Jan 2018 20:09:07 +0300
From: Antony Pavlov <antonynpavlov@gmail.com>
Message-Id: <20180104200907.7232a1e131af98e25931faa5@gmail.com>
In-Reply-To: <1514940265-18093-22-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-22-git-send-email-mjc@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 21/21] RISC-V Build Infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed,  3 Jan 2018 13:44:25 +1300
Michael Clark <mjc@sifive.com> wrote:

> This adds RISC-V into the build system enabling the following targets:
>=20
> - riscv32-softmmu
> - riscv64-softmmu
> - riscv32-linux-user
> - riscv64-linux-user
>=20

...

> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv3=
2-softmmu.mak
> new file mode 100644
> index 0000000..f9e7421
> --- /dev/null
> +++ b/default-configs/riscv32-softmmu.mak
> @@ -0,0 +1,4 @@
> +# Default configuration for riscv-softmmu
> +
> +CONFIG_SERIAL=3Dy
> +CONFIG_VIRTIO=3Dy
> diff --git a/default-configs/riscv64-linux-user.mak b/default-configs/ris=
cv64-linux-user.mak
> new file mode 100644
> index 0000000..865b362
> --- /dev/null
> +++ b/default-configs/riscv64-linux-user.mak
> @@ -0,0 +1 @@
> +# Default configuration for riscv-linux-user
> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv6=
4-softmmu.mak
> new file mode 100644
> index 0000000..f9e7421
> --- /dev/null
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -0,0 +1,4 @@
> +# Default configuration for riscv-softmmu
> +
> +CONFIG_SERIAL=3Dy
> +CONFIG_VIRTIO=3Dy
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> new file mode 100644
> index 0000000..a0c31ae
> --- /dev/null
> +++ b/hw/riscv/Makefile.objs
> @@ -0,0 +1,12 @@
> +obj-y +=3D riscv_elf.o
> +obj-y +=3D riscv_htif.o
> +obj-y +=3D riscv_hart.o
> +obj-y +=3D sifive_e300.o
> +obj-y +=3D sifive_clint.o
> +obj-y +=3D sifive_prci.o
> +obj-y +=3D sifive_plic.o
> +obj-y +=3D sifive_u500.o
> +obj-y +=3D sifive_uart.o
> +obj-y +=3D spike_v1_09.o
> +obj-y +=3D spike_v1_10.o
> +obj-y +=3D virt.o

According to https://www.sifive.com/products/freedom/
Freedom E300 Platform uses RV32IMAC Architecture
and Freedom U500 Platform uses RV64GC Architecture.

Which means that qemu-system-riscv32 has to have E300 support but not U500 =
support.
qemu-system-riscv64 has to have U500 support but not E300 support.

However please see this log:

riscv-qemu$ ./riscv32-softmmu/qemu-system-riscv32 -M ?
Supported machines are:
none                 empty machine
sifive_e300          RISC-V Board compatible with SiFive E300 SDK
sifive_u500          RISC-V Board compatible with SiFive U500 SDK <<<<<< U5=
00 in 32-bit mode
spike_v1.10          RISC-V Spike Board (Privileged ISA v1.10)
spike_v1.9           RISC-V Spike Board (Privileged ISA v1.9.1) (default)
virt                 RISC-V VirtIO Board (Privileged spec v1.10)
riscv-qemu$ ./riscv64-softmmu/qemu-system-riscv64 -M ?
Supported machines are:
none                 empty machine
sifive_e300          RISC-V Board compatible with SiFive E300 SDK <<<<<< E3=
00 in 64-bit mode
sifive_u500          RISC-V Board compatible with SiFive U500 SDK
spike_v1.10          RISC-V Spike Board (Privileged ISA v1.10)
spike_v1.9           RISC-V Spike Board (Privileged ISA v1.9.1) (default)
virt                 RISC-V VirtIO Board (Privileged spec v1.10)

I propose at least this fixup:

diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-=
softmmu.mak
index f9e742120c..6a807f5f96 100644
--- a/default-configs/riscv32-softmmu.mak
+++ b/default-configs/riscv32-softmmu.mak
@@ -1,4 +1,5 @@
-# Default configuration for riscv-softmmu
+# Default configuration for riscv32-softmmu
=20
 CONFIG_SERIAL=3Dy
 CONFIG_VIRTIO=3Dy
+CONFIG_SIFIVE_E300=3Dy
diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-=
softmmu.mak
index f9e742120c..1a0349fe27 100644
--- a/default-configs/riscv64-softmmu.mak
+++ b/default-configs/riscv64-softmmu.mak
@@ -1,4 +1,5 @@
-# Default configuration for riscv-softmmu
+# Default configuration for riscv64-softmmu
=20
 CONFIG_SERIAL=3Dy
 CONFIG_VIRTIO=3Dy
+CONFIG_SIFIVE_U500=3Dy
diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index a0c31ae25e..bac5faa603 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -1,11 +1,11 @@
 obj-y +=3D riscv_elf.o
 obj-y +=3D riscv_htif.o
 obj-y +=3D riscv_hart.o
-obj-y +=3D sifive_e300.o
+obj-$(CONFIG_SIFIVE_E300) +=3D sifive_e300.o
 obj-y +=3D sifive_clint.o
 obj-y +=3D sifive_prci.o
 obj-y +=3D sifive_plic.o
-obj-y +=3D sifive_u500.o
+obj-$(CONFIG_SIFIVE_U500) +=3D sifive_u500.o
 obj-y +=3D sifive_uart.o
 obj-y +=3D spike_v1_09.o
 obj-y +=3D spike_v1_10.o

--=20
Best regards,
=A0 Antony Pavlov
