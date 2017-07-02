Received: from eggs.gnu.org ([2001:4830:134:3::10]:50395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRelW-00075Q-GR
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 09:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRelV-0000rh-IH
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 09:18:18 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:39086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dRelV-0000Zx-Cl
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 09:18:17 -0400
Date: Sun, 2 Jul 2017 15:18:04 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170702131804.7it62euy4mah63x6@aurel32.net>
References: <20170701202600.14057-1-rth@twiddle.net>
	<20170701202600.14057-3-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170701202600.14057-3-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] target/s390x: Implement CONVERT
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
Cc: qemu-devel@nongnu.org, david@redhat.com

On 2017-07-01 13:25, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |   6 +
>  target/s390x/mem_helper.c  | 310 +++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   |  44 +++++++
>  target/s390x/insn-data.def |  13 ++
>  4 files changed, 373 insertions(+)
> 

...

> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index e739525..9301daa 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -2122,6 +2122,49 @@ static ExitStatus op_ct(DisasContext *s, DisasOps *o)
>      return NO_EXIT;
>  }
>  
> +static ExitStatus op_cuXX(DisasContext *s, DisasOps *o)
> +{
> +    int m3 = get_field(s->fields, m3);
> +    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
> +    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
> +    TCGv_i32 chk;
> +
> +    if (!s390_has_feat(s->insn->fac == S390_FEAT_EXTENDED_TRANSLATION_3
> +                       ? S390_FEAT_ETF3_ENH : S390_FEAT_ETF2_ENH)) {
> +        m3 = 0;
> +    }

This doesn't look correct to me. The well-formedness checking is part of
ETF3_ENH facility, for both convert unicode instructions that are part
of the Z architecture (CU12 and CU21) and for the ones added by the ETF3
facility (CU14 and CU24).

The rest of the patch now looks fine.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
