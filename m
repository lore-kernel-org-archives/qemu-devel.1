Received: from eggs.gnu.org ([2001:4830:134:3::10]:34372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilY-000271-3Z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPilV-0006Wl-4L
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 02:14:52 -0400
Date: Mon, 4 Jun 2018 11:27:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604012734.GG4251@umbus>
References: <1527531079-32717-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <1527531079-32717-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Use proper logging function
 for possible guest errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 28, 2018 at 08:11:19PM +0200, Thomas Huth wrote:
> fprintf() and qemu_log_separate() are frowned upon these days for printing
> logging information in QEMU. Accessing the wrong SPRs indicates wrong gue=
st
> behaviour in most cases, and we've got a proper way to log such situation=
s,
> which is the qemu_log_mask(LOG_GUEST_ERROR, ...) function. So use this
> function now for logging the bad SPR accesses instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.13, thanks.

> ---
>  target/ppc/translate.c | 37 ++++++++++++-------------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e30d99f..0806ee0 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3933,13 +3933,9 @@ static inline void gen_op_mfspr(DisasContext *ctx)
>               * allowing userland application to read the PVR
>               */
>              if (sprn !=3D SPR_PVR) {
> -                fprintf(stderr, "Trying to read privileged spr %d (0x%03=
x) at "
> -                        TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_nex=
t - 4);
> -                if (qemu_log_separate()) {
> -                    qemu_log("Trying to read privileged spr %d (0x%03x) =
at "
> -                             TARGET_FMT_lx "\n", sprn, sprn,
> -                             ctx->base.pc_next - 4);
> -                }
> +                qemu_log_mask(LOG_GUEST_ERROR, "Trying to read privilege=
d spr "
> +                              "%d (0x%03x) at " TARGET_FMT_lx "\n", sprn=
, sprn,
> +                              ctx->base.pc_next - 4);
>              }
>              gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
>          }
> @@ -3951,12 +3947,9 @@ static inline void gen_op_mfspr(DisasContext *ctx)
>              return;
>          }
>          /* Not defined */
> -        fprintf(stderr, "Trying to read invalid spr %d (0x%03x) at "
> -                TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
> -        if (qemu_log_separate()) {
> -            qemu_log("Trying to read invalid spr %d (0x%03x) at "
> -                     TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next -=
 4);
> -        }
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Trying to read invalid spr %d (0x%03x) at "
> +                      TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next =
- 4);
> =20
>          /* The behaviour depends on MSR:PR and SPR# bit 0x10,
>           * it can generate a priv, a hv emu or a no-op
> @@ -4097,12 +4090,9 @@ static void gen_mtspr(DisasContext *ctx)
>              (*write_cb)(ctx, sprn, rS(ctx->opcode));
>          } else {
>              /* Privilege exception */
> -            fprintf(stderr, "Trying to write privileged spr %d (0x%03x) =
at "
> -                    TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - =
4);
> -            if (qemu_log_separate()) {
> -                qemu_log("Trying to write privileged spr %d (0x%03x) at "
> -                         TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_ne=
xt - 4);
> -            }
> +            qemu_log_mask(LOG_GUEST_ERROR, "Trying to write privileged s=
pr "
> +                          "%d (0x%03x) at " TARGET_FMT_lx "\n", sprn, sp=
rn,
> +                          ctx->base.pc_next - 4);
>              gen_priv_exception(ctx, POWERPC_EXCP_PRIV_REG);
>          }
>      } else {
> @@ -4114,12 +4104,9 @@ static void gen_mtspr(DisasContext *ctx)
>          }
> =20
>          /* Not defined */
> -        if (qemu_log_separate()) {
> -            qemu_log("Trying to write invalid spr %d (0x%03x) at "
> -                     TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next -=
 4);
> -        }
> -        fprintf(stderr, "Trying to write invalid spr %d (0x%03x) at "
> -                TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next - 4);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Trying to write invalid spr %d (0x%03x) at "
> +                      TARGET_FMT_lx "\n", sprn, sprn, ctx->base.pc_next =
- 4);
> =20
> =20
>          /* The behaviour depends on MSR:PR and SPR# bit 0x10,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUlYYACgkQbDjKyiDZ
s5J15g/8COrAAxXZQAaz/aYaKYFGF+gsDarB1/A3+xr6+ek+OIjsTar8DtlKXFF9
St/1MCz13hMxJgiRMvuU/ebKUYCvWFOO82oyAji+cWUg+fxlOtIyKlFGDjROuTon
lLr70ZP5JV+fXLsr/YlHLytROoJcgFinl5roibh+26Y+77mFTbkm93YEl41FmSor
RnyOxoTPCnMnWtKAX9OusPUvNeYdqZDSQF6RumCteDreyym3AzT0QyxbBgNwwPHe
gd9uwhWGPN9ZJh39s2rnrRJv7N6ox0335gVBDSvriHBpahBurmSRDOpLOOVrCcXt
PnThhqWBLvmlcmwmp0B6F73ucxW6f54ZbUgk4bHpET5MOIwBDpejiEZ10aGt+q3F
v88fe+anQq7h2B0+Hv95xg8IJBeVWq3EqxiJGn5l0eyJBIyipXGCMuFhDnc66bI1
JkYGouGSB+s/nPb/Wt7wOfn6wL1lFrWOO3Ydm4X3EEl6N1ASZg6Uw9y42RHONWmD
cPrfCbWTe6l1Sl5g/2afqTMPZtKtcEqjT3aWuntF7h3PMqatVdYCgXwta/Mu3bJI
I+hF6JgJ6BJief8Sc1+Tb6giQ7RGA6Wc8YU5OOyJZUjf5Lt6bhMfyL8PaK7laieV
iDWyINvP9RKpvFtFDqcfF0dfackMgSdYmOdfTdDopRBzJyYXitQ=
=BEO5
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
