Received: from eggs.gnu.org ([209.51.188.92]:38118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqv2x-00039W-UU
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqv2w-0000US-1w
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:21:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gqv2s-0000TV-CN
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 02:21:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-8-yuval.shaia@oracle.com>
	<42ba3330-f7ca-b5c5-126f-8dd97e343d51@redhat.com>
	<20190131200816.GA2838@lap1>
	<3557b3f3-cec5-fcb1-1527-e613fa446b89@redhat.com>
	<87ftt8j73b.fsf@dusky.pond.sub.org> <20190203070601.GA2893@lap1>
	<87va20rmga.fsf@dusky.pond.sub.org> <20190204160735.GB14293@lap1>
Date: Tue, 05 Feb 2019 08:21:17 +0100
In-Reply-To: <20190204160735.GB14293@lap1> (Yuval Shaia's message of "Mon, 4
	Feb 2019 18:07:36 +0200")
Message-ID: <87y36u8zv6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/10] monitor: Expose pvrdma device
 statistics counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Yuval Shaia <yuval.shaia@oracle.com> writes:

> On Mon, Feb 04, 2019 at 09:23:49AM +0100, Markus Armbruster wrote:
>> Yuval Shaia <yuval.shaia@oracle.com> writes:
>> 
>> > On Fri, Feb 01, 2019 at 08:33:44AM +0100, Markus Armbruster wrote:
>> >> Eric Blake <eblake@redhat.com> writes:
>> >> 
>> >> > On 1/31/19 2:08 PM, Yuval Shaia wrote:
>> >> >> On Thu, Jan 31, 2019 at 07:17:16AM -0600, Eric Blake wrote:
>> >> >>> On 1/31/19 7:08 AM, Yuval Shaia wrote:
>> >> >>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> >> >>>> ---
>> >> >>>>  hmp-commands-info.hx | 14 ++++++++++++++
>> >> >>>>  monitor.c            |  6 ++++++
>> >> >>>>  2 files changed, 20 insertions(+)
>> >> >> 
>> >> >> Hi Eric,
>> >> >> 
>> >> >>>
>> >> >>> Commit message should state WHY this is being added as an HMP-only
>> >> >>> command, and does not have a QMP counterpart.  It may be okay if the
>> >> >>> interface is only designed to be useful to developers, but having that
>> >> >>> justification in the git log is important.
>> >> >> 
>> >> >> Thanks for your review.
>> >> >> 
>> >> >> See, i need this interface mainly for development/debug purposes, to help
>> >> >> troubleshot problems and to give insights to what device "is doing".
>> >> >> 
>> >> >> Trace points are great but not effective in high load.
>> >> >> QMP as i see it, and correct me if i'm wrong, is used to report management
>> >> >> events etc and also here, is not effective in high load.
>> >> 
>> >> If QMP is not effective, HMP won't be effective, either.  But I guess
>> >> you mean something else, namely QMP *events* aren't effective, but
>> >> *polling* is.
>> >
>> > Yeah.
>> > I really meant to say "QMP is not effective *choice* for my needs".
>> >
>> >> 
>> >> That's an argument for polling, not an argument for not supporting QMP.
>> >> 
>> >> >> I choose this interface as it is interactive, i.e. whenever i need the info
>> >> >> i trigger 'info pvrdmastats' command from the monitor console.
>> >> >> 
>> >> >> During my research i notice that some devices (or families) have nice user
>> >> >> interface via virsh (blkstat, ifstat, memstat etc). Is it the preferred way
>> >> >> for non-devel/debug purposes?
>> >> 
>> >> Libvirt interfaces like these are built on top of *QMP* interfaces.  If
>> >> a libvirt interface would be useful, that's another argument for
>> >> supporting QMP.
>> >
>> > I was asking in a context of what is the standard way to do it.
>> 
>> You were right to ask it.
>> 
>> >> > Using existing HMP-only debug interfaces as the design you copied is
>> >> > indeed acceptable justification for making yours HMP-only as well.  So
>> >> > now you just need to copy the rationale from this email into your commit
>> >> > message, so it doesn't get lost.
>> >> 
>> >> Yes.  If we conclude HMP-only is okay, then the rationale for it goes
>> >> into your commit message.
>> >> 
>> >> If we conclude we want HMP and QMP, I'll be happy to assist you with
>> >> adapting your patch.
>> >
>> > Thanks!
>> > Well, for now i want only to expose debugging-related info and have no idea
>> > yet what would be the best to expose to end-users via QMP events.
>> > Device statistics for end-users are currently exposed by the device driver
>> > in guest. If in the future we will see that this info is also needed in the
>> > host then i'll revisit it.
>> 
>> For me, there are four cases of the "get information from QEMU to the
>> user":
>> 
>> 1. Information that is of use only for developers
>> 
>>    a. When tracing works, use tracing
>> 
>>    b. When it doesn't, we can consider QMP + HMP command, or HMP command
>>       only.  A QMP command would carry an x- prefix to mark it unstable.
>> 
>> 2. Information that is of use only for human users
>> 
>>    Provide an HMP command.
>> 
>> 3. Information a management application such as libvirt wants to
>>    provide, but not monitor
>> 
>>    The QEMU part is just like for 4a below.  The difference is that the
>>    management application doesn't poll automatically.
>> 
>> 4. Information a management application such as libvirt wants to monitor
>> 
>>    This is not the case here, but I mention it for completeness.
>> 
>>    a. The obvious way to monitor is regular polling via QMP.  Provide a
>>       QMP command to poll.
>> 
>>    b. Another way is tracking a QMP event that reports changes, plus
>>       polling on reconnect.  This is generally more efficient.  Provide
>>       a QMP event tracking changes, and a command to poll.  The event
>>       may have to be rate-limited.
>> 
>>    If the information is also useful for human users, throw in a command
>>    to poll via HMP.
>> 
>> I'm not yet sure tracing doesn't work for your use case.  I replied
>> to your claim it's not effective upthread.  Let's discuss it there.
>
> We conclude there, and correct me if i misunderstood you, that for
> 'polling' it make sense to use HMP only.

Not in general; case 3. exists.  But as long as there's no interest in
plumbing the polling through a management application or debugging
tools, HMP only is okay.

>> >> HMP commands without a QMP equivalent are okay if their functionality
>> >> makes no sense in QMP, or is of use only for human users.
>> >> 
>> >> Example for "makes no sense in QMP": setting the current CPU, because a
>> >> QMP monitor doesn't have a current CPU.
>> >> 
>> >> Examples for "is of use only for human users": HMP command "help", the
>> >> integrated pocket calculator.
>> >> 
>> >> Debugging commands are kind of borderline.  Debugging is commonly a
>> >> human activity, where HMP is just fine.  However, humans create tools to
>> >> assist with their activities, and then QMP is useful.  While I wouldn't
>> >> encourage HMP-only for the debugging use case, I wouldn't veto it.
>> >> 
>> >> "Device statistics" sounds like it should have debugging uses.  But
>> >> statistics often have non-debugging uses as well.  What use cases can
>> >> you imagine for this command?
>> >
>> > One use case from real live example is that this interface helped me to
>> > detect a leak in freeing a context of a resource.
>> 
>> Sounds like you can't think of a use other than debugging.  That means
>> we should think harder about using tracepoints.
>
> Here is a case where tracepoint cannot help.
> Consider a counter that counts the number of sent buffers. Now, this
> counter get increased on every buffer that is sent. Let's assume that we
> have tracepoint at the function send_buff that prints it. So first just
> imagine how the trace buffer will look when burst of data is sent. But then
> on the other, if no data is sent then i will never have the chance to see
> the counter.
>
> This is where i left the tracepoints and moved to HMP.

"Tracepoints cannot help" is factually incorrect.  Tracepoints *can*
count, but it takes a sufficiently sophisticated backend such as DTrace
or SystemTap.  For an example, check out

    https://sourceware.org/systemtap/examples/#network/netfilter_summary.stp

With a query command, you bake the counting into the code.  You can
count exactly what the developer thought you'll want to count.

With tracepoints, you can count things the developer has never thought
of.

Finally, there's efficiency.  Efficiency rarely really matters, but when
it matters, you better know how to get it.  Tracepoints can be more
efficient when tracing is off, and DTrace / Systemtap should be
competitively efficient when tracing is on.

Mind, the above isn't an attempt to shoot down your patch.  It's an
attempt to correct misconceptions about tracing!  Your patch may be
useful all the same.

Since your patch's stated purpose is to help with debugging PVRDMA, the
PVRDMA maintainers (Marcel and you) get to decide whether it's useful
for debugging PVRDMA.  The HMP maintainer (David) gets to decide whether
to accept your debugging code into master.  All the QMP maintainer (me)
gets to decide is whether to demand a QMP command (right now I don't),
and whether the commit message adequately explains the lack of a QMP
command (so far it doesn't, but that shouldn't be hard to fix).
