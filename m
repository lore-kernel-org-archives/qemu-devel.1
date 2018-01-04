Received: from eggs.gnu.org ([2001:4830:134:3::10]:57107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eXE22-0002JC-2K
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 17:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eXE1y-0005vw-QE
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 17:30:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38340
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eXE1y-0005vB-4q
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 17:30:34 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w04MScK3114066
	for <qemu-devel@nongnu.org>; Thu, 4 Jan 2018 17:30:31 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f9rs7jevu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 17:30:31 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 4 Jan 2018 17:30:30 -0500
References: <20180103115455.25843-1-danielhb@linux.vnet.ibm.com>
	<20180103115455.25843-2-danielhb@linux.vnet.ibm.com>
	<151510322624.2579.8984005167302810474@sif>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 4 Jan 2018 20:30:25 -0200
MIME-Version: 1.0
In-Reply-To: <151510322624.2579.8984005167302810474@sif>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <47de114e-888c-237b-6974-1a2162a3e0a5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qmp: adding
 'wakeup-suspend-support' in query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com



On 01/04/2018 08:00 PM, Michael Roth wrote:
> Quoting Daniel Henrique Barboza (2018-01-03 05:54:54)
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
>> action to resume the guest, otherwise the guest will simply reboot.
>>
>> At this moment there are only two subscribers of the wake up event: one
>> in hw/acpi/core.c and another one in hw/i386/xen/xen-hvm.c. This means
>> that system_wakeup does not work as intended with other architectures.
>>
>> However, only the presence of 'system_wakeup' is required for QGA to
>> support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
>> This means that the user/management will expect to suspend the guest using
>> one of those suspend commands and then resume execution using system_wakeup,
>> regardless of the support offered in system_wakeup in the first place.
>>
>> This patch adds a new flag called 'wakeup-suspend-support' in TargetInfo
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
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Looks good to me, but I'm a little concerned that someone might
> register a wakeup notifier in the future for some reason other than
> actually supporting wakeup (perhaps as an informational thing, or as
> as part of some change to general lifecycle event tracking). I'm not
> sure it's currently worth adding an explicit flag that users need to
> set, but maybe at least some comments around
> qemu_register_wakeup_notifier() noting the potential side-effects of
> doing such a thing would be warranted.

Noted. I'll add a disclaimer in qemu_register_wakeup_notifier to
inform that the presence/absence of a notifier is being used to
determine whether an architecture supports wake up from suspend. That
way we can at least inform what will happen if someone adds
a new notifier without including the proper support.


Thanks,

Daniel
>
>> ---
>>   arch_init.c             | 1 +
>>   include/sysemu/sysemu.h | 1 +
>>   qapi-schema.json        | 4 +++-
>>   vl.c                    | 5 +++++
>>   4 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch_init.c b/arch_init.c
>> index a0b8ed6167..9c5c519d9d 100644
>> --- a/arch_init.c
>> +++ b/arch_init.c
>> @@ -109,6 +109,7 @@ TargetInfo *qmp_query_target(Error **errp)
>>       TargetInfo *info = g_malloc0(sizeof(*info));
>>
>>       info->arch = g_strdup(TARGET_NAME);
>> +    info->wakeup_suspend_support = !qemu_wakeup_notifier_is_empty();
>>
>>       return info;
>>   }
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 31612caf10..b15374e0b8 100644
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
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 5c06745c79..2f1c08fde7 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -2388,11 +2388,13 @@
>>   # Information describing the QEMU target.
>>   #
>>   # @arch: the target architecture (eg "x86_64", "i386", etc)
>> +# @wakeup-suspend-support: true if the target supports wake up from
>> +#                          suspend (since 2.12)
>>   #
>>   # Since: 1.2.0
>>   ##
>>   { 'struct': 'TargetInfo',
>> -  'data': { 'arch': 'str' } }
>> +  'data': { 'arch': 'str', 'wakeup-suspend-support': 'bool' } }
>>
>>   ##
>>   # @query-target:
>> diff --git a/vl.c b/vl.c
>> index d3a5c5d021..871c1f9bd1 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -1844,6 +1844,11 @@ void qemu_register_wakeup_notifier(Notifier *notifier)
>>       notifier_list_add(&wakeup_notifiers, notifier);
>>   }
>>
>> +bool qemu_wakeup_notifier_is_empty(void)
>> +{
>> +    return QLIST_EMPTY(&wakeup_notifiers.notifiers);
>> +}
>> +
>>   void qemu_system_killed(int signal, pid_t pid)
>>   {
>>       shutdown_signal = signal;
>> -- 
>> 2.13.6
>>
>
