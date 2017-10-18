Received: from eggs.gnu.org ([2001:4830:134:3::10]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4x5X-00059G-Tf
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4x5T-0003Et-Uq
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:45:23 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4x5T-0003Eg-O5
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:45:19 -0400
Date: Wed, 18 Oct 2017 18:45:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171018224518.GA28532@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 00/50] tcg tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, Oct 16, 2017 at 10:25:19 -0700, Richard Henderson wrote:
> I've fixed two bugs within v5 of Emilio's patch set:
> 
>  - The step_next_tb patch fixes the "rep movsb" bug that appeared
>    when we included CF_COUNT_MASK into CF_HASH_MASK.  We had been
>    relying on magic to single-step the next guest insn.
> 
>  - The original "allocate optimizer temps with tcg_malloc" patch
>    failed testing on arm32 host.  I didn't really look into exactly
>    what was wrong because I had an older patch set that touched the
>    same portion of the optimizer.

Thanks a lot for fixing these issues and respinning the series.

I have just pushed a branch on top of this series that includes
10 patches that further pave the way for the removal of tb_lock:

  https://github.com/cota/qemu/tree/multi-tcg-v6-plus

These patches are a subset of the ones that I posted on the
tb_lock removal patchset [1]. In particular, these patches are
groundwork that doesn't change anything fundamental wrt locking,
which does get tricky.

Given how close we are to the soft freeze for 2.11 [2], do you want
me to post these patches on the list for review? Otherwise I can wait
for the 2.12 dev cycle to post them with the complete tb_lock removal
work.

That said, I think we should at least cherry-pick "translate-all: exit
from tb_phys_invalidate if qht_remove fails" for 2.11, since it
fixes a real bug. Stable should also get it.

Thanks,

		Emilio

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01199.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg02217.html
