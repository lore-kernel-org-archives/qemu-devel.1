Received: from eggs.gnu.org ([2001:4830:134:3::10]:60900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsH2D-00058h-GY
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsH2A-0002Ud-Ct
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:25:33 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:44666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsH2A-0002U3-5x
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:25:30 -0400
Received: by mail-pg0-x22e.google.com with SMTP id j16so3155194pga.1
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:25:30 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-5-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8cf54de7-a40d-dbed-b491-7cdf7f3b67ff@linaro.org>
Date: Wed, 13 Sep 2017 16:25:26 -0700
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/19] nvic: Add cached vectpending_prio
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/12/2017 11:13 AM, Peter Maydell wrote:
> Instead of looking up the pending priority
> in nvic_pending_prio(), cache it in a new state struct
> field. The calculation of the pending priority given
> the interrupt number is more complicated in v8M with
> the security extension, so the caching will be worthwhile.
> 
> This changes nvic_pending_prio() from returning a full
> (group + subpriority) priority value to returning a group
> priority. This doesn't require changes to its callsites
> because we use it only in comparisons of the form
>   execution_prio > nvic_pending_prio()
> and execution priority is always a group priority, so
> a test (exec prio > full prio) is true if and only if
> (execprio > group_prio).
> 
> (Architecturally the expected comparison is with the
> group priority for this sort of "would we preempt" test;
> we were only doing a test with a full priority as an
> optimisation to avoid the mask, which is possible
> precisely because the two comparisons always give the
> same answer.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/intc/armv7m_nvic.h |  2 ++
>  hw/intc/armv7m_nvic.c         | 23 +++++++++++++----------
>  hw/intc/trace-events          |  2 +-
>  3 files changed, 16 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
