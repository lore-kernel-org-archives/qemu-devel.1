Received: from eggs.gnu.org ([2001:4830:134:3::10]:35395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fIfDf-0003R3-Py
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fIfDd-0007X3-5W
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:02:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fIfDc-0007Wz-Vn
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:02:41 -0400
Date: Tue, 15 May 2018 20:02:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180515190236.GG2749@work-vm>
References: <20180515154353.17691-1-danielhb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515154353.17691-1-danielhb@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] qmp.c: system_wakeup: adding
 RUN_STATE_SUSPENDED check before proceeding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

* Daniel Henrique Barboza (danielhb@linux.ibm.com) wrote:
> The qmp/hmp command 'system_wakeup' is simply a direct call to
> 'qemu_system_wakeup_request' from vl.c. This function verifies if
> runstate is SUSPENDED and if the wake up reason is valid before
> proceeding.
> 
> However, no error or warning is thrown if any of those
> pre-requirements isn't met. There is no way for the caller to
> differentiate between a successful wakeup or an error state caused
> when trying to wake up a guest that wasn't suspended. Silent
> failures should be interpreted as bugs and there is no API break
> in fixing this behavior - applications that didn't check the result
> will remain broken, the ones that check will have a chance to deal
> with it.
> 
> This patch changes qmp_system_wakeup to make the runstate verification
> before proceeding to call qemu_system_wakeup_request, firing up
> an error message if the user tries to wake up a machine that
> isn't in SUSPENDED state. The change isn't made inside
> qemu_system_wakeup_request because it is used in migration,
> ACPI and others where this usage might be valid.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
> 
> Changes in v3:
> - improved commit message, as requested by Eric Blake
> - added Eric's R-b
> 
>  hmp.c | 4 +++-
>  qmp.c | 5 +++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 898e25f3e1..2c4c867cab 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1156,7 +1156,9 @@ void hmp_cont(Monitor *mon, const QDict *qdict)
>  
>  void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
>  {
> -    qmp_system_wakeup(NULL);
> +    Error *err = NULL;
> +    qmp_system_wakeup(&err);
> +    hmp_handle_error(mon, &err);
>  }

Fine from HMP side:


Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  void hmp_nmi(Monitor *mon, const QDict *qdict)
> diff --git a/qmp.c b/qmp.c
> index 25fdc9a5b2..9c1d0df1ab 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -205,6 +205,11 @@ void qmp_cont(Error **errp)
>  
>  void qmp_system_wakeup(Error **errp)
>  {
> +    if (!runstate_check(RUN_STATE_SUSPENDED)) {
> +        error_setg(errp,
> +                   "Unable to wake up: guest is not in suspended state");
> +        return;
> +    }
>      qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER);
>  }
>  
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
