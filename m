Received: from eggs.gnu.org ([2001:4830:134:3::10]:44892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqDN1-0003Rr-HE
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqDMz-0002RJ-Mf
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:11:02 -0400
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-10-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <f41e91ae-324e-17dc-f7c3-34c499dbe027@greensocs.com>
Date: Thu, 16 Aug 2018 10:10:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-10-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oANo8G3AxHELt1pdVopR5dxkChviLCjS8"
Subject: Re: [Qemu-devel] [PATCH 09/10] target/arm: Implement AArch32 ERET
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oANo8G3AxHELt1pdVopR5dxkChviLCjS8
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com
Message-ID: <f41e91ae-324e-17dc-f7c3-34c499dbe027@greensocs.com>
Subject: Re: [PATCH 09/10] target/arm: Implement AArch32 ERET instruction
References: <20180814124254.5229-1-peter.maydell@linaro.org>
 <20180814124254.5229-10-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/14/18 2:42 PM, Peter Maydell wrote:
> ARMv7VE introduced the ERET instruction, which is necessary to
> return from an exception taken to Hyp mode. Implement this.
> In A32 encoding it is a completely new encoding; in T32 it
> is an adjustment of the behaviour of the existing
> "SUBS PC, LR, #<imm8>" instruction.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-By: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/arm/translate.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 3f5751d4826..5ecc24f12fb 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8887,6 +8887,25 @@ static void disas_arm_insn(DisasContext *s, unsi=
gned int insn)
>              tcg_temp_free_i32(tmp2);
>              store_reg(s, rd, tmp);
>              break;
> +        case 0x6: /* ERET */
> +            if (op1 !=3D 3) {
> +                goto illegal_op;
> +            }
> +            if (!arm_dc_feature(s, ARM_FEATURE_V7VE)) {
> +                goto illegal_op;
> +            }
> +            if ((insn & 0x000fff0f) !=3D 0x0000000e) {
> +                /* UNPREDICTABLE; we choose to UNDEF */
> +                goto illegal_op;
> +            }
> +
> +            if (s->current_el =3D=3D 2) {
> +                tmp =3D load_cpu_field(elr_el[2]);
> +            } else {
> +                tmp =3D load_reg(s, 14);
> +            }
> +            gen_exception_return(s, tmp);
> +            break;
>          case 7:
>          {
>              int imm16 =3D extract32(insn, 0, 4) | (extract32(insn, 8, =
12) << 4);
> @@ -11144,8 +11163,16 @@ static void disas_thumb2_insn(DisasContext *s,=
 uint32_t insn)
>                          if (rn !=3D 14 || rd !=3D 15) {
>                              goto illegal_op;
>                          }
> -                        tmp =3D load_reg(s, rn);
> -                        tcg_gen_subi_i32(tmp, tmp, insn & 0xff);
> +                        if (s->current_el =3D=3D 2) {
> +                            /* ERET from Hyp uses ELR_Hyp, not LR */
> +                            if (insn & 0xff) {
> +                                goto illegal_op;
> +                            }
> +                            tmp =3D load_cpu_field(elr_el[2]);
> +                        } else {
> +                            tmp =3D load_reg(s, rn);
> +                            tcg_gen_subi_i32(tmp, tmp, insn & 0xff);
> +                        }
>                          gen_exception_return(s, tmp);
>                          break;
>                      case 6: /* MRS */
>=20


--oANo8G3AxHELt1pdVopR5dxkChviLCjS8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt1MYMACgkQd8knW3Qn
Tr7SpQ/8CHqZ+TQe90ZlRA1TH73UdRfQ87LJIOlLRo1eXHqr+e2IKwruiTSx1/pL
UP/itM4Ljb3BDWMznBfXA2sxGKfkCykaG7y5BS7NJ/wvswi5P7SvPTvPx6o9YYlv
iKS+ojLfx2sQU+qow7OEBgJ5kjMKMUId8m4gVhwos+8OKhlcGugJTOlY97HUMUtg
+Yh2a9bdnR+f+qHVOceD9oxVN9bGDIYXE+Jewt7v1xG1q4M3Fa7c7c8pprPRAu7q
6mhuu1dhw7w2UpTuEDhiJsoO4rcV+H/cndLnwez4Gm8yQL+RC0gQlr6/dNj9M6NJ
N1bsTMdc4NP4LYebYXD5exdS+m9WBSLZTI+vA3eDxZI60AMAOT+tWVpDNBE767mN
WA3iTk2daYsgWH2ItI9sjL7uA1L/wmF7S58tY6o7VwLM2tW2eOt4efhxKd6kxAYd
fJX/mthvnKP8NjVSW1C7D/32DV7gbE6SwTugj5wnf82IPirYvwlgjqhVv7SCYPQI
XSdb8Q6qnkC7vfc/P1tqNOvmbiJgPfwLJ7pPstHyqBaCoR29mW5TOmJPOF/JdGoh
RQ3ReWQVusG/7gbnPen54AETQMy11RVOB/vUm1ZamqZ6OqE+cn8kSnEbVf9XP3e3
3wxW6m0ASii8pJodhnr2dkm7fCoelWH/EZxqQCvMxjE2mKN6Q+c=
=Hzw6
-----END PGP SIGNATURE-----

--oANo8G3AxHELt1pdVopR5dxkChviLCjS8--
