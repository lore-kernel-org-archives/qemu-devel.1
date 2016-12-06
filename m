Received: from eggs.gnu.org ([2001:4830:134:3::10]:59253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEEoZ-0006Mi-SD
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEEoW-0007qm-9s
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:25:43 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cEEoV-0007jZ-P3
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:25:40 -0500
Received: by mail-wm0-f42.google.com with SMTP id a197so126463279wmd.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 04:25:18 -0800 (PST)
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-5-git-send-email-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1479906121-12211-5-git-send-email-rth@twiddle.net>
Date: Tue, 06 Dec 2016 12:24:15 +0000
Message-ID: <87oa0pz1n4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 04/64] tcg/aarch64: Implement field
 extraction opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Claudio Fontana <claudio.fontana@huawei.com>


Richard Henderson <rth@twiddle.net> writes:

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/aarch64/tcg-target.h     |  8 ++++----
>  tcg/aarch64/tcg-target.inc.c | 14 ++++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 410c31b..4a74bd8 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -63,8 +63,8 @@ typedef enum {
>  #define TCG_TARGET_HAS_nand_i32         0
>  #define TCG_TARGET_HAS_nor_i32          0
>  #define TCG_TARGET_HAS_deposit_i32      1
> -#define TCG_TARGET_HAS_extract_i32      0
> -#define TCG_TARGET_HAS_sextract_i32     0
> +#define TCG_TARGET_HAS_extract_i32      1
> +#define TCG_TARGET_HAS_sextract_i32     1
>  #define TCG_TARGET_HAS_movcond_i32      1
>  #define TCG_TARGET_HAS_add2_i32         1
>  #define TCG_TARGET_HAS_sub2_i32         1
> @@ -95,8 +95,8 @@ typedef enum {
>  #define TCG_TARGET_HAS_nand_i64         0
>  #define TCG_TARGET_HAS_nor_i64          0
>  #define TCG_TARGET_HAS_deposit_i64      1
> -#define TCG_TARGET_HAS_extract_i64      0
> -#define TCG_TARGET_HAS_sextract_i64     0
> +#define TCG_TARGET_HAS_extract_i64      1
> +#define TCG_TARGET_HAS_sextract_i64     1
>  #define TCG_TARGET_HAS_movcond_i64      1
>  #define TCG_TARGET_HAS_add2_i64         1
>  #define TCG_TARGET_HAS_sub2_i64         1
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 1939d35..c0e9890 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -1640,6 +1640,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>          tcg_out_dep(s, ext, a0, REG0(2), args[3], args[4]);
>          break;
>
> +    case INDEX_op_extract_i64:
> +    case INDEX_op_extract_i32:
> +        tcg_out_ubfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
> +        break;
> +
> +    case INDEX_op_sextract_i64:
> +    case INDEX_op_sextract_i32:
> +        tcg_out_sbfm(s, ext, a0, a1, a2, a2 + args[3] - 1);
> +        break;
> +

This isn't right is it? As I'm reading it extract takes from a
offset+len from the source register to low bits of the destination
register. The Bitfield Move instructions are the other way around,
moving from the low order bits in the source register to an offset+len
in the destination.

>      case INDEX_op_add2_i32:
>          tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, REG0(2), REG0(3),
>                          (int32_t)args[4], args[5], const_args[4],
> @@ -1785,6 +1795,10 @@ static const TCGTargetOpDef aarch64_op_defs[] = {
>
>      { INDEX_op_deposit_i32, { "r", "0", "rZ" } },
>      { INDEX_op_deposit_i64, { "r", "0", "rZ" } },
> +    { INDEX_op_extract_i32, { "r", "r" } },
> +    { INDEX_op_extract_i64, { "r", "r" } },
> +    { INDEX_op_sextract_i32, { "r", "r" } },
> +    { INDEX_op_sextract_i64, { "r", "r" } },
>
>      { INDEX_op_add2_i32, { "r", "r", "rZ", "rZ", "rA", "rMZ" } },
>      { INDEX_op_add2_i64, { "r", "r", "rZ", "rZ", "rA", "rMZ" } },


--
Alex Bennée
