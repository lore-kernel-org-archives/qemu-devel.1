Received: from eggs.gnu.org ([2001:4830:134:3::10]:55678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJEWS-0004YM-Di
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJEWP-0000nF-93
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:44:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fJEWO-0000mp-Vk
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:44:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180515140944.15979-1-danielhb@linux.ibm.com>
	<20180515140944.15979-2-danielhb@linux.ibm.com>
	<87zi10udl9.fsf@dusky.pond.sub.org>
	<061a0f45-857c-3210-9fb2-af2469eb7956@linux.ibm.com>
Date: Thu, 17 May 2018 10:44:22 +0200
In-Reply-To: <061a0f45-857c-3210-9fb2-af2469eb7956@linux.ibm.com> (Daniel
	Henrique Barboza's message of "Wed, 16 May 2018 10:13:28 -0300")
Message-ID: <871seaoemx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/2] qmp: adding
 'wakeup-suspend-support' in query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:

> On 05/15/2018 12:45 PM, Markus Armbruster wrote:
>> Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:
>>
>>> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
>>> nutshell is:
>>>
>>> - qmp_system_wakeup_request set runstate to RUNNING, sets a wakeup_reas=
on
>>> and notify the event
>>> - in the main_loop, all vcpus are paused, a system reset is issued, all
>>> subscribers of wakeup_notifiers receives a notification, vcpus are then
>>> resumed and the wake up QAPI event is fired
>>>
>>> Note that this procedure alone doesn't ensure that the guest will awake
>>> from SUSPENDED state - the subscribers of the wake up event must take
>>> action to resume the guest, otherwise the guest will simply reboot.
>>>
>>> At this moment there are only two subscribers of the wake up event: one
>>> in hw/acpi/core.c and another one in hw/i386/xen/xen-hvm.c. This means
>>> that system_wakeup does not work as intended with other architectures.
>>>
>>> However, only the presence of 'system_wakeup' is required for QGA to
>>> support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
>>> This means that the user/management will expect to suspend the guest us=
ing
>>> one of those suspend commands and then resume execution using system_wa=
keup,
>>> regardless of the support offered in system_wakeup in the first place.
>>>
>>> This patch adds a new flag called 'wakeup-suspend-support' in TargetInfo
>>> that allows the caller to query if the guest supports wake up from
>>> suspend via system_wakeup. It goes over the subscribers of the wake up
>>> event and, if it's empty, it assumes that the guest does not support
>>> wake up from suspend (and thus, pm-suspend itself).
>>>
>>> This is the expected output of query-target when running a x86 guest:
>>>
>>> {"execute" : "query-target"}
>>> {"return": {"arch": "x86_64", "wakeup-suspend-support": true}}
>>>
>>> This is the output when running a pseries guest:
>>>
>>> {"execute" : "query-target"}
>>> {"return": {"arch": "ppc64", "wakeup-suspend-support": false}}
>>>
>>> Given that the TargetInfo structure is read-only, adding a new flag to
>>> it is backwards compatible. There is no need to deprecate the old
>>> TargetInfo format.
>>>
>>> With this extra tool, management can avoid situations where a guest
>>> that does not have proper suspend/wake capabilities ends up in
>>> inconsistent state (e.g.
>>> https://github.com/open-power-host-os/qemu/issues/31).
>>>
>>> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
>>> ---
>>>   arch_init.c             |  1 +
>>>   include/sysemu/sysemu.h |  1 +
>>>   qapi/misc.json          |  4 +++-
>>>   vl.c                    | 21 +++++++++++++++++++++
>>>   4 files changed, 26 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch_init.c b/arch_init.c
>>> index 9597218ced..67bdf27528 100644
>>> --- a/arch_init.c
>>> +++ b/arch_init.c
>>> @@ -115,6 +115,7 @@ TargetInfo *qmp_query_target(Error **errp)
>>>         info->arch =3D qapi_enum_parse(&SysEmuTarget_lookup,
>>> TARGET_NAME, -1,
>>>                                    &error_abort);
>>> +    info->wakeup_suspend_support =3D !qemu_wakeup_notifier_is_empty();
>> Huh?  Hmm, see "hack" below.
>>
>>>         return info;
>>>   }
>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>> index 544ab77a2b..fbe2a3373e 100644
>>> --- a/include/sysemu/sysemu.h
>>> +++ b/include/sysemu/sysemu.h
>>> @@ -69,6 +69,7 @@ typedef enum WakeupReason {
>>>   void qemu_system_reset_request(ShutdownCause reason);
>>>   void qemu_system_suspend_request(void);
>>>   void qemu_register_suspend_notifier(Notifier *notifier);
>>> +bool qemu_wakeup_notifier_is_empty(void);
>>>   void qemu_system_wakeup_request(WakeupReason reason);
>>>   void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
>>>   void qemu_register_wakeup_notifier(Notifier *notifier);
>>> diff --git a/qapi/misc.json b/qapi/misc.json
>>> index f5988cc0b5..a385d897ae 100644
>>> --- a/qapi/misc.json
>>> +++ b/qapi/misc.json
>>> @@ -2484,11 +2484,13 @@
>>>   # Information describing the QEMU target.
>>>   #
>>>   # @arch: the target architecture
>>> +# @wakeup-suspend-support: true if the target supports wake up from
>>> +#                          suspend (since 2.13)
>>>   #
>>>   # Since: 1.2.0
>>>   ##
>>>   { 'struct': 'TargetInfo',
>>> -  'data': { 'arch': 'SysEmuTarget' } }
>>> +  'data': { 'arch': 'SysEmuTarget', 'wakeup-suspend-support': 'bool' }=
 }
>>>     ##
>>>   # @query-target:
>> Does the documentation of system_wakeup need fixing?
>>
>>     ##
>>     # @system_wakeup:
>>     #
>>     # Wakeup guest from suspend.  Does nothing in case the guest isn't s=
uspended.
>>     #
>>     # Since:  1.1
>>     #
>>     # Returns:  nothing.
>>     #
>>     # Example:
>>     #
>>     # -> { "execute": "system_wakeup" }
>>     # <- { "return": {} }
>>     #
>>     ##
>>     { 'command': 'system_wakeup' }
>>
>> I figure we better explain right here what the command does, both for
>> wakeup-suspend-support: false and true.
>
> Hmm, I've re-sent a patch that changes a bit the behavior of system_wakeup
> yesterday. The command should now fail with an error if the VM isn't in
> SUSPENDED state. However, I failed to update this documentation
> in that patch.
>
> What if I resend that system_wakeup patch with the updated
> documentation such
> as:
>
>
>    ##
>    # @system_wakeup:
>    #
>    # Wakeup guest from suspend.  Throws an error in case the guest isn't =
suspended.
>    #
>    # Since:  1.1
>    #
>    # Returns:  nothing if succeed
>    #
>
>
> And then I believe we don't need to update this doc again - if the
> guest isn't suspended,
> =C2=A0system_wakeup will still fire up an error.

What about a guest that is suspended under a QEMU that isn't capable of
waking it?

Shouldn't system_wakeup's documentation point to query-target's
wakeup-suspend-support?

> In fact, I could have added that patch in this series too since it
> kind of relates with these
> changes as well. Let me know if you think it helps and I'll respin it
> together with this
> series.

Respinning in a single series is the simplest way to ensure the patches
get committed in a sane order.  I'd appreciate that.

[...]
