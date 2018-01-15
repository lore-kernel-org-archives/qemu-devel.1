Received: from eggs.gnu.org ([2001:4830:134:3::10]:58916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eb0m6-0008HU-RN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eb0m5-00082c-RD
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:09:50 -0500
Date: Mon, 15 Jan 2018 10:09:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180115100914.3ee3c68b.cohuck@redhat.com>
In-Reply-To: <20180114020412.26160-4-f4bug@amsat.org>
References: <20180114020412.26160-1-f4bug@amsat.org>
	<20180114020412.26160-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC PATCH 3/3] qdev: use
 device_class_set_parent_realize/unrealize/reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S.
	Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Dmitry Fleytman <dmitry@daynix.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Yongbok Kim <yongbok.kim@mips.com>, Marek Vasut <marex@denx.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Fam Zheng <famz@redhat.com>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "open list:ARM cores" <qemu-arm@nongnu.org>, Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "open list:S390" <qemu-s390x@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Sat, 13 Jan 2018 23:04:12 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> changes generated using the following Coccinelle patch:
>=20
>   @@
>   type DeviceParentClass;
>   DeviceParentClass *pc;
>   DeviceClass *dc;
>   identifier parent_fn;
>   identifier child_fn;
>   @@
>   (
>   +device_class_set_parent_realize(dc, child_fn, &pc->parent_fn);
>   -pc->parent_fn =3D dc->realize;
>   ...
>   -dc->realize =3D child_fn;
>   |
>   +device_class_set_parent_unrealize(dc, child_fn, &pc->parent_fn);
>   -pc->parent_fn =3D dc->unrealize;
>   ...
>   -dc->unrealize =3D child_fn;
>   |
>   +device_class_set_parent_reset(dc, child_fn, &pc->parent_fn);
>   -pc->parent_fn =3D dc->reset;
>   ...
>   -dc->reset =3D child_fn;
>   )
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i386/kvm/i8254.c                | 4 ++--
>  hw/i386/kvm/i8259.c                | 3 +--
>  hw/input/adb-kbd.c                 | 4 ++--
>  hw/input/adb-mouse.c               | 4 ++--
>  hw/intc/arm_gic.c                  | 3 +--
>  hw/intc/arm_gic_kvm.c              | 7 +++----
>  hw/intc/arm_gicv3.c                | 3 +--
>  hw/intc/arm_gicv3_its_kvm.c        | 3 +--
>  hw/intc/arm_gicv3_kvm.c            | 7 +++----
>  hw/intc/i8259.c                    | 3 +--
>  hw/net/vmxnet3.c                   | 4 ++--
>  hw/pci-bridge/gen_pcie_root_port.c | 3 +--
>  hw/scsi/vmw_pvscsi.c               | 4 ++--
>  hw/timer/i8254.c                   | 3 +--
>  hw/vfio/amd-xgbe.c                 | 4 ++--
>  hw/vfio/calxeda-xgmac.c            | 4 ++--
>  hw/virtio/virtio-pci.c             | 4 ++--
>  target/alpha/cpu.c                 | 4 ++--
>  target/arm/cpu.c                   | 4 ++--
>  target/cris/cpu.c                  | 4 ++--
>  target/hppa/cpu.c                  | 4 ++--
>  target/i386/cpu.c                  | 8 ++++----
>  target/lm32/cpu.c                  | 5 ++---
>  target/m68k/cpu.c                  | 5 ++---
>  target/microblaze/cpu.c            | 5 ++---
>  target/mips/cpu.c                  | 5 ++---
>  target/moxie/cpu.c                 | 5 ++---
>  target/nios2/cpu.c                 | 4 ++--
>  target/openrisc/cpu.c              | 5 ++---
>  target/ppc/translate_init.c        | 8 ++++----
>  target/s390x/cpu.c                 | 4 ++--
>  target/sh4/cpu.c                   | 4 ++--
>  target/sparc/cpu.c                 | 4 ++--
>  target/tilegx/cpu.c                | 4 ++--
>  target/tricore/cpu.c               | 4 ++--
>  target/unicore32/cpu.c             | 4 ++--
>  target/xtensa/cpu.c                | 4 ++--
>  37 files changed, 73 insertions(+), 88 deletions(-)

> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index ae3cee91a2..4c068cedff 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -463,8 +463,8 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
>      CPUClass *cc =3D CPU_CLASS(scc);
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> =20
> -    scc->parent_realize =3D dc->realize;
> -    dc->realize =3D s390_cpu_realizefn;
> +    device_class_set_parent_realize(dc, s390_cpu_realizefn,
> +                                    &scc->parent_realize);
>      dc->props =3D s390x_cpu_properties;
>      dc->user_creatable =3D true;
> =20

s390x change:

Acked-by: Cornelia Huck <cohuck@redhat.com>
