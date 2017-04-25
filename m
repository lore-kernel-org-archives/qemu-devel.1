Received: from eggs.gnu.org ([2001:4830:134:3::10]:32987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d375X-0000f0-4U
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 16:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d375T-0000J9-2M
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 16:29:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d375S-0000Iv-Rg
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 16:29:26 -0400
Date: Tue, 25 Apr 2017 17:29:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170425202920.GQ3482@thinpad.lan.raisama.net>
References: <20170424130355.31324-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170424130355.31324-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RFC: vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, lersek@redhat.com, anderson@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Apr 24, 2017 at 05:03:55PM +0400, Marc-Andr=E9 Lureau wrote:
[...]
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 5d5be91daf..d0c9b71902 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -135,6 +135,10 @@
>          .driver   =3D "vmgenid",\
>          .property =3D "x-write-pointer-available",\
>          .value    =3D "off",\
> +    },{\
> +        .driver   =3D "vmcoreinfo",\
> +        .property =3D "x-write-pointer-available",\
> +        .value    =3D "off",\
>      },

My first reaction to this was "we don't need this compat property, becaus=
e the
device didn't even exist in QEMU 2.4".

But then I read commit f2a1ae45d8ec5ad494e66a9234499a2e0fbf4b40 and now I=
 see
why this is required: this is a compat property whose sole function is to
prevent the device from being instantiated.

Instead of requiring an extra compat property, I suggest just checking if
fw_cfg has DMA enabled. e.g.:

 static void vmgenid_realize(DeviceState *dev, Error **errp)
 {
     VmGenIdState *vms =3D VMGENID(dev);
+    FWCfgState *fw_cfg =3D FW_CFG(object_resolve_path_type("", TYPE_FW_C=
FG, NULL));

-    if (!vms->write_pointer_available) {
+    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
         error_setg(errp, "%s requires DMA write support in fw_cfg, "
                    "which this machine type does not provide", VMGENID_D=
EVICE);
         return;


This has the additional benefit of handling other cases properly, like:

  $ qemu-system-x86_64 -device vmgenid -machine none
  qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write support=
 in fw_cfg, which this machine type does not provide
  $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.9 -global fw_=
cfg.dma_enabled=3Doff
  qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write support=
 in fw_cfg, which this machine type does not provide
  $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.6 -global fw_=
cfg.dma_enabled=3Don
  [boots normally]
  $

--=20
Eduardo
