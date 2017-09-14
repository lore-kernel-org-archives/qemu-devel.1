Received: from eggs.gnu.org ([2001:4830:134:3::10]:45396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dsWnU-0005aR-VA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dsWnR-0006uO-PG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:15:24 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dsWnR-0006tP-KA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:15:21 -0400
Received: by mail-pf0-x242.google.com with SMTP id i23so1700581pfi.2
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 09:15:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506083546.19604.543091497330269756.stgit@frigg.lan>
	<169db8d7-fe49-05c4-aca7-ad818b12c9c5@linaro.org>
	<87a81xpasb.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7e4260a8-89a3-9c52-4f09-afe9035ceac2@twiddle.net>
Date: Thu, 14 Sep 2017 09:15:18 -0700
MIME-Version: 1.0
In-Reply-To: <87a81xpasb.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/7] tcg: Add support for "inlining"
 regions of code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 09/14/2017 08:20 AM, Lluís Vilanova wrote:
> Richard Henderson writes:
> 
>> On 09/10/2017 09:27 AM, Lluís Vilanova wrote:
>>> TCG BBLs and instructions have multiple exit points from where to raise
>>> tracing events, but some of the necessary information in the generic
>>> disassembly infrastructure is not available until after generating these
>>> exit points.
>>>
>>> This patch adds support for "inline points" (where the tracing code will
>>> be placed), and "inline regions" (which identify the TCG code that must
>>> be inlined). The TCG compiler will basically copy each inline region to
>>> any inline points that reference it.
> 
>> I am not keen on this.
> 
>> Is there a reason you can't just emit the tracing code at the appropriate place
>> to begin with?  Perhaps I have to wait to see how this is used...
> 
> As I tried to briefly explain on next patch, the main problem without inlining
> is that we will see guest_tb_after_trans twice on the trace for each TB in
> conditional instructions on the guest, since they have two exit points (which we
> capture when emitting goto_tb in TCG).

Without seeing the code, I suspect this is because you didn't examine the
argument to tcg_gen_exit_tb.  You can tell when goto_tb must have been emitted
and avoid logging twice.


r~
