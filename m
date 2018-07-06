Received: from eggs.gnu.org ([2001:4830:134:3::10]:60814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbSwZ-0000o7-Gj
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fbSwW-0006Q7-Ay
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:46:47 -0400
Received: from mail-eopbgr680113.outbound.protection.outlook.com
	([40.107.68.113]:5924
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fbSwW-0006Pb-4p
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:46:44 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 6 Jul 2018 15:46:41 +0000
Message-ID: <BN7PR08MB4868E3BC16E55F381B078AD6C6470@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1530732637-28606-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530732637-28606-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] target/mips: Check ELPA flag only
 in some cases of MFHC0 and MTHC0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Yongbok Kim <yongbok.kim@mips.com>
>
> MFHC0 and MTHC0 used to handle EntryLo0 and EntryLo1 registers only,
> and placing ELPA flag checks befor switch statement were technically
> correct. However, after adding handling more registers, these checks
> should be moved to act only in cases of handling EntryLo0 and
> EntryLo1.
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

(ctx->hflags & MIPS_HFLAG_ELPA) is set to be a flag that depends on both
LPA and ELPA. This does not seem to me the best way to do this - I would ra=
ther have separate bits for this and similar occasions. It would be easier =
to check the code against the documentation - and that is more imortant IMH=
O than having spent extra bit, or having slightly more to check in tha tcod=
e. But, this is ooutside of the scope of this patch. The outcome of the pat=
ch seems to be in accirdance with the documentation. So:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index fa1da7e..c01cafe 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -4885,12 +4885,11 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg=
, int > reg, int sel)
>  {
>      const char *rn =3D "invalid";
>
> -    CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
> -
>      switch (reg) {
>      case 2:
>          switch (sel) {
>          case 0:
> +            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
>              gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0))=
;
>              rn =3D "EntryLo0";
>              break;
> @@ -4901,6 +4900,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, =
int reg, > int sel)
>      case 3:
>          switch (sel) {
>          case 0:
> +            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
>              gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1))=
;
>              rn =3D "EntryLo1";
>              break;
> @@ -4965,12 +4965,11 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg=
, int > reg, int sel)
>      const char *rn =3D "invalid";
>      uint64_t mask =3D ctx->PAMask >> 36;
>
> -    CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
> -
>      switch (reg) {
>      case 2:
>          switch (sel) {
>          case 0:
> +            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
>              tcg_gen_andi_tl(arg, arg, mask);
>              gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0))=
;
>              rn =3D "EntryLo0";
> @@ -4982,6 +4981,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, =
int reg, > int sel)
>      case 3:
>          switch (sel) {
>          case 0:
> +            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
>              tcg_gen_andi_tl(arg, arg, mask);
>              gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1))=
;
>              rn =3D "EntryLo1";
> --
> 2.7.4
