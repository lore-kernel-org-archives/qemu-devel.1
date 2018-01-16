Received: from eggs.gnu.org ([2001:4830:134:3::10]:35994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebXlC-0001kc-Of
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebXl8-0006IJ-0C
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:23:06 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:40450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebXl7-0006I7-PA
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:23:01 -0500
Received: by mail-pl0-x242.google.com with SMTP id g18so1419814plo.7
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 12:23:01 -0800 (PST)
References: <20180116172510.28878-1-laurent@vivier.eu>
	<20180116172510.28878-4-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03e660cb-26d7-ecde-5d52-b6d5d0d79e46@linaro.org>
Date: Tue, 16 Jan 2018 12:22:51 -0800
MIME-Version: 1.0
In-Reply-To: <20180116172510.28878-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] linux-user,
 m68k: select CPU according to ELF header values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Aaron Sierra <asierra@xes-inc.com>

On 01/16/2018 09:25 AM, Laurent Vivier wrote:
> M680x0 doesn't support the same set of instructions
> as ColdFire, so we can't use "any" CPU type to execute
> m68020 instructions.
> We select CPU type ("m68020" or "any" for ColdFire)
> according to the ELF header. If we can't, we
> use by default the value used until now: "any".
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v2: call cpu_get_model() with the result of get_elf_eflags()
> 
>  linux-user/m68k/target_elf.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
> index df375ad5d3..946b90f342 100644
> --- a/linux-user/m68k/target_elf.h
> +++ b/linux-user/m68k/target_elf.h
> @@ -9,6 +9,12 @@
>  #define M68K_TARGET_ELF_H
>  static inline const char *cpu_get_model(uint32_t eflags)
>  {
> +    if (eflags == 0) {
> +        /* 680x0 */
> +        return "m68020";
> +    }
> +
> +    /* Coldfire */
>      return "any";

This isn't quite right.  From binutils:

/* We use the top 24 bits to encode information about the
   architecture variant.  */
#define EF_M68K_CPU32    0x00810000
#define EF_M68K_M68000   0x01000000
#define EF_M68K_CFV4E    0x00008000
#define EF_M68K_FIDO     0x02000000
#define EF_M68K_ARCH_MASK                                               \
  (EF_M68K_M68000 | EF_M68K_CPU32 | EF_M68K_CFV4E | EF_M68K_FIDO)

/* We use the bottom 8 bits to encode information about the
   coldfire variant.  If we use any of these bits, the top 24 bits are
   either 0 or EF_M68K_CFV4E.  */
#define EF_M68K_CF_ISA_MASK     0x0F  /* Which ISA */
#define EF_M68K_CF_ISA_A_NODIV  0x01  /* ISA A except for div */
#define EF_M68K_CF_ISA_A        0x02
#define EF_M68K_CF_ISA_A_PLUS   0x03
#define EF_M68K_CF_ISA_B_NOUSP  0x04  /* ISA_B except for USP */
#define EF_M68K_CF_ISA_B        0x05
#define EF_M68K_CF_ISA_C        0x06
#define EF_M68K_CF_ISA_C_NODIV  0x07  /* ISA C except for div */
#define EF_M68K_CF_MAC_MASK     0x30
#define EF_M68K_CF_MAC          0x10  /* MAC */
#define EF_M68K_CF_EMAC         0x20  /* EMAC */
#define EF_M68K_CF_EMAC_B       0x30  /* EMAC_B */
#define EF_M68K_CF_FLOAT        0x40  /* Has float insns */
#define EF_M68K_CF_MASK         0xFF

It looks like m68000 series for flags == 0 || flags & EF_M68K_M68000.

While we're at it, surely 68040 is a better default than 68020 for user-only,
especially once all your fpu patches are in.


r~
