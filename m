Received: from eggs.gnu.org ([209.51.188.92]:50167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLljb-0004qy-TK
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLljW-0005oI-8G
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:41:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hLljV-0005nM-FJ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:40:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65AA57C0B6
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 09:40:55 +0000 (UTC)
Date: Wed, 1 May 2019 10:40:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190501094049.GA10995@work-vm>
References: <984634226fa14316641f31f84e7dd0bb770bd94c.1556141033.git.crobinso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984634226fa14316641f31f84e7dd0bb770bd94c.1556141033.git.crobinso@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hmp: delvm: use hmp_handle_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

* Cole Robinson (crobinso@redhat.com) wrote:
> This gives us the consistent 'Error:' prefix added in 66363e9a43f,
> which helps users like libvirt who still need to scrape hmp error
> messages to detect failure.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Cole Robinson <crobinso@redhat.com>

Queued

> ---
> v2:
>     Drop now redundant "Error while" string prefix
> 
>  hmp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 4bb3af748e..56a3ed7375 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1480,10 +1480,11 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
>      const char *name = qdict_get_str(qdict, "name");
>  
>      if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
> -        error_reportf_err(err,
> -                          "Error while deleting snapshot on device '%s': ",
> -                          bdrv_get_device_name(bs));
> +        error_prepend(&err,
> +                      "deleting snapshot on device '%s': ",
> +                      bdrv_get_device_name(bs));
>      }
> +    hmp_handle_error(mon, &err);
>  }
>  
>  void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
