Received: from eggs.gnu.org ([2001:4830:134:3::10]:33881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXqNL-0002XU-83
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXqNH-0001Mh-5Y
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:54:55 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:58434)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dXqNG-0001M3-VB
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:54:51 -0400
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<742650a35d49502a994c008fd3a70eccd5391f1b.1500378931.git-series.james.hogan@imgtec.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <dfb9c8fe-0779-89d4-dbab-5b030f6666be@imgtec.com>
Date: Wed, 19 Jul 2017 15:54:47 +0100
MIME-Version: 1.0
In-Reply-To: <742650a35d49502a994c008fd3a70eccd5391f1b.1500378931.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/14] target/mips: Add CP0_Ebase.WG (write
 gate) support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>



On 18/07/2017 12:55, James Hogan wrote:
> Add support for the CP0_EBase.WG bit, which allows upper bits to be
> written (bits 31:30 on MIPS32, or bits 63:30 on MIPS64), along with the
> CP0_Config5.CV bit to control whether the exception vector for Cache
> Error exceptions is forced into KSeg1.
> 
> This is necessary on MIPS32 to support Segmentation Control and Enhanced
> Virtual Addressing (EVA) extensions (where KSeg1 addresses may not
> represent an unmapped uncached segment).
> 
> It is also useful on MIPS64 to allow the exception base to reside in
> XKPhys, and possibly out of range of KSEG0 and KSEG1.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> Changes in v2:
> - Fix CP0_EBase.WG to be read only when WG is not set in
>   CP0_EBase_rw_bitmask, otherwise it will be wrongly probed as present.
> - Make cache error exception vector conditional on Config3.SC as well as
>   Config5.CV, as per the PRA, and take the CP0C3_SC definition from
>   patch 7 (Yongbok).
> - Rename CP0_EBase_rw_bitmask to CP0_EBaseWG_rw_bitmask (Yongbok).
> ---
>  target/mips/cpu.h            |  5 ++++-
>  target/mips/helper.c         | 14 ++++++++------
>  target/mips/machine.c        |  6 +++---
>  target/mips/op_helper.c      | 12 ++++++++++--
>  target/mips/translate.c      |  8 +++++---
>  target/mips/translate_init.c |  1 +
>  6 files changed, 31 insertions(+), 15 deletions(-)
> 


> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1515,14 +1515,22 @@ target_ulong helper_mftc0_ebase(CPUMIPSState *env)
>  
>  void helper_mtc0_ebase(CPUMIPSState *env, target_ulong arg1)
>  {
> -    env->CP0_EBase = (env->CP0_EBase & ~0x3FFFF000) | (arg1 & 0x3FFFF000);
> +    target_ulong mask = 0x3FFFF000 | env->CP0_EBaseWG_rw_bitmask;
> +    if (arg1 & (1 << CP0EBase_WG) & mask) {

isn't it just ...?
if (arg1 & env->CP0_EBaseWG_rw_bitmask) {

> +        mask |= ~0x3FFFFFFF;
> +    }
> +    env->CP0_EBase = (env->CP0_EBase & ~mask) | (arg1 & mask);
>  }
>  
>  void helper_mttc0_ebase(CPUMIPSState *env, target_ulong arg1)
>  {
>      int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
>      CPUMIPSState *other = mips_cpu_map_tc(env, &other_tc);
> -    other->CP0_EBase = (other->CP0_EBase & ~0x3FFFF000) | (arg1 & 0x3FFFF000);
> +    target_ulong mask = 0x3FFFF000 | env->CP0_EBaseWG_rw_bitmask;
> +    if (arg1 & (1 << CP0EBase_WG) & mask) {

here as well.

> +        mask |= ~0x3FFFFFFF;
> +    }
> +    other->CP0_EBase = (other->CP0_EBase & ~mask) | (arg1 & mask);
>  }
>  


Otherwise,
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>

Regards,
Yongbok
