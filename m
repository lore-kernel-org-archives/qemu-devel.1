Received: from eggs.gnu.org ([2001:4830:134:3::10]:37491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffTnG-0005YX-KK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffTnC-0002FR-LB
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:29:46 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ffTnC-0002EP-60
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:29:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id n7-v6so741271pgq.4
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 10:29:42 -0700 (PDT)
References: <20180716133302.25989-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57aa2f3f-aa32-bcdb-f971-32709e717833@linaro.org>
Date: Tue, 17 Jul 2018 10:29:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180716133302.25989-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] target/arm: Correctly handle
 overlapping small MPU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Adithya Baglody <adithya.nagaraj.baglody@intel.com>, patches@linaro.org

On 07/16/2018 06:33 AM, Peter Maydell wrote:
> @@ -9963,6 +9994,21 @@ static bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
>              }
>  
>              if (address < base || address > limit) {> +                /*> +                 * Address not in this region. We must
check whether the> +                 * region covers addresses in the same page
as our address.> +                 * In that case we must not report a size
that covers the> +                 * whole page for a subsequent hit against a
different MPU> +                 * region or the background region, because it
would result in> +                 * incorrect TLB hits for subsequent accesses
to addresses that> +                 * are in this MPU region.> +
  */> +                if (limit >= base &&> +
ranges_overlap(base, limit - base + 1,> +
addr_page_base,> +                                   TARGET_PAGE_SIZE)) {> +
                *is_subpage = true;> +                }
I don't understand why this is necessary in the v8m case.

               AP                 APL
    <----B1----|----L1-B2-A-------|---L2--->


Your comment posits two regions [B1,L1] and [B2,L2], that A is not within
[B1,L1] but is within [B2,L2] (otherwise we would not report a hit at all).
Further, that [B1,L1] intersects [AP,APL] but does not intersect [B2,L2]
(otherwise we would report a fault for overlapping regions).

Surely this combination of ranges implies that [B2,L2] must itself set
IS_SUBPAGE (otherwise the first region would not overlap the page of A, or
would not overlap the second region).

Because of the non-fault for region overlap in v7m, I can see that the test is
required in get_phys_addr_pmsav7, but AFAICS only there.


r~
