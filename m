Received: from eggs.gnu.org ([2001:4830:134:3::10]:38546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dpLk6-000071-8u
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dpLk1-0003Tj-EY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:50:46 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:37949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dpLk1-0003Sy-8V
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:50:41 -0400
Received: by mail-pg0-x229.google.com with SMTP id v66so11628032pgb.5
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 14:50:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170829172326.1131-1-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <efa7f1f6-af37-a06b-10b0-d40be2a502f0@twiddle.net>
Date: Tue, 5 Sep 2017 14:50:35 -0700
MIME-Version: 1.0
In-Reply-To: <20170829172326.1131-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/softmmu: Increase size of TLB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org

On 08/29/2017 10:23 AM, Pranith Kumar wrote:
> This patch increases the number of entries cached in the TLB. I went
> over a few architectures to see if increasing it is problematic. Only
> armv6 seems to have a limitation that only 8 bits can be used for
> indexing these entries. For other architectures, the number of TLB
> entries is increased to a 4K-sized cache. The patch also doubles the
> number of victim TLB entries.
> 
> Some statistics collected from a build benchmark for various cache
> sizes is listed below:
> 
> | TLB bits\vTLB entires |             8 |            16  |            32 |
> |                     8 | 952.94(+0.0%) | 929.99(+2.4%)  | 919.02(+3.6%) |
> |                    10 | 898.92(+5.6%) | 886.13(+7.0%)  | 887.03(+6.9%) |
> |                    12 | 878.56(+7.8%) | 873.53(+8.3%)* | 875.34(+8.1%) |
> 
> The best combination for this workload came out to be 12 bits for the
> TLB and a 16 entry vTLB cache.

This significantly degrades performance of alpha-softmmu.
It spends about 25% of all cpu time in memset.


r~
