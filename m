Received: from eggs.gnu.org ([2001:4830:134:3::10]:60685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSetk-0007Ng-4J
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gSetf-0003c0-9r
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:15:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gSetf-0003Zp-1W
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:15:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181031115242.6558-1-d.csapak@proxmox.com>
	<20181031115242.6558-2-d.csapak@proxmox.com>
	<87efb3lz2r.fsf@dusky.pond.sub.org>
Date: Fri, 30 Nov 2018 10:15:36 +0100
In-Reply-To: <87efb3lz2r.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 30 Nov 2018 10:00:28 +0100")
Message-ID: <871s73lydj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: move ShutdownCause to
 qapi/run-state.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

One more thing...

Markus Armbruster <armbru@redhat.com> writes:

> Dominik Csapak <d.csapak@proxmox.com> writes:
>
>> this makes it possible to use the reason as return value
>> in a QMP event, such as SHUTDOWN
>
> Please start your sentences with a capital letter and end them with
> punctuation.
>
> The patch's purpose could perhaps be stated a bit more clearly.  Let me
> try:
>
>   qapi: Turn ShutdownCause into a QAPI enum
>
>   Needed so the patch after next can add ShutdownCause to QMP events
>   SHUTDOWN and RESET.
>
>> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
>> ---
>>  include/sysemu/sysemu.h | 20 --------------------
>>  qapi/run-state.json     | 33 +++++++++++++++++++++++++++++++++
>>  2 files changed, 33 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 8d6095d98b..f83522c7e7 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -31,26 +31,6 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>>  void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
>>  void vm_state_notify(int running, RunState state);
>>  
>> -/* Enumeration of various causes for shutdown. */
>> -typedef enum ShutdownCause {
>> -    SHUTDOWN_CAUSE_NONE,          /* No shutdown request pending */
>> -    SHUTDOWN_CAUSE_HOST_ERROR,    /* An error prevents further use of guest */
>> -    SHUTDOWN_CAUSE_HOST_QMP,      /* Reaction to a QMP command, like 'quit' */
>> -    SHUTDOWN_CAUSE_HOST_SIGNAL,   /* Reaction to a signal, such as SIGINT */
>> -    SHUTDOWN_CAUSE_HOST_UI,       /* Reaction to UI event, like window close */
>> -    SHUTDOWN_CAUSE_GUEST_SHUTDOWN,/* Guest shutdown/suspend request, via
>> -                                     ACPI or other hardware-specific means */
>> -    SHUTDOWN_CAUSE_GUEST_RESET,   /* Guest reset request, and command line
>> -                                     turns that into a shutdown */
>> -    SHUTDOWN_CAUSE_GUEST_PANIC,   /* Guest panicked, and command line turns
>> -                                     that into a shutdown */
>> -    SHUTDOWN_CAUSE_SUBSYSTEM_RESET,/* Partial guest reset that does not trigger
>> -                                      QMP events and ignores --no-reboot. This
>> -                                      is useful for sanitize hypercalls on s390
>> -                                      that are used during kexec/kdump/boot */
>> -    SHUTDOWN_CAUSE__MAX,
>> -} ShutdownCause;
>> -
>>  static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>>  {
>>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;

Because of this, order matters.  Your patch moves the enumeration away,
so readers get even less of a chance to catch this.

>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index 332e44897b..883bed167c 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -60,6 +60,39 @@
>>              'guest-panicked', 'colo', 'preconfig' ] }
>>  
>>  ##
>> +# @ShutdownCause:
>> +#
>> +# An enumeration of reasons for a Shutdown.
>> +#
>> +# @none: No shutdown request pending
>> +#
>> +# @host-error: An error prevented further use of guest
>
> Any particular reason for changing the tense from "prevents" to
> "prevented"?
>
>> +#
>> +# @host-qmp: Reaction to a QMP command, like 'quit'
>> +#
>> +# @host-signal: Reaction to a signal, such as SIGINT
>> +#
>> +# @host-ui: Reaction to a UI event, like window close
>> +#
>> +# @guest-shutdown: Guest shutdown/suspend request, via ACPI or other
>> +#                  hardware-specific means
>> +#
>> +# @guest-reset: Guest reset request, and command line turns that into
>> +#               a shutdown
>> +#
>> +# @guest-panic: Guest panicked, and command line turns that into a shutdown
>> +#
>> +# @subsystem-reset: Partial guest reset that does not trigger QMP events and
>> +#                  ignores --no-reboot. This is useful for sanitizing
>> +#                  hypercalls on s390 that are used during kexec/kdump/boot
>> +#
>> +##
>> +{ 'enum': 'ShutdownCause',

Let's add

       # Beware, shutdown_caused_by_guest() depends on enumeration order

here.  Adding it to the doc comment above would be no good, because
that's external documentation (it would end up in the QEMU QMP reference
manual).

>> +  'data': [ 'none', 'host-error', 'host-qmp', 'host-signal', 'host-ui',
>> +            'guest-shutdown', 'guest-reset', 'guest-panic',
>> +            'subsystem-reset'] }
>> +
>> +##
>>  # @StatusInfo:
>>  #
>>  # Information about VCPU run state
