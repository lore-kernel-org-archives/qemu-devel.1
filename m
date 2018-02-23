Received: from eggs.gnu.org ([2001:4830:134:3::10]:53657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epEHU-00082Z-9M
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epEHT-0002sT-7F
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:25:00 -0500
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:45303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epEHS-0002q3-Vw
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:24:59 -0500
Received: by mail-pg0-x233.google.com with SMTP id e11so3405481pgq.12
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:24:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-27-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 14:24:37 +0000
Message-ID: <CAFEAcA8UWBemOXvu7-Dt5CMv7VHSTNp4fGSKPnnHT2UfNryOHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 26/67] target/arm: Implement
 SVE Permute - Extract Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  2 ++
>  target/arm/sve_helper.c    | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 29 +++++++++++++++++
>  target/arm/sve.decode      |  9 +++++-
>  4 files changed, 120 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 79493ab647..94f4356ce9 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -414,6 +414,8 @@ DEF_HELPER_FLAGS_4(sve_cpy_z_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>  DEF_HELPER_FLAGS_4(sve_cpy_z_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>  DEF_HELPER_FLAGS_4(sve_cpy_z_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
>
> +DEF_HELPER_FLAGS_4(sve_ext, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 6a95d1ec48..fb3f54300b 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -1469,3 +1469,84 @@ void HELPER(sve_cpy_z_d)(void *vd, void *vg, uint64_t val, uint32_t desc)
>          d[i] = (pg[H1(i)] & 1 ? val : 0);
>      }
>  }
> +
> +/* Big-endian hosts need to frob the byte indicies.  If the copy
> + * happens to be 8-byte aligned, then no frobbing necessary.
> + */

Have you run risu tests with a big endian host?

>  ###########################################################################
>  # Named fields.  These are primarily for disjoint fields.
>
> -%imm4_16_p1             16:4 !function=plus1
> +%imm4_16_p1    16:4 !function=plus1

Another bit that should be squashed into an earlier patch.

>  %imm6_22_5     22:1 5:5
> +%imm8_16_10    16:5 10:3
>  %imm9_16_10    16:s6 10:3
>  %preg4_5       5:4
>
> @@ -363,6 +364,12 @@ FCPY               00000101 .. 01 .... 110 imm:8 .....             @rdn_pg4
>  CPY_m_i                00000101 .. 01 .... 01 . ........ .....   @rdn_pg4 imm=%sh8_i8s
>  CPY_z_i                00000101 .. 01 .... 00 . ........ .....   @rdn_pg4 imm=%sh8_i8s
>
> +### SVE Permute - Extract Group
> +
> +# SVE extract vector (immediate offset)
> +EXT            00000101 001 ..... 000 ... rm:5 rd:5 \
> +               &rrri rn=%reg_movprfx imm=%imm8_16_10
> +
>  ### SVE Predicate Logical Operations Group
>
>  # SVE predicate logical operations
> --

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
