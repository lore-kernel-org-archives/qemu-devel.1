Received: from eggs.gnu.org ([2001:4830:134:3::10]:39733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpv2F-0005ry-0F
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpv2B-00041x-Vx
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:59:35 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cpv2B-00041V-Ph
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:59:31 -0400
Received: by mail-wm0-x22e.google.com with SMTP id n11so60121066wma.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 03:59:31 -0700 (PDT)
References: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
	<1487616072-9226-4-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1487616072-9226-4-git-send-email-peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 10:59:54 +0000
Message-ID: <87o9wwnrh1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] arm: Enforce should-be-1 bits in MRS
 decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Michael Davidsaver <mdavidsaver@gmail.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> The MRS instruction requires that bits [19..16] are all 1s, and for
> A/R profile also that bits [7..0] are all 0s.  At this point in the
> decode tree we have checked all of the rest of the instruction but
> were allowing these to be any value.  If these bits are not set then
> the result is architecturally UNPREDICTABLE, but choosing to UNDEF is
> more helpful to the user and avoids unexpected odd behaviour if the
> encodings are used for some purpose in future architecture versions.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


> ---
>  target/arm/translate.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 0f8548f..9090356 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10498,6 +10498,14 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
>                              break;
>                          }
>
> +                        if (extract32(insn, 16, 4) != 0xf) {
> +                            goto illegal_op;
> +                        }
> +                        if (!arm_dc_feature(s, ARM_FEATURE_M) &&
> +                            extract32(insn, 0, 8) != 0) {
> +                            goto illegal_op;
> +                        }
> +
>                          /* mrs cpsr */
>                          tmp = tcg_temp_new_i32();
>                          if (arm_dc_feature(s, ARM_FEATURE_M)) {
> @@ -10525,6 +10533,12 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
>                          if (IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_M)) {
>                              goto illegal_op;
>                          }
> +
> +                        if (extract32(insn, 16, 4) != 0xf ||
> +                            extract32(insn, 0, 8) != 0) {
> +                            goto illegal_op;
> +                        }
> +
>                          tmp = load_cpu_field(spsr);
>                          store_reg(s, rd, tmp);
>                          break;


--
Alex Bennée
