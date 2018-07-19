Received: from eggs.gnu.org ([2001:4830:134:3::10]:34629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fg7pm-0001cv-Ow
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fg7pj-0004sd-HT
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42626 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fg7pj-0004ry-Ac
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:14:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39749401CE8B
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 12:14:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620071040.28729-1-peterx@redhat.com>
	<87y3e8lfks.fsf@dusky.pond.sub.org> <20180719050145.GD4071@xz-mi>
	<87va9bitdp.fsf@dusky.pond.sub.org> <20180719080306.GF4071@xz-mi>
	<87fu0fh9y9.fsf@dusky.pond.sub.org> <20180719094601.GJ4071@xz-mi>
Date: Thu, 19 Jul 2018 14:14:56 +0200
In-Reply-To: <20180719094601.GJ4071@xz-mi> (Peter Xu's message of "Thu, 19 Jul
	2018 17:46:01 +0800")
Message-ID: <878t67fmm7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Thu, Jul 19, 2018 at 11:05:34AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Jul 19, 2018 at 09:20:34AM +0200, Markus Armbruster wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Wed, Jul 18, 2018 at 05:38:11PM +0200, Markus Armbruster wrote:
>> >> >> Peter Xu <peterx@redhat.com> writes:
>> >> >> 
>> >> >> > After the Out-Of-Band work, the monitor iothread may be accessing the
>> >> >> > cur_mon as well (via monitor_qmp_dispatch_one()).
>> 
>> Since renamed to monitor_qmp_dispatch().
>
> True.
>
>> 
>> Further down, we concluded that cur_mon isn't actually used from the I/O
>> thread, didn't we?
>
> I think so; if not we should either fix it or apply this patch. :)
>
>> 
>> >> >> >                                                    Let's convert the
>> >> >> > cur_mon variable to be a per-thread variable to make sure there won't be
>> >> >> > a race between threads when accessing the variable.
>> >> >> 
>> >> >> Hmm... why hasn't the OOB work created such a race already?
>> >> >> 
>> >> >> A monitor reads, parses, dispatches and executes commands, formats and
>> >> >> sends replies.
>> >> >> 
>> >> >> Before OOB, all of that ran in the main thread.  Any access of cur_mon
>> >> >> should therefore be from the main thread.  No races.
>> >> >> 
>> >> >> OOB moves read, parse, format and send to an I/O thread.  Dispatch and
>> >> >> execute remain in the main thread.  *Except* for commands executed OOB,
>> >> >> dispatch and execute move to the I/O thread, too.
>> >> >> 
>> >> >> Why is this not racy?  I guess it relies on careful non-use of cur_mon
>> >> >> in any part that may now execute in the I/O thread.  Scary...
>> >> >
>> >> > I think it's because cur_mon is not really used in out-of-band command
>> >> > executions - now we only have a few out-of-band enabled commands, and
>> >> > IIUC none of them is using cur_mon (for example, in
>> >> > qmp_migrate_recover() we don't even call error_report, and the code
>> >> > path is quite straight forward to make sure of that).  So IIUC cur_mon
>> >> > variable is still only touched by main thread for now hence we should
>> >> > be safe.  However that condition might change in the future when we
>> >> > add more out-of-band capable commands.
>> >> >
>> >> > (not to mention that I don't even know whether there are real users of
>> >> >  out-of-band if we haven't yet started to support that for libvirt...)
>> >> 
>> >> It's not just the actual OOB commands (there are just two), it's also
>> >> the monitor code to read, parse, format and send.
>> >
>> > My understanding is that read, parse, format, send will not touch
>> > cur_mon (it was touched before but some patches in the out-of-band
>> > series should have removed the last users when parsing).  So IIUC only
>> > the dispatcher would touch that now.  I didn't consider the callers
>> > like net_init_socket() and I'm only considering the monitor code (and
>> > those callers should be only in the main thread too after all).
>> 
>> There *is* cur_mon use outside dispatch & execute, e.g.
>> 
>>     void error_vprintf(const char *fmt, va_list ap)
>>     {
>>         if (cur_mon && !monitor_cur_is_qmp()) {
>>             monitor_vprintf(cur_mon, fmt, ap);
>>         } else {
>>             vfprintf(stderr, fmt, ap);
>>         }
>>     }
>> 
>> Obviously unsafe to use outside the main thread.  Consider:
>> 
>>     bool monitor_cur_is_qmp(void)
>>     {
>>         return cur_mon && monitor_is_qmp(cur_mon);
>>     }
>> 
>>     static inline bool monitor_is_qmp(const Monitor *mon)
>>     {
>>         return (mon->flags & MONITOR_USE_CONTROL);
>>     }
>> 
>> If monitor_cur_is_qmp() reads cur_mon twice (which it is entitled to
>> do), this crashes when the main thread sets cur_mon back to null in
>> between.
>
> Yes, but I thought we should not even use these error_vprintf() or
> sister functions outside the QMP handlers, or at least that's what I
> thought.  For example, in parsers, we should always use error_setg()
> or something similar but never error_report().

error_report() & friends are for general use, not just for monitor
handlers.  They are for reporting errors to a human user.  error_setg()
is for passing errors to code.

>> Did the OOB work make things any worse?  Let's see.
>> 
>> @cur_mon is null unless the main thread is running monitor code, either
>> HMP within monitor_read():
>> 
>>     cur_mon = opaque;
>> 
>>     if (cur_mon->rs) {
>>         for (i = 0; i < size; i++)
>>             readline_handle_byte(cur_mon->rs, buf[i]);
>>     } else {
>>         if (size == 0 || buf[size - 1] != 0)
>>             monitor_printf(cur_mon, "corrupted command\n");
>>         else
>>             handle_hmp_command(cur_mon, (char *)buf);
>>     }
>> 
>>     cur_mon = old_mon;
>> 
>> or QMP within monitor_qmp_dispatch():
>> 
>>     old_mon = cur_mon;
>>     cur_mon = mon;
>> 
>>     rsp = qmp_dispatch(mon->qmp.commands, req, qmp_oob_enabled(mon));
>> 
>>     cur_mon = old_mon;
>> 
>> In both cases, old_mon is always null.
>> 
>> Fine print: before commit 227a07552f3 "monitor: move the cur_mon hack
>> deeper for QMP", we ran more code for QMP with cur_mon set, namely the
>> JSON parser, but that doesn't matter here.
>> 
>> More fine print: there's also qmp_human_monitor_command(), which stacks
>> an HMP monitor on top of the QMP monitor.  Also doesn't matter here.
>> 
>> The OOB work doesn't add any new races as long as
>> 
>> * it doesn't add assignments to @cur_mon, and
>> 
>> * none of the code it moves out of the main thread accesses @cur_mon.
>> 
>> The first condition obviously holds.  The second one isn't obvious, but
>> I figure it holds, too.
>> 
>> Okay, I think I've convince myself the OOB work didn't add
>> cur_mon-related races.
>
> Hopefully, yes.  Thanks for the double check.

Wait!  I think I found one.

Say we have an HMP monitor running in the main thread (they always do),
and a QMP monitor running in @mon_iothread.

Now both threads write to @cur_mon, without synchronization!  The main
thread writes in monitor_read() when reading HMP input, and in
monitor_qmp_dispatch() when dispatching in-band QMP commands.
@mon_iothread writes in monitor_qmp_dispatch() when dispatching
out-of-band QMP commands.

Example:

    in main thread:

        chardev reads input, calls
            monitor_read()
                old_mon = cur_mon; // null
                cur_mon = opaque;  // HMP monitor
                ...

    in mon_iothread:

        chardev reads input, calls
            monitor_qmp_read(), calls
                handle_qmp_command() via JSON parser
                    calls monitor_qmp_dispatch() to execute OOB command
                        old_mon = cur_mon; // HMP monitor!
                        cur_mon = mon;     // QMP monitor
                        ...

    in main thread
                ... HMP code runs with @cur_mon pointing to QMP monitor
                cur_mon = old_mon; // null

    in mon_iothread
                        old_mon = cur_mon; // HMP monitor!

    all threads
        non-monitor code runs with @cur_mon pointing to HMP monitor

>> >> >> Should this go into 3.0 to reduce the risk of bugs?
>> >> >
>> >> > Yes I think it would be good to have that even for 3.0, since it still
>> >> > can be seen as a bug fix of existing code.
>> >> 
>> >> Agreed.
>> >> 
>> >> > Regards,
>> >> >
>> >> >> > Note that thread variables are not initialized to a valid value when new
>> >> >> > thread is created.
>> >> 
>> >> Confusing.  It sounds like @cur_mon's initial value would be
>> >> indeterminate, like an automatic variable's.  Not true.  Variables with
>> >> thread storage duration are initialized when the thread is created.
>> >> Since @cur_mon's declaration lacks an initializer, it'll be initialized
>> >> to a null pointer.  Your sentence is correct when you consider that null
>> >> pointer not a valid value.
>> >
>> > Yes that's what I meant.  So how about this?
>> >
>> >   Note that the per-thread @cur_mon variable is not initialized to
>> >   point to a valid Monitor struct when a new thread is created (the
>> >   default value will be NULL).
>> >
>> > Please feel free to tune it up.
>> 
>> I think what the patch really changes is the value of @cur_mon outside
>> the main thread: it remains null there now.  Before, it depended on what
>> the main thread was doing, and therefore could not be used safely.
>> 
>> In other words, the patch makes uses of @cur_mon like the one in
>> error_vprintf() shown above safe.
>> 
>> I think that's what we should explain in the commit message.  I can try
>> rewriting it,
>
> I'll appreciate that if so.

Here's my try:

    monitor: Fix unsafe sharing of @cur_mon among threads

    @cur_mon is null unless the main thread is running monitor code, either
    HMP code within monitor_read(), or QMP code within
    monitor_qmp_dispatch().

    Use of @cur_mon outside the main thread is therefore unsafe.

    Most of its uses are in monitor command handlers.  These run in the main
    thread.

    However, there are also uses hiding elsewhere, such as in
    error_vprintf(), and thus error_report(), making these functions unsafe
    outside the main thread.  No such unsafe uses are known at this time.
    Regardless, this is an unnecessary trap.  It's an ancient trap, though.

    More recently, commit cf869d53172 "qmp: support out-of-band (oob)
    execution" spiced things up: the monitor I/O thread assigns to @cur_mon
    when executing commands out-of-band.  Having two threads save, set and
    restore @cur_mon without synchronization is definitely unsafe.  We can
    end up with @cur_mon null while the main thread runs monitor code, or
    non-null while it runs non-monitor code.

    We could fix this by making the I/O thread not mess with @cur_mon, but
    that would leave the trap armed and ready.

    Instead, make @cur_mon thread-local.  It's now reliably null unless the
    thread is running monitor code.
    
>> but right now I got to run.
>
> Must be lunch time! :)

Time to prepare lunch for the family, actually :)
