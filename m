Received: from eggs.gnu.org ([2001:4830:134:3::10]:51832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fxi8x-0003z2-AJ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 20:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fxi8t-0002oq-92
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 20:27:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fxi8q-0002PP-Lq
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 20:27:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w860ORKu042384
	for <qemu-devel@nongnu.org>; Wed, 5 Sep 2018 20:27:17 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2map897pdd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 20:27:17 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 5 Sep 2018 18:27:16 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180705200813.2033-4-danielhb413@gmail.com>
References: <20180705200813.2033-1-danielhb413@gmail.com>
	<20180705200813.2033-4-danielhb413@gmail.com>
Date: Wed, 05 Sep 2018 19:27:08 -0500
Message-Id: <153619362876.28231.7392145818127711611@sif>
Subject: Re: [Qemu-devel] [PATCH v8 3/3] qmp hmp: Make system_wakeup check
 wake-up support and run state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com

Quoting Daniel Henrique Barboza (2018-07-05 15:08:13)
> The qmp/hmp command 'system_wakeup' is simply a direct call to
> 'qemu_system_wakeup_request' from vl.c. This function verifies if
> runstate is SUSPENDED and if the wake up reason is valid before
> proceeding. However, no error or warning is thrown if any of those
> pre-requirements isn't met. There is no way for the caller to
> differentiate between a successful wakeup or an error state caused
> when trying to wake up a guest that wasn't suspended.
> =

> This means that system_wakeup is silently failing, which can be
> considered a bug. Adding error handling isn't an API break in this
> case - applications that didn't check the result will remain broken,
> the ones that check it will have a chance to deal with it.
> =

> Adding to that, the commit before previous created a new QMP API called
> query-current-machine, with a new flag called wakeup-suspend-support,
> that indicates if the guest has the capability of waking up from suspended
> state. Although such guest will never reach SUSPENDED state and erroring
> it out in this scenario would suffice, it is more informative for the user
> to differentiate between a failure because the guest isn't suspended vers=
us
> a failure because the guest does not have support for wake up at all.
> =

> All this considered, this patch changes qmp_system_wakeup to:
> =

> - check if the guest has the capability to wake-up from suspend. If
> not, error out informing about the lack of support;
> =

> - make the runstate verification before proceeding to call
> qemu_system_wakeup_request, firing up an error message if the user tries
> to wake up a machine that isn't in SUSPENDED state.
> =

> After this patch, this is the output of system_wakeup in a guest that
> does not have wake-up from suspend support (ppc64):
> =

> (qemu) system_wakeup
> wake-up from suspend is not supported by this guest
> (qemu)
> =

> And this is the output of system_wakeup in a x86 guest that has the
> support but isn't suspended:
> =

> (qemu) system_wakeup
> Unable to wake up: guest is not in suspended state
> (qemu)
> =

> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hmp.c                   |  5 ++++-
>  include/sysemu/sysemu.h |  1 +
>  qapi/misc.json          |  5 ++++-
>  qmp.c                   | 11 ++++++++++-
>  vl.c                    |  2 +-
>  5 files changed, 20 insertions(+), 4 deletions(-)
> =

> diff --git a/hmp.c b/hmp.c
> index 41f5e39b72..83a8041d11 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1169,7 +1169,10 @@ void hmp_cont(Monitor *mon, const QDict *qdict)
> =

>  void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
>  {
> -    qmp_system_wakeup(NULL);
> +    Error *err =3D NULL;
> +
> +    qmp_system_wakeup(&err);
> +    hmp_handle_error(mon, &err);
>  }
> =

>  void hmp_nmi(Monitor *mon, const QDict *qdict)
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index b921c6f3b7..483f804b36 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -70,6 +70,7 @@ void qemu_exit_preconfig_request(void);
>  void qemu_system_reset_request(ShutdownCause reason);
>  void qemu_system_suspend_request(void);
>  void qemu_register_suspend_notifier(Notifier *notifier);
> +bool qemu_wakeup_suspend_support(void);
>  void qemu_system_wakeup_request(WakeupReason reason);
>  void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
>  void qemu_register_wakeup_notifier(Notifier *notifier);
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 266f88cb09..86195d79e9 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1230,7 +1230,10 @@
>  ##
>  # @system_wakeup:
>  #
> -# Wakeup guest from suspend.  Does nothing in case the guest isn't suspe=
nded.
> +# If the guest has wake-up from suspend support enabled
> +# (wakeup-suspend-support flag from query-current-machine), wakeup guest
> +# from suspend if the guest is in SUSPENDED state. Returns an error
> +# otherwise.
>  #
>  # Since:  1.1
>  #
> diff --git a/qmp.c b/qmp.c
> index 73e46d795f..0673ff1fa5 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -215,7 +215,16 @@ void qmp_cont(Error **errp)
> =

>  void qmp_system_wakeup(Error **errp)
>  {
> -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
> +    if (!qemu_wakeup_suspend_support()) {
> +        error_setg(errp,
> +                   "wake-up from suspend is not supported by this guest"=
);
> +        return;
> +    }
> +    if (!runstate_check(RUN_STATE_SUSPENDED)) {
> +        error_setg(errp,
> +                   "Unable to wake up: guest is not in suspended state");
> +        return;
> +    }
>  }

Was removing qemu_system_wakeup_request() intentional or did that just get
lost somehow?

> =

>  ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
> diff --git a/vl.c b/vl.c
> index 96ad448d57..2af10b75cb 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1769,7 +1769,7 @@ void qemu_register_wakeup_notifier(Notifier *notifi=
er)
>      notifier_list_add(&wakeup_notifiers, notifier);
>  }
> =

> -static bool qemu_wakeup_suspend_support(void)
> +bool qemu_wakeup_suspend_support(void)
>  {
>      return !QLIST_EMPTY(&wakeup_notifiers.notifiers) && acpi_enabled;
>  }
> -- =

> 2.17.1
>=20
