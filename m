Received: from eggs.gnu.org ([2001:4830:134:3::10]:59578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLI4-0001wr-CU
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLI2-0006vL-5F
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:38:28 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqLI1-0006tk-VC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:38:26 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so9097632oie.13
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:38:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180816120533.6587-1-rka@sysgo.com>
References: <20180816120533.6587-1-rka@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 17:38:04 +0100
Message-ID: <CAFEAcA8W_Vf_G_0TKUHUWuckFN7ruj1UjWud=QP6xUpvW5XTPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: crash on conditional instr
 in it block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 16 August 2018 at 13:05, Roman Kapl <rka@sysgo.com> wrote:
> If an instruction is conditional (like CBZ) and it is executed conditiona=
lly
> (using the ITx instruction), a jump to undefined label is generated.
> CBZ in IT block is an unpredictable behavior, and honouring the condition=
 code
> is allowed by the spec in this case (constrained unpredictable, ARMv8, se=
ction
> K1.1.7).
>
> Fix the 'skip on condtion' code to create a new label only if it does not
> already exist. Previously multiple labels were created, but only the last=
 one of
> them was set.
>
> Signed-off-by: Roman Kapl <rka@sysgo.com>
> ---
> v1 -> v2
>  Split arm_conditional_skip into arm_gen_condlabel and arm_skip_unless to
>  a) cover all usages
>  b) do not force callers to ^1 the condition
>
>  Add note about CBZ in IT block to the commit message.
>
>  target/arm/translate.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index f845da7c63..e54e0ca2ba 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -8480,6 +8480,22 @@ static void gen_srs(DisasContext *s,
>      s->base.is_jmp =3D DISAS_UPDATE;
>  }
>
> +/* Generate a labe used for skipping this instruction */

"label"

> +static void arm_gen_condlabel(DisasContext *s)
> +{
> +    if (!s->condjmp) {
> +        s->condlabel =3D gen_new_label();
> +        s->condjmp =3D 1;
> +    }
> +}
> +
> +/* Skip this instruction if the ARM condition is false */
> +static void arm_skip_unless(DisasContext *s, uint32_t cond)
> +{
> +    arm_gen_condlabel(s);
> +    arm_gen_test_cc(cond, s->condlabel ^ 1);

This has applied the ^ 1 to the wrong argument. This causes
a compile error (at least if you're building with debug):

/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c: In
function =E2=80=98arm_skip_unless=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/target/arm/translate.c:8496:40:
error: invalid operands to binary ^ (have =E2=80=98TCGLabel * {aka struct
TCGLabel *}=E2=80=99 and =E2=80=98int=E2=80=99)
     arm_gen_test_cc(cond, s->condlabel ^ 1);
                                        ^

Rather than make you resend the patch, I'll just fix this up locally.

thanks
-- PMM
