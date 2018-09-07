Received: from eggs.gnu.org ([2001:4830:134:3::10]:56692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyHWf-0005Bl-Ho
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyHWc-0000Hx-8J
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:14:21 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:40456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyHWc-0000HA-1Q
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:14:18 -0400
Received: by mail-wm0-x22d.google.com with SMTP id 207-v6so14718373wme.5
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 07:14:17 -0700 (PDT)
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819516675.30857.9162557650483931182.stgit@pasha-ThinkPad-T60>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <152819516675.30857.9162557650483931182.stgit@pasha-ThinkPad-T60>
Date: Fri, 07 Sep 2018 15:14:15 +0100
Message-ID: <87mustz96w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/7] Add plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu


Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> This patch adds support for dynamically loaded plugins.
> Every plugin is a dynamic library with a set of optional exported
> functions that will be called from QEMU.
>
<snip>
> +
> +static QLIST_HEAD(, QemuPluginInfo) qemu_plugins
> +                                =3D QLIST_HEAD_INITIALIZER(qemu_plugins);
> +
> +static QemuOptsList qemu_plugin_opts =3D {
> +    .name =3D "plugin",
> +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_plugin_opts.head),
> +    .desc =3D {
> +        {
> +            .name =3D "file",
> +            .type =3D QEMU_OPT_STRING,
> +        },{
> +            .name =3D "args",
> +            .type =3D QEMU_OPT_STRING,
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +void qemu_plugin_parse_cmd_args(const char *optarg)
> +{
> +    QemuOpts *opts =3D qemu_opts_parse_noisily(&qemu_plugin_opts, optarg=
, false);
> +    qemu_plugin_load(qemu_opt_get(opts, "file"),
> +        qemu_opt_get(opts, "args"));
> +}

Currently this is only available to system mode emulation. Can it be
extended to include linux-user as well?

> +
> +void qemu_plugin_load(const char *filename, const char *args)
> +{
> +    GModule *g_module;
> +    QemuPluginInfo *info =3D NULL;
> +    if (!filename) {
> +        error_report("plugin name was not specified");
> +        return;
> +    }
> +    g_module =3D g_module_open(filename,
> +        G_MODULE_BIND_LAZY | G_MODULE_BIND_LOCAL);
> +    if (!g_module) {
> +        error_report("can't load plugin '%s'", filename);
> +        return;
> +    }
> +    info =3D g_new0(QemuPluginInfo, 1);
> +    info->filename =3D g_strdup(filename);
> +    info->g_module =3D g_module;
> +    if (args) {
> +        info->args =3D g_strdup(args);
> +    }
> +
> +    g_module_symbol(g_module, "plugin_init", (gpointer*)&info->init);
> +
> +    /* Get the instrumentation callbacks */
> +    g_module_symbol(g_module, "plugin_needs_before_insn",
> +        (gpointer*)&info->needs_before_insn);
> +    g_module_symbol(g_module, "plugin_before_insn",
> +        (gpointer*)&info->before_insn);
> +
> +    QLIST_INSERT_HEAD(&qemu_plugins, info, next);
> +
> +    return;
> +}
> +
> +void qemu_plugins_init(void)
> +{
> +    QemuPluginInfo *info;
> +    QLIST_FOREACH(info, &qemu_plugins, next) {
> +        if (info->init) {
> +            info->init(info->args);
> +        }
> +    }
> +}
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c0d3951..d171544 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3950,6 +3950,16 @@ Dump json-encoded vmstate information for current =
machine type to file
>  in @var{file}
>  ETEXI
>
> +#ifdef CONFIG_PLUGINS
> +DEF("plugin", HAS_ARG, QEMU_OPTION_plugin, \
> +           "-plugin file=3D<file>[,args=3D<args>] load <dso> plugin with=
 <args>\n", QEMU_ARCH_ALL)
> +STEXI
> +@item -plugin file=3D@var{file}[,args=3D@var{args}]
> +@findex -plugin
> +Load @var{file} plugin passing @var{args} arguments.
> +ETEXI
> +#endif
> +
>  STEXI
>  @end table
>  ETEXI
> diff --git a/vl.c b/vl.c
> index 0603171..05420bf 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -129,6 +129,7 @@ int main(int argc, char **argv)
>  #include "qapi/qapi-commands-run-state.h"
>  #include "qapi/qmp/qerror.h"
>  #include "sysemu/iothread.h"
> +#include "qemu/plugins.h"
>
>  #define MAX_VIRTIO_CONSOLES 1
>
> @@ -3925,6 +3926,11 @@ int main(int argc, char **argv, char **envp)
>                      exit(1);
>                  }
>                  break;
> +#ifdef CONFIG_PLUGINS
> +            case QEMU_OPTION_plugin:
> +                qemu_plugin_parse_cmd_args(optarg);
> +                break;
> +#endif
>              case QEMU_OPTION_nodefconfig:
>              case QEMU_OPTION_nouserconfig:
>                  /* Nothing to be parsed here. Especially, do not error o=
ut below. */
> @@ -4470,6 +4476,8 @@ int main(int argc, char **argv, char **envp)
>      }
>      parse_numa_opts(current_machine);
>
> +    qemu_plugins_init();
> +
>      /* do monitor/qmp handling at preconfig state if requested */
>      main_loop();
>


--
Alex Benn=C3=A9e
