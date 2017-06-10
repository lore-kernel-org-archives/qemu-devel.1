Received: from eggs.gnu.org ([2001:4830:134:3::10]:43136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJW9m-0007Ei-St
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 22:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJW9m-0003Bg-2x
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 22:29:42 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170609170100.3599-1-alex.bennee@linaro.org>
	<20170609170100.3599-4-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
Date: Fri, 9 Jun 2017 19:29:28 -0700
MIME-Version: 1.0
In-Reply-To: <20170609170100.3599-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC DEBUG PATCH 3/3] translate-a64: fix
 lookup_tb_ptr hang (DEBUG!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, cota@braap.org
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 06/09/2017 10:01 AM, Alex Bennée wrote:
> THIS IS A DEBUG PATCH DO NOT MERGE
> 
> I include all the comments to show my working. I was trying to
> isolate which instructions cause the problem. It turns out it is the
> RET instruction. I don't understand why because AFAICT it is a
> pretty much a BR instruction.

Yeah, same thing for Alpha.

It has been my guess that not chaining through RET means that we get back to 
the main loop regularly and often, letting interrupts be recognized in a timely 
manner.

I can't figure out why that would be, however, since interrupts *ought* to be 
setting icount_decr, and the TB to which we chain *is* checking that to return 
to the main loop.

Since changing the timing affects the outcome (e.g. -d exec), it follows that 
this *must* be some sort of race condition.  But since this still happens with 
single-threaded mode, I can't imagine what sort of race condition it might be.

More data points.  I removed the tb_htable_lookup, and that by itself is enough 
to fix Alpha booting.  But it doesn't help the aarch64 kernel+image that I 
have.  Which does still boot with -d nochain (which, along with disabling 
goto_tb chaining, also disables all goto_ptr).

Not really sure where to go from here.


r~
