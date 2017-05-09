Received: from eggs.gnu.org ([2001:4830:134:3::10]:53513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7vWj-0002EN-EA
	for qemu-devel@nongnu.org; Mon, 08 May 2017 23:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7vWh-0007Ug-7J
	for qemu-devel@nongnu.org; Mon, 08 May 2017 23:09:29 -0400
Date: Tue, 9 May 2017 12:42:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170509024242.GJ25748@umbus.fritz.box>
References: <20170508205735.23444-1-ehabkost@redhat.com>
	<20170508205735.23444-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
Content-Disposition: inline
In-Reply-To: <20170508205735.23444-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] audio: Move arch_init audio code to
 hw/audio/soundhw.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org, Gerd Hoffmann <kraxel@redhat.com>, agraf@suse.de


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 05:57:33PM -0300, Eduardo Habkost wrote:
> There's no reason to keep the soundhw table in arch_init.c. Move
> that code to a new hw/audio/soundhw.c file.
>=20
> While moving the code, trivial coding style issues were fixed.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes v2 -> v3:
> * Update hw/ppc/prep.c to include hw/audio/audio.h too
>=20
> Changes v1 -> v2:
> * Rebase to latest qemu.git master
> ---
>  include/hw/audio/audio.h   |   3 +
>  include/sysemu/arch_init.h |   2 -
>  arch_init.c                | 124 -----------------------------------
>  hw/audio/soundhw.c         | 156 +++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/prep.c              |   1 +
>  vl.c                       |   1 +
>  hw/audio/Makefile.objs     |   2 +
>  7 files changed, 163 insertions(+), 126 deletions(-)
>  create mode 100644 hw/audio/soundhw.c
>=20
> diff --git a/include/hw/audio/audio.h b/include/hw/audio/audio.h
> index 55d40f71bf..259bb2cf96 100644
> --- a/include/hw/audio/audio.h
> +++ b/include/hw/audio/audio.h
> @@ -7,4 +7,7 @@ void isa_register_soundhw(const char *name, const char *d=
escr,
>  void pci_register_soundhw(const char *name, const char *descr,
>                            int (*init_pci)(PCIBus *bus));
> =20
> +void audio_init(void);
> +void select_soundhw(const char *optarg);
> +
>  #endif
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 2bf16b203c..8751c468ed 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -28,8 +28,6 @@ enum {
> =20
>  extern const uint32_t arch_type;
> =20
> -void select_soundhw(const char *optarg);
> -void audio_init(void);
>  int kvm_available(void);
>  int xen_available(void);
> =20
> diff --git a/arch_init.c b/arch_init.c
> index 0810116144..74ca62f508 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -85,130 +85,6 @@ int graphic_depth =3D 32;
> =20
>  const uint32_t arch_type =3D QEMU_ARCH;
> =20
> -struct soundhw {
> -    const char *name;
> -    const char *descr;
> -    int enabled;
> -    int isa;
> -    union {
> -        int (*init_isa) (ISABus *bus);
> -        int (*init_pci) (PCIBus *bus);
> -    } init;
> -};
> -
> -static struct soundhw soundhw[9];
> -static int soundhw_count;
> -
> -void isa_register_soundhw(const char *name, const char *descr,
> -                          int (*init_isa)(ISABus *bus))
> -{
> -    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
> -    soundhw[soundhw_count].name =3D name;
> -    soundhw[soundhw_count].descr =3D descr;
> -    soundhw[soundhw_count].isa =3D 1;
> -    soundhw[soundhw_count].init.init_isa =3D init_isa;
> -    soundhw_count++;
> -}
> -
> -void pci_register_soundhw(const char *name, const char *descr,
> -                          int (*init_pci)(PCIBus *bus))
> -{
> -    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
> -    soundhw[soundhw_count].name =3D name;
> -    soundhw[soundhw_count].descr =3D descr;
> -    soundhw[soundhw_count].isa =3D 0;
> -    soundhw[soundhw_count].init.init_pci =3D init_pci;
> -    soundhw_count++;
> -}
> -
> -void select_soundhw(const char *optarg)
> -{
> -    struct soundhw *c;
> -
> -    if (is_help_option(optarg)) {
> -    show_valid_cards:
> -
> -        if (soundhw_count) {
> -             printf("Valid sound card names (comma separated):\n");
> -             for (c =3D soundhw; c->name; ++c) {
> -                 printf ("%-11s %s\n", c->name, c->descr);
> -             }
> -             printf("\n-soundhw all will enable all of the above\n");
> -        } else {
> -             printf("Machine has no user-selectable audio hardware "
> -                    "(it may or may not have always-present audio hardwa=
re).\n");
> -        }
> -        exit(!is_help_option(optarg));
> -    }
> -    else {
> -        size_t l;
> -        const char *p;
> -        char *e;
> -        int bad_card =3D 0;
> -
> -        if (!strcmp(optarg, "all")) {
> -            for (c =3D soundhw; c->name; ++c) {
> -                c->enabled =3D 1;
> -            }
> -            return;
> -        }
> -
> -        p =3D optarg;
> -        while (*p) {
> -            e =3D strchr(p, ',');
> -            l =3D !e ? strlen(p) : (size_t) (e - p);
> -
> -            for (c =3D soundhw; c->name; ++c) {
> -                if (!strncmp(c->name, p, l) && !c->name[l]) {
> -                    c->enabled =3D 1;
> -                    break;
> -                }
> -            }
> -
> -            if (!c->name) {
> -                if (l > 80) {
> -                    error_report("Unknown sound card name (too big to sh=
ow)");
> -                }
> -                else {
> -                    error_report("Unknown sound card name `%.*s'",
> -                                 (int) l, p);
> -                }
> -                bad_card =3D 1;
> -            }
> -            p +=3D l + (e !=3D NULL);
> -        }
> -
> -        if (bad_card) {
> -            goto show_valid_cards;
> -        }
> -    }
> -}
> -
> -void audio_init(void)
> -{
> -    struct soundhw *c;
> -    ISABus *isa_bus =3D (ISABus *) object_resolve_path_type("", TYPE_ISA=
_BUS, NULL);
> -    PCIBus *pci_bus =3D (PCIBus *) object_resolve_path_type("", TYPE_PCI=
_BUS, NULL);
> -
> -    for (c =3D soundhw; c->name; ++c) {
> -        if (c->enabled) {
> -            if (c->isa) {
> -                if (!isa_bus) {
> -                    error_report("ISA bus not available for %s", c->name=
);
> -                    exit(1);
> -                }
> -                c->init.init_isa(isa_bus);
> -            } else {
> -                if (!pci_bus) {
> -                    error_report("PCI bus not available for %s", c->name=
);
> -                    exit(1);
> -                }
> -                c->init.init_pci(pci_bus);
> -            }
> -        }
> -    }
> -}
> -
>  int kvm_available(void)
>  {
>  #ifdef CONFIG_KVM
> diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
> new file mode 100644
> index 0000000000..5e96b73c81
> --- /dev/null
> +++ b/hw/audio/soundhw.c
> @@ -0,0 +1,156 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/help_option.h"
> +#include "qemu/error-report.h"
> +#include "qom/object.h"
> +#include "hw/isa/isa.h"
> +#include "hw/pci/pci.h"
> +#include "hw/audio/audio.h"
> +
> +struct soundhw {
> +    const char *name;
> +    const char *descr;
> +    int enabled;
> +    int isa;
> +    union {
> +        int (*init_isa) (ISABus *bus);
> +        int (*init_pci) (PCIBus *bus);
> +    } init;
> +};
> +
> +static struct soundhw soundhw[9];
> +static int soundhw_count;
> +
> +void isa_register_soundhw(const char *name, const char *descr,
> +                          int (*init_isa)(ISABus *bus))
> +{
> +    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
> +    soundhw[soundhw_count].name =3D name;
> +    soundhw[soundhw_count].descr =3D descr;
> +    soundhw[soundhw_count].isa =3D 1;
> +    soundhw[soundhw_count].init.init_isa =3D init_isa;
> +    soundhw_count++;
> +}
> +
> +void pci_register_soundhw(const char *name, const char *descr,
> +                          int (*init_pci)(PCIBus *bus))
> +{
> +    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
> +    soundhw[soundhw_count].name =3D name;
> +    soundhw[soundhw_count].descr =3D descr;
> +    soundhw[soundhw_count].isa =3D 0;
> +    soundhw[soundhw_count].init.init_pci =3D init_pci;
> +    soundhw_count++;
> +}
> +
> +void select_soundhw(const char *optarg)
> +{
> +    struct soundhw *c;
> +
> +    if (is_help_option(optarg)) {
> +    show_valid_cards:
> +
> +        if (soundhw_count) {
> +             printf("Valid sound card names (comma separated):\n");
> +             for (c =3D soundhw; c->name; ++c) {
> +                 printf ("%-11s %s\n", c->name, c->descr);
> +             }
> +             printf("\n-soundhw all will enable all of the above\n");
> +        } else {
> +             printf("Machine has no user-selectable audio hardware "
> +                    "(it may or may not have always-present audio hardwa=
re).\n");
> +        }
> +        exit(!is_help_option(optarg));
> +    }
> +    else {
> +        size_t l;
> +        const char *p;
> +        char *e;
> +        int bad_card =3D 0;
> +
> +        if (!strcmp(optarg, "all")) {
> +            for (c =3D soundhw; c->name; ++c) {
> +                c->enabled =3D 1;
> +            }
> +            return;
> +        }
> +
> +        p =3D optarg;
> +        while (*p) {
> +            e =3D strchr(p, ',');
> +            l =3D !e ? strlen(p) : (size_t) (e - p);
> +
> +            for (c =3D soundhw; c->name; ++c) {
> +                if (!strncmp(c->name, p, l) && !c->name[l]) {
> +                    c->enabled =3D 1;
> +                    break;
> +                }
> +            }
> +
> +            if (!c->name) {
> +                if (l > 80) {
> +                    error_report("Unknown sound card name (too big to sh=
ow)");
> +                }
> +                else {
> +                    error_report("Unknown sound card name `%.*s'",
> +                                 (int) l, p);
> +                }
> +                bad_card =3D 1;
> +            }
> +            p +=3D l + (e !=3D NULL);
> +        }
> +
> +        if (bad_card) {
> +            goto show_valid_cards;
> +        }
> +    }
> +}
> +
> +void audio_init(void)
> +{
> +    struct soundhw *c;
> +    ISABus *isa_bus =3D (ISABus *) object_resolve_path_type("", TYPE_ISA=
_BUS, NULL);
> +    PCIBus *pci_bus =3D (PCIBus *) object_resolve_path_type("", TYPE_PCI=
_BUS, NULL);
> +
> +    for (c =3D soundhw; c->name; ++c) {
> +        if (c->enabled) {
> +            if (c->isa) {
> +                if (!isa_bus) {
> +                    error_report("ISA bus not available for %s", c->name=
);
> +                    exit(1);
> +                }
> +                c->init.init_isa(isa_bus);
> +            } else {
> +                if (!pci_bus) {
> +                    error_report("PCI bus not available for %s", c->name=
);
> +                    exit(1);
> +                }
> +                c->init.init_pci(pci_bus);
> +            }
> +        }
> +    }
> +}
> +
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 961230c569..96a4813b3f 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -36,6 +36,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/ppc/ppc.h"
>  #include "hw/boards.h"
> +#include "hw/audio/audio.h"
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "hw/ide.h"
> diff --git a/vl.c b/vl.c
> index 560288fe0c..a2400e1ab6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -89,6 +89,7 @@ int main(int argc, char **argv)
>  #include "migration/block.h"
>  #include "sysemu/tpm.h"
>  #include "sysemu/dma.h"
> +#include "hw/audio/audio.h"
>  #include "audio/audio.h"
>  #include "migration/migration.h"
>  #include "sysemu/cpus.h"
> diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
> index bb6f07a91e..63db383709 100644
> --- a/hw/audio/Makefile.objs
> +++ b/hw/audio/Makefile.objs
> @@ -14,3 +14,5 @@ common-obj-$(CONFIG_PL041) +=3D pl041.o lm4549.o
>  common-obj-$(CONFIG_CS4231) +=3D cs4231.o
>  common-obj-$(CONFIG_MARVELL_88W8618) +=3D marvell_88w8618.o
>  common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-ac97.o
> +
> +common-obj-y +=3D soundhw.o

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZESygAAoJEGw4ysog2bOSST0P/31ZKmfmJS3wpXVhk5Hb/eVn
WXyVYjl0Qxyh3FROgn3K+cRzze7NhwBn0uL/qwai1kOOQVfvUF3UeHe2Gi1jgbYG
dwZ5pc6imdfbrqHYfre5WHq2PvL90wSgtu7Ug8v3dAW03J25v0c9N76lenhCuu1b
M8XkEfVlZMvTRYvm0mp1I8eCL014muoA0raClJtVP99JZ2r2jGhB3qCy4gD7AacQ
sLrQugbGtEPARnakoXPGW2X2VZAsmtTaYaLaBX8Ry4CkeFON8A+rr3Fb1jgTMy8i
uhnFzkYOuIT9X5H4+Wd2jyocoH3UL6M2Of/Hc0zUdMvNnhu8wWaZ7drljfY4oI9B
LPnTsKB/M2a3Xjzj7BvAwIqDBTW5a3de8y+PkjkZEOhaWlVzwR0+FfvvDSEjPDNk
8lpqNej2R86btFCCbpljfX04ZIhsSEsGuelAyZPjpVrTi3tN4dxM4BERP7f49K5r
fp1WU4BgLVk2vsRNgKar40V9ctzihsVOtua2n9L4a/7vm1hRezMxXLtdWgBSoCU8
tNap/MuHdBkWErBycMKLnP3mOZ+0iokv875mSKCZykUoQuNA2PBj2r0iUZsbBBxe
CGxyBd4ItBwhqIWpUQZKKJBPapCnuiXdCI2ItBcdzsS+tpt+SgItEF7ynjSRxRLC
ty6MoXXzr6yg2qi+i2Xg
=+Olz
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--
