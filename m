Received: from eggs.gnu.org ([2001:4830:134:3::10]:60902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duZFH-0003ID-Ov
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duZFE-0004ZO-Ex
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:16:31 -0400
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <333d3515-9533-bf2a-29a5-7ff3faffa94f@redhat.com>
Date: Wed, 20 Sep 2017 09:16:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/12] Patch Round-up for stable 2.10.1,
 freeze on 2017-09-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, P J P <ppandit@redhat.com>

On 20.09.2017 02:45, Michael Roth wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v2.10.1:
>=20
>   https://github.com/mdroth/qemu/commits/stable-2.10-staging
>=20
> The release is planned for 2017-10-02:
>=20
>   https://wiki.qemu.org/Planning/2.10
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.

Looks like there have been some patches that fix CVEs, I think they
should be included, too:

e65294157d4b69393b3f819c99f4f647452b48e3
"vga: fix display update region calculation (split screen)"

3d90c6254863693a6b13d918d2b8682e08bbc681
"vga: stop passing pointers to vga_draw_line* functions"

ed4f86e8b6eff8e600c69adee68c7cd34dd2cccb
"multiboot: validate multiboot header address values"

?


Apart from that, I'd like to suggest the following commits, since
without these patches, QEMU can crash during runtime when the user
accidentally issues the wrong device_add/del commands:

84ebd3e8c7d4fe955b359b9aac84395907b0412e
"watchdog/wdt_diag288: Mark diag288 watchdog as non-hotpluggable"

0d4fa4996fc5ee56ea7d072e272b8e69948460a5
"s390x/ipl: The s390-ipl device is not hot-pluggable"

f58f25599b72c7479e6a1ff67c7f671823aa14da
"hw/arm/digic: Mark device with user_creatable =3D false"

469f3da42ef4af347fa7831e1cc0bd35d17f5b83
"hw/arm/aspeed_soc: Mark devices as user_creatable =3D false"

4c93950659487c7ad4f85571ee78524c1e3a94b3
"hw/ide/microdrive: Mark the dscm1xxxx device with user_creatable =3D fal=
se"

955f5c7ba127746345a3d43b4d7c885ca159ae6b
"ide: ahci: unparent children buses before freeing their memory"


And searching the history for "assert", I think these are also good
candidates:

32b6943699948f7adc35ada233fbd25daffad5e9
"virtfs: error out gracefully when mandatory suboptions are missing"

1540008629bbb6a9c0826582d94ecf7a559f784c
"console: fix dpy_gfx_replace_surface assert"

 Thomas


>=20
> ----------------------------------------------------------------
> Alex Williamson (1):
>       vhost: Release memory references on cleanup
>=20
> Farhan Ali (1):
>       s390-ccw: Fix alignment for CCW1
>=20
> Greg Kurz (1):
>       virtfs: error out gracefully when mandatory suboptions are missin=
g
>=20
> Hannes Reinecke (1):
>       scsi-bus: correct responses for INQUIRY and REQUEST SENSE
>=20
> Marc-Andr=C3=A9 Lureau (2):
>       libvhost-user: support resuming vq->last_avail_idx based on used_=
idx
>       vhost-user-bridge: fix resume regression (since 2.9)
>=20
> Pavel Butsykin (1):
>       qcow2: move qcow2_store_persistent_dirty_bitmaps() before cache f=
lushing
>=20
> Peter Maydell (1):
>       mps2-an511: Fix wiring of UART overflow interrupt lines
>=20
> Pranith Kumar (1):
>       arm_gicv3_kvm: Fix compile warning
>=20
> Richard Henderson (1):
>       target/arm: Fix aa64 ldp register writeback
>=20
> Samuel Thibault (1):
>       slirp: fix clearing ifq_so from pending packets
>=20
> Thomas Huth (1):
>       hw/arm/allwinner-a10: Mark the allwinner-a10 device with user_cre=
atable =3D false
>=20
>  block/qcow2.c                         | 16 +++++++-------
>  contrib/libvhost-user/libvhost-user.c | 13 ++++++++++++
>  contrib/libvhost-user/libvhost-user.h |  7 +++++++
>  hw/arm/allwinner-a10.c                |  2 ++
>  hw/arm/mps2.c                         |  4 ++--
>  hw/intc/arm_gicv3_kvm.c               |  2 +-
>  hw/scsi/scsi-bus.c                    | 29 ++++++++++++++++++++++----
>  hw/virtio/vhost.c                     |  4 ++++
>  pc-bios/s390-ccw/cio.h                |  2 +-
>  scripts/device-crash-test             |  1 -
>  slirp/socket.c                        | 39 +++++++++++++++++++++------=
--------
>  target/arm/translate-a64.c            | 29 +++++++++++++++-----------
>  tests/vhost-user-bridge.c             |  7 +++++++
>  vl.c                                  | 16 ++++++++------
>  14 files changed, 120 insertions(+), 51 deletions(-)
>=20
>=20
>=20
