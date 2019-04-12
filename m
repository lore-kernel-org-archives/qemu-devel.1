Received: from eggs.gnu.org ([209.51.188.92]:42039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hF0i8-0003Vx-Sp
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hF0i7-0000AE-VL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hF0i7-00009b-MZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:15:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00E5A30B8FAC
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:15:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <f61645d0b3720a039423532d49dd65588d9bccd8.1554919328.git.crobinso@redhat.com>
Date: Fri, 12 Apr 2019 20:15:32 +0200
In-Reply-To: <f61645d0b3720a039423532d49dd65588d9bccd8.1554919328.git.crobinso@redhat.com>
	(Cole Robinson's message of "Wed, 10 Apr 2019 14:03:31 -0400")
Message-ID: <87d0lrjdiz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hmp: delvm: use hmp_handle_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Cole Robinson <crobinso@redhat.com> writes:

> This gives us the consistent 'Error:' prefix added in 66363e9a43f,
> which helps users like libvirt who still need to scrape hmp error
> messages to detect failure.
>
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>  hmp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hmp.c b/hmp.c
> index 8eec768088..74a4bfc1f9 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1481,10 +1481,11 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
>      const char *name = qdict_get_str(qdict, "name");
>  
>      if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
> -        error_reportf_err(err,
> -                          "Error while deleting snapshot on device '%s': ",
> -                          bdrv_get_device_name(bs));
> +        error_prepend(&err,
> +                      "Error while deleting snapshot on device '%s': ",
> +                      bdrv_get_device_name(bs));
>      }
> +    hmp_handle_error(mon, &err);
>  }
>  
>  void hmp_info_snapshots(Monitor *mon, const QDict *qdict)

No objection to this patch, just apropos hmp_handle_error().

HMP command handlers look like this:

    void hmp_FOO(Monitor *mon, const QDict *qdict)

They can report errors however they like.  The monitor core has no
notion of HMP command failure.

Commonly, hmp_FOO() wraps around some qmp_FOO(), or some helper(s) it
shares with qmp_FOO().  These will return errors through an Error **
argument.  The sane way for hmp_FOO() to report them is with
hmp_handle_error().

In other words, we get an hmp_handle_error() on most[*] failure paths.

Why not move it into the monitor core?

    bool hmp_FOO(Monitor *mon, const QDict *qdict, Error **errp)

While at it, ditch the @mon parameter, because it's always cur_mon
anyway:

    bool hmp_FOO(const QDict *qdict, Error **errp)


[*] Common exceptions are failures in code that add convenience over
QMP.  These need not produce an Error object.  Instead, they may report
with error_report(), or even monitor_printf().  The latter would be in
bad taste.
