Received: from eggs.gnu.org ([2001:4830:134:3::10]:35017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCkZs-0002Mh-Vc
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCkZZ-0002K8-WA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:05:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gCkZY-0001ru-EN
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:05:08 -0400
Date: Wed, 17 Oct 2018 13:04:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181017120446.GF2530@work-vm>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-18-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181005154910.3099-18-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 17/21] hmp: expose status of plugins to
 the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

* Alex Benn=E9e (alex.bennee@linaro.org) wrote:
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  hmp-commands-info.hx   | 17 +++++++++++++++++
>  include/qemu/plugins.h |  1 +
>  monitor.c              | 14 ++++++++++++++
>  trace/plugins.c        | 15 +++++++++++++++
>  4 files changed, 47 insertions(+)

I'm OK with this; although it's worth thinking about whether this should
be available via qmp, but it is just for debug/tracing.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index cbee8b944d..e245a852ae 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -683,6 +683,23 @@ STEXI
>  Show available trace-events & their state.
>  ETEXI

> +#if defined(CONFIG_TRACE_PLUGIN)
> +    {
> +        .name       =3D "trace-plugins",
> +        .args_type  =3D "name:s?",
> +        .params     =3D "[name]",
> +        .help       =3D "show available plugins and any extra info "
> +                      "(name: plugin name pattern)",
> +        .cmd =3D hmp_info_trace_plugins,
> +    },
> +
> +STEXI
> +@item info trace-plugins
> +@findex info trace-plugins
> +Show available trace-plugins & their state.
> +ETEXI
> +#endif
> +
>      {
>          .name       =3D "tpm",
>          .args_type  =3D "",
> diff --git a/include/qemu/plugins.h b/include/qemu/plugins.h
> index c86bb7ae67..44f2ec8c98 100644
> --- a/include/qemu/plugins.h
> +++ b/include/qemu/plugins.h
> @@ -6,6 +6,7 @@
>  void qemu_plugin_parse_cmd_args(const char *optarg);
>  void qemu_plugin_load(const char *filename, const char *args);
>  void qemu_plugins_init(void);
> +GString *qemu_plugin_status(const char *name);
> =20
>  #else
> =20
> diff --git a/monitor.c b/monitor.c
> index d8229cd2b0..0d0de9ece7 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -67,6 +67,9 @@
>  #ifdef CONFIG_TRACE_SIMPLE
>  #include "trace/simple.h"
>  #endif
> +#ifdef CONFIG_TRACE_PLUGIN
> +#include "qemu/plugins.h"
> +#endif
>  #include "exec/memory.h"
>  #include "exec/exec-all.h"
>  #include "qemu/log.h"
> @@ -1429,6 +1432,17 @@ static void hmp_info_trace_events(Monitor *mon, =
const QDict *qdict)
>      qapi_free_TraceEventInfoList(events);
>  }
> =20
> +#ifdef CONFIG_TRACE_PLUGIN
> +static void hmp_info_trace_plugins(Monitor *mon, const QDict *qdict)
> +{
> +    const char *name =3D qdict_get_try_str(qdict, "name");
> +    GString *status =3D qemu_plugin_status(name);
> +
> +    monitor_printf(mon, "%s", status->str);
> +    g_string_free(status, true);
> +}
> +#endif
> +
>  void qmp_client_migrate_info(const char *protocol, const char *hostnam=
e,
>                               bool has_port, int64_t port,
>                               bool has_tls_port, int64_t tls_port,
> diff --git a/trace/plugins.c b/trace/plugins.c
> index 25aec2ff70..05630b02e6 100644
> --- a/trace/plugins.c
> +++ b/trace/plugins.c
> @@ -58,6 +58,21 @@ void qemu_plugin_parse_cmd_args(const char *optarg)
>                       qemu_opt_get(opts, "args"));
>  }
> =20
> +GString *qemu_plugin_status(const char *name)
> +{
> +    QemuPluginInfo *info;
> +    GString *status =3D g_string_new("");
> +
> +    QLIST_FOREACH(info, &qemu_plugins, next) {
> +        if (info->status) {
> +            char *pstatus =3D info->status();
> +            g_string_append_printf(status, "%s: %s\n", info->filename,=
 pstatus);
> +            g_free(pstatus);
> +        }
> +    }
> +    return status;
> +}
> +
>  static int bind_to_tracepoints(GModule *g_module, GPtrArray *events)
>  {
>      int count =3D 0;
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
