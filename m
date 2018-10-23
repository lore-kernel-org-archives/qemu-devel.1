Received: from eggs.gnu.org ([2001:4830:134:3::10]:50416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gErFG-00016x-63
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gErFC-0005yh-VJ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:36:54 -0400
Received: from mout02.posteo.de ([185.67.36.66]:58585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1gErFC-0005xG-GU
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:36:50 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id 7B67A240102
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 09:36:48 +0200 (CEST)
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-8-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <82a4a209-3fba-ab45-3d27-c9f2e6585608@posteo.de>
Date: Tue, 23 Oct 2018 08:36:44 +0100
MIME-Version: 1.0
In-Reply-To: <20181018182856.28001-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 07/11] hw/m68k: add Nubus support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, yongbok.kim@mips.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

On 2018-10-18 19:28, Mark Cave-Ayland wrote:
> From: Laurent Vivier <laurent@vivier.eu>
>=20
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
[...]
> +static void nubus_register_format_block(NubusDevice *dev)
> +{
> +    char fblock_name[27];
> +
> +    sprintf(fblock_name, "nubus-slot-%d-format-block", dev->slot_nb);

Latest GCC (version 8) got very picky about possible buffer overflows
during sprintf() ... not sure, but it might be necessary to either use a
bigger array here, or assert(dev->slot_nb < NUBUS_SLOT_NB), or even
better use g_strdup_printf() instead (with g_free() at the end of the
function) instead.

> +    hwaddr fblock_offset =3D memory_region_size(&dev->slot_mem) - FBLO=
CK_SIZE;
> +    memory_region_init_io(&dev->fblock_io, NULL, &nubus_format_block_o=
ps,
> +                          dev, fblock_name, FBLOCK_SIZE);
> +    memory_region_add_subregion(&dev->slot_mem, fblock_offset,
> +                                &dev->fblock_io);
> +}
[...]
> diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
> index 70ea5480fe..3059f2f36a 100644
> --- a/include/hw/display/macfb.h
> +++ b/include/hw/display/macfb.h
> @@ -39,4 +39,25 @@ typedef struct {
>      MacfbState macfb;
>  } MacfbSysBusState;
> =20
> +#define MACFB_NUBUS_DEVICE_CLASS(class) \
> +    OBJECT_CLASS_CHECK(MacfbNubusDeviceClass, (class), TYPE_NUBUS_MACF=
B)
> +#define MACFB_NUBUS_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MacfbNubusDeviceClass, (obj), TYPE_NUBUS_MACFB)
> +
> +typedef struct MacfbNubusDeviceClass {
> +    DeviceClass parent_class;
> +
> +    DeviceRealize parent_realize;> +} MacfbNubusDeviceClass;
>
> +#define TYPE_NUBUS_MACFB "nubus-macfb"
> +#define NUBUS_MACFB(obj) \
> +    OBJECT_CHECK(MacfbNubusState, (obj), TYPE_NUBUS_MACFB)
> +
> +typedef struct {
> +    NubusDevice busdev;
> +
> +    MacfbState macfb;
> +} MacfbNubusState;
> +
>  #endif

I think this should rather be part of the next patch instead?

 Thomas
