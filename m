Received: from eggs.gnu.org ([2001:4830:134:3::10]:46474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d80IR-0007kk-3Y
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d80IP-0003Rr-TM
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:15:03 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d80IP-0003RX-No
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:15:01 -0400
Date: Tue, 9 May 2017 10:14:57 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170509081457.zcxvzd5spv7n4stj@aurel32.net>
References: <20170508151707.5434-1-rth@twiddle.net>
	<20170508151707.5434-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170508151707.5434-2-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] target/s390x: Implement STORE
 FACILITIES LIST EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-08 08:17, Richard Henderson wrote:
> At the same time, improve STORE FACILITIES LIST
> so that we don't hard-code the list for all cpus.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |  2 ++
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/misc_helper.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   | 17 ++++++++-------
>  4 files changed, 67 insertions(+), 8 deletions(-)
>
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index eca8244..5263726 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -678,3 +678,57 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
>      }
>  }
>  #endif
> +
> +/* The maximum bit defined at the moment is 129.  */
> +#define MAX_STFL_WORDS  3

Could it be computed from S390_FEAT_MAX? in gen-features.c,
S390_FEAT_MAX / 64 + 1 is used.

> +
> +/* Canonicalize the current cpu's features into the 64-bit words required
> +   by STFLE.  Return the index-1 of the max word that is non-zero.  */
> +static unsigned do_stfle(CPUS390XState *env, uint64_t words[MAX_STFL_WORDS])
> +{
> +    S390CPU *cpu = s390_env_get_cpu(env);
> +    const unsigned long *features = cpu->model->features;
> +    unsigned max_bit = 0;
> +    S390Feat feat;
> +
> +    memset(words, 0, sizeof(uint64_t) * MAX_STFL_WORDS);
> +
> +    for (feat = find_first_bit(features, S390_FEAT_MAX);
> +         feat < S390_FEAT_MAX;
> +         feat = find_next_bit(features, S390_FEAT_MAX, feat + 1)) {
> +        const S390FeatDef *def = s390_feat_def(feat);
> +        if (def->type == S390_FEAT_TYPE_STFL) {
> +            unsigned bit = def->bit;
> +            if (bit > max_bit) {
> +                max_bit = bit;
> +            }
> +            assert(bit / 64 < MAX_STFL_WORDS);
> +            words[bit / 64] |= 1ULL << (63 - bit % 64);
> +        }
> +    }
> +
> +    return max_bit / 64;
> +}

Is there a reason to not use s390_fill_feat_block here? I guess max_bit
can be compute using find_last_bit. It's probably a bit less optimal,
but if we care about STFLE performance, we should probably avoid recomputing
the features words each time. Anyway if there is a good reason to not
use s390_fill_feat_block, the zArch active bit should also be handled here.

Otherwise it looks fine to me. It's probably a discussion for later
patches, but should we also implement a TCG feature mask, like for
example on PowerPC? Currently the only allowed CPU for TCG is z900,
which makes this code almost useless. And while QEMU implements many
features from newer CPU, some of them are missing and we don't want
them to appear in the feature list.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
