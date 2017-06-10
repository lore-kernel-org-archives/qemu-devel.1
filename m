Received: from eggs.gnu.org ([2001:4830:134:3::10]:59072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJjjW-0007tC-7C
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 12:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJjjV-0000q6-CF
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 12:59:30 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170609170100.3599-1-alex.bennee@linaro.org>
	<20170609170100.3599-4-alex.bennee@linaro.org>
	<fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
	<87vao4b4z5.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9776b437-90b4-f2c2-4a0c-c1c6585379bf@twiddle.net>
Date: Sat, 10 Jun 2017 09:59:19 -0700
MIME-Version: 1.0
In-Reply-To: <87vao4b4z5.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, cota@braap.org, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 06/10/2017 01:51 AM, Alex Bennée wrote:
> 
> Richard Henderson <rth@twiddle.net> writes:
> 
>> On 06/09/2017 10:01 AM, Alex Bennée wrote:
>>> THIS IS A DEBUG PATCH DO NOT MERGE
>>>
>>> I include all the comments to show my working. I was trying to
>>> isolate which instructions cause the problem. It turns out it is the
>>> RET instruction. I don't understand why because AFAICT it is a
>>> pretty much a BR instruction.
>>
>> Yeah, same thing for Alpha.
>>
>> It has been my guess that not chaining through RET means that we get
>> back to the main loop regularly and often, letting interrupts be
>> recognized in a timely manner.
>>
>> I can't figure out why that would be, however, since interrupts
>> *ought* to be setting icount_decr, and the TB to which we chain *is*
>> checking that to return to the main loop.
> 
> Indeed - if that was broken a lot more stuff wouldn't work.
> 
>> Since changing the timing affects the outcome (e.g. -d exec), it
>> follows that this *must* be some sort of race condition.  But since
>> this still happens with single-threaded mode, I can't imagine what
>> sort of race condition it might be.
> 
> Apart from timer expiry I can't think what other interactions the other
> threads have on the main TCG thread. I guess there is IO but my test
> hangs way before the kernel starts poking the disk. Is there an
> interaction between IRQs and QEMU's serial driver?

The Alpha hang appears to be timer expiry.  In that it happens as soon as the 
kernel spawns some kthreads to finish up the boot process.  The kernel then 
sits in the idle loop for an unreasonably long time.

But, bizarrely, it will complete the boot eventually.  But it takes ~5 minutes 
to do so, when we ought to be able to boot to prompt in seconds.

>> More data points.  I removed the tb_htable_lookup, and that by itself
>> is enough to fix Alpha booting.  But it doesn't help the aarch64
>> kernel+image that I have.  Which does still boot with -d nochain
>> (which, along with disabling goto_tb chaining, also disables all
>> goto_ptr).
> 
> I wonder what is different about your aarch64 image and mine then?
> Because mine works just with suppressing the chaining for RET.

Oh I just tried -d nochain because it doesn't require source modification.

>> Not really sure where to go from here.
> 
> I would agree with Emilio that we revert but I can't quite shake the
> feeling we are missing an underlying problem. Would just skipping the
> htable lookup (but keeping the tb_jmp_cache) be an OK fix for now?

I agree.  It seems like there's some real problem that this is uncovering.

Dropping the htable lookup is certainly ok by me.  If that's enough to un-stick 
your regression testing for aarch64 guest.


r~
