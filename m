Received: from eggs.gnu.org ([2001:4830:134:3::10]:52423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBxGe-00022k-K6
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBxGa-0000NC-My
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:54:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBxGa-0000Mq-Hc
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:54:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-7-lersek@redhat.com>
	<8736zjagg3.fsf@dusky.pond.sub.org>
	<4509705a-43b2-db40-aa24-18eff649e750@redhat.com>
	<87sh7i4h5y.fsf@dusky.pond.sub.org>
	<ea646e6d-9512-559d-be8d-fd3c754cc301@redhat.com>
	<136c5d3a-9d5b-eb15-a1f4-18150662144b@redhat.com>
	<87vacexcir.fsf@dusky.pond.sub.org>
	<230b57bf-1bf0-fd4e-05bf-cb7c4902975d@redhat.com>
	<8736zix8yb.fsf@dusky.pond.sub.org>
	<f0c9c7ca-3dcf-4f74-9812-5dea5b6376cd@redhat.com>
Date: Fri, 27 Apr 2018 08:53:51 +0200
In-Reply-To: <f0c9c7ca-3dcf-4f74-9812-5dea5b6376cd@redhat.com> (Laszlo Ersek's
	message of "Thu, 26 Apr 2018 18:30:19 +0200")
Message-ID: <87bme5uolc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] qapi: discriminate CpuInfo[Fast] on
 SysEmuTarget, not CpuInfoArch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/26/18 17:51, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 04/26/2018 09:34 AM, Markus Armbruster wrote:
>>>>>
>>>>> Acerbic discovery of the day: @CpuInfoArch has "x86", while configure
>>>>> produces:
>>>>>
>>>>>   TARGET_NAME  TARGET_BASE_ARCH
>>>>>          i386              i386
>>>>>        x86_64              i386
>>>>>
>>>>> Note how "i386" does not match "x86".
>>>>
>>>> Review fail.
>>>>
>>>> Just three weeks ago, we could still have fixed query-cpus-fast...
>>>
>>> Actually, I think we still can.  We already documented in the 2.12
>>> release notes that the "arch" field of query-cpus-fast is known to be
>>> broken for all but "s390x" (which is really the only arch field that
>>> MUST be correct, as that is the only time we send additional
>>> information).  And introspection can easily see both the enum contents
>>> (if we add something) as well as any other additions to the
>>> query-cpus-fast output union (although that is less likely), to use
>>> those as a witness for whether qemu is new enough to have fixed the
>>> bogus "arch" values.  I'd argue that if we change things right now, with
>>> intent to include the change in 2.12.1, before people start relying on
>>> the bogus "arch" of 2.12, then we should feel free to make
>>> query-cpus-fast output whatever we want for all architectures other than
>>> "s390x", even if it changes the current output of "x86".
>> 
>> In other words, we managed to screw up query-cpus-fast sufficiently to
>> let us fix it even now.  Cool, let's do it!
>> 
>
> Let me clarify a little.
>
> The @CpuInfoArch enum has the following constants now:
>
> ['x86', 'sparc', 'ppc', 'mips', 'tricore', 's390', 'riscv', 'other' ]
>
> This enum was originally introduced in 2.6 (according to the
> documentation), and only the @s390 and @riscv constants were added in 2.12.
>
> The enum constants show up in the following two places, *on the wire*:
>
> - in @CpuInfo.@arch, only produced by @query-cpus,
> - in @CpuInfoFast.@arch, only produced by @query-cpus-fast.
>
> The plan would be to rewrite *all* those enum constants of @CpuInfoArch
> to which the respective TARGET_BASE_ARCH values (from "configure") do
> not map *identically*. Here's the mapping:
>
>   TARGET_BASE_ARCH  CpuInfoArch  CpuInfoArch needs change
>   ----------------  -----------  ------------------------
>   i386              x86          YES
>   sparc             sparc        no
>   ppc               ppc          no
>   mips              mips         no
>   tricore           tricore      no
>   s390x             s390         YES
>   riscv             riscv        no
>
> In other words, @CpuInfoArch would have to be changed to the following:
>
> ['i386', 'sparc', 'ppc', 'mips', 'tricore', 's390x', 'riscv', 'other' ]
>  ^^^^^^                                     ^^^^^^^
>
> This means that the @arch field, returned by @query-cpus and
> @query-cpus-fast, would change incompatibly for those QAPI clients that
> look specifically for "x86" or "s390".
>
> Is this a safe change?
>
> I would say, because of the 's390' -> 's390x' change, that it isn't.
>
> (Also, to confirm, the wiki section at
> <https://wiki.qemu.org/Planning/2.12#Issues_that_will_not_be_fixed> states,
>
>   * the query-cpus-fast QMP command reports bogus arch data for all
>     architectures except x86 and s390; applications should be careful to
>     not rely on the bogus information
>
> It (correctly) refers to "s390". That value would change.)

You're right, that's a compatibility break.

We could perhaps still declare *all* @arch values useless in v2.12.0,
then fix them in v2.12.1.

Or we deprecate @arch right when we introduce @target, and drop it later
in accordance with our deprecation policy (qemu-doc.texi @appendix
Deprecated features).  That way, the rather ridiculous code to compute
it will be temporary.  I think that's cleaner.

   @arch in     query-cpus      query-cpus-fast
   before 2.6   nonexistent
   2.6 - 2.11   CpuInfoArch
   2.12         cmd deprecated  CpuInfoArch
   2.13         cmd deprecated  memb deprecated
   2.14         cmd gone        memb deprecated
   2.15         cmd gone        memb gone

Opinions?
