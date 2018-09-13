Received: from eggs.gnu.org ([2001:4830:134:3::10]:41435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0LIx-00015q-0g
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0LIt-00055z-1S
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:40:43 -0400
Received: from mail.ispras.ru ([83.149.199.45]:48454)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0LIs-00055N-Ld
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 02:40:38 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819516675.30857.9162557650483931182.stgit@pasha-ThinkPad-T60>
	<87zhwtzkg9.fsf@linaro.org>
In-Reply-To: <87zhwtzkg9.fsf@linaro.org>
Date: Thu, 13 Sep 2018 09:40:34 +0300
Message-ID: <000601d44b2c$ac7aa4f0$056feed0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/7] Add plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:
>=20
> > This patch adds support for dynamically loaded plugins.
> > Every plugin is a dynamic library with a set of optional exported
> > functions that will be called from QEMU.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > ---
> <snip>
> >  qemu-options.hx           |   10 +++++
> >  vl.c                      |    8 ++++
>=20
> There are a couple of trivial conflicts vs master here, simple to fix.
>=20
> >  7 files changed, 143 insertions(+), 1 deletion(-)
> >  create mode 100644 include/qemu/plugins.h
> >  create mode 100644 plugins/include/plugins.h
> >  create mode 100644 plugins/plugins.c
> >
> > diff --git a/Makefile.target b/Makefile.target
> > index dad2cf8..4cffd96 100644
> > --- a/Makefile.target
> > +++ b/Makefile.target
> > @@ -93,6 +93,7 @@ all: $(PROGS) stap
> >  # cpu emulator library
> >  obj-y +=3D exec.o
> >  obj-y +=3D accel/
> > +obj-$(CONFIG_PLUGINS) +=3D plugins/plugins.o
> >  obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o =
tcg/tcg-op-gvec.o
> >  obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/optimize.o
> >  obj-$(CONFIG_TCG_INTERPRETER) +=3D tcg/tci.o
> > diff --git a/configure b/configure
> > index a71bf9b..34e6f00 100755
> > --- a/configure
> > +++ b/configure
> > @@ -373,6 +373,7 @@ EXESUF=3D""
> >  DSOSUF=3D".so"
> >  LDFLAGS_SHARED=3D"-shared"
> >  modules=3D"no"
> > +plugins=3D"no"
> >  prefix=3D"/usr/local"
> >  mandir=3D"\${prefix}/share/man"
> >  datadir=3D"\${prefix}/share"
> > @@ -922,6 +923,12 @@ for opt do
> >    --disable-modules)
> >        modules=3D"no"
> >    ;;
> > +  --enable-plugins)
> > +      plugins=3D"yes"
> > +  ;;
> > +  --disable-plugins)
> > +      plugins=3D"no"
> > +  ;;
> >    --cpu=3D*)
> >    ;;
> >    --target-list=3D*) target_list=3D"$optarg"
> > @@ -1567,6 +1574,7 @@ disabled with --disable-FEATURE, default is =
enabled if available:
> >    guest-agent-msi build guest agent Windows MSI installation =
package
> >    pie             Position Independent Executables
> >    modules         modules support
> > +  plugins         plugins support
> >    debug-tcg       TCG debugging (default is disabled)
> >    debug-info      debugging information
> >    sparse          sparse checker
> > @@ -3392,7 +3400,7 @@ else
> >      glib_req_ver=3D2.22
> >  fi
> >  glib_modules=3Dgthread-2.0
> > -if test "$modules" =3D yes; then
> > +if test "$modules" =3D yes || test "$plugins" =3D yes; then
> >      glib_modules=3D"$glib_modules gmodule-export-2.0"
> >  fi
> >
> > @@ -5777,6 +5785,7 @@ if test "$slirp" =3D "yes" ; then
> >      echo "smbd              $smbd"
> >  fi
> >  echo "module support    $modules"
> > +echo "plugin support    $plugins"
> >  echo "host CPU          $cpu"
> >  echo "host big endian   $bigendian"
> >  echo "target list       $target_list"
> > @@ -6111,6 +6120,9 @@ if test "$modules" =3D "yes"; then
> >    echo "CONFIG_STAMP=3D_$( (echo $qemu_version; echo $pkgversion; =
cat $0) | $shacmd - | cut -
> f1 -d\ )" >> $config_host_mak
> >    echo "CONFIG_MODULES=3Dy" >> $config_host_mak
> >  fi
> > +if test "$plugins" =3D "yes"; then
> > +  echo "CONFIG_PLUGINS=3Dy" >> $config_host_mak
> > +fi
> >  if test "$have_x11" =3D "yes" -a "$need_x11" =3D "yes"; then
> >    echo "CONFIG_X11=3Dy" >> $config_host_mak
> >    echo "X11_CFLAGS=3D$x11_cflags" >> $config_host_mak
> > diff --git a/include/qemu/plugins.h b/include/qemu/plugins.h
> > new file mode 100644
> > index 0000000..4464822
> > --- /dev/null
> > +++ b/include/qemu/plugins.h
> > @@ -0,0 +1,8 @@
> > +#ifndef PLUGINS_H
> > +#define PLUGINS_H
> > +
> > +void qemu_plugin_parse_cmd_args(const char *optarg);
> > +void qemu_plugin_load(const char *filename, const char *args);
> > +void qemu_plugins_init(void);
> > +
> > +#endif /* PLUGINS_H */
> > diff --git a/plugins/include/plugins.h b/plugins/include/plugins.h
> > new file mode 100644
> > index 0000000..100a786
> > --- /dev/null
> > +++ b/plugins/include/plugins.h
> > @@ -0,0 +1,12 @@
> > +#ifndef PLUGINS_INTERFACE_H
> > +#define PLUGINS_INTERFACE_H
> > +
> > +#include <stdbool.h>
> > +
> > +/* Plugin interface */
> > +
> > +bool plugin_init(const char *args);
> > +bool plugin_needs_before_insn(uint64_t pc, void *cpu);
> > +void plugin_before_insn(uint64_t pc, void *cpu);
> > +
> > +#endif /* PLUGINS_INTERFACE_H */
> > diff --git a/plugins/plugins.c b/plugins/plugins.c
> > new file mode 100644
> > index 0000000..eabc931
> > --- /dev/null
> > +++ b/plugins/plugins.c
> > @@ -0,0 +1,91 @@
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/plugins.h"
> > +#include "qemu/queue.h"
> > +#include <gmodule.h>
> > +
> > +typedef bool (*PluginInitFunc)(const char *);
> > +typedef bool (*PluginNeedsBeforeInsnFunc)(uint64_t, void *);
> > +typedef void (*PluginBeforeInsnFunc)(uint64_t, void *);
> > +
> > +typedef struct QemuPluginInfo {
> > +    const char *filename;
> > +    const char *args;
> > +    GModule *g_module;
> > +
> > +    PluginInitFunc init;
> > +    PluginNeedsBeforeInsnFunc needs_before_insn;
>=20
> It seems a bit heavyweight to have a query function here. Is this
> dynamic state the plugin might change during execution? If not could =
we
> not better report plugin requirements during initialisation?

Yes, it is dynamic.
For example, we created a plugin, which detects dynamic module loading
in the guest. Then it can add tracepoints to the entry addresses of the =
loaded
functions. These addresses are not known in advance.


Pavel Dovgalyuk
