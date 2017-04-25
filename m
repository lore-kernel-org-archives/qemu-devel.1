Received: from eggs.gnu.org ([2001:4830:134:3::10]:44212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d30cX-000452-NN
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d30cR-0007pc-RY
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:35:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d30cR-0007pN-Ho
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:35:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 790B146D0B9
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 13:35:02 +0000 (UTC)
References: <20170425102446.4008-1-quintela@redhat.com>
	<20170425102446.4008-5-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <350e8cee-9f0d-c16f-26b9-ae9b8216937a@redhat.com>
Date: Tue, 25 Apr 2017 15:34:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170425102446.4008-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] monitor: Move hmp_delvm from savevm.c
 to hmp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 25/04/2017 12:24, Juan Quintela wrote:
> It really uses block/* stuff, not migration one.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  hmp.c                   | 13 +++++++++++++
>  hmp.h                   |  1 +
>  include/sysemu/sysemu.h |  1 -
>  migration/savevm.c      | 13 -------------
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index a82a952..bb739ce 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1286,6 +1286,19 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
>      save_vmstate(qdict_get_try_str(qdict, "name"));
>  }
>  
> +void hmp_delvm(Monitor *mon, const QDict *qdict)
> +{
> +    BlockDriverState *bs;
> +    Error *err;
> +    const char *name = qdict_get_str(qdict, "name");
> +
> +    if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
> +        error_reportf_err(err,
> +                          "Error while deleting snapshot on device '%s': ",
> +                          bdrv_get_device_name(bs));
> +    }
> +}
> +
>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
>  {
>      qmp_migrate_cancel(NULL);
> diff --git a/hmp.h b/hmp.h
> index b302c8d..6a402b1 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -65,6 +65,7 @@ void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
>  void hmp_drive_backup(Monitor *mon, const QDict *qdict);
>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
>  void hmp_savevm(Monitor *mon, const QDict *qdict);
> +void hmp_delvm(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
>  void hmp_migrate_set_downtime(Monitor *mon, const QDict *qdict);
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 914c36c..e4f355ceb 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -77,7 +77,6 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify);
>  
>  int save_vmstate(const char *name);
>  int load_vmstate(const char *name);
> -void hmp_delvm(Monitor *mon, const QDict *qdict);
>  void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
>  
>  void qemu_announce_self(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index bbff4d8..acd304b 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2304,19 +2304,6 @@ int load_vmstate(const char *name)
>      return 0;
>  }
>  
> -void hmp_delvm(Monitor *mon, const QDict *qdict)
> -{
> -    BlockDriverState *bs;
> -    Error *err;
> -    const char *name = qdict_get_str(qdict, "name");
> -
> -    if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
> -        error_reportf_err(err,
> -                          "Error while deleting snapshot on device '%s': ",
> -                          bdrv_get_device_name(bs));
> -    }
> -}
> -
>  void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
>  {
>      BlockDriverState *bs, *bs1;
> 
