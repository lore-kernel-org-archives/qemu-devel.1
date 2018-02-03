Received: from eggs.gnu.org ([2001:4830:134:3::10]:51740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei53U-0004ur-ND
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei53P-0004PP-P6
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:09:00 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:45608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei53P-0004P5-Gm
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:08:55 -0500
Received: by mail-pl0-x244.google.com with SMTP id p5so8956539plo.12
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:08:55 -0800 (PST)
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-4-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9825a1c2-6f25-5b4d-c193-bd4f880fb708@linaro.org>
Date: Sat, 3 Feb 2018 13:08:51 -0800
MIME-Version: 1.0
In-Reply-To: <1517324542-6607-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] target/arm: Add ignore_stackfaults
 argument to v7m_exception_taken()
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

On 01/30/2018 07:02 AM, Peter Maydell wrote:
> In the v8M architecture, if the process of taking an exception
> results in a further exception this is called a derived exception
> (for example, an MPU exception when writing the exception frame to
> memory). If the derived exception happens while pushing the initial
> stack frame, we must ignore any subsequent possible exception
> pushing the callee-saves registers.
> 
> In preparation for making the stack writes check for exceptions,
> add a return value from v7m_push_stack() and a new parameter to
> v7m_exception_taken(), so that the former can tell the latter that
> it needs to ignore failures to write to the stack. We also plumb
> the argument through to v7m_push_callee_stack(), which is where
> the code to ignore the failures will be.
> 
> (Note that the v8M ARM pseudocode structures this slightly differently:
> derived exceptions cause the attempt to process the original
> exception to be abandoned; then at the top level it calls
> DerivedLateArrival to prioritize the derived exception and call
> TakeException from there. We choose to let the NVIC do the prioritization
> and continue forward with a call to TakeException which will then
> take either the original or the derived exception. The effect is
> the same, but this structure works better for QEMU because we don't
> have a convenient top level place to do the abandon-and-retry logic.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
