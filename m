Received: from eggs.gnu.org ([2001:4830:134:3::10]:37697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daKTW-0006iK-UI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daKTS-0002WZ-RV
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:27:34 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:37183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daKTS-0002WC-Ki
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:27:30 -0400
Received: by mail-wr0-f182.google.com with SMTP id 33so73765037wrz.4
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:27:30 -0700 (PDT)
References: <20170717212446.15268-1-rth@twiddle.net>
	<20170717212446.15268-2-rth@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7b583a7-2043-6b64-7d83-ba00255553dc@redhat.com>
Date: Wed, 26 Jul 2017 13:27:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170717212446.15268-2-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 1/8] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

On 17/07/2017 23:24, Richard Henderson wrote:
> +        case 4:
> +            if (parallel_cpus) {
> +#ifdef CONFIG_ATOMIC128
> +                TCGMemOpIdx oi = make_memop_idx(MO_TEQ | MO_ALIGN_16, mem_idx);
> +                Int128 sv = int128_make128(svl, svh);
> +                helper_atomic_sto_be_mmu(env, a2, sv, oi, ra);
> +#else
> +                /* Note that we asserted !parallel_cpus above.  */
> +                g_assert_not_reached();
> +#endif
> +            } else {
> +                cpu_stq_data_ra(env, a2 + 0, svh, ra);
> +                cpu_stq_data_ra(env, a2 + 8, svl, ra);
> +            }
> +        default:
> +            g_assert_not_reached();

Coverity complains about a missing "break".

Paolo
