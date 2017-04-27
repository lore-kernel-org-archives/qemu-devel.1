Received: from eggs.gnu.org ([2001:4830:134:3::10]:48754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d3ftj-0007Ji-SZ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d3fti-000748-Sa
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:39:39 -0400
Date: Thu, 27 Apr 2017 11:39:25 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170427093925.cldh6ydudq3t2t7m@aurel32.net>
References: <1493263764-18657-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493263764-18657-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v4 00/11] TCG optimizations for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On 2017-04-26 23:29, Emilio G. Cota wrote:
> v3 for context: https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04795.html
> 
> Changes from v3:
> 
> - Added reviewed-by tags.
> 
> - Added a couple of suggested-by tags that I forgot to add in v3
>   regarding lookup_and_goto_ptr and i386's implementation of goto_ptr.
> 
> - lookup_tb_ptr
>   + Dropped the unnecessary exit_request check, as suggested by Paolo and
>     Richard.
>   + Only get the CPU state if we get a tb from the jmp_cache, as suggested
>     by Richard.
>   + Added tb_htable_lookup if we miss in tb_jmp_cache, as suggested by
>     Richard. This requires an extra patch to export tb_htable_lookup.
> 
> - goto_ptr: add IMPL(has_goto_ptr), as pointed out by Richard.
> 
> - target/arm: added a comment about gen_jr. See the v3 thread for why
>   it is needed.
> 
> - target/i386: use TCGV_UNUSED instead of (ab)using NULL on a TCGv,
>   as suggested by Richard. Also took his suggestion to simplify
>   the addition of jr + cs_base.
>   To minimize churn I renamed gen_eob_worker to do_gen_eob_worker,
>   which takes the newly added argument.
> 
> I have *not* re-run all experiments, because it takes several hours and
> performance hasn't changed much from v3, as can be seen in these two charts:
> * spec06int user-mode, test input, v2.9.0 baseline: http://imgur.com/ME2eMq1
> * spec06int softmmu, test input, v3 baseline: http://imgur.com/Clolu9Z
> The perf differences are mostly due to adding the htable check. Note that
> its impact is small, since tb_jmp_cache has a %hit rate in the high 90's.
> 
> You can inspect/fetch the changes at:
>   https://github.com/cota/qemu/tree/tcg-opt-v4

Thanks for this patchset. I have tested it with an arm target, but also
with a mips target with and additional patch. I haven't done any precise
benchmark yet. The patch is trivial and only changes 3 lines, but I am
not 100% sure I have done things correctly (see my comment on patch 7).

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
