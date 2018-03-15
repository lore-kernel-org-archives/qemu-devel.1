Received: from eggs.gnu.org ([2001:4830:134:3::10]:36733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewZ5G-00030N-Fb
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewZ5D-0006Gt-D4
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:02:42 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:43989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ewZ5D-0006GE-6B
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:02:39 -0400
Received: by mail-pl0-x230.google.com with SMTP id f23-v6so4434162plr.10
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 13:02:39 -0700 (PDT)
References: <871sgwmcc3.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b8642b07-307a-6109-6350-e7830a1b7842@linaro.org>
Date: Fri, 16 Mar 2018 04:02:33 +0800
MIME-Version: 1.0
In-Reply-To: <871sgwmcc3.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Using new TCG Vector infrastructure in PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 03/07/2018 06:03 PM, Nikunj A Dadhania wrote:
> Hi Richard,
> 
> I was working to get TCG vector support for PowerPC[1]. Started with
> converting logical operations like vector AND/OR/XOR and compare
> instructions. Found some inconsistency during my testing on x86 laptop
> emulating PowerPC:

Great.

Well, the problem is that you cannot use TCG generic vectors and TCG global
variables to access the same memory.

Thus your first step must be to remove all references to cpu_avrh and cpu_avrl.
 These can be replaced by translator helpers that perform an explicit
tcg_gen_ld_i64 or tcg_gen_st_i64 to the proper memory locations.

Only after that's done can you begin converting other references to use the
host vectors.  Otherwise, the tcg optimizer will do Bad and Unpredictable
Things, which may well have produced the incorrect results that you saw.

I'll note that it's probably worth rearranging all of {fpr,vsr,avr} to the more
logical configuration presented by Power7 (?) such that it's one array of 64 x
128-bit registers.


r~
