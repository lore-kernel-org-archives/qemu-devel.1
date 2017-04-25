Received: from eggs.gnu.org ([2001:4830:134:3::10]:42477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d39N1-0007Pn-1i
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d39Mx-0000qC-VE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:55:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d39Mx-0000pZ-MU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:55:39 -0400
Date: Tue, 25 Apr 2017 19:55:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170425225531.GR3482@thinpad.lan.raisama.net>
References: <20170424130355.31324-1-marcandre.lureau@redhat.com>
	<20170425202920.GQ3482@thinpad.lan.raisama.net>
	<20170425233318-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170425233318-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, anderson@redhat.com, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, lersek@redhat.com, Richard Henderson <rth@twiddle.net>

On Tue, Apr 25, 2017 at 11:35:23PM +0300, Michael S. Tsirkin wrote:
> On Tue, Apr 25, 2017 at 05:29:20PM -0300, Eduardo Habkost wrote:
> > On Mon, Apr 24, 2017 at 05:03:55PM +0400, Marc-Andr=E9 Lureau wrote:
> > [...]
> > > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > > index 5d5be91daf..d0c9b71902 100644
> > > --- a/include/hw/compat.h
> > > +++ b/include/hw/compat.h
> > > @@ -135,6 +135,10 @@
> > >          .driver   =3D "vmgenid",\
> > >          .property =3D "x-write-pointer-available",\
> > >          .value    =3D "off",\
> > > +    },{\
> > > +        .driver   =3D "vmcoreinfo",\
> > > +        .property =3D "x-write-pointer-available",\
> > > +        .value    =3D "off",\
> > >      },
> >=20
> > My first reaction to this was "we don't need this compat property, be=
cause the
> > device didn't even exist in QEMU 2.4".
> >=20
> > But then I read commit f2a1ae45d8ec5ad494e66a9234499a2e0fbf4b40 and n=
ow I see
> > why this is required: this is a compat property whose sole function i=
s to
> > prevent the device from being instantiated.
> >=20
> > Instead of requiring an extra compat property, I suggest just checkin=
g if
> > fw_cfg has DMA enabled. e.g.:
> >=20
> >  static void vmgenid_realize(DeviceState *dev, Error **errp)
> >  {
> >      VmGenIdState *vms =3D VMGENID(dev);
> > +    FWCfgState *fw_cfg =3D FW_CFG(object_resolve_path_type("", TYPE_=
FW_CFG, NULL));
> >=20
> > -    if (!vms->write_pointer_available) {
> > +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
> >          error_setg(errp, "%s requires DMA write support in fw_cfg, "
> >                     "which this machine type does not provide", VMGEN=
ID_DEVICE);
> >          return;
> >=20
> >=20
> > This has the additional benefit of handling other cases properly, lik=
e:
> >=20
> >   $ qemu-system-x86_64 -device vmgenid -machine none
> >   qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write sup=
port in fw_cfg, which this machine type does not provide
> >   $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.9 -global=
 fw_cfg.dma_enabled=3Doff
> >   qemu-system-x86_64: -device vmgenid: vmgenid requires DMA write sup=
port in fw_cfg, which this machine type does not provide
> >   $ qemu-system-x86_64 -device vmgenid -machine pc-i440fx-2.6 -global=
 fw_cfg.dma_enabled=3Don
> >   [boots normally]
> >   $
>=20
> It's quite ugly to make it poke at fw cfg internals though,
> it shouldn't know how is write pointer implemented.
> We need some kind of API that it can share with vm gen id.

Do you mean adding something like this to bios-linker-loader.c?

  bool bios_linker_loader_can_write_pointer(void)
  {
      FWCfgState *fw_cfg =3D FW_CFG(object_resolve_path_type("", TYPE_FW_=
CFG, NULL));
      return fw_cfg && fw_cfg_dma_enabled(fw_cfg);
  }

--=20
Eduardo
