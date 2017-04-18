Received: from eggs.gnu.org ([2001:4830:134:3::10]:42760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0PgY-0001NI-7A
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0PgT-0002AJ-Cd
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:44:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0PgT-0002A4-67
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:44:29 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C66E4E35B
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 09:44:28 +0000 (UTC)
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-19-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c1de8f4-f30a-e189-0da0-40768fb0e5a3@redhat.com>
Date: Tue, 18 Apr 2017 11:44:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170417200041.2451-19-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/19] monitor: move hmp_savevm() to
 monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com



On 17/04/2017 22:00, Juan Quintela wrote:
> hmp_loadvm is already there, so be consistent.

Can you move both to hmp.c instead?

Paolo

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/sysemu/sysemu.h | 1 -
>  migration/savevm.c      | 5 -----
>  monitor.c               | 5 +++++
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 5f2f21d..146a0dc 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -75,7 +75,6 @@ void qemu_remove_exit_notifier(Notifier *notify);
>  void qemu_add_machine_init_done_notifier(Notifier *notify);
>  void qemu_remove_machine_init_done_notifier(Notifier *notify);
>  
> -void hmp_savevm(Monitor *mon, const QDict *qdict);
>  int save_vmstate(Monitor *mon, const char *name);
>  int load_vmstate(const char *name);
>  void hmp_delvm(Monitor *mon, const QDict *qdict);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f628d01..cbd7e0d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2156,11 +2156,6 @@ int save_vmstate(Monitor *mon, const char *name)
>      return ret;
>  }
>  
> -void hmp_savevm(Monitor *mon, const QDict *qdict)
> -{
> -    save_vmstate(mon, qdict_get_try_str(qdict, "name"));
> -}
> -
>  void qmp_xen_save_devices_state(const char *filename, Error **errp)
>  {
>      QEMUFile *f;
> diff --git a/monitor.c b/monitor.c
> index ceb0489..2fca4fb 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1854,6 +1854,11 @@ static void hmp_loadvm(Monitor *mon, const QDict *qdict)
>      }
>  }
>  
> +static void hmp_savevm(Monitor *mon, const QDict *qdict)
> +{
> +    save_vmstate(mon, qdict_get_try_str(qdict, "name"));
> +}
> +
>  int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>  {
>      mon_fd_t *monfd;
> 
