Received: from eggs.gnu.org ([2001:4830:134:3::10]:40775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cEPy2-0000MC-So
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 19:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cEPxz-0000uw-ND
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 19:20:14 -0500
Received: from ozlabs.org ([103.22.144.67]:57365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cEPxy-0000t6-Lx
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 19:20:11 -0500
Date: Wed, 7 Dec 2016 10:21:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161206232116.GR32366@umbus.fritz.box>
References: <20161201170624.26496-1-lersek@redhat.com>
	<20161201170624.26496-4-lersek@redhat.com>
	<20161206124906.76a41896@nial.brq.redhat.com>
	<3da2baa9-9fa6-7802-fe56-afa02a892a07@redhat.com>
	<ef91b0e5-3863-d93e-680f-13d7a3f3cdf2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VdnGiXwuH6t1Tqzo"
Content-Disposition: inline
In-Reply-To: <ef91b0e5-3863-d93e-680f-13d7a3f3cdf2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/7] fw-cfg: expose "file_slots"
 parameter in fw_cfg_init_io_dma()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, "Gabriel L. Somlo" <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--VdnGiXwuH6t1Tqzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 05:52:26PM +0100, Laszlo Ersek wrote:
> Mark, Artyom, do the sun4u machines support any kind of migration, given
> that they are not versioned?
>=20
> Alex, David, do the mac_newworld / mac_oldworld machines support
> migration, given that they are not versioned?

I don't believe so.  There might be some bits and pieces of migration
code, but I don't think it's ever been in a state where it was really
expected to work.

>=20
> Thanks
> Laszlo
>=20
> On 12/06/16 17:46, Laszlo Ersek wrote:
> > On 12/06/16 12:49, Igor Mammedov wrote:
> >> On Thu,  1 Dec 2016 18:06:20 +0100
> >> Laszlo Ersek <lersek@redhat.com> wrote:
> >>
> >>> Accordingly, generalize the "file_slots" minimum calculation in
> >>> fw_cfg_init_io_dma(), and move the constant FW_CFG_FILE_SLOTS_TRAD
> >>> argument to the callers of fw_cfg_init_io_dma().
> >> If I get idea correctly you're extending fw_cfg_init_io_dma() and
> >> setting
> >>  qdev_prop_set_uint32(dev, "file_slots", file_slots);
> >> manually to keep old fw_cfg_init_io() the same without touching
> >> xen/sun4u machines.
> >=20
> > First, to my knowledge, Xen does not use fw_cfg. The following call
> > chains depend on (!xen_enabled()):
> >=20
> > pc_init1() | pc_q35_init()
> >   if (!xen_enabled()):
> >     pc_memory_init()
> >       bochs_bios_init()
> >         fw_cfg_init_io_dma()
> >=20
> > Second, I wanted to keep the fw_cfg_init_io() call sites un-touched. In
> > this patch, the fw_cfg_init_io() function passes an additional /
> > internal-only parameter to fw_cfg_init_io_dma(), and the unconditional
> > qdev_prop_set_uint32() call in fw_cfg_init_io_dma() is replaced with a
> > conditional one (so that the property can only be lowered, not raised,
> > by board code).
> >=20
> >> That way we would have 2 different ways to set defaults
> >> per machine type/version rather then the single COMPAT property way.
> >>
> >> How about dropping this patch and adding
> >>  SET_MACHINE_COMPAT
> >> to xen/sun4u machines instead and dropping fw_cfg_init_io() in
> >> favor of fw_cfg_init_io_dma() along the way.
> >=20
> > For the conditional qdev_prop_set_uint32() call, added in this patch, I
> > used commit e6915b5f3a87 ("fw_cfg: unbreak migration compatibility for
> > 2.4 and earlier machines") as model. According to that model, I couldn't
> > drop this patch completely, because the new feature -- i.e., DMA in that
> > patch, and higher fw_cfg file slots in this patch -- depends on both
> > machine versions and board opt-in.
> >=20
> > However, if we agree (according to your feedback on patch v4 2/7) that
> > we will silently bump the fw_cfg file count for all new machine
> > versions, without requiring (or permitting) board opt-in / opt-out, then
> > I agree your above suggestion is consistent with that.
> >=20
> > I think I don't have to drop fw_cfg_init_io() actually. But, with the
> > board opt-in going away, I can drop both the additional "file_slots"
> > parameter in fw_cfg_init_io_dma(), and the qdev_prop_set_uint32() call
> > in it (even the unconditional one).
> >=20
> > In fact I like this simplicity more, I just wanted to be extra cautious
> > in the first version of the series that turned file_slots into a proper=
ty.
> >=20
> > ... Actually, are sun4u machines versioned? Hm... "hw/sparc64/sun4u.c"
> > doesn't seem to define versioned machine types. Doesn't that imply that
> > migration is *completely* unsupported for sun4u? Because, if that's the
> > case, then I wouldn't even have to add SET_MACHINE_COMPAT().
> >=20
> > Thanks!
> > Laszlo
> >=20
> >>
> >>>
> >>> Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
> >>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >>> Cc: Gerd Hoffmann <kraxel@redhat.com>
> >>> Cc: Igor Mammedov <imammedo@redhat.com>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> >>> ---
> >>>  docs/specs/fw_cfg.txt     |  4 ++--
> >>>  include/hw/nvram/fw_cfg.h |  2 +-
> >>>  hw/i386/pc.c              |  3 ++-
> >>>  hw/nvram/fw_cfg.c         | 13 ++++++-------
> >>>  4 files changed, 11 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
> >>> index 84e2978706f5..4a6888b511f4 100644
> >>> --- a/docs/specs/fw_cfg.txt
> >>> +++ b/docs/specs/fw_cfg.txt
> >>> @@ -153,12 +153,12 @@ Selector Reg.    Range Usage
> >>>  0x4000 - 0x7fff  Generic (0x0000 - 0x3fff, RW, ignored in QEMU v2.4+)
> >>>  0x8000 - 0xbfff  Arch. Specific (0x0000 - 0x3fff, generally RO, poss=
ibly RW
> >>>                                   through the DMA interface in QEMU v=
2.9+)
> >>>  0xc000 - 0xffff  Arch. Specific (0x0000 - 0x3fff, RW, ignored in v2.=
4+)
> >>> =20
> >>> -In practice, the number of allowed firmware configuration items is g=
iven
> >>> -by the value (FW_CFG_FILE_FIRST + FW_CFG_FILE_SLOTS_TRAD) (see fw_cf=
g.h).
> >>> +In practice, the number of allowed firmware configuration items depe=
nds on the
> >>> +machine type.
> >> machine type/version
> >>
> >>> =20
> >>>  =3D Guest-side DMA Interface =3D
> >>> =20
> >>>  If bit 1 of the feature bitmap is set, the DMA interface is present.=
 This does
> >>>  not replace the existing fw_cfg interface, it is an add-on. This int=
erface
> >>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> >>> index b980cbaebf43..e9a6b6aa968c 100644
> >>> --- a/include/hw/nvram/fw_cfg.h
> >>> +++ b/include/hw/nvram/fw_cfg.h
> >>> @@ -173,11 +173,11 @@ void fw_cfg_add_file_callback(FWCfgState *s, co=
nst char *filename,
> >>>   */
> >>>  void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *=
data,
> >>>                           size_t len);
> >>> =20
> >>>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
> >>> -                                AddressSpace *dma_as);
> >>> +                                AddressSpace *dma_as, uint32_t file_=
slots);
> >>>  FWCfgState *fw_cfg_init_io(uint32_t iobase);
> >>>  FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr);
> >>>  FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> >>>                                   hwaddr data_addr, uint32_t data_wid=
th,
> >>>                                   hwaddr dma_addr, AddressSpace *dma_=
as);
> >>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >>> index a9e64a88e5e7..5d929d8fc887 100644
> >>> --- a/hw/i386/pc.c
> >>> +++ b/hw/i386/pc.c
> >>> @@ -741,11 +741,12 @@ static FWCfgState *bochs_bios_init(AddressSpace=
 *as, PCMachineState *pcms)
> >>>  {
> >>>      FWCfgState *fw_cfg;
> >>>      uint64_t *numa_fw_cfg;
> >>>      int i, j;
> >>> =20
> >>> -    fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4=
, as);
> >>> +    fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4=
, as,
> >>> +                                FW_CFG_FILE_SLOTS_TRAD);
> >>>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
> >>> =20
> >>>      /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
> >>>       *
> >>>       * For machine types prior to 1.8, SeaBIOS needs FW_CFG_MAX_CPUS=
 for
> >>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> >>> index 2e1441c09750..c33c76ab93b1 100644
> >>> --- a/hw/nvram/fw_cfg.c
> >>> +++ b/hw/nvram/fw_cfg.c
> >>> @@ -926,11 +926,11 @@ static void fw_cfg_init1(DeviceState *dev)
> >>>      s->machine_ready.notify =3D fw_cfg_machine_ready;
> >>>      qemu_add_machine_init_done_notifier(&s->machine_ready);
> >>>  }
> >>> =20
> >>>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
> >>> -                                AddressSpace *dma_as)
> >>> +                                AddressSpace *dma_as, uint32_t file_=
slots)
> >>>  {
> >>>      DeviceState *dev;
> >>>      FWCfgState *s;
> >>>      uint32_t version =3D FW_CFG_VERSION;
> >>>      bool dma_requested =3D dma_iobase && dma_as;
> >>> @@ -940,15 +940,14 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase,=
 uint32_t dma_iobase,
> >>>      qdev_prop_set_uint32(dev, "dma_iobase", dma_iobase);
> >>>      if (!dma_requested) {
> >>>          qdev_prop_set_bit(dev, "dma_enabled", false);
> >>>      }
> >>> =20
> >>> -    /* Once we expose the "file_slots" property to callers of
> >>> -     * fw_cfg_init_io_dma(), the following setting should become con=
ditional on
> >>> -     * the input parameter being lower than the current value of the=
 property.
> >>> -     */
> >>> -    qdev_prop_set_uint32(dev, "file_slots", FW_CFG_FILE_SLOTS_TRAD);
> >>> +    if (file_slots < object_property_get_int(OBJECT(dev), "file_slot=
s",
> >>> +                                             &error_abort)) {
> >>> +        qdev_prop_set_uint32(dev, "file_slots", file_slots);
> >>> +    }
> >>> =20
> >>>      fw_cfg_init1(dev);
> >>>      s =3D FW_CFG(dev);
> >>> =20
> >>>      if (s->dma_enabled) {
> >>> @@ -964,11 +963,11 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase,=
 uint32_t dma_iobase,
> >>>      return s;
> >>>  }
> >>> =20
> >>>  FWCfgState *fw_cfg_init_io(uint32_t iobase)
> >>>  {
> >>> -    return fw_cfg_init_io_dma(iobase, 0, NULL);
> >>> +    return fw_cfg_init_io_dma(iobase, 0, NULL, FW_CFG_FILE_SLOTS_TRA=
D);
> >>>  }
> >>> =20
> >>>  FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> >>>                                   hwaddr data_addr, uint32_t data_wid=
th,
> >>>                                   hwaddr dma_addr, AddressSpace *dma_=
as)
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VdnGiXwuH6t1Tqzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYR0fqAAoJEGw4ysog2bOS9ScP/0EEF5Biop6zdiTrndxG5GQn
lerim0SP34MT2k0uKsjYF2ySqJLJHuL19nFUEpfBFI5/47LH/sVKS5BfnZUc5KtN
XUz8qQwY/aOH6rXs4+g1ysKr4gXHbZFe1C+7EPy2Um0vVrHz5vsPbMEx0FaffdKD
MGUaMNXJt/szFnCIshsAUlGsLiAW/bbSLgiawkvdpTlrbYvU6LdaW+jcM5IKDLjI
QD3/7/UvHFTsda0LUOjhh7VHLWgKyDjfDJBfGFp7VsL8oJbE5aRVv4vKxz72qdAg
OyPA2T3K+NHJ+9dhT217VEqJnGxCXc/IZShbLFNNZP7/rSE5cZOdY3WLbSVmjwko
Pzi7coWRH6Fu48dZSHTx0r2eq/4rUTHlbYBqJ/zirRGFGL6NaayUhB0k6koiJOoE
fWWs2Ow3Gs+oSWu1f6sOmpOVKkXuCFPp/JlY8QWYLD2Dm9+5c9RkkQ+BX8EjNpm8
e1MLm4/VnJpfJsTm81Qe+2mLaMuVnkcwYnOez1xZFI+kDm9szds1G6YfQUdiPoA1
q/uJEjYJToMo2QqOzoXYKtzXsdBhytwirM/doFK4IUO7n8aKfkxFeGK8F3C4L+R7
7q22inQIyWSOsnIrbFD/SBzIJQXfBptDruqBj4JhizBLYk6z26fThj1+zOQPEeYg
eryuFuSW3a3yTwOwNBnj
=LO8Y
-----END PGP SIGNATURE-----

--VdnGiXwuH6t1Tqzo--
