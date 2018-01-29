Received: from eggs.gnu.org ([2001:4830:134:3::10]:56515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egB80-0007sC-2d
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egB7v-0001LQ-98
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:13:48 -0500
Date: Mon, 29 Jan 2018 16:13:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129151308.GG6141@localhost.localdomain>
References: <20180125144557.25502-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180125144557.25502-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] hmp: Add nbd_server_remove to
 mirror QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, dgilbert@redhat.com, qemu-block@nongnu.org

Am 25.01.2018 um 15:45 hat Eric Blake geschrieben:
> Since everything else about the nbd-server-* QMP commands is
> accessible from HMP, we might as well make removing an export
> available as well.  For now, I went with a bool flag rather
> than a mode string for choosing between safe (default) and
> hard modes.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> Based-on: <20180119135719.24745-1-vsementsov@virtuozzo.com>
> ([PATCH v3 0/5] nbd export qmp interface)
> 
>  hmp.h           |  1 +
>  hmp.c           | 14 +++++++++++---
>  hmp-commands.hx | 17 +++++++++++++++++
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/hmp.h b/hmp.h
> index a6f56b1f29e..536cb91caa4 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -101,6 +101,7 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict);
>  void hmp_screendump(Monitor *mon, const QDict *qdict);
>  void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
>  void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
> +void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
>  void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_add(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_change(Monitor *mon, const QDict *qdict);
> diff --git a/hmp.c b/hmp.c
> index 7a64dd59c5c..b3de32d219b 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2226,10 +2226,18 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
>      Error *local_err = NULL;
> 
>      qmp_nbd_server_add(device, !!name, name, true, writable, &local_err);
> +    hmp_handle_error(mon, &local_err);
> +}
> 
> -    if (local_err != NULL) {
> -        hmp_handle_error(mon, &local_err);
> -    }
> +void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
> +{
> +    const char *name = qdict_get_str(qdict, "name");
> +    bool force = qdict_get_try_bool(qdict, "force", false);
> +    Error *err = NULL;
> +
> +    /* Rely on NBD_SERVER_REMOVE_MODE_SAFE being the default */
> +    qmp_nbd_server_remove(name, force, NBD_SERVER_REMOVE_MODE_HARD, &err);

Usually we pass has_* = true and don't rely on defaults which may change
in the long run. Might also make the code a bit easier to understand, as
the existence of your comment shows.

> +    hmp_handle_error(mon, &err);
>  }

Either way:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
