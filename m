Received: from eggs.gnu.org ([2001:4830:134:3::10]:37281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffVq1-0004wX-B6
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffVq0-0000Eg-Fq
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:40:45 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffVq0-0000E3-8o
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:40:44 -0400
Received: by mail-oi0-x241.google.com with SMTP id b15-v6so4249496oib.10
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:40:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57aa2f3f-aa32-bcdb-f971-32709e717833@linaro.org>
References: <20180716133302.25989-1-peter.maydell@linaro.org>
	<57aa2f3f-aa32-bcdb-f971-32709e717833@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 20:40:23 +0100
Message-ID: <CAFEAcA8FnSP35scTZmLG6_qFOBsu1wRC0mLq5isz+Y_r907i5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Adithya Baglody <adithya.nagaraj.baglody@intel.com>, "patches@linaro.org" <patches@linaro.org>

On 17 July 2018 at 18:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I don't understand why this is necessary in the v8m case.
>
>                AP                 APL
>     <----B1----|----L1-B2-A-------|---L2--->
>
>
> Your comment posits two regions [B1,L1] and [B2,L2], that A is not within
> [B1,L1] but is within [B2,L2] (otherwise we would not report a hit at all).
> Further, that [B1,L1] intersects [AP,APL] but does not intersect [B2,L2]
> (otherwise we would report a fault for overlapping regions).
>
> Surely this combination of ranges implies that [B2,L2] must itself set
> IS_SUBPAGE (otherwise the first region would not overlap the page of A, or
> would not overlap the second region).

(a) the overlap fault is only for addresses which are actually in the
overlap (ie "you asked about address X and it hits in R1 and R2"); it
doesn't imply that other addresses which are only in R1 fault just
because some part of R1 overlaps with R2. So for instance:

       AP                        APL
   [B1                                L1]
                 [B2       L2]
             A1^     A2^

we must report a narrowed page for address A1, even though
it hits only within one region (B1-L1) which covers the
full page which A1 is within. (Otherwise if we later access
A2 then we'll get the TLB entry for A1, rather than reporting
the fault for it being in 2 regions.)

(b) Consider the case where one of the regions is the "background
region" that you get if you don't hit on anything.

thanks
-- PMM
