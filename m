Received: from eggs.gnu.org ([2001:4830:134:3::10]:51140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlLQ-0003Hr-An
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlLO-0002bC-Nn
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:00:44 -0400
Date: Mon, 18 Jun 2018 14:00:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618040006.GS25461@umbus.fritz.box>
References: <20180615115303.31125-1-clg@kaod.org>
	<20180615115303.31125-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kLVKJMuKEUFaIs8+"
Content-Disposition: inline
In-Reply-To: <20180615115303.31125-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] spapr: split the IRQ allocation
 sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--kLVKJMuKEUFaIs8+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 01:53:01PM +0200, C=E9dric Le Goater wrote:
> Today, when a device requests for IRQ number in a sPAPR machine, the
> spapr_irq_alloc() routine first scans the ICSState status array to
> find an empty slot and then performs the assignement of the selected
> numbers. Split this sequence in two distinct routines : spapr_irq_find()
> for lookups and spapr_irq_claim() for claiming the IRQ numbers.
>=20
> This will ease the introduction of a static layout of IRQ numbers.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr.h |  5 ++++
>  hw/ppc/spapr.c         | 64 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr_events.c  | 18 ++++++++++----
>  hw/ppc/spapr_pci.c     | 19 ++++++++++++---
>  hw/ppc/spapr_vio.c     | 10 +++++++-
>  5 files changed, 108 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 3388750fc795..6088f44c1b2a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -776,6 +776,11 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int ir=
q_hint, bool lsi,
>                      Error **errp);
>  int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
>                            bool align, Error **errp);
> +int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align,
> +                   Error **errp);
> +#define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false, e=
rrp)
> +int spapr_irq_claim(sPAPRMachineState *spapr, int irq, int num, bool lsi,
> +                    Error **errp);

Unlike find, there's no reason we need to atomically claim a block of
irqs.  So I think claim should just grab a single irq.  Callers can
loop if they need multiple irqs.

Other than that and the minor points Greg noted, this looks good.

>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f59999daacfc..b1d19b328166 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3810,6 +3810,36 @@ static int ics_find_free_block(ICSState *ics, int =
num, int alignnum)
>      return -1;
>  }
> =20
> +int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Error =
**errp)
> +{
> +    ICSState *ics =3D spapr->ics;
> +    int first =3D -1;
> +
> +    assert(ics);
> +
> +    /*
> +     * MSIMesage::data is used for storing VIRQ so
> +     * it has to be aligned to num to support multiple
> +     * MSI vectors. MSI-X is not affected by this.
> +     * The hint is used for the first IRQ, the rest should
> +     * be allocated continuously.
> +     */
> +    if (align) {
> +        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
> +               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
> +        first =3D ics_find_free_block(ics, num, num);
> +    } else {
> +        first =3D ics_find_free_block(ics, num, 1);
> +    }
> +
> +    if (first < 0) {
> +        error_setg(errp, "can't find a free %d-IRQ block", num);
> +        return -1;
> +    }
> +
> +    return first + ics->offset;
> +}
> +
>  /*
>   * Allocate the IRQ number and set the IRQ type, LSI or MSI
>   */
> @@ -3888,6 +3918,40 @@ int spapr_irq_alloc_block(sPAPRMachineState *spapr=
, int num, bool lsi,
>      return first;
>  }
> =20
> +int spapr_irq_claim(sPAPRMachineState *spapr, int irq, int num, bool lsi,
> +                    Error **errp)
> +{
> +    ICSState *ics =3D spapr->ics;
> +    int i;
> +    int srcno =3D irq - ics->offset;
> +    int ret =3D 0;
> +
> +    assert(ics);
> +
> +    if (!ics_valid_irq(ics, irq) || !ics_valid_irq(ics, irq + num)) {
> +        return -1;
> +    }
> +
> +    for (i =3D srcno; i < srcno + num; ++i) {
> +        if (ICS_IRQ_FREE(ics, i)) {
> +            spapr_irq_set_lsi(spapr, i + ics->offset, lsi);
> +        } else {
> +            error_setg(errp, "IRQ %d is not free", i + ics->offset);
> +            ret =3D -1;
> +            break;
> +        }
> +    }
> +
> +    /* we could call spapr_irq_free() when rolling back */
> +    if (ret) {
> +        while (--i >=3D srcno) {
> +            memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
> +        }
> +    }
> +
> +    return ret;
> +}
> +
>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
>  {
>      ICSState *ics =3D spapr->ics;
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 86836f0626dc..3b6ae7272092 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -707,13 +707,18 @@ void spapr_clear_pending_events(sPAPRMachineState *=
spapr)
> =20
>  void spapr_events_init(sPAPRMachineState *spapr)
>  {
> +    int epow_irq;
> +
> +    epow_irq =3D spapr_irq_findone(spapr, &error_fatal);
> +
> +    spapr_irq_claim(spapr, epow_irq, 1, false, &error_fatal);
> +
>      QTAILQ_INIT(&spapr->pending_events);
> =20
>      spapr->event_sources =3D spapr_event_sources_new();
> =20
>      spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_EPOW,
> -                                 spapr_irq_alloc(spapr, 0, false,
> -                                                  &error_fatal));
> +                                 epow_irq);
> =20
>      /* NOTE: if machine supports modern/dedicated hotplug event source,
>       * we add it to the device-tree unconditionally. This means we may
> @@ -724,9 +729,14 @@ void spapr_events_init(sPAPRMachineState *spapr)
>       * checking that it's enabled.
>       */
>      if (spapr->use_hotplug_event_source) {
> +        int hp_irq;
> +
> +        hp_irq =3D spapr_irq_findone(spapr, &error_fatal);
> +
> +        spapr_irq_claim(spapr, hp_irq, 1, false, &error_fatal);
> +
>          spapr_event_sources_register(spapr->event_sources, EVENT_CLASS_H=
OT_PLUG,
> -                                     spapr_irq_alloc(spapr, 0, false,
> -                                                      &error_fatal));
> +                                     hp_irq);
>      }
> =20
>      spapr->epow_notifier.notify =3D spapr_powerdown_req;
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index f936ce63effa..7394c62b4a8b 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -371,8 +371,14 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
>      }
> =20
>      /* Allocate MSIs */
> -    irq =3D spapr_irq_alloc_block(spapr, req_num, false,
> -                           ret_intr_type =3D=3D RTAS_TYPE_MSI, &err);
> +    irq =3D spapr_irq_find(spapr, req_num, ret_intr_type =3D=3D RTAS_TYP=
E_MSI, &err);
> +    if (err) {
> +        error_reportf_err(err, "Can't allocate MSIs for device %x: ",
> +                          config_addr);
> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> +        return;
> +    }
> +    spapr_irq_claim(spapr, irq, req_num, false, &err);
>      if (err) {
>          error_reportf_err(err, "Can't allocate MSIs for device %x: ",
>                            config_addr);
> @@ -1698,7 +1704,14 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>          uint32_t irq;
>          Error *local_err =3D NULL;
> =20
> -        irq =3D spapr_irq_alloc_block(spapr, 1, true, false, &local_err);
> +        irq =3D spapr_irq_findone(spapr, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            error_prepend(errp, "can't allocate LSIs: ");
> +            return;
> +        }
> +
> +        spapr_irq_claim(spapr, irq, 1, true, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              error_prepend(errp, "can't allocate LSIs: ");
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 4555c648a8e2..ad9b56e28447 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -475,7 +475,15 @@ static void spapr_vio_busdev_realize(DeviceState *qd=
ev, Error **errp)
>          dev->qdev.id =3D id;
>      }
> =20
> -    dev->irq =3D spapr_irq_alloc(spapr, dev->irq, false, &local_err);
> +    if (!dev->irq) {
> +        dev->irq =3D spapr_irq_findone(spapr, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +
> +    spapr_irq_claim(spapr, dev->irq, 1, false, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kLVKJMuKEUFaIs8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnLkYACgkQbDjKyiDZ
s5Igcg//YGvE+uEeQ65yLth4Q8knvhD7GhWC6F6S70oHSU79utyIKXVJb5e7drFX
OSFSpD+9SrVvEoeesNWvArfjeIaYuhlYJMn+fUiuPcNKYFnzYNsBIfZ3rwsyAxAp
modCLqgJCyz+zD/6YorxQUEKnd+QXWcCtTSnvmJJ8xRaAmxXykqGUj2Mjx+1fzjP
Zs6nuJ5DZPUY+TFn+tgVTwqcRCnjSstw3pT+ZF5bd2lLUSOWhdlbl8il0b7dENrD
3dHQ6ZWOBoptif1RSqFqeNP4exGngava4kD8cyO9NcRtHlXNlgZHr1yZyZC69SLW
kk8+V+ufdoGDz8RGRKEZ0x/96Cw6jMFNEe50glhCuBRfgU+1RLaK3S2oZ7z11WBc
mjCuQL3VOCV8I9/BLsFwXVvY+cDql6qCKXvU5foUXSWxEcxyBdcmVri5fjodJ4nq
WD6xb/Fszp/rXoWPKwee8xIDsTPAUDSKVo3Elj5qQF3TD94yZdClzJuxPqs7/9Kf
LEH7fFZGk6Jb1VcVy8ztQquS0AlV58eW/guScZjzH7Rx3Iih7he6313l3C50NGd8
OtyKrlm7B4D88M9lX6HGJiF1jQiFT4uCrUmZAfLZxTTsYZ63BbGLdB22+M4Na7Z6
2zsILAkhFukY5NbMLrpwBql0Aj86JcB0t09HRlghm15raZ5IR78=
=JAqp
-----END PGP SIGNATURE-----

--kLVKJMuKEUFaIs8+--
