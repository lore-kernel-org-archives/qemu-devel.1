Received: from eggs.gnu.org ([2001:4830:134:3::10]:55893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6y6N-0007Lm-T0
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d6y6M-0006Zi-PC
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:42:19 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d6y6M-0006ZA-It
	for qemu-devel@nongnu.org; Sat, 06 May 2017 07:42:18 -0400
Date: Sat, 6 May 2017 13:42:14 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170506114214.m2paompbwuzeppl3@aurel32.net>
References: <20170502120350.3368.92338.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502120350.3368.92338.stgit@PASHA-ISP>
Subject: Re: [Qemu-devel] [PATCH] mips: set CP0 Debug DExcCode for SDBBP
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, yongbok.kim@imgtec.com

On 2017-05-02 15:03, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> This patch fixes setting DExcCode field of CP0 Debug register
> when SDBBP instruction is executed. According to EJTAG specification,
> this field must be set to the value 9 (Bp).
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  target/mips/helper.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index e359ca3b44..166f0d1243 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -627,6 +627,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
>          goto set_DEPC;
>      case EXCP_DBp:
>          env->CP0_Debug |= 1 << CP0DB_DBp;
> +        /* Setup DExcCode - SDBBP instruction */
> +        env->CP0_Debug = (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) | 9 << CP0DB_DEC;
>          goto set_DEPC;
>      case EXCP_DDBS:
>          env->CP0_Debug |= 1 << CP0DB_DDBS;
> 

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
