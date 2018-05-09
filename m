Received: from eggs.gnu.org ([2001:4830:134:3::10]:33845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fGNOp-00084O-FR
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fGNOo-0006JG-2Z
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:36:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87bme62nu0.fsf@dusky.pond.sub.org>
	<068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
	<20180427003215.GU29865@localhost.localdomain>
	<87o9i5uplt.fsf@dusky.pond.sub.org>
	<20180507135330.GS25013@localhost.localdomain>
	<87h8njtnok.fsf@dusky.pond.sub.org>
	<20180507182126.GC25013@localhost.localdomain>
	<4bba0be5-a52c-48ad-3df4-4e9be3624dc0@redhat.com>
	<20180507193220.GF25013@localhost.localdomain>
	<5837d14a-b562-c382-f95a-32ef12a4e25c@redhat.com>
	<20180508164040.GL25013@localhost.localdomain>
	<87f9536a-3413-419e-5367-90bd60ba27d8@redhat.com>
Date: Wed, 09 May 2018 13:36:40 +0200
In-Reply-To: <87f9536a-3413-419e-5367-90bd60ba27d8@redhat.com> (Thomas Huth's
	message of "Wed, 9 May 2018 09:41:28 +0200")
Message-ID: <871selawmv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-ppc] Running QEMU without default devices /
 kernel / bios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 08.05.2018 18:40, Eduardo Habkost wrote:
>> On Tue, May 08, 2018 at 07:33:46AM +0200, Thomas Huth wrote:
>>> On 07.05.2018 21:32, Eduardo Habkost wrote:
>>>> On Mon, May 07, 2018 at 09:13:57PM +0200, Thomas Huth wrote:
> [...]
>>>>> Without "-accel qtest", things are not that easy, unfortunately. Lots of
>>>>> boards require "-kernel" or "-bios" and refuse to work without. So you
>>>>> can hardly test "-nodefaults" automatically in the normal tcg mode. (But
>>>>> maybe all boards should allow to start QEMU in case you've at least also
>>>>> specified "-S" ? ... in that case we've got plenty of work for
>>>>> BiteSizeTasks ;-) )
>>>>
>>>> Hmm, maybe it's not a bite-sized task after all.  :)
>>>>
>>>> Should we do this gradually?
>>>>
>>>> * Working with -accel qtest is useful, and sounds like an easier goal;
>>>
>>> We're pretty much there already. Apart from the SD card problem (and the
>>> xen boards), all machines should work with -nodefaults in qtest mode now.
>>>
>>>> * working with -S seems desirable too;
>>>
>>> Yes, it could be interesting to load the firmware / OS via HMP or GDB
>>> after QEMU has been started.
>>>
>>> Maybe we'd simply need a new function a la:
>>>
>>> bool cpu_starts_automatically()
>>> {
>>>     return autostart && !qtest_enabled();
>>> }
>>>
>>> And then replace all spots where we exit due to missing -kernel or -bios
>>> parameters, e.g.:
>>>
>>> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
>>> --- a/hw/m68k/mcf5208.c
>>> +++ b/hw/m68k/mcf5208.c
>>> @@ -286,7 +286,7 @@ static void mcf5208evb_init(MachineState *machine)
>>>
>>>      /* Load kernel.  */
>>>      if (!kernel_filename) {
>>> -        if (qtest_enabled()) {
>>> +        if (!cpu_starts_automatically()) {
>>>              return;
>>>          }
>>>          error_report("Kernel image must be specified");
>>>
>>> Does that sound like a plan?
>> 
>> Not sure.  If a given command-line fails without -S, I would
>> expect it to also fail if using -S and the "cont" monitor command
>> is issued.  (But not necessarily if "-S" is used and "cont" is
>> never issued.)
>> 
>>>
>>>> * working without -S (even if the emulated CPU crashes and burns)
>>>>   would be interesting.
>>>
>>> Not sure whether we really need this. It's likely better to give the
>>> user a proper error message to use "-kernel" instead of just showing a
>>> crash.
>> 
>> I think I agree.
>> 
>>>
>>>> Related question: what are the use cases where we require
>>>> "-accel qtest" and "-S" wouldn't work?
>>>
>>> Maybe there are some boards where you can not load code via HMP or GDB
>>> once you've started QEMU with "-S"? You'd end up with a mostly useless
>>> HMP prompt in that case, which is a little bit ugly, but not fatal.
>> 
>> You have a point.  I guess the definition of "useless" here
>> depend on what are the use cases we want to address with -S: are
>> there reasonable use cases for using -S and never issuing "cont"?
>> 
>> Would it be OK if we reported errors like "kernel image must be
>> specified"  only when/if "cont" is issued?
>
> From a users point of view, this would be great, yes. You could start
> QEMU with -S, set up your machine via HMP, QMP oder GDB, and then try to
> start with "cont". If you'd screw it up, "cont" would yell at you and
> you could try again.
>
> From a developers point of view, this sounds like a nightmare to get it
> right with all the QEMU machines that we support, though.
>
>>> Apart from that ... I can't think of a case where "-S" would not work at
>>> all once we've introduce something like cpu_starts_automatically().
>> 
>> I'm being convinced that "-accel qtest" and "-S" are not expected
>> to be equivalent, so my main priority right now is to document
>> what are the differences.
>
> Hmmm, I think I originally slightly misunderstood your original
> question.... and until now, I also thought that "-accel qtest" would
> enable the qtest interface in qtest.c, but it seems like this is rather
> done by the "-qtest" parameter instead.
>
> So as far as I can see, it theoretically should be possible to replace
> "-accel qtest" with "-S". But I'm also not an expert here.

-S makes QEMU remain in RUN_STATE_PRELAUNCH.  Without it, QEMU enters
RUN_STATE_RUNNING.

RUN_STATE_RUNNING with accel=qtest is not obviously equivalent to
RUN_STATE_PRELAUNCH!  The state transition does more than just resuming
CPUs.

>> I'm reaching two conclusions from this thread:
>> 
>> 1) "-accel qtest" has additional purposes other than the "don't
>>    run any guest code".  We need to document them clearly,
>>    and it probably can't be replaced by -S directly.
>
> There are just two things that come to my mind why we could not
> immediately replace "-accel qtest" by "-S":
>
> - There are some few qtest which override "-accel qtest" with "-accel
>   tcg". But I think they could simply be changed to use the "cont"
>   command instead.
>
> - We should also consider that it is possible nowadays to build QEMU
>   with --disable-tcg. In that case, you depend on KVM to be available
>   as accelerator. As long as there's still "-accel qtest", it should
>   be possible to run "make test" (just the tests that really need tcg
>   don't work anymore). But if we remove "-accel qtest" and replace it
>   with "-S", the tests can't be run anymore if the host machine does
>   not offer KVM (e.g. on an automated builder machine). We could add
>   an "-accel none" mode instead, but from a users point of view, that's
>   pretty much the same as the current "-accel qtest" mode...

Different name, same thing, not worth changing.
