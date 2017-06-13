Received: from eggs.gnu.org ([2001:4830:134:3::10]:32906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh47-0007bA-6k
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh45-0007v4-RP
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:43 -0400
Date: Tue, 13 Jun 2017 16:20:26 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170613082026.GF30171@umbus>
References: <20170608070351.1434-1-sjitindarsingh@gmail.com>
	<20170608070351.1434-4-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline
In-Reply-To: <20170608070351.1434-4-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] target/ppc: Implement migration
 support for large decrementer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 05:03:49PM +1000, Suraj Jitindar Singh wrote:
> Implement support to migrate a guest which is using the large
> decrementer.
>=20
> We need to save the decrementer width to the migration stream.
> On incoming migration we then need to check that the hypervisor is
> capable of letting the guest use the large decrementer and that the
> decrementer width is the same on the receiving side. Since there is no
> way to tell the guest when the width of the decrementer changes we have
> to terminate if the decrementer width is not what the guest expects.
> If we can use the large decrementer then we have to tell the hypervisor
> to enable it.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr.c         | 63 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |  1 +
>  2 files changed, 64 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5d10366..6ba869a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1420,6 +1420,45 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error =
**errp)
>      }
>  }
> =20
> +static int spapr_import_large_decr_bits(sPAPRMachineState *spapr)
> +{
> +    /*
> +     * If the guest uses the large decrementer then this hypervisor must=
 also
> +     * support it and have the exact same width. We must also enable the=
 large
> +     * decrementer because we have no way to tell the guest to stop usin=
g it.
> +     */
> +    if (spapr->large_decr_bits) {
> +        uint32_t dec_bits =3D 32;
> +        PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +        CPUState *cs =3D CPU(cpu);
> +        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
> +
> +        if (kvm_enabled()) {
> +            if (!kvmppc_has_cap_large_decr()) {
> +                error_report("Host doesn't support large decrementer and=
 guest requires it");
> +                return -EINVAL;
> +            }
> +            dec_bits =3D kvmppc_get_dec_bits();
> +        } else {
> +            dec_bits =3D pcc->large_decr_bits;
> +        }
> +
> +        if (spapr->large_decr_bits !=3D dec_bits) {
> +            error_report("Host large decrementer size [%u] doesn't match=
 what guest expects [%u]",
> +                         dec_bits, spapr->large_decr_bits);
> +            return -EINVAL;
> +        }

Could you just use a VMSTATE_EQUAL() rather than explicit post_load logic?

> +
> +        if (kvm_enabled()) {
> +            CPU_FOREACH(cs) {
> +                kvmppc_configure_large_decrementer(cs, true);
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static int spapr_post_load(void *opaque, int version_id)
>  {
>      sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> @@ -1439,8 +1478,13 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>       * value into the RTC device */
>      if (version_id < 3) {
>          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
> +        if (err) {
> +            return err;
> +        }
>      }
> =20
> +    err =3D spapr_import_large_decr_bits(spapr);
> +
>      return err;
>  }
> =20
> @@ -1529,6 +1573,24 @@ static const VMStateDescription vmstate_spapr_patb=
_entry =3D {
>      },
>  };
> =20
> +static bool spapr_large_decr_entry_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    return !!spapr->large_decr_bits;

Hrm.  We have no existing releases - upstream or down - that support
POWER9, which is the first thing with large decr.  Rather than fancy
conditional logic, could we just always transfer the decr size for
POWER9?

Do we need to support qemu on POWER9 with a pre-large-decr host
kernel?  Or is POWER9 support new enough that we can just say that you
require a host kernel with large decr support to run POWER9 guests.
That could simplify several things.

> +}
> +
> +static const VMStateDescription vmstate_spapr_large_decr_entry =3D {
> +    .name =3D "spapr_large_decr_entry",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_large_decr_entry_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(large_decr_bits, sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -1547,6 +1609,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
> +        &vmstate_spapr_large_decr_entry,
>          NULL
>      }
>  };
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 98fb78b..4ba9b89 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -91,6 +91,7 @@ struct sPAPRMachineState {
>      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
>      bool cas_reboot;
>      bool cas_legacy_guest_workaround;
> +    uint32_t large_decr_bits; /* Large decrementer width (0 -> not in us=
e) */

Having this here as well as in the CPU class seems a bit icky.

>      Notifier epow_notifier;
>      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZP6BJAAoJEGw4ysog2bOSNmYQAKGW1jhpIfVeKhPloGF+Iai2
4NGZCmex/2wsW9TEH45XrhuQ04c7ZYt5jf0Q+hEzZP3QiLK4qjPTAgzJ+nVfyHh7
3Oy14MiMUZB8mAuYlAKm27C7OpQa7bpHXAfLZ6kR86f6wzDC4Ak0zVwf5eR9A28D
e15HgIom5nlcB6IEbnxANpE2SE/j2KJGuf9GSBjM/tGX+N5eAwm0Uqg2ATdPoyoO
fDAcTgPbjZwqTnQWpGNiR6fzqhrkjAJVqnTFlhaxtULGiKjotdUMbxnruVNluSAx
oGBSxmiC9wHtnMHSId7SA9pZqfWZvRi6fzH/eOfgNxK/2osKeLwbf5SJ2XroqJE4
updvLv/MLR0AMzYW3y9bt7YWgJVIk6aHMTHGxqaMM1FKaghW+CdAoMKV9p0zd+fO
RUPiLC0S5vkPFkfdXXFpJPhOg4GFxgTlTcp3XfvHQSzWb64me3quf12FxZlwv2ti
lH1KDISqgUFcofSHmDw2hYVBz8GTysbWYIPsbl1q7S4J5C9H2V8UCLWSeH+Vs57w
jNKH/aQLUv+KBsKKAdMSb2OZp6tTdAgQSDdkIk2sA40XeocLoPT8Wgv8eE2J7+BE
J4GhzgQo0m+ynfPkBLPs6W3tL6gizsaLGF6xStdwYETd/DTaXcb39jgOW0nv3XXH
QSjwbvVnZsDc77JZFWe6
=rH1w
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
