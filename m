Received: from eggs.gnu.org ([2001:4830:134:3::10]:38642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxwOy-0000yZ-KB
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxwOt-00026Q-Pc
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:04:12 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxwOt-00025b-JX
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:04:07 -0400
Received: by mail-wr0-x232.google.com with SMTP id o21so141289471wrb.2
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 07:04:07 -0700 (PDT)
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
	<87vaqgrds2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a74b9ee8-1b9d-244b-8046-b116fedb55f1@kaod.org>
	<25dcb89b-35be-ea27-8719-7b446f464694@kaod.org>
	<87lgr8ji2f.fsf@linaro.org>
	<04c9f03f-7f04-ebce-15f1-988db1fb2c1d@kaod.org>
	<1491917167.7236.1.camel@kernel.crashing.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1491917167.7236.1.camel@kernel.crashing.org>
Date: Tue, 11 Apr 2017 15:04:15 +0100
Message-ID: <87h91vjb1c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC v1 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, programmingkidx@gmail.com, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2017-04-11 at 14:28 +0200, Cédric Le Goater wrote:
>> I really don't know.
>>
>> Ben, now that we have mttcg activated by default on ppc, it takes
>> a while for the linux kernel to do the early setup. I think we are
>> in the code section where we spin loop the secondaries. Most of the
>> time is spent in skiboot under cpu_idle/relax.
>>
>> Any idea where that could come from ?
>>
>> > See c22edfebff29f63d793032e4fbd42a035bb73e27 for an example.
>>
>> Thanks for the hint.
>
> They are spinning, but they have smt_low instructions in the loop,
> maybe that causes us to do some kind of synchronization as we exit
> the emulation loop on these ? I added that to force relinguish time
> to other threads on the pre-MT TCG...

Yeah you need a tweak the approach when running with MTTCG as otherwise
you end up causing exits for one vCPUs loop to yield to vCPUs that are
already running in other threads.

> There isn't really such a "pause" instruction. At least not yet.... P9
> has a wait that is meant to wait for special AS_Notify cycles but will
> also wait for interrupts. We don't have an mwait at this point.

They are worth implementing. FWIW on ARM we only really handle WFI
(Wait-for-interrupt) which will cause the EXCP_HALT and that will put
the vCPU into a halted state which can be woken up next interrupt.

For the other cases YIELD and WFE (wait-for-event) we just treat them as
NOPs when MTTCG is enabled (test parallel_cpus). So they will busy-wait
spin around the guests wfe code but don't trigger expensive longjmps out
of the execution loop. This was all done in:

  c22edfebff target-arm: don't generate WFE/YIELD calls for MTTCG

One other thing I noticed while looking through the PPC stuff is I
couldn't see any handling of cpu_reset/powering on. There is a potential
race here which ThreadSanitizer will complain about if you start loading
up your about-to-be-powered-on-vCPU from another thread. The fix here is
to defer the setup with async work. See:

  062ba099e0 target-arm/powerctl: defer cpu reset work to CPU context

--
Alex Bennée
