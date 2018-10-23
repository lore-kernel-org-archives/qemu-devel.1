Received: from eggs.gnu.org ([2001:4830:134:3::10]:43408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gF0DJ-0005sj-5z
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 13:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gF0D7-0007Xe-E5
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 13:11:22 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gF0D5-0007Wf-TS
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 13:11:16 -0400
Date: Tue, 23 Oct 2018 13:11:14 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181023171114.GA10827@flamenco>
References: <20181023070253.6407-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023070253.6407-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/10] cputlb: track dirty tlbs and general
 cleanup
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

On Tue, Oct 23, 2018 at 08:02:42 +0100, Richard Henderson wrote:
> The motivation here is reducing the total overhead.
> 
> Before a few patches went into target-arm.next, I measured total
> tlb flush overhead for aarch64 at 25%.  This appears to reduce the
> total overhead to about 5% (I do need to re-run the control tests,
> not just watch perf top as I'm doing now).

I'd like to see those absolute perf numbers; I ran a few Ubuntu aarch64
boots and the noise is just too high to draw any conclusions (I'm
using your tlb-dirty branch on github).

When booting the much smaller debian image, these patches are
performance-neutral though. So,
  Reviewed-by: Emilio G. Cota <cota@braap.org>
for the series.

(On a pedantic note: consider s/miniscule/minuscule/ in patches 6-7)

> The final patch is somewhat of an RFC.  I'd like to know what
> benchmark was used when putting in pending_tlb_flushes, and I
> have not done any archaeology to find out.  I suspect that it
> does make any measurable difference beyond tlb_c.dirty, and I
> think the code is a bit cleaner without it.

I suspect that pending_tlb_flushes was premature optimization.
Avoiding an async job sounds like a good idea, since it is very
expensive for the remote vCPU.
However, in most cases we'll be taking a lock (or a full barrier
in the original code) but we won't avoid the async job (because
a race when flushing other vCPUs is unlikely), therefore wasting
cycles in the lock (formerly barrier).

Thanks,

		Emilio
