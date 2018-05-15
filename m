Received: from eggs.gnu.org ([2001:4830:134:3::10]:41071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIc9G-0002qx-44
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIc9E-0005Es-8J
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:45:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fIc9E-0005ES-3E
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:45:56 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180515140944.15979-1-danielhb@linux.ibm.com>
	<20180515140944.15979-2-danielhb@linux.ibm.com>
Date: Tue, 15 May 2018 17:45:54 +0200
In-Reply-To: <20180515140944.15979-2-danielhb@linux.ibm.com> (Daniel Henrique
	Barboza's message of "Tue, 15 May 2018 11:09:43 -0300")
Message-ID: <87zi10udl9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com

Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:

> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
> nutshell is:
>
> - qmp_system_wakeup_request set runstate to RUNNING, sets a wakeup_reason
> and notify the event
> - in the main_loop, all vcpus are paused, a system reset is issued, all
> subscribers of wakeup_notifiers receives a notification, vcpus are then
> resumed and the wake up QAPI event is fired
>
> Note that this procedure alone doesn't ensure that the guest will awake
> from SUSPENDED state - the subscribers of the wake up event must take
> action to resume the guest, otherwise the guest will simply reboot.
>
> At this moment there are only two subscribers of the wake up event: one
> in hw/acpi/core.c and another one in hw/i386/xen/xen-hvm.c. This means
> that system_wakeup does not work as intended with other architectures.
>
> However, only the presence of 'system_wakeup' is required for QGA to
> support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
> This means that the user/management will expect to suspend the guest using
> one of those suspend commands and then resume execution using system_wakeup,
> regardless of the support offered in system_wakeup in the first place.
>
> This patch adds a new flag called 'wakeup-suspend-support' in TargetInfo
> that allows the caller to query if the guest supports wake up from
> suspend via system_wakeup. It goes over the subscribers of the wake up
> event and, if it's empty, it assumes that the guest does not support
> wake up from suspend (and thus, pm-suspend itself).
>
> This is the expected output of query-target when running a x86 guest:
>
> {"execute" : "query-target"}
> {"return": {"arch": "x86_64", "wakeup-suspend-support": true}}
>
> This is the output when running a pseries guest:
>
> {"execute" : "query-target"}
> {"return": {"arch": "ppc64", "wakeup-suspend-support": false}}
>
> Given that the TargetInfo structure is read-only, adding a new flag to
> it is backwards compatible. There is no need to deprecate the old
> TargetInfo format.
>
> With this extra tool, management can avoid situations where a guest
> that does not have proper suspend/wake capabilities ends up in
> inconsistent state (e.g.
> https://github.com/open-power-host-os/qemu/issues/31).
>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
> ---
>  arch_init.c             |  1 +
>  include/sysemu/sysemu.h |  1 +
>  qapi/misc.json          |  4 +++-
>  vl.c                    | 21 +++++++++++++++++++++
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch_init.c b/arch_init.c
> index 9597218ced..67bdf27528 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -115,6 +115,7 @@ TargetInfo *qmp_query_target(Error **errp)
>  
>      info->arch = qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, -1,
>                                   &error_abort);
> +    info->wakeup_suspend_support = !qemu_wakeup_notifier_is_empty();

Huh?  Hmm, see "hack" below.

>  
>      return info;
>  }
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 544ab77a2b..fbe2a3373e 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -69,6 +69,7 @@ typedef enum WakeupReason {
>  void qemu_system_reset_request(ShutdownCause reason);
>  void qemu_system_suspend_request(void);
>  void qemu_register_suspend_notifier(Notifier *notifier);
> +bool qemu_wakeup_notifier_is_empty(void);
>  void qemu_system_wakeup_request(WakeupReason reason);
>  void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
>  void qemu_register_wakeup_notifier(Notifier *notifier);
> diff --git a/qapi/misc.json b/qapi/misc.json
> index f5988cc0b5..a385d897ae 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2484,11 +2484,13 @@
>  # Information describing the QEMU target.
>  #
>  # @arch: the target architecture
> +# @wakeup-suspend-support: true if the target supports wake up from
> +#                          suspend (since 2.13)
>  #
>  # Since: 1.2.0
>  ##
>  { 'struct': 'TargetInfo',
> -  'data': { 'arch': 'SysEmuTarget' } }
> +  'data': { 'arch': 'SysEmuTarget', 'wakeup-suspend-support': 'bool' } }
>  
>  ##
>  # @query-target:

Does the documentation of system_wakeup need fixing?

   ##
   # @system_wakeup:
   #
   # Wakeup guest from suspend.  Does nothing in case the guest isn't suspended.
   #
   # Since:  1.1
   #
   # Returns:  nothing.
   #
   # Example:
   #
   # -> { "execute": "system_wakeup" }
   # <- { "return": {} }
   #
   ##
   { 'command': 'system_wakeup' }

I figure we better explain right here what the command does, both for
wakeup-suspend-support: false and true.

> diff --git a/vl.c b/vl.c
> index 3b39bbd7a8..ab6bd7e090 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1832,11 +1832,32 @@ void qemu_system_wakeup_enable(WakeupReason reason, bool enabled)
>      }
>  }
>  
> +/* The existence of a wake-up notifier is being checked in the function

Please wing both ends of this comment:

   /*
    * The existence of a wake-up notifier is being checked in the function

> + * qemu_wakeup_notifier_is_empty and it's used in the logic of the
> + * wakeup-suspend-support flag of QMP 'query-target' command. The idea
> + * of this flag is to indicate whether the guest supports wake-up from
> + * suspend (via system_wakeup QMP/HMP call for example), warning the user
> + * that the guest can't handle both wake-up from suspend and the suspend
> + * itself via QGA guest-suspend-ram and guest-suspend-hybrid (if it
> + * can't wake up, it can't be suspended safely).
> + *
> + * An assumption is made by the wakeup-suspend-support flag that only the
> + * guests that can go to RUN_STATE_SUSPENDED and wake up properly would
> + * be interested in this wakeup_notifier. Adding a wakeup_notifier for
> + * any other reason will break the logic of the wakeup-suspend-support
> + * flag and can lead to user/management confusion about the suspend/wake-up
> + * support of the guest.
> + */

The assumption is a bit of a hack, but I don't have better ideas.
Thanks for commenting it clearly.  However, ...

>  void qemu_register_wakeup_notifier(Notifier *notifier)
>  {
>      notifier_list_add(&wakeup_notifiers, notifier);
>  }
>  
> +bool qemu_wakeup_notifier_is_empty(void)
> +{
> +    return QLIST_EMPTY(&wakeup_notifiers.notifiers);
> +}
> +
>  void qemu_system_killed(int signal, pid_t pid)
>  {
>      shutdown_signal = signal;

... I'd recommend to rename qemu_wakeup_notifier_is_empty() to
qemu_wakeup_suspend_support(), because then the hack is a bit more
isolated.  With the current name, it spills into qmp_query_target(),
which doesn't have such a helpful comment.
