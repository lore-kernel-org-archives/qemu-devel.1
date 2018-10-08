Received: from eggs.gnu.org ([2001:4830:134:3::10]:51262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9gKP-0006nu-8Q
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 20:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g9gKL-0003aY-8f
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 20:56:49 -0400
Received: from ozlabs.org ([203.11.71.1]:50417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1g9gKK-0003Ys-6o
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 20:56:45 -0400
Date: Tue, 9 Oct 2018 09:25:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181008222553.GZ7004@umbus.fritz.box>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ar0NSVY9gjTGNA2"
Content-Disposition: inline
In-Reply-To: <20181008173125.19678-4-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/31] cpus hw target: Use warn_report() &
 friends to report warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alex Williamson <alex.williamson@redhat.com>, Fam Zheng <famz@redhat.com>, Wei Huang <wei@redhat.com>


--1ar0NSVY9gjTGNA2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 07:30:57PM +0200, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  Convert a few that are actually warnings to
> warn_report().
>=20
> While there, split a warning consisting of multiple sentences to
> conform to conventions spelled out in warn_report()'s contract.
>=20
> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Wei Huang <wei@redhat.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

ppc part
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  cpus.c                          |  8 ++++----
>  hw/display/cg3.c                |  2 +-
>  hw/display/tcx.c                |  2 +-
>  hw/misc/ivshmem.c               |  4 ++--
>  hw/net/virtio-net.c             |  8 ++++----
>  hw/virtio/virtio-pci.c          |  4 ++--
>  target/i386/cpu.c               | 17 +++++++++--------
>  target/ppc/translate_init.inc.c |  4 ++--
>  8 files changed, 25 insertions(+), 24 deletions(-)
>=20
> diff --git a/cpus.c b/cpus.c
> index 361678e459..7804071872 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -211,12 +211,12 @@ void qemu_tcg_configure(QemuOpts *opts, Error **err=
p)
>                  error_setg(errp, "No MTTCG when icount is enabled");
>              } else {
>  #ifndef TARGET_SUPPORTS_MTTCG
> -                error_report("Guest not yet converted to MTTCG - "
> -                             "you may get unexpected results");
> +                warn_report("Guest not yet converted to MTTCG - "
> +                            "you may get unexpected results");
>  #endif
>                  if (!check_tcg_memory_orders_compatible()) {
> -                    error_report("Guest expects a stronger memory orderi=
ng "
> -                                 "than the host provides");
> +                    warn_report("Guest expects a stronger memory orderin=
g "
> +                                "than the host provides");
>                      error_printf("This may cause strange/hard to debug e=
rrors\n");
>                  }
>                  mttcg_enabled =3D true;
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index 1c199ab369..e50d97e48c 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -307,7 +307,7 @@ static void cg3_realizefn(DeviceState *dev, Error **e=
rrp)
>          ret =3D load_image_mr(fcode_filename, &s->rom);
>          g_free(fcode_filename);
>          if (ret < 0 || ret > FCODE_MAX_ROM_SIZE) {
> -            error_report("cg3: could not load prom '%s'", CG3_ROM_FILE);
> +            warn_report("cg3: could not load prom '%s'", CG3_ROM_FILE);
>          }
>      }
> =20
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index b2786ee8d0..66f2459226 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -823,7 +823,7 @@ static void tcx_realizefn(DeviceState *dev, Error **e=
rrp)
>          ret =3D load_image_mr(fcode_filename, &s->rom);
>          g_free(fcode_filename);
>          if (ret < 0 || ret > FCODE_MAX_ROM_SIZE) {
> -            error_report("tcx: could not load prom '%s'", TCX_ROM_FILE);
> +            warn_report("tcx: could not load prom '%s'", TCX_ROM_FILE);
>          }
>      }
> =20
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 6febbabcaa..4794518b2c 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -1292,8 +1292,8 @@ static void ivshmem_realize(PCIDevice *dev, Error *=
*errp)
>      IVShmemState *s =3D IVSHMEM_COMMON(dev);
> =20
>      if (!qtest_enabled()) {
> -        error_report("ivshmem is deprecated, please use ivshmem-plain"
> -                     " or ivshmem-doorbell instead");
> +        warn_report("ivshmem is deprecated, please use ivshmem-plain"
> +                    " or ivshmem-doorbell instead");
>      }
> =20
>      if (qemu_chr_fe_backend_connected(&s->server_chr) + !!s->shmobj !=3D=
 1) {
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 4bdd5b8532..385b1a03e9 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2020,10 +2020,10 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
> =20
>      if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")
>                         && strcmp(n->net_conf.tx, "bh")) {
> -        error_report("virtio-net: "
> -                     "Unknown option tx=3D%s, valid options: \"timer\" \=
"bh\"",
> -                     n->net_conf.tx);
> -        error_report("Defaulting to \"bh\"");
> +        warn_report("virtio-net: "
> +                    "Unknown option tx=3D%s, valid options: \"timer\" \"=
bh\"",
> +                    n->net_conf.tx);
> +        error_printf("Defaulting to \"bh\"");
>      }
> =20
>      n->net_conf.tx_queue_size =3D MIN(virtio_net_max_tx_queue_size(n),
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 3a01fe90f0..a954799267 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1683,8 +1683,8 @@ static void virtio_pci_device_plugged(DeviceState *=
d, Error **errp)
>          if (err) {
>              /* Notice when a system that supports MSIx can't initialize =
it */
>              if (err !=3D -ENOTSUP) {
> -                error_report("unable to init msix vectors to %" PRIu32,
> -                             proxy->nvectors);
> +                warn_report("unable to init msix vectors to %" PRIu32,
> +                            proxy->nvectors);
>              }
>              proxy->nvectors =3D 0;
>          }
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c88876dfe3..9d4217afba 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5123,14 +5123,15 @@ static void x86_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>       * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
>       * cs->nr_threads hasn't be populated yet and the checking is incorr=
ect.
>       */
> -     if (IS_AMD_CPU(env) &&
> -         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
> -         cs->nr_threads > 1 && !ht_warned) {
> -            error_report("This family of AMD CPU doesn't support "
> -                         "hyperthreading(%d). Please configure -smp "
> -                         "options properly or try enabling topoext featu=
re.",
> -                         cs->nr_threads);
> -        ht_warned =3D true;
> +    if (IS_AMD_CPU(env) &&
> +        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
> +        cs->nr_threads > 1 && !ht_warned) {
> +            warn_report("This family of AMD CPU doesn't support "
> +                        "hyperthreading(%d)",
> +                        cs->nr_threads);
> +            error_printf("Please configure -smp options properly"
> +                         " or try enabling topoext feature.\n");
> +            ht_warned =3D true;
>      }
> =20
>      x86_cpu_apic_realize(cpu, &local_err);
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 263e63cb03..ee9432eb15 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8381,8 +8381,8 @@ static void getset_compat_deprecated(Object *obj, V=
isitor *v, const char *name,
>      QNull *null =3D NULL;
> =20
>      if (!qtest_enabled()) {
> -        error_report("CPU 'compat' property is deprecated and has no eff=
ect; "
> -                     "use max-cpu-compat machine property instead");
> +        warn_report("CPU 'compat' property is deprecated and has no effe=
ct; "
> +                    "use max-cpu-compat machine property instead");
>      }
>      visit_type_null(v, name, &null, NULL);
>      qobject_unref(null);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1ar0NSVY9gjTGNA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu72XEACgkQbDjKyiDZ
s5KPfRAAmqw7tbi6f6qSgjS+yWC6S4uI5DkP+THwQBVZFBVs/lXXWn+GwnIVPiZl
o3BGctm4tCud0noj2FhctAx4SzM6OZa9TmMgeMuNSfnriGfTV5Pe+tsE7xFdcHfb
jw2A42r839vWJfAfDBwGlYyS8vsjDyxNFLir7pc1Pw1kijE+2ZaqWbMNJNobw4VA
JDbbuUNdPwUhItN5euBDMJqORrqvan5IMr8VRgGC3FBf3Rnaq452F+xCQslt2NR/
tc0zblaZyy7qPjGJgzI+AmKFSS2hpf4cc+ycDkBjwJn0cnmSdKAv/+5WreV01XU/
DKKv2JD87dZdyf67B4DFfFftCcv9dGvV3wBsaA42fJ9NQmjKJqQZvOOqbfo3M3eq
n9pjqCVRF/UhGtmViahbcXHjIIkM9fSDOF8nus5ZbbodbZpq6oJWgpIq9H/mnCcf
Tuwai0LPz7QJekQZaW3BNikeqqn690rjuY/o4WKv2J9l04I5vfHueR621dBSUCxc
vaivcucUlBizXlBvi6YaeravR7AFVmkEyw91RLbHWzadtqAy35Wg8PUESCAKtWO7
aJFN6XTPwhoG6RLbMxcAKBDM+JdgEXdkz8bbRofm8EDf/13pgkUVxoXcLWkPrBnE
KiX7XwSo7EyIo8dYuvjdPQlPAww7LkpCav1ili88LVQzQwsC/fM=
=VxUL
-----END PGP SIGNATURE-----

--1ar0NSVY9gjTGNA2--
