Received: from eggs.gnu.org ([2001:4830:134:3::10]:53854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIiy2-0003fk-Ge
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dIixz-0004QD-4o
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:58:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dIixy-0004Pk-Qk
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 17:58:15 -0400
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-6-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <56127bd4-c7b5-6589-9dc6-58dc955e7103@redhat.com>
Date: Wed, 7 Jun 2017 16:58:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170607074632.13162-6-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H6PoMbepJn0KiJBKBwfvvqvhptnHJ629l"
Subject: Re: [Qemu-devel] [PATCH 5/5] coccinelle: prefer glib g_new/g_renew
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H6PoMbepJn0KiJBKBwfvvqvhptnHJ629l
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <56127bd4-c7b5-6589-9dc6-58dc955e7103@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] coccinelle: prefer glib g_new/g_renew
 macros
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
 <20170607074632.13162-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170607074632.13162-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/07/2017 02:46 AM, Marc-Andr=C3=A9 Lureau wrote:
> The g_new() familly of macros is simpler and safer than g_malloc().

s/familly/family/

>=20
> "The return pointer is cast to the given type... Care is taken to
> avoid overflow when calculating the size of the allocated block."
>=20
> I left out the common g_malloc(sizeof(*ptr)) pattern, since
> alternative "g_new(typeof(*ptr))" isn't very common. But we may want
> to change that too?

Markus has made changes like this in the past (see commits bdd81add,
b45c03f, ...).  It may even be worth cribbing his commit messages,
and/or converting his Coccinelle script into something stored in the
repository, since we tend to re-run it and find more poor uses that have
crept in over time.

>=20
> Here is the cocci script I used, then I edited manually a few
> changes (I removed useless cast for ex):
>=20
> @@
> expression e1;
> expression e2;
> expression mem;
> type t1;
> @@

Your script differs from Markus', we should figure out if they can be
merged into one.

> (
> - g_malloc0(sizeof(*e2))
> + g_malloc0(sizeof(*e2))

Huh?

> |
> - g_malloc(sizeof(*e2))
> + g_malloc(sizeof(*e2))

Huh?

> |
> - g_realloc(mem, (e1) * sizeof(*e2))
> + g_renew(typeof(*e2), mem, e1)

We haven't used typeof() very frequently. I don't know if it is worth
using more frequently, maybe Markus has an opinion.

> |
> - g_malloc0((e1) * sizeof(*e2))
> + g_new0(typeof(*e2), e1)
> |
> - g_malloc((e1) * sizeof(*e2))
> + g_new(typeof(*e2), e1)
> |
> - g_realloc(mem, (e1) * sizeof(e2[0]))
> + g_renew(typeof(e2[0]), mem, e1)

Ditto.

> |
> - g_realloc(mem, (e1) * sizeof(e2))
> + g_renew(e2, mem, e1)

This one makes sense.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/lm32/lm32_hwsetup.h              |  2 +-
>  include/hw/elf_ops.h                |  2 +-
>  include/qemu/timer.h                |  2 +-
>  audio/alsaaudio.c                   |  2 +-
>  audio/coreaudio.c                   |  2 +-
>  audio/dsoundaudio.c                 |  2 +-
>  audio/ossaudio.c                    |  2 +-
>  audio/paaudio.c                     |  2 +-
>  audio/wavaudio.c                    |  2 +-
>  backends/cryptodev.c                |  2 +-
>  bootdevice.c                        |  2 +-
>  bsd-user/syscall.c                  |  2 +-
>  bt-host.c                           |  2 +-
>  bt-vhci.c                           |  2 +-
>  cpus-common.c                       |  4 ++--
>  cpus.c                              | 16 ++++++++--------
>  dma-helpers.c                       |  4 ++--
>  dump.c                              | 10 +++++-----
>  gdbstub.c                           |  4 ++--
>  hw/9pfs/9p-handle.c                 |  2 +-
>  hw/9pfs/9p-proxy.c                  |  2 +-
>  hw/9pfs/9p-synth.c                  |  2 +-
>  hw/9pfs/9p.c                        |  6 +++---
>  hw/9pfs/xen-9p-backend.c            |  6 +++---
>  hw/acpi/memory_hotplug.c            |  2 +-
>  hw/audio/intel-hda.c                |  2 +-
>  hw/bt/core.c                        |  4 ++--
>  hw/bt/hci.c                         |  4 ++--
>  hw/bt/l2cap.c                       |  4 ++--
>  hw/bt/sdp.c                         |  6 +++---
>  hw/char/parallel.c                  |  2 +-
>  hw/char/serial.c                    |  4 ++--
>  hw/char/sh_serial.c                 |  2 +-
>  hw/char/virtio-serial-bus.c         | 12 +++++-------
>  hw/core/irq.c                       |  2 +-
>  hw/core/ptimer.c                    |  2 +-
>  hw/core/reset.c                     |  2 +-
>  hw/cris/axis_dev88.c                |  2 +-
>  hw/display/pxa2xx_lcd.c             |  2 +-
>  hw/display/tc6393xb.c               |  2 +-
>  hw/display/virtio-gpu.c             |  4 ++--
>  hw/display/xenfb.c                  |  4 ++--
>  hw/dma/etraxfs_dma.c                |  2 +-
>  hw/dma/rc4030.c                     |  4 ++--
>  hw/dma/soc_dma.c                    |  6 ++----
>  hw/i2c/bitbang_i2c.c                |  2 +-
>  hw/i2c/core.c                       |  4 ++--
>  hw/i386/amd_iommu.c                 |  4 ++--
>  hw/i386/intel_iommu.c               |  2 +-
>  hw/i386/kvm/pci-assign.c            |  2 +-
>  hw/i386/pc.c                        |  5 ++---
>  hw/i386/xen/xen-hvm.c               | 12 ++++++------
>  hw/i386/xen/xen-mapcache.c          | 14 +++++++-------
>  hw/input/pckbd.c                    |  2 +-
>  hw/input/ps2.c                      |  4 ++--
>  hw/input/pxa2xx_keypad.c            |  2 +-
>  hw/input/tsc2005.c                  |  3 +--
>  hw/input/virtio-input.c             |  4 ++--
>  hw/intc/exynos4210_gic.c            |  2 +-
>  hw/intc/heathrow_pic.c              |  2 +-
>  hw/intc/xics.c                      |  2 +-
>  hw/intc/xics_kvm.c                  |  2 +-
>  hw/lm32/lm32_boards.c               |  4 ++--
>  hw/lm32/milkymist.c                 |  2 +-
>  hw/m68k/mcf5206.c                   |  4 ++--
>  hw/m68k/mcf5208.c                   |  2 +-
>  hw/mips/mips_malta.c                |  2 +-
>  hw/mips/mips_mipssim.c              |  2 +-
>  hw/mips/mips_r4k.c                  |  2 +-
>  hw/misc/applesmc.c                  |  2 +-
>  hw/misc/imx6_src.c                  |  2 +-
>  hw/misc/ivshmem.c                   |  4 ++--
>  hw/misc/macio/mac_dbdma.c           |  2 +-
>  hw/misc/pci-testdev.c               |  2 +-
>  hw/net/net_rx_pkt.c                 |  2 +-
>  hw/net/virtio-net.c                 |  2 +-
>  hw/pci/msix.c                       |  2 +-
>  hw/pci/pci.c                        |  2 +-
>  hw/pci/pcie_aer.c                   |  4 ++--
>  hw/ppc/e500.c                       |  4 ++--
>  hw/ppc/mac_newworld.c               |  2 +-
>  hw/ppc/mac_oldworld.c               |  2 +-
>  hw/ppc/ppc.c                        |  8 ++++----
>  hw/ppc/ppc405_boards.c              |  8 ++++----
>  hw/ppc/ppc405_uc.c                  | 28 ++++++++++++++--------------
>  hw/ppc/ppc440_bamboo.c              |  4 ++--
>  hw/ppc/ppc4xx_devs.c                |  4 ++--
>  hw/ppc/ppc_booke.c                  |  4 ++--
>  hw/ppc/prep.c                       |  2 +-
>  hw/ppc/spapr.c                      |  4 ++--
>  hw/ppc/spapr_events.c               |  2 +-
>  hw/ppc/spapr_iommu.c                |  2 +-
>  hw/ppc/spapr_pci.c                  |  2 +-
>  hw/ppc/spapr_vio.c                  |  2 +-
>  hw/ppc/virtex_ml507.c               |  2 +-
>  hw/s390x/css.c                      |  8 ++++----
>  hw/s390x/s390-pci-bus.c             |  4 ++--
>  hw/sh4/r2d.c                        |  4 ++--
>  hw/sh4/sh7750.c                     |  2 +-
>  hw/sparc/leon3.c                    |  2 +-
>  hw/sparc64/sparc64.c                |  4 ++--
>  hw/timer/arm_timer.c                |  2 +-
>  hw/timer/grlib_gptimer.c            |  2 +-
>  hw/timer/sh_timer.c                 |  4 ++--
>  hw/timer/slavio_timer.c             |  2 +-
>  hw/timer/xilinx_timer.c             |  2 +-
>  hw/vfio/common.c                    |  2 +-
>  hw/vfio/pci.c                       |  4 ++--
>  hw/vfio/platform.c                  |  4 ++--
>  hw/virtio/virtio-crypto.c           |  2 +-
>  hw/virtio/virtio-pci.c              |  4 ++--
>  hw/virtio/virtio.c                  |  4 ++--
>  hw/xtensa/xtfpga.c                  |  2 +-
>  kvm-all.c                           |  4 ++--
>  linux-user/elfload.c                |  2 +-
>  memory.c                            | 12 ++++++------
>  memory_mapping.c                    |  2 +-
>  migration/block.c                   |  2 +-
>  migration/postcopy-ram.c            |  2 +-
>  migration/ram.c                     |  2 +-
>  monitor.c                           |  2 +-
>  nbd/server.c                        |  4 ++--
>  net/slirp.c                         |  2 +-
>  qga/commands-win32.c                |  2 +-
>  qga/commands.c                      |  2 +-
>  qmp.c                               |  2 +-
>  qobject/json-parser.c               |  2 +-
>  replay/replay-char.c                |  8 ++++----
>  replay/replay-events.c              | 10 +++++-----
>  replay/replay-net.c                 |  5 ++---
>  slirp/dnssearch.c                   |  4 ++--
>  slirp/slirp.c                       |  2 +-
>  target/i386/cpu.c                   |  2 +-
>  target/mips/translate_init.c        |  4 ++--
>  target/openrisc/mmu.c               |  2 +-
>  target/ppc/translate_init.c         |  6 +++---
>  target/s390x/misc_helper.c          |  2 +-
>  target/s390x/mmu_helper.c           |  2 +-
>  tcg/tcg.c                           |  4 ++--
>  tests/ahci-test.c                   |  2 +-
>  tests/fw_cfg-test.c                 |  4 ++--
>  tests/libqos/ahci.c                 |  2 +-
>  tests/libqos/libqos.c               |  2 +-
>  tests/libqos/malloc.c               |  6 +++---
>  tests/pc-cpu-test.c                 |  2 +-
>  tests/qht-bench.c                   |  4 ++--
>  tests/test-hbitmap.c                |  2 +-
>  tests/test-iov.c                    |  2 +-
>  tests/test-qmp-commands.c           | 14 +++++++-------
>  tests/test-qobject-output-visitor.c |  2 +-
>  ui/console.c                        |  2 +-
>  ui/input-legacy.c                   |  2 +-
>  ui/vnc-enc-tight.c                  |  2 +-
>  ui/vnc.c                            |  2 +-
>  util/acl.c                          |  2 +-
>  util/envlist.c                      |  2 +-
>  util/hbitmap.c                      |  2 +-
>  util/iohandler.c                    |  2 +-
>  util/main-loop.c                    |  2 +-
>  util/qemu-timer.c                   |  2 +-
>  vl.c                                |  2 +-
>  161 files changed, 278 insertions(+), 285 deletions(-)

That's big; I'd rather we get consensus on the Coccinelle script first,
and then review the fallout.  Last time I did a .cocci patch that was
worth having in the tree, I specifically split the addition of the
script from running the script, to make backporting slightly easier
(backport the script as-is, then re-run the formula in the commit
message of the application, which is easier than hand-verifying conflict
resolutions over time).

>=20
> diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
> index a01f6bc5df..38ade3db0e 100644
> --- a/hw/lm32/lm32_hwsetup.h
> +++ b/hw/lm32/lm32_hwsetup.h
> @@ -58,7 +58,7 @@ static inline HWSetup *hwsetup_init(void)
>  {
>      HWSetup *hw;
> =20
> -    hw =3D g_malloc(sizeof(HWSetup));
> +    hw =3D g_new(HWSetup, 1);

At any rate, cleanups like this match what we have done in the past, so
you're on the right track, even though I'm not giving R-b yet.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--H6PoMbepJn0KiJBKBwfvvqvhptnHJ629l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOHbyAAoJEKeha0olJ0NqJEIH/R1uGI91Uo7KbsqCtcqVBLrI
hTy2HDl5vSQUvGYuFuvzkFviq3HXDUAWQQ2D31JZM0s9q34gJHXzrjsFekj5LZ+v
C2fypwkCiz8PT+lYPC9MPJPTRTDQ35B/FlNvL/JSvXJc3YYhPQUjbW6f2p0QZ89q
Q62r+NjwTMWUjr6DNsjYX+X5z/gGERp90UjIPDnx+A2T3/+BWEPAFTOZrSAWWfTv
5u0YjJ/9sD7B9O5iUCCQ21k2C4pY8Y5obzNavsQPUmHsV0ZJdqoaaEymNWc3C3QO
avGNn/ZOzQTDEdyjfGJlfPHNjrZgER9Km354NlambjaVpdX/cU42aMKkawR992U=
=nrE8
-----END PGP SIGNATURE-----

--H6PoMbepJn0KiJBKBwfvvqvhptnHJ629l--
