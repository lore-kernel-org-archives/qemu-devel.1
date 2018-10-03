Received: from eggs.gnu.org ([2001:4830:134:3::10]:47062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nZl-0003cf-1S
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nZi-0004ko-A0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:16:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nZh-0004fT-P0
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:16:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id i12-v6so6927185otl.1
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:16:42 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <572e6756-7cad-7f0a-cb82-a214cfc35757@linaro.org>
Date: Wed, 3 Oct 2018 15:16:37 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/13] target/arm: Add v8M stack checks for
 LDRD/STRD (imm)
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

On 10/2/18 11:35 AM, Peter Maydell wrote:
> Add the v8M stack checks for:
>  * LDRD (immediate)
>  * STRD (immediate)
> 
> Loads and stores are more complicated than ADD/SUB/MOV, because we
> must ensure that memory accesses below the stack limit are not
> performed, so we can't simply do the check when we actually update
> SP.
> 
> For these instructions, if the stack limit check triggers
> we must not:
>  * perform any memory access below the SP limit
>  * update PC, SP or the load/store base register
> but it is IMPDEF whether we:
>  * perform any accesses above or equal to the SP limit
>  * update destination registers for loads
> 
> For QEMU we choose to always check the limit before doing any other
> part of the load or store, so we won't update any registers or
> perform any memory accesses.
> 
> It is UNKNOWN whether the limit check triggers for a load or store
> where the initial SP value is below the limit and one of the stores
> would be below the limit, but the writeback moves SP to above the
> limit.  For QEMU we choose to trigger the check in this situation.
> 
> Note that limit checks happen only for loads and stores which update
> SP via writeback; they do not happen for loads and stores which
> simply use SP as a base register.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
