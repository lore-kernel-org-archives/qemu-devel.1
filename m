Received: from eggs.gnu.org ([2001:4830:134:3::10]:54581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAVfn-0005BS-Fz
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAVfj-0007NS-N7
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAVfb-0007Jy-RN
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:46:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180918185246.18109-1-danielhb413@gmail.com>
	<20180918185246.18109-4-danielhb413@gmail.com>
Date: Thu, 11 Oct 2018 09:45:59 +0200
In-Reply-To: <20180918185246.18109-4-danielhb413@gmail.com> (Daniel Henrique
	Barboza's message of "Tue, 18 Sep 2018 15:52:46 -0300")
Message-ID: <871s8x7wp4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 3/3] qmp hmp: Make system_wakeup check
 wake-up support and run state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com

Daniel Henrique Barboza <danielhb413@gmail.com> writes:

> The qmp/hmp command 'system_wakeup' is simply a direct call to
> 'qemu_system_wakeup_request' from vl.c. This function verifies if
> runstate is SUSPENDED and if the wake up reason is valid before
> proceeding. However, no error or warning is thrown if any of those
> pre-requirements isn't met. There is no way for the caller to
> differentiate between a successful wakeup or an error state caused
> when trying to wake up a guest that wasn't suspended.
>
> This means that system_wakeup is silently failing, which can be
> considered a bug. Adding error handling isn't an API break in this
> case - applications that didn't check the result will remain broken,
> the ones that check it will have a chance to deal with it.
>
> Adding to that, the commit before previous created a new QMP API called
> query-current-machine, with a new flag called wakeup-suspend-support,
> that indicates if the guest has the capability of waking up from suspended
> state. Although such guest will never reach SUSPENDED state and erroring
> it out in this scenario would suffice, it is more informative for the user
> to differentiate between a failure because the guest isn't suspended versus
> a failure because the guest does not have support for wake up at all.
>
> All this considered, this patch changes qmp_system_wakeup to:
>
> - check if the guest has the capability to wake-up from suspend. If
> not, error out informing about the lack of support;
>
> - make the runstate verification before proceeding to call
> qemu_system_wakeup_request, firing up an error message if the user tries
> to wake up a machine that isn't in SUSPENDED state.
>
> After this patch, this is the output of system_wakeup in a guest that
> does not have wake-up from suspend support (ppc64):
>
> (qemu) system_wakeup
> wake-up from suspend is not supported by this guest
> (qemu)
>
> And this is the output of system_wakeup in a x86 guest that has the
> support but isn't suspended:
>
> (qemu) system_wakeup
> Unable to wake up: guest is not in suspended state
> (qemu)
>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hmp.c                   |  5 ++++-
>  include/sysemu/sysemu.h |  1 +
>  qapi/misc.json          |  5 ++++-
>  qmp.c                   | 10 ++++++++++
>  vl.c                    |  2 +-
>  5 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/hmp.c b/hmp.c
> index 4975fa56b0..e98c24782f 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1203,7 +1203,10 @@ void hmp_cont(Monitor *mon, const QDict *qdict)
>  
>  void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
>  {
> -    qmp_system_wakeup(NULL);
> +    Error *err = NULL;
> +
> +    qmp_system_wakeup(&err);
> +    hmp_handle_error(mon, &err);
>  }
>  
>  void hmp_nmi(Monitor *mon, const QDict *qdict)
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 0446adacc6..8d91c5ad5b 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -74,6 +74,7 @@ void qemu_exit_preconfig_request(void);
>  void qemu_system_reset_request(ShutdownCause reason);
>  void qemu_system_suspend_request(void);
>  void qemu_register_suspend_notifier(Notifier *notifier);
> +bool qemu_wakeup_suspend_enabled(void);
>  void qemu_system_wakeup_request(WakeupReason reason);
>  void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
>  void qemu_register_wakeup_notifier(Notifier *notifier);
> diff --git a/qapi/misc.json b/qapi/misc.json
> index b616d385a4..2f5995f45f 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1230,7 +1230,10 @@
>  ##
>  # @system_wakeup:
>  #
> -# Wakeup guest from suspend.  Does nothing in case the guest isn't suspended.
> +# If the guest has wake-up from suspend support enabled
> +# (wakeup-suspend-support flag from query-current-machine), wakeup guest
> +# from suspend if the guest is in SUSPENDED state. Returns an error
> +# otherwise.

Perhaps a note that versions older than 3.1 neglected to report errors
would be helpful.

>  #
>  # Since:  1.1
>  #
> diff --git a/qmp.c b/qmp.c
> index e7c0a2fd60..44e619d1be 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -183,6 +183,16 @@ void qmp_cont(Error **errp)
>  
>  void qmp_system_wakeup(Error **errp)
>  {
> +    if (!qemu_wakeup_suspend_enabled()) {
> +        error_setg(errp,
> +                   "wake-up from suspend is not supported by this guest");
> +        return;
> +    }

Is this a new check?

If not, where is the condition checked before this patch?

> +    if (!runstate_check(RUN_STATE_SUSPENDED)) {
> +        error_setg(errp,
> +                   "Unable to wake up: guest is not in suspended state");
> +        return;
> +    }

Duplicates the check in qemu_system_wakeup_request().  Should that
function take an Error ** argument instead?

>      qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
>  }
>  
> diff --git a/vl.c b/vl.c
> index f78947f69c..35a33d61ba 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1759,7 +1759,7 @@ void qemu_register_wakeup_support(void)
>      wakeup_suspend_enabled = true;
>  }
>  
> -static bool qemu_wakeup_suspend_enabled(void)
> +bool qemu_wakeup_suspend_enabled(void)
>  {
>      return wakeup_suspend_enabled;
>  }
