Received: from eggs.gnu.org ([2001:4830:134:3::10]:42025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ91M-0007C8-ET
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ91I-0002kH-8k
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:16 -0400
Received: from ozlabs.org ([203.11.71.1]:57153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gJ91H-0002bX-6o
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:11 -0400
Date: Sat, 3 Nov 2018 13:25:09 +0000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181103132509.GF24365@umbus.hotspot.internet-for-guests.com>
References: <20181030093031.10131.17221.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <20181030093031.10131.17221.stgit@pasha-VirtualBox>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix mtmsr instruction for
 icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, agraf@suse.de


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 12:30:31PM +0300, Pavel Dovgalyuk wrote:
> This patch fixes processing of mtmsr instructions in icount mode.
> In this mode writing to interrupt/peripheral state is controlled
> by can_do_io flag. This flag must be set explicitly before helper
> function invocation.
>=20
> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Applied to ppc-for-3.1, thanks.

> ---
>  target/ppc/translate.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4e59dd5..987ce6e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4257,11 +4257,17 @@ static void gen_mtmsrd(DisasContext *ctx)
>           *      if we enter power saving mode, we will exit the loop
>           *      directly from ppc_store_msr
>           */
> +        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +            gen_io_start();
> +        }
>          gen_update_nip(ctx, ctx->base.pc_next);
>          gen_helper_store_msr(cpu_env, cpu_gpr[rS(ctx->opcode)]);
>          /* Must stop the translation as machine state (may have) changed=
 */
>          /* Note that mtmsr is not always defined as context-synchronizin=
g */
>          gen_stop_exception(ctx);
> +        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +            gen_io_end();
> +        }
>      }
>  #endif /* !defined(CONFIG_USER_ONLY) */
>  }
> @@ -4286,6 +4292,9 @@ static void gen_mtmsr(DisasContext *ctx)
>           *      if we enter power saving mode, we will exit the loop
>           *      directly from ppc_store_msr
>           */
> +        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +            gen_io_start();
> +        }
>          gen_update_nip(ctx, ctx->base.pc_next);
>  #if defined(TARGET_PPC64)
>          tcg_gen_deposit_tl(msr, cpu_msr, cpu_gpr[rS(ctx->opcode)], 0, 32=
);
> @@ -4293,6 +4302,9 @@ static void gen_mtmsr(DisasContext *ctx)
>          tcg_gen_mov_tl(msr, cpu_gpr[rS(ctx->opcode)]);
>  #endif
>          gen_helper_store_msr(cpu_env, msr);
> +        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +            gen_io_end();
> +        }
>          tcg_temp_free(msr);
>          /* Must stop the translation as machine state (may have) changed=
 */
>          /* Note that mtmsr is not always defined as context-synchronizin=
g */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvdobQACgkQbDjKyiDZ
s5KtmRAA51MgkQLOo6o2+lprHi8p3/qjJxFHncRpJEzCCkNZYoD0xh8KkDFYZEYm
uzjTlM0pnTVd+jQ6a2XnsMzSB5f5q9atxMWN3qwxmnTggV6fGj4jMLakGf+BT5Lt
V4G1JDpZI6zYzkvkAcvKa4H34ao2V3WJEsF4KdgyDbkhGsiqEpb0PkWhcAsJiO2J
zFl8T6HoG+cdKaHQAW97NpqZKbzuYk89aKUP1WlqKEIORKgH8LRYYgFGoIU9bZJj
hD3CExpw7CbQP1hymdMrzIrlfUkxsTzjNrqEHHd8OWactLgUQuTlN/WL7seXEz3Z
VOkUEVL6qh+wqqV99mDGW1m5fkyrv0kb55636luhUHYDBsXqL7gGuiMKYhOECozr
7Cw/5I7TRwbQhI35Vdy7XpGv0zXAecnu6lOaIirhkQOxxceAom9wtR/FRMwVYj79
180bnMTtSf77KQbEq++ViEcRO+AujKimQoXPdlyklh/isBDXub5aICsjRs+YweGe
NuilfJSMX232W5ncchZz7niYwEEU91a1HYS3d/Qep/vrqePVqOhKC9DVCz0Dr0VR
eUZwWz5CehsdjoznTKfUAw42qxBkHtsi4/GN9xZ8He4f1DNF1FrIEvv+aMAHKg79
esQVfHw3Py9g6GuRnyRzg15342RTV81ymyTlrXEFWCCYBH0kSWQ=
=JjAC
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
