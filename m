Received: from eggs.gnu.org ([2001:4830:134:3::10]:51809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIwFP-0004xV-Tg
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIwFM-0007oJ-NJ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:13:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36862
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fIwFM-0007nh-H0
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:13:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4GD9dlh099506
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:13:35 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j0k82wrts-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 09:13:35 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Wed, 16 May 2018 09:13:34 -0400
References: <20180515140944.15979-1-danielhb@linux.ibm.com>
	<20180515140944.15979-2-danielhb@linux.ibm.com>
	<87zi10udl9.fsf@dusky.pond.sub.org>
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Wed, 16 May 2018 10:13:28 -0300
MIME-Version: 1.0
In-Reply-To: <87zi10udl9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <061a0f45-857c-3210-9fb2-af2469eb7956@linux.ibm.com>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com



On 05/15/2018 12:45 PM, Markus Armbruster wrote:
> Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:
>
>> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
>> nutshell is:
>>
>> - qmp_system_wakeup_request set runstate to RUNNING, sets a wakeup_rea=
son
>> and notify the event
>> - in the main_loop, all vcpus are paused, a system reset is issued, al=
l
>> subscribers of wakeup_notifiers receives a notification, vcpus are the=
n
>> resumed and the wake up QAPI event is fired
>>
>> Note that this procedure alone doesn't ensure that the guest will awak=
e
>> from SUSPENDED state - the subscribers of the wake up event must take
>> action to resume the guest, otherwise the guest will simply reboot.
>>
>> At this moment there are only two subscribers of the wake up event: on=
e
>> in hw/acpi/core.c and another one in hw/i386/xen/xen-hvm.c. This means
>> that system_wakeup does not work as intended with other architectures.
>>
>> However, only the presence of 'system_wakeup' is required for QGA to
>> support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
>> This means that the user/management will expect to suspend the guest u=
sing
>> one of those suspend commands and then resume execution using system_w=
akeup,
>> regardless of the support offered in system_wakeup in the first place.
>>
>> This patch adds a new flag called 'wakeup-suspend-support' in TargetIn=
fo
>> that allows the caller to query if the guest supports wake up from
>> suspend via system_wakeup. It goes over the subscribers of the wake up
>> event and, if it's empty, it assumes that the guest does not support
>> wake up from suspend (and thus, pm-suspend itself).
>>
>> This is the expected output of query-target when running a x86 guest:
>>
>> {"execute" : "query-target"}
>> {"return": {"arch": "x86_64", "wakeup-suspend-support": true}}
>>
>> This is the output when running a pseries guest:
>>
>> {"execute" : "query-target"}
>> {"return": {"arch": "ppc64", "wakeup-suspend-support": false}}
>>
>> Given that the TargetInfo structure is read-only, adding a new flag to
>> it is backwards compatible. There is no need to deprecate the old
>> TargetInfo format.
>>
>> With this extra tool, management can avoid situations where a guest
>> that does not have proper suspend/wake capabilities ends up in
>> inconsistent state (e.g.
>> https://github.com/open-power-host-os/qemu/issues/31).
>>
>> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
>> ---
>>   arch_init.c             |  1 +
>>   include/sysemu/sysemu.h |  1 +
>>   qapi/misc.json          |  4 +++-
>>   vl.c                    | 21 +++++++++++++++++++++
>>   4 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch_init.c b/arch_init.c
>> index 9597218ced..67bdf27528 100644
>> --- a/arch_init.c
>> +++ b/arch_init.c
>> @@ -115,6 +115,7 @@ TargetInfo *qmp_query_target(Error **errp)
>>  =20
>>       info->arch =3D qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME=
, -1,
>>                                    &error_abort);
>> +    info->wakeup_suspend_support =3D !qemu_wakeup_notifier_is_empty()=
;
> Huh?  Hmm, see "hack" below.
>
>>  =20
>>       return info;
>>   }
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 544ab77a2b..fbe2a3373e 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -69,6 +69,7 @@ typedef enum WakeupReason {
>>   void qemu_system_reset_request(ShutdownCause reason);
>>   void qemu_system_suspend_request(void);
>>   void qemu_register_suspend_notifier(Notifier *notifier);
>> +bool qemu_wakeup_notifier_is_empty(void);
>>   void qemu_system_wakeup_request(WakeupReason reason);
>>   void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
>>   void qemu_register_wakeup_notifier(Notifier *notifier);
>> diff --git a/qapi/misc.json b/qapi/misc.json
>> index f5988cc0b5..a385d897ae 100644
>> --- a/qapi/misc.json
>> +++ b/qapi/misc.json
>> @@ -2484,11 +2484,13 @@
>>   # Information describing the QEMU target.
>>   #
>>   # @arch: the target architecture
>> +# @wakeup-suspend-support: true if the target supports wake up from
>> +#                          suspend (since 2.13)
>>   #
>>   # Since: 1.2.0
>>   ##
>>   { 'struct': 'TargetInfo',
>> -  'data': { 'arch': 'SysEmuTarget' } }
>> +  'data': { 'arch': 'SysEmuTarget', 'wakeup-suspend-support': 'bool' =
} }
>>  =20
>>   ##
>>   # @query-target:
> Does the documentation of system_wakeup need fixing?
>
>     ##
>     # @system_wakeup:
>     #
>     # Wakeup guest from suspend.  Does nothing in case the guest isn't =
suspended.
>     #
>     # Since:  1.1
>     #
>     # Returns:  nothing.
>     #
>     # Example:
>     #
>     # -> { "execute": "system_wakeup" }
>     # <- { "return": {} }
>     #
>     ##
>     { 'command': 'system_wakeup' }
>
> I figure we better explain right here what the command does, both for
> wakeup-suspend-support: false and true.

Hmm, I've re-sent a patch that changes a bit the behavior of system_wakeu=
p
yesterday. The command should now fail with an error if the VM isn't in
SUSPENDED state. However, I failed to update this documentation
in that patch.

What if I resend that system_wakeup patch with the updated documentation=20
such
as:


    ##
    # @system_wakeup:
    #
    # Wakeup guest from suspend.  Throws an error in case the guest isn't=
 suspended.
    #
    # Since:  1.1
    #
    # Returns:  nothing if succeed
    #


And then I believe we don't need to update this doc again - if the guest=20
isn't suspended,
 =C2=A0system_wakeup will still fire up an error.

In fact, I could have added that patch in this series too since it kind=20
of relates with these
changes as well. Let me know if you think it helps and I'll respin it=20
together with this
series.

>> diff --git a/vl.c b/vl.c
>> index 3b39bbd7a8..ab6bd7e090 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -1832,11 +1832,32 @@ void qemu_system_wakeup_enable(WakeupReason re=
ason, bool enabled)
>>       }
>>   }
>>  =20
>> +/* The existence of a wake-up notifier is being checked in the functi=
on
> Please wing both ends of this comment:
>
>     /*
>      * The existence of a wake-up notifier is being checked in the func=
tion

ok!

>
>> + * qemu_wakeup_notifier_is_empty and it's used in the logic of the
>> + * wakeup-suspend-support flag of QMP 'query-target' command. The ide=
a
>> + * of this flag is to indicate whether the guest supports wake-up fro=
m
>> + * suspend (via system_wakeup QMP/HMP call for example), warning the =
user
>> + * that the guest can't handle both wake-up from suspend and the susp=
end
>> + * itself via QGA guest-suspend-ram and guest-suspend-hybrid (if it
>> + * can't wake up, it can't be suspended safely).
>> + *
>> + * An assumption is made by the wakeup-suspend-support flag that only=
 the
>> + * guests that can go to RUN_STATE_SUSPENDED and wake up properly wou=
ld
>> + * be interested in this wakeup_notifier. Adding a wakeup_notifier fo=
r
>> + * any other reason will break the logic of the wakeup-suspend-suppor=
t
>> + * flag and can lead to user/management confusion about the suspend/w=
ake-up
>> + * support of the guest.
>> + */
> The assumption is a bit of a hack, but I don't have better ideas.
> Thanks for commenting it clearly.  However, ...
>
>>   void qemu_register_wakeup_notifier(Notifier *notifier)
>>   {
>>       notifier_list_add(&wakeup_notifiers, notifier);
>>   }
>>  =20
>> +bool qemu_wakeup_notifier_is_empty(void)
>> +{
>> +    return QLIST_EMPTY(&wakeup_notifiers.notifiers);
>> +}
>> +
>>   void qemu_system_killed(int signal, pid_t pid)
>>   {
>>       shutdown_signal =3D signal;
> ... I'd recommend to rename qemu_wakeup_notifier_is_empty() to
> qemu_wakeup_suspend_support(), because then the hack is a bit more
> isolated.  With the current name, it spills into qmp_query_target(),
> which doesn't have such a helpful comment.

I'll rename it in the next spin.

>
