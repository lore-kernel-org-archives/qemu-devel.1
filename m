Received: from eggs.gnu.org ([2001:4830:134:3::10]:50480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g7fQZ-0008ES-2U
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g7fQU-0006XB-VK
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:34:51 -0400
Received: from mail-bgr052101131073.outbound.protection.outlook.com
	([52.101.131.73]:6441
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1g7fQU-0006W8-Cm
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 07:34:46 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 3 Oct 2018 11:34:34 +0000
Message-ID: <20181003113428.GA24354@rkaganb.sw.ru>
References: <20180921082041.29380-1-rkagan@virtuozzo.com>
	<20180921082041.29380-4-rkagan@virtuozzo.com>
	<eac406e9-13d0-31e3-9b80-15d1fa46e165@redhat.com>
In-Reply-To: <eac406e9-13d0-31e3-9b80-15d1fa46e165@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD986D15DA704F419D7201CC74A0F05B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/5] hyperv: factor out arch-independent
 API into hw/hyperv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On Wed, Oct 03, 2018 at 12:56:00PM +0200, Paolo Bonzini wrote:
> On 21/09/2018 10:20, Roman Kagan wrote:
> > A significant part of hyperv.c is not actually tied to x86, and can
> > be moved to hw/.
> >=20
> > This will allow to maintain most of Hyper-V and VMBus
> > target-independent, and to avoid conflicts with inclusion of
> > arch-specific headers down the road in VMBus implementation.
> >=20
> > Also this stuff can now be opt-out with CONFIG_HYPERV.
> >=20
> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
>=20
> We can squash this in too:
>=20
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index b8f4675219..30722ccf98 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
...
> -devices-dirs-$(CONFIG_SOFTMMU) +=3D hyperv/
> +devices-dirs-$(CONFIG_HYPERV) +=3D hyperv/
...
> --- a/hw/hyperv/Makefile.objs
> +++ b/hw/hyperv/Makefile.objs
...
> -obj-$(CONFIG_HYPERV) +=3D hyperv.o
> +obj-y +=3D hyperv.o

Actually I did it this way at first, but then decided to follow the
pattern of virtio/, xen/, and most other subdirectories there just for
consistency.  Is there any preference for this?

> +obj-$(CONFIG_HYPERV_TESTDEV) +=3D hyperv_testdev.o
> diff --git a/hw/misc/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
> similarity index 100%
> rename from hw/misc/hyperv_testdev.c
> rename to hw/hyperv/hyperv_testdev.c
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 6d50b03cfd..680350b3c3 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -71,7 +71,6 @@ obj-$(CONFIG_IOTKIT_SYSCTL) +=3D iotkit-sysctl.o
>  obj-$(CONFIG_IOTKIT_SYSINFO) +=3D iotkit-sysinfo.o
>=20
>  obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
> -obj-$(CONFIG_HYPERV_TESTDEV) +=3D hyperv_testdev.o
>  obj-$(CONFIG_AUX) +=3D auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
>  obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o

Fine by me.

Thanks,
Roman.
