Received: from eggs.gnu.org ([2001:4830:134:3::10]:49025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOQsX-0007Ao-Ie
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOQsW-00022u-Nz
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:52:13 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:38038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOQsW-00022R-HG
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:52:12 -0400
Date: Fri, 23 Jun 2017 17:52:07 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623155207.jj6aakw36qmwqvow@aurel32.net>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-14-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620000405.3391-14-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 13/18] target/s390x: Implement CONVERT
 UNICODE insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 2017-06-19 17:04, Richard Henderson wrote:
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 9c8f184..634ef98 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -313,6 +313,19 @@
>      C(0xb3a1, CDLGBR,  RRF_e, FPE, 0, r2_o, f1, 0, cdlgb, 0)
>      C(0xb3a2, CXLGBR,  RRF_e, FPE, 0, r2_o, x1, 0, cxlgb, 0)
>  
> +/* CONVERT UTF-8 TO UTF-16 */
> +    D(0xb2a7, CU12,    RRF_c, Z,   0, 0, 0, 0, cuXX, 0, 12)
> +/* CONVERT UTF-8 TO UTF-32 */
> +    D(0xb9b0, CU14,    RRF_c, ETF3, 0, 0, 0, 0, cuXX, 0, 14)
> +/* CONVERT UTF-16 to UTF-8 */
> +    D(0xb2a6, CU21,    RRF_c, Z,   0, 0, 0, 0, cuXX, 0, 21)
> +/* CONVERT UTF-16 to UTF-32 */
> +    D(0xb9b1, CU24,    RRF_c, ETF3, 0, 0, 0, 0, cuXX, 0, 24)
> +/* CONVERT UTF-32 to UTF-8 */
> +    D(0xb9b3, CU41,    RRF_c, ETF3, 0, 0, 0, 0, cuXX, 0, 41)
> +/* CONVERT UTF-32 to UTF-16 */
> +    D(0xb9b2, CU42,    RRF_c, ETF3, 0, 0, 0, 0, cuXX, 0, 42)
> +

CU41 and CU42 are inverted here. CU41 has the 0xb9b2 opcode and CU42 the
0xb9b3 opcode.

> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 4376c72..df082f5 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c

...

> +static int encode_utf8(CPUS390XState *env, uint64_t addr, uint64_t ilen,
> +                       uintptr_t ra, uint32_t c, uint32_t *olen)
> +{
> +    uint8_t d[4];
> +    uint32_t l, i;
> +
> +    if (c <= 0x7f) {
> +        /* one byte character */
> +        l = 1;
> +        d[0] = c;
> +    } else if (c <= 0x7ff) {
> +        /* two byte character */
> +        l = 2;
> +        d[1] = 0x80 | extract32(c, 0, 6);
> +        d[0] = 0xc0 | extract32(c, 6, 5);
> +    } else if (c <= 0xffff) {
> +        /* three byte character */
> +        l = 3;
> +        d[2] = 0x80 | extract32(c, 0, 6);
> +        d[1] = 0x80 | extract32(c, 6, 6);
> +        d[0] = 0xe0 | extract32(c, 12, 4);
> +    } else {
> +        /* four byte character */
> +        l = 4;
> +        d[3] = 0x80 | extract32(c, 0, 6);
> +        d[2] = 0x80 | extract32(c, 6, 6);
> +        d[1] = 0x80 | extract32(c, 12, 6);
> +        d[0] = 0xe0 | extract32(c, 18, 3);

This should be 0xf0 instead of 0xe0.

> +static int encode_utf16(CPUS390XState *env, uint64_t addr, uint64_t ilen,
> +                        uintptr_t ra, uint32_t c, uint32_t *olen)
> +{
> +    uint16_t d0, d1;
> +
> +    if (c <= 0xffff) {
> +        /* one word character */
> +        if (ilen < 2) {
> +            return 1;
> +        }
> +        cpu_stw_data_ra(env, addr, c, ra);
> +        *olen = 2;
> +    } else {
> +        /* two word character */
> +        if (ilen < 4) {
> +            return 1;
> +        }
> +        d1 = 0xbc00 | extract32(c, 0, 10);
> +        d0 = 0xb800 | extract32(c, 10, 6);

This should be 0xdc00 and 0xd800;


Otherwise the patch looks fine to me.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
