Received: from eggs.gnu.org ([2001:4830:134:3::10]:59574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxQk-0005Hn-Eo
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxQh-0005n4-7Y
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:32:06 -0400
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com
	([104.47.38.134]:19502
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcxQh-0005mm-0m
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:32:03 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 18:32:01 +0000
Message-ID: <BN7PR08MB4868AD6E534F7B5AB8E52AB4C65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-30-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-30-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 29/33] mips_malta: Setup GT64120 BARs in
 nanoMIPS bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 29/33] mips_malta: Setup GT64120 BARs in nanoMIPS boot=
loader
>
> From: Paul Burton <pburton@wavecomp.com>
>
> Setup the GT64120 BARs in the nanoMIPS bootloader, in the same way that
> they are setup in the MIPS32 bootloader. This is necessary for Linux to
> be able to access peripherals, including the UART.
>
> Signed-off-by: Paul Burton <pburton@wavecomp.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  hw/mips/mips_malta.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 73 insertions(+)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 4bc9036..d1a7c1f 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -664,6 +664,79 @@ static void write_bootloader_nanomips(uint8_t *base,=
 int64_t run_addr,
>                                  /* lui a3,%hi(loaderparams.ram_low_size)=
 */
>      stw_p(p++, 0x80e7); stw_p(p++, NM_LO(loaderparams.ram_low_size));
>                                  /* ori a3,a3,%lo(loaderparams.ram_low_si=
ze) */
> +
> +    /* Load BAR registers as done by YAMON */
> +    stw_p(p++, 0xe040); stw_p(p++, 0x0681);
> +                                /* lui t1, %hi(0xb4000000) */
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0be1);
> +                                /* lui t0, %hi(0xdf000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x00df);
> +                                /* addiu[32] t0, $0, 0xdf */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9068);
> +                                /* sw t0, 0x68(t1) */
> +
> +    stw_p(p++, 0xe040); stw_p(p++, 0x077d);
> +                                /* lui t1, %hi(0xbbe00000) */
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0801);
> +                                /* lui t0, %hi(0xc0000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x00c0);
> +                                /* addiu[32] t0, $0, 0xc0 */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9048);
> +                                /* sw t0, 0x48(t1) */
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0800);
> +                                /* lui t0, %hi(0x40000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x0040);
> +                                /* addiu[32] t0, $0, 0x40 */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9050);
> +                                /* sw t0, 0x50(t1) */
> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0001);
> +                                /* lui t0, %hi(0x80000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x0080);
> +                                /* addiu[32] t0, $0, 0x80 */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9058);
> +                                /* sw t0, 0x58(t1) */
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x07e0);
> +                                /* lui t0, %hi(0x3f000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x003f);
> +                                /* addiu[32] t0, $0, 0x3f */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9060);
> +                                /* sw t0, 0x60(t1) */
> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0821);
> +                                /* lui t0, %hi(0xc1000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x00c1);
> +                                /* addiu[32] t0, $0, 0xc1 */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9080);
> +                                /* sw t0, 0x80(t1) */
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    stw_p(p++, 0xe020); stw_p(p++, 0x0bc0);
> +                                /* lui t0, %hi(0x5e000000) */
> +#else
> +    stw_p(p++, 0x0020); stw_p(p++, 0x005e);
> +                                /* addiu[32] t0, $0, 0x5e */
> +#endif
> +    stw_p(p++, 0x8422); stw_p(p++, 0x9088);
> +                                /* sw t0, 0x88(t1) */
> +
>      stw_p(p++, 0xe320 | NM_HI1(kernel_entry));
>      stw_p(p++, NM_HI2(kernel_entry));
>                                  /* lui t9,%hi(kernel_entry) */
> --
> 2.7.4
>
>
