Received: from eggs.gnu.org ([2001:4830:134:3::10]:46018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGRX9-0001RI-50
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGRX5-0005qZ-V2
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dGRX5-0005qJ-MV
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:57:03 -0400
Date: Thu, 1 Jun 2017 15:56:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170601145649.GC2845@work-vm>
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-11-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496152683-102751-11-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 10/13] hmp: add hmp analogue for
 qmp-chardev-change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

* Anton Nefedov (anton.nefedov@virtuozzo.com) wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks, with Marc-Andre's comments, this looks fine from the HMP point.

If you can find a way to add a test to tests/test-hmp.c  it would be
great.

Dave

> ---
>  chardev/char.c        |  2 +-
>  hmp-commands.hx       | 16 ++++++++++++++++
>  hmp.c                 | 34 ++++++++++++++++++++++++++++++++++
>  hmp.h                 |  1 +
>  include/sysemu/char.h | 12 ++++++++++++
>  5 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/chardev/char.c b/chardev/char.c
> index 2d6e204..1e2a2dd 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -888,7 +888,7 @@ help_string_append(const char *name, void *opaque)
>      g_string_append_printf(str, "\n%s", name);
>  }
>  
> -static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
> +ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
>  {
>      Error *local_err = NULL;
>      const ChardevClass *cc;
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index baeac47..19bfddd 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1727,6 +1727,22 @@ chardev_add accepts the same parameters as the -chardev command line switch.
>  ETEXI
>  
>      {
> +        .name       = "chardev-change",
> +        .args_type  = "id:s,args:s",
> +        .params     = "id args",
> +        .help       = "change chardev",
> +        .cmd        = hmp_chardev_change,
> +    },
> +
> +STEXI
> +@item chardev-change args
> +@findex chardev-change
> +chardev_change accepts existing chardev @var{id} and then the same arguments
> +as the -chardev command line switch (except for "id").
> +
> +ETEXI
> +
> +    {
>          .name       = "chardev-remove",
>          .args_type  = "id:s",
>          .params     = "id",
> diff --git a/hmp.c b/hmp.c
> index 20f5dab..7660495 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2224,6 +2224,40 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
>  
> +void hmp_chardev_change(Monitor *mon, const QDict *qdict)
> +{
> +    const char *args = qdict_get_str(qdict, "args");
> +    const char *id;
> +    Error *err = NULL;
> +    ChardevBackend *backend = NULL;
> +    ChardevReturn *ret = NULL;
> +    QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"), args,
> +                                             true);
> +    if (!opts) {
> +        error_setg(&err, "Parsing chardev args failed");
> +        goto end;
> +    }
> +
> +    id = qdict_get_str(qdict, "id");
> +    if (qemu_opts_id(opts)) {
> +        error_setg(&err, "Unexpected 'id' parameter");
> +        goto end;
> +    }
> +
> +    backend = qemu_chr_parse_opts(opts, &err);
> +    if (!backend) {
> +        goto end;
> +    }
> +
> +    ret = qmp_chardev_change(id, backend, &err);
> +
> +end:
> +    qapi_free_ChardevReturn(ret);
> +    qapi_free_ChardevBackend(backend);
> +    qemu_opts_del(opts);
> +    hmp_handle_error(mon, &err);
> +}
> +
>  void hmp_chardev_remove(Monitor *mon, const QDict *qdict)
>  {
>      Error *local_err = NULL;
> diff --git a/hmp.h b/hmp.h
> index d8b94ce..23e035c 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -102,6 +102,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
>  void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
>  void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_add(Monitor *mon, const QDict *qdict);
> +void hmp_chardev_change(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
>  void hmp_qemu_io(Monitor *mon, const QDict *qdict);
>  void hmp_cpu_add(Monitor *mon, const QDict *qdict);
> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index 342f531..18fcd26 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -131,6 +131,18 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>  void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend);
>  
>  /**
> + * @qemu_chr_parse_opts:
> + *
> + * Parse the options to the ChardevBackend struct.
> + *
> + * @opts
> + *
> + * Returns: a new backend
> + */
> +ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
> +                                    Error **errp);
> +
> +/**
>   * @qemu_chr_new:
>   *
>   * Create a new character backend from a URI.
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
