Received: from eggs.gnu.org ([2001:4830:134:3::10]:58932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d83LM-00036Z-0D
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d83LH-0001EY-Uf
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:30:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d83LH-0001Dt-LU
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:30:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170505193810.2934-1-eblake@redhat.com>
	<20170505193810.2934-3-eblake@redhat.com>
	<87zien433w.fsf@dusky.pond.sub.org>
	<b5139e70-1be8-49ae-282b-ceac5867f4bb@redhat.com>
Date: Tue, 09 May 2017 13:30:01 +0200
In-Reply-To: <b5139e70-1be8-49ae-282b-ceac5867f4bb@redhat.com> (Eric Blake's
	message of "Mon, 8 May 2017 13:33:41 -0500")
Message-ID: <8737ceqnd2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 2/5] shutdown: Prepare for use of an
 enum in reset/shutdown_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, alistair.francis@xilinx.com, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

Eric Blake <eblake@redhat.com> writes:

> On 05/08/2017 01:26 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> We want to track why a guest was shutdown; in particular, being able
>>> to tell the difference between a guest request (such as ACPI request)
>>> and host request (such as SIGINT) will prove useful to libvirt.
>>> Since all requests eventually end up changing shutdown_requested in
>>> vl.c, the logical change is to make that value track the reason,
>>> rather than its current 0/1 contents.
>>>
>>> Since command-line options control whether a reset request is turned
>>> into a shutdown request instead, the same treatment is given to
>>> reset_requested.
>>>
>>> This patch adds an internal enum ShutdownCause that describes reasons
>>> that a shutdown can be requested, and changes qemu_system_reset() to
>>> pass the reason through, although for now it is not reported.  The
>>> enum could be exported via QAPI at a later date, if deemed necessary,
>>> but for now, there has not been a request to expose that much detail
>>> to end clients.
>>>
>>> For now, we only populate the reason with HOST_ERROR, along with FIXME
>>> comments that describe our plans for how to pass an actual correct
>>> reason.
>> 
>> In other words, replacing 0 by SHUTDOWN_CAUSE_NONE, and 1 by
>> SHUTDOWN_CAUSE_HOST_ERROR.  Makes sense.
>
> Maybe I could have ordered HOST_ERROR to actually be 1...

Might be marginally worthwhile if you can split patches so that the one
replacing int by ShutdownCause doesn't change anything but names.

>>> +/* Enumeration of various causes for shutdown. */
>>> +typedef enum ShutdownCause ShutdownCause;
>>> +enum ShutdownCause {
>> 
>> Why define the typedef separately here?  What's wrong with
>> 
>>     typedef enum ShutdownCause {
>>         ...
>>     } ShutdownCause;
>> 
>> ?
>
> That would work too.  I don't know if the code base has a strong
> preference for one form over the other.

I don't have numbers, but I think we use the split form pretty much only
when there's a reason for the split, such as defining an incomplete type
in a header, and completing it elsewhere.

>>> +    SHUTDOWN_CAUSE_NONE,          /* No shutdown requested yet */
>> 
>> Comment is fine.  Possible alternative: /* No shutdown request pending */
>> 
>>> +    SHUTDOWN_CAUSE_HOST_QMP,      /* Reaction to a QMP command, like 'quit' */
>>> +    SHUTDOWN_CAUSE_HOST_SIGNAL,   /* Reaction to a signal, such as SIGINT */
>>> +    SHUTDOWN_CAUSE_HOST_UI,       /* Reaction to UI event, like window close */
>>> +    SHUTDOWN_CAUSE_HOST_ERROR,    /* An error prevents further use of guest */
>
> ...rather than 4.  I don't know that it matters much.
>
>
>>> -static int qemu_reset_requested(void)
>>> +static ShutdownCause qemu_reset_requested(void)
>>>  {
>>> -    int r = reset_requested;
>>> +    ShutdownCause r = reset_requested;
>> 
>> Good opportunity to insert a blank line here.
>> 
>
> Sure.
>
>>>      if (r && replay_checkpoint(CHECKPOINT_RESET_REQUESTED)) {
>>> -        reset_requested = 0;
>>> +        reset_requested = SHUTDOWN_CAUSE_NONE;
>>>          return r;
>>>      }
>>> -    return false;
>>> +    return SHUTDOWN_CAUSE_NONE;
>>>  }
>>>
>>>  static int qemu_suspend_requested(void)
>>> @@ -1686,7 +1687,12 @@ static int qemu_debug_requested(void)
>>>      return r;
>>>  }
>>>
>>> -void qemu_system_reset(bool report)
>>> +/*
>>> + * Reset the VM. If @report is VMRESET_REPORT, issue an event, using
>>> + * the @reason interpreted as ShutdownCause for details.  Otherwise,
>>> + * @report is VMRESET_SILENT and @reason is ignored.
>>> + */
>> 
>> "interpreted as ShutdownCause"?  It *is* a ShutdownCause.  Leftover?
>
> Oh, yeah. In v5, the parameter was 'int'.

Easy enough to clean up :)

>>> +void qemu_system_reset(bool report, ShutdownCause reason)
>>>  {
>>>      MachineClass *mc;
>>>
>>> @@ -1700,6 +1706,7 @@ void qemu_system_reset(bool report)
>>>          qemu_devices_reset();
>>>      }
>>>      if (report) {
>>> +        assert(reason);
>>>          qapi_event_send_reset(&error_abort);
>>>      }
>>>      cpu_synchronize_all_post_reset();
>> 
>> Looks like we're not using @reason "for details" just yet.
>
> Correct. I can add a FIXME (to be removed in the later patch where it is
> used) if that is desired.

Not necessary if the function comment refrains from claiming it *is*
used.

>>> @@ -1807,7 +1815,7 @@ void qemu_system_killed(int signal, pid_t pid)
>>>      /* Cannot call qemu_system_shutdown_request directly because
>>>       * we are in a signal handler.
>>>       */
>>> -    shutdown_requested = 1;
>>> +    shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;
>> 
>> Should this be SHUTDOWN_CAUSE_HOST_ERROR, to be updated in the next
>> patch?  Alternatively, tweak this patch's commit message?
>
> This is the one case that we actually do have a strong cause affiliated
> with the reason without having to resort to changing function
> signatures.  Commit message tweak is better.

Works for me.

>>> @@ -1846,13 +1855,16 @@ void qemu_system_debug_request(void)
>>>  static bool main_loop_should_exit(void)
>>>  {
>>>      RunState r;
>>> +    ShutdownCause request;
>>> +
>>>      if (qemu_debug_requested()) {
>>>          vm_stop(RUN_STATE_DEBUG);
>>>      }
>>>      if (qemu_suspend_requested()) {
>>>          qemu_system_suspend();
>>>      }
>>> -    if (qemu_shutdown_requested()) {
>>> +    request = qemu_shutdown_requested();
>>> +    if (request) {
>>>          qemu_kill_report();
>>>          qapi_event_send_shutdown(&error_abort);
>>>          if (no_shutdown) {
>> 
>> The detour through @request appears isn't necessary here.  Perhaps you
>> do it for consistency with the next hunk.  Do you?  Just asking to make
>> sure I get what you're doing.
>
> Consistency with the next hunk, AND because a later patch then uses
> 'request' to pass an additional parameter to qapi_event_send_shutdown().
>
>> 
>> Hmm, there's another one in xen-hvm.c, but consistency hardly applies
>> there.  If later patches add more uses, you might want delay the change
>> until then.
>
> Can do, if it makes incremental reviews easier.

Use your judgement.

>>> +++ b/migration/savevm.c
>>> @@ -2300,7 +2300,7 @@ int load_vmstate(const char *name)
>>>          return -EINVAL;
>>>      }
>>>
>>> -    qemu_system_reset(VMRESET_SILENT);
>>> +    qemu_system_reset(VMRESET_SILENT, SHUTDOWN_CAUSE_NONE);
>>>      mis->from_src_file = f;
>>>
>>>      aio_context_acquire(aio_context);
>> 
>> You seem to be passing SHUTDOWN_CAUSE_NONE exactly with VMRESET_SILENT.
>> Would it be possible to have SHUTDOWN_CAUSE_NONE imply !report, any
>> other case imply report, and get rid of the first parameter?
>
> Indeed, and it would also get rid of the ugly
>  #define VMRESET_SILENT false

I'd love that.
