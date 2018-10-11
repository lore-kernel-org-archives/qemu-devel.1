Received: from eggs.gnu.org ([2001:4830:134:3::10]:37185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gAZlt-00064A-Px
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gAZls-0002py-IS
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:08:53 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:37113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gAZls-0002pX-Cs
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:08:52 -0400
Received: by mail-qt1-x844.google.com with SMTP id d14-v6so9469355qto.4
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:08:51 -0700 (PDT)
References: <20180918185246.18109-1-danielhb413@gmail.com>
	<20180918185246.18109-2-danielhb413@gmail.com>
	<87a7nl7x12.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <214c0ceb-4d0f-5a9f-b926-f8d374d8f0f8@gmail.com>
Date: Thu, 11 Oct 2018 09:08:45 -0300
MIME-Version: 1.0
In-Reply-To: <87a7nl7x12.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v9 1/3] qmp: query-current-machine with
 wakeup-suspend-support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com



On 10/11/18 4:38 AM, Markus Armbruster wrote:
> Daniel Henrique Barboza <danielhb413@gmail.com> writes:
>
>> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
>> nutshell is:
>>
>> - qmp_system_wakeup_request set runstate to RUNNING, sets a wakeup_reason
>> and notify the event
>> - in the main_loop, all vcpus are paused, a system reset is issued, all
>> subscribers of wakeup_notifiers receives a notification, vcpus are then
>> resumed and the wake up QAPI event is fired
>>
>> Note that this procedure alone doesn't ensure that the guest will awake
>> from SUSPENDED state - the subscribers of the wake up event must take
>> action to resume the guest, otherwise the guest will simply reboot. At
>> this moment, only the ACPI machines via acpi_pm1_cnt_init has wake-up
>> from suspend support.
>>
>> However, only the presence of 'system_wakeup' is required for QGA to
>> support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
>> This means that the user/management will expect to suspend the guest using
>> one of those suspend commands and then resume execution using system_wakeup,
>> regardless of the support offered in system_wakeup in the first place.
>>
>> This patch creates a new API called query-current-machine [1], that holds
>> a new flag called 'wakeup-suspend-support' that indicates if the guest
>> supports wake up from suspend via system_wakeup. The machine is considered
>> to implement wake-up support if a call to a new 'qemu_register_wakeup_support'
>> is made during its init, as it is now being done inside acpi_pm1_cnt_init.
>> This allows for any other machine type to declare wake-up support regardless
>> of ACPI state or wakeup_notifiers subscription, making easier for
>> newer implementations that might have its own mechanisms in the future.
>>
>> This is the expected output of query-current-machine when running a x86
>> guest:
>>
>> {"execute" : "query-current-machine"}
>> {"return": {"wakeup-suspend-support": true}}
>>
>> Running the same x86 guest, but with the --no-acpi option:
>>
>> {"execute" : "query-current-machine"}
>> {"return": {"wakeup-suspend-support": false}}
>>
>> This is the output when running a pseries guest:
>>
>> {"execute" : "query-current-machine"}
>> {"return": {"wakeup-suspend-support": false}}
>>
>> With this extra tool, management can avoid situations where a guest
>> that does not have proper suspend/wake capabilities ends up in
>> inconsistent state (e.g.
>> https://github.com/open-power-host-os/qemu/issues/31).
>>
>> [1] the decision of creating the query-current-machine API is based
>> on discussions in the QEMU mailing list where it was decided that
>> query-target wasn't a proper place to store the wake-up flag, neither
>> was query-machines because this isn't a static property of the
>> machine object. This new API can then be used to store other
>> dynamic machine properties that are scattered around the code
>> ATM. More info at:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04235.html
>>
>> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   hw/acpi/core.c          |  1 +
>>   include/sysemu/sysemu.h |  1 +
>>   qapi/misc.json          | 24 ++++++++++++++++++++++++
>>   vl.c                    | 19 +++++++++++++++++++
>>   4 files changed, 45 insertions(+)
>>
>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>> index b8d39012cd..2dea893245 100644
>> --- a/hw/acpi/core.c
>> +++ b/hw/acpi/core.c
>> @@ -617,6 +617,7 @@ void acpi_pm1_cnt_init(ACPIREGS *ar, MemoryRegion *parent,
>>       ar->pm1.cnt.s4_val = s4_val;
>>       ar->wakeup.notify = acpi_notify_wakeup;
>>       qemu_register_wakeup_notifier(&ar->wakeup);
>> +    qemu_register_wakeup_support();
>>       memory_region_init_io(&ar->pm1.cnt.io, memory_region_owner(parent),
>>                             &acpi_pm_cnt_ops, ar, "acpi-cnt", 2);
>>       memory_region_add_subregion(parent, 4, &ar->pm1.cnt.io);
> We might've discussed this before, not sure...  There's a second
> qemu_register_wakeup_notifier() in xen-hvm.c.  By not adding
> qemu_register_wakeup_support() there, you implicitly state that it
> doesn't provide wakeup support.  I have no idea whether that's true.  If
> it is, then I think the commit message should explain it.  We might even
> want a comment.  Please advise.

Not adding the wakeup notifier at xen-hvm.c was a mistake. I am under
the assumption that everyone that register a notifier is implementing
wakeup support, which seems reasonable to me (why else would you
want to listen to that event?). Simply put, I failed to check on all 
callers of
qemu_register_wakeup_notifier().

Thanks for noticing it.


>
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 8d6095d98b..0446adacc6 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -77,6 +77,7 @@ void qemu_register_suspend_notifier(Notifier *notifier);
>>   void qemu_system_wakeup_request(WakeupReason reason);
>>   void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
>>   void qemu_register_wakeup_notifier(Notifier *notifier);
>> +void qemu_register_wakeup_support(void);
>>   void qemu_system_shutdown_request(ShutdownCause reason);
>>   void qemu_system_powerdown_request(void);
>>   void qemu_register_powerdown_notifier(Notifier *notifier);
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index d450cfef21..b616d385a4 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -2003,6 +2003,30 @@
>>   ##
>>   { 'command': 'query-machines', 'returns': ['MachineInfo'] }
>>   
>> +##
>> +# @CurrentMachineParams:
>> +#
>> +# Information describing the running machine parameters.
>> +#
>> +# @wakeup-suspend-support: true if the target supports wake up from
> s/target/machine/

ok!

>
>> +#                          suspend
>> +#
>> +# Since: 3.1.0
>> +##
>> +{ 'struct': 'CurrentMachineParams',
>> +  'data': { 'wakeup-suspend-support': 'bool'} }
>> +
>> +##
>> +# @query-current-machine:
>> +#
>> +# Return a list of parameters of the running machine.
> "a list of" suggests it returns a QAPI list.  Let's say "Return
> information on the current virtual machine".

ok!

>
>> +#
>> +# Returns: CurrentMachineParams
>> +#
>> +# Since: 3.1.0
>> +##
>> +{ 'command': 'query-current-machine', 'returns': 'CurrentMachineParams' }
>> +
>>   ##
>>   # @CpuDefinitionInfo:
>>   #
>> diff --git a/vl.c b/vl.c
>> index 5ba06adf78..f78947f69c 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -184,6 +184,7 @@ bool boot_strict;
>>   uint8_t *boot_splash_filedata;
>>   size_t boot_splash_filedata_size;
>>   uint8_t qemu_extra_params_fw[2];
>> +bool wakeup_suspend_enabled;
>>   
>>   int icount_align_option;
>>   
>> @@ -1753,6 +1754,24 @@ void qemu_register_wakeup_notifier(Notifier *notifier)
>>       notifier_list_add(&wakeup_notifiers, notifier);
>>   }
>>   
>> +void qemu_register_wakeup_support(void)
>> +{
>> +    wakeup_suspend_enabled = true;
>> +}
>> +
>> +static bool qemu_wakeup_suspend_enabled(void)
>> +{
>> +    return wakeup_suspend_enabled;
>> +}
>> +
>> +CurrentMachineParams *qmp_query_current_machine(Error **errp)
>> +{
>> +    CurrentMachineParams *params = g_malloc0(sizeof(*params));
>> +    params->wakeup_suspend_support = qemu_wakeup_suspend_enabled();
>> +
>> +    return params;
>> +}
>> +
>>   void qemu_system_killed(int signal, pid_t pid)
>>   {
>>       shutdown_signal = signal;
