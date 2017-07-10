Received: from eggs.gnu.org ([2001:4830:134:3::10]:57451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUbya-00039j-Bb
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUbyZ-0001mS-JV
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:56:00 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710142850.10468-1-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1e34d387-753b-14ff-dcc0-226515ff0124@twiddle.net>
Date: Mon, 10 Jul 2017 06:55:42 -1000
MIME-Version: 1.0
In-Reply-To: <20170710142850.10468-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] include/exec/cpu-defs.h: try and make
 SoftMMU page size match target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, bobby.prani@gmail.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 07/10/2017 04:28 AM, Alex Bennée wrote:
> While the SoftMMU is not emulating the target MMU of a system there is
> a relationship between its page size and that of the target. If the
> target MMU is full featured the functions called to re-fill the
> entries in the SoftMMU entries start moving up the perf profiles. If
> we can we should try and prevent too much thrashing around by having
> the page sizes the same.

What you are changing has absolutely nothing to do with page size.  Mentioning 
page sizes just confuses the issue.

What you're changing is the number of entries in the TLB, and the mapping 
between pages and TLB entries.  And I'm quite certain that you saw a 
performance increase by increasing the size of the TLB.


>   #define CPU_TLB_BITS                                             \
> -    MIN(8,                                                       \
> +    MIN(10,                                                      \

You will find this has broken tcg/arm, because the operand to an armv6 AND 
(immediate) instruction is only 8 bits.

I will grant you that we could do a better job of configuring this across the 
tcg backends.

It also possibly warrants some work in the tcg/arm backend so that armv7 makes 
use of UBFX so that not-ancient arm is not so constrained.


r~
