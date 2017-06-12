Received: from eggs.gnu.org ([2001:4830:134:3::10]:54266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dKMcl-0005rS-V5
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dKMch-0004SN-UT
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:31:07 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dKMch-0004RX-P0
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:31:03 -0400
Received: by mail-wr0-x235.google.com with SMTP id q97so91606439wrb.2
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 03:31:02 -0700 (PDT)
References: <20170609170100.3599-1-alex.bennee@linaro.org>
	<20170609170100.3599-4-alex.bennee@linaro.org>
	<fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
	<87vao4b4z5.fsf@linaro.org>
	<9776b437-90b4-f2c2-4a0c-c1c6585379bf@twiddle.net>
	<20170611050730.GA12317@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170611050730.GA12317@flamenco>
Date: Mon, 12 Jun 2017 11:31:32 +0100
Message-ID: <874lvljy4b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <rth@twiddle.net>, peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> On Sat, Jun 10, 2017 at 09:59:19 -0700, Richard Henderson wrote:
>> On 06/10/2017 01:51 AM, Alex Bennée wrote:
>> >I would agree with Emilio that we revert but I can't quite shake the
>> >feeling we are missing an underlying problem. Would just skipping the
>> >htable lookup (but keeping the tb_jmp_cache) be an OK fix for now?
>>
>> I agree.  It seems like there's some real problem that this is uncovering.
>>
>> Dropping the htable lookup is certainly ok by me.  If that's enough to
>> un-stick your regression testing for aarch64 guest.
>
> Unfortunately not checking the htable isn't enough to fix it for me.

Interesting. It was for me on my more complex command line (i.e. with
network and disk hardware) but while checking on my plain kernel+initrd
image I can reproduce the "hang" purely with the jmp_cache lookup....

> I spent a few hours on Friday trying (and failing) to understand
> what's going on. Regarding interrupts, I see *more* TB_EXIT_INTERRUPT
> exits than without the patch, so my current best guess is that this is
> a livelock kind of thing.
>
> I'll keep digging, but regardless I think we should revert
> e75449a346 ("target/aarch64: optimize indirect branches") ASAP, and
> then reenable the feature ("revert the revert") once we get to the
> bottom of this.
>
> 		E.


--
Alex Bennée
