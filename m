Received: from eggs.gnu.org ([2001:4830:134:3::10]:33018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWTMS-0004ZX-Ro
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWTMS-0001Lt-1L
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:12:52 -0400
Date: Fri, 22 Jun 2018 17:12:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180622211244.GA11346@flamenco>
References: <20180621173635.21537-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621173635.21537-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: Change mmap_lock to rwlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-arm@nongnu.org

On Thu, Jun 21, 2018 at 07:36:33 -1000, Richard Henderson wrote:
> The objective here is to avoid serializing the first-fault
> and no-fault aarch64 sve loads.
> 
> When I first thought of this, we still had tb_lock protecting
> code generation and merely needed mmap_lock to prevent mapping
> changes while doing so.  Now (or very soon), tb_lock is gone
> and user-only code generation dual-purposes the mmap_lock for
> the code generation lock.
> 
> There are two other legacy users of mmap_lock within linux-user,
> for ppc and mips.  I believe these are dead code from before these
> ports were converted to use tcg atomics.
> 
> Thoughts?

I'm curious to see how much perf could be gained. It seems that the hold
times in SVE code for readers might not be very large, which
then wouldn't let us amortize the atomic inc of the read lock
(IOW, we might not see much of a difference compared to a regular
mutex).

Are you using any benchmark that shows any perf difference?

Thanks,

		E.
