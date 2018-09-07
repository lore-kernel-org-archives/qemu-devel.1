Received: from eggs.gnu.org ([2001:4830:134:3::10]:53213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyFyM-0008TF-D7
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyFyJ-0005QL-60
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:34:50 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyFyH-0005Jt-RT
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:34:46 -0400
Received: by mail-wm0-x22b.google.com with SMTP id t25-v6so14450444wmi.3
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 05:34:45 -0700 (PDT)
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819516675.30857.9162557650483931182.stgit@pasha-ThinkPad-T60>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <152819516675.30857.9162557650483931182.stgit@pasha-ThinkPad-T60>
Date: Fri, 07 Sep 2018 13:34:43 +0100
Message-ID: <87worxzdss.fsf@linaro.org>
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
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  Makefile.target           |    1
>  configure                 |   14 ++++++-
>  include/qemu/plugins.h    |    8 ++++
>  plugins/include/plugins.h |   12 ++++++
>  plugins/plugins.c         |   91 +++++++++++++++++++++++++++++++++++++++=
++++++
>  qemu-options.hx           |   10 +++++
>  vl.c                      |    8 ++++
>  7 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100644 include/qemu/plugins.h
>  create mode 100644 plugins/include/plugins.h
>  create mode 100644 plugins/plugins.c
>
> diff --git a/Makefile.target b/Makefile.target
> index dad2cf8..4cffd96 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -93,6 +93,7 @@ all: $(PROGS) stap
>  # cpu emulator library
>  obj-y +=3D exec.o
>  obj-y +=3D accel/
> +obj-$(CONFIG_PLUGINS) +=3D plugins/plugins.o
>  obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-o=
p-gvec.o
>  obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/optimize.o
>  obj-$(CONFIG_TCG_INTERPRETER) +=3D tcg/tci.o
> diff --git a/configure b/configure
> index a71bf9b..34e6f00 100755
> --- a/configure
> +++ b/configure
> @@ -373,6 +373,7 @@ EXESUF=3D""
>  DSOSUF=3D".so"
>  LDFLAGS_SHARED=3D"-shared"
>  modules=3D"no"
> +plugins=3D"no"
>  prefix=3D"/usr/local"
>  mandir=3D"\${prefix}/share/man"
>  datadir=3D"\${prefix}/share"
> @@ -922,6 +923,12 @@ for opt do
>    --disable-modules)
>        modules=3D"no"
>    ;;
> +  --enable-plugins)
> +      plugins=3D"yes"
> +  ;;
> +  --disable-plugins)
> +      plugins=3D"no"
> +  ;;
>    --cpu=3D*)
>    ;;
>    --target-list=3D*) target_list=3D"$optarg"
> @@ -1567,6 +1574,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
>    guest-agent-msi build guest agent Windows MSI installation package
>    pie             Position Independent Executables
>    modules         modules support
> +  plugins         plugins support
>    debug-tcg       TCG debugging (default is disabled)
>    debug-info      debugging information
>    sparse          sparse checker
> @@ -3392,7 +3400,7 @@ else
>      glib_req_ver=3D2.22
>  fi
>  glib_modules=3Dgthread-2.0
> -if test "$modules" =3D yes; then
> +if test "$modules" =3D yes || test "$plugins" =3D yes; then
>      glib_modules=3D"$glib_modules gmodule-export-2.0"
>  fi
>
> @@ -5777,6 +5785,7 @@ if test "$slirp" =3D "yes" ; then
>      echo "smbd              $smbd"
>  fi
>  echo "module support    $modules"
> +echo "plugin support    $plugins"
>  echo "host CPU          $cpu"
>  echo "host big endian   $bigendian"
>  echo "target list       $target_list"
> @@ -6111,6 +6120,9 @@ if test "$modules" =3D "yes"; then
>    echo "CONFIG_STAMP=3D_$( (echo $qemu_version; echo $pkgversion; cat $0=
) | $shacmd - | cut -f1 -d\ )" >> $config_host_mak
>    echo "CONFIG_MODULES=3Dy" >> $config_host_mak
>  fi
> +if test "$plugins" =3D "yes"; then
> +  echo "CONFIG_PLUGINS=3Dy" >> $config_host_mak
> +fi
>  if test "$have_x11" =3D "yes" -a "$need_x11" =3D "yes"; then
>    echo "CONFIG_X11=3Dy" >> $config_host_mak
>    echo "X11_CFLAGS=3D$x11_cflags" >> $config_host_mak
> diff --git a/include/qemu/plugins.h b/include/qemu/plugins.h
> new file mode 100644
> index 0000000..4464822
> --- /dev/null
> +++ b/include/qemu/plugins.h
> @@ -0,0 +1,8 @@
> +#ifndef PLUGINS_H
> +#define PLUGINS_H
> +
> +void qemu_plugin_parse_cmd_args(const char *optarg);
> +void qemu_plugin_load(const char *filename, const char *args);
> +void qemu_plugins_init(void);

I think you want to have an #ifdef CONFIG_PLUGINS here and some empty
inlines for the non CONFIG_PLUGINS case so you don't need to ifdef so
much later.

> +
> +#endif /* PLUGINS_H */
> diff --git a/plugins/include/plugins.h b/plugins/include/plugins.h
> new file mode 100644
> index 0000000..100a786
> --- /dev/null
> +++ b/plugins/include/plugins.h
> @@ -0,0 +1,12 @@
> +#ifndef PLUGINS_INTERFACE_H
> +#define PLUGINS_INTERFACE_H
> +
> +#include <stdbool.h>
> +
> +/* Plugin interface */
> +
> +bool plugin_init(const char *args);
> +bool plugin_needs_before_insn(uint64_t pc, void *cpu);
> +void plugin_before_insn(uint64_t pc, void *cpu);
> +
> +#endif /* PLUGINS_INTERFACE_H */
> diff --git a/plugins/plugins.c b/plugins/plugins.c
> new file mode 100644
> index 0000000..eabc931
> --- /dev/null
> +++ b/plugins/plugins.c
> @@ -0,0 +1,91 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +#include "qemu/plugins.h"
> +#include "qemu/queue.h"
> +#include <gmodule.h>
> +
> +typedef bool (*PluginInitFunc)(const char *);
> +typedef bool (*PluginNeedsBeforeInsnFunc)(uint64_t, void *);
> +typedef void (*PluginBeforeInsnFunc)(uint64_t, void *);
> +
> +typedef struct QemuPluginInfo {
> +    const char *filename;
> +    const char *args;
> +    GModule *g_module;
> +
> +    PluginInitFunc init;
> +    PluginNeedsBeforeInsnFunc needs_before_insn;
> +    PluginBeforeInsnFunc before_insn;
> +
> +    QLIST_ENTRY(QemuPluginInfo) next;
> +} QemuPluginInfo;
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

For example this fails to build currently.

>      /* do monitor/qmp handling at preconfig state if requested */
>      main_loop();
>


--
Alex Benn=C3=A9e
