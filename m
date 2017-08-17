Received: from eggs.gnu.org ([2001:4830:134:3::10]:36788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1diK9D-0007il-CN
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1diK9A-0001O4-PN
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:43:39 -0400
MIME-Version: 1.0
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-27-marcandre.lureau@redhat.com>
	<87shgqcr7a.fsf@dusky.pond.sub.org>
In-Reply-To: <87shgqcr7a.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Aug 2017 12:43:23 +0000
Message-ID: <CAJ+F1CL2z10V=xwJOKDHG=dCT01q7mOzNdLY7Y9io6goUZK61g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 26/26] qapi: make query-cpu-definitions
 depend on specific targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi

On Thu, Aug 17, 2017 at 2:30 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > It depends on TARGET_PPC || TARGET_ARM || TARGET_I386 || TARGET_S390X.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi-schema.json            |  4 +++-
> >  include/sysemu/arch_init.h  |  2 --
> >  monitor.c                   | 22 ----------------------
> >  qmp.c                       |  5 -----
> >  stubs/arch-query-cpu-def.c  | 10 ----------
> >  target/arm/helper.c         |  3 ++-
> >  target/i386/cpu.c           |  3 ++-
> >  target/ppc/translate_init.c |  3 ++-
> >  target/s390x/cpu_models.c   |  2 +-
> >  stubs/Makefile.objs         |  1 -
> >  10 files changed, 10 insertions(+), 45 deletions(-)
> >  delete mode 100644 stubs/arch-query-cpu-def.c
> >
> > diff --git a/qapi-schema.json b/qapi-schema.json
> > index f5e1acff83..8e3949bca8 100644
> > --- a/qapi-schema.json
> > +++ b/qapi-schema.json
> > @@ -4433,7 +4433,9 @@
> >  #
> >  # Since: 1.2.0
> >  ##
> > -{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo']=
 }
> > +{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo']=
,
> > +  'if': ['defined(NEED_CPU_H)',
> > +         'defined(TARGET_PPC) || defined(TARGET_ARM) ||
> defined(TARGET_I386) || defined(TARGET_S390X)'] }
> >
> >  ##
> >  # @CpuModelInfo:
> > diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> > index fb3d20a1b8..e9721b9ce8 100644
> > --- a/include/sysemu/arch_init.h
> > +++ b/include/sysemu/arch_init.h
> > @@ -31,6 +31,4 @@ extern const uint32_t arch_type;
> >  int kvm_available(void);
> >  int xen_available(void);
> >
> > -CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp);
> > -
> >  #endif
> > diff --git a/monitor.c b/monitor.c
> > index b134c39144..6600819599 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -956,26 +956,6 @@ static void qmp_query_qmp_schema(QDict *qdict,
> QObject **ret_data,
> >      *ret_data =3D qobject_from_qlit(&qmp_schema_qlit);
> >  }
> >
> > -/*
> > - * We used to define commands in qmp-commands.hx in addition to the
> > - * QAPI schema.  This permitted defining some of them only in certain
> > - * configurations.  query-commands has always reflected that (good,
> > - * because it lets QMP clients figure out what's actually available),
> > - * while query-qmp-schema never did (not so good).  This function is a
> > - * hack to keep the configuration-specific commands defined exactly as
> > - * before, even though qmp-commands.hx is gone.
> > - *
> > - * FIXME Educate the QAPI schema on configuration-specific commands,
> > - * and drop this hack.
> > - */
> > -static void qmp_unregister_commands_hack(void)
> > -{
> > -#if !defined(TARGET_PPC) && !defined(TARGET_ARM) &&
> !defined(TARGET_I386) \
> > -    && !defined(TARGET_S390X)
> > -    qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
> > -#endif
> > -}
> > -
>
> Very nice to see this gone.  Its removal could be made a separate commit
> to highlight the achievement :)
>
> There are a few more candidates:
>
> * QERR_FEATURE_DISABLED leads me to
>   - query-hotpluggable-cpus via monitor.c
>   - x-colo-lost-heartbeat via colo-failover.c
>   - query-rocker, query-rocker-ports, query-rocker-of-dpa-flows,
>     query-rocker-of-dpa-groups via qmp-norocker.c
>
> * QERR_UNSUPPORTED leads me to
>   - dump-guest-memory via dump_init() and stubs/dump.c
>   - query-vm-generation-id via stubs/vmgenid.c
>   - inject-nmi via nmi_monitor_handle() and s390_nmi()
>   - query-pci via pci-stub.c
>
> * grep error_set stubs/* doesn't find more
>

I have started to look at other opportunities in
https://github.com/elmarco/qemu/commits/qapi-if-more, but I have to revisit
that once we have that series ready. I guess this could be done case by
case later, and collaboratively.

Thanks for the review so far, I'll get back to it soon.


> >  void monitor_init_qmp_commands(void)
> >  {
> >      /*
> > @@ -995,8 +975,6 @@ void monitor_init_qmp_commands(void)
> >      qmp_register_command(&qmp_commands, "netdev_add", qmp_netdev_add,
> >                           QCO_NO_OPTIONS);
> >
> > -    qmp_unregister_commands_hack();
> > -
> >      QTAILQ_INIT(&qmp_cap_negotiation_commands);
> >      qmp_register_command(&qmp_cap_negotiation_commands,
> "qmp_capabilities",
> >                           qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS)=
;
> > diff --git a/qmp.c b/qmp.c
> > index afa266ec1e..d57ccf1251 100644
> > --- a/qmp.c
> > +++ b/qmp.c
> > @@ -541,11 +541,6 @@ DevicePropertyInfoList
> *qmp_device_list_properties(const char *typename,
> >      return prop_list;
> >  }
> >
> > -CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> > -{
> > -    return arch_query_cpu_definitions(errp);
> > -}
> > -
> >  void qmp_add_client(const char *protocol, const char *fdname,
> >                      bool has_skipauth, bool skipauth, bool has_tls,
> bool tls,
> >                      Error **errp)
> > diff --git a/stubs/arch-query-cpu-def.c b/stubs/arch-query-cpu-def.c
> > deleted file mode 100644
> > index cefe4beb82..0000000000
> > --- a/stubs/arch-query-cpu-def.c
> > +++ /dev/null
> > @@ -1,10 +0,0 @@
> > -#include "qemu/osdep.h"
> > -#include "qemu-common.h"
> > -#include "sysemu/arch_init.h"
> > -#include "qapi/qmp/qerror.h"
> > -
> > -CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
> > -{
> > -    error_setg(errp, QERR_UNSUPPORTED);
> > -    return NULL;
> > -}
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 4ed32c56b8..ec644f3930 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -15,6 +15,7 @@
> >  #include <zlib.h> /* For crc32 */
> >  #include "exec/semihost.h"
> >  #include "sysemu/kvm.h"
> > +#include "qmp-commands.h"
> >
> >  #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurabl=
e
> */
> >
> > @@ -5336,7 +5337,7 @@ static void arm_cpu_add_definition(gpointer data,
> gpointer user_data)
> >      *cpu_list =3D entry;
> >  }
> >
> > -CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
> > +CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> >  {
> >      CpuDefinitionInfoList *cpu_list =3D NULL;
> >      GSList *list;
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index d683e70a13..e5f61f6bff 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -36,6 +36,7 @@
> >  #include "qapi/visitor.h"
> >  #include "qom/qom-qobject.h"
> >  #include "sysemu/arch_init.h"
> > +#include "qmp-commands.h"
> >
> >  #if defined(CONFIG_KVM)
> >  #include <linux/kvm_para.h>
> > @@ -2318,7 +2319,7 @@ static void x86_cpu_definition_entry(gpointer
> data, gpointer user_data)
> >      *cpu_list =3D entry;
> >  }
> >
> > -CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
> > +CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> >  {
> >      CpuDefinitionInfoList *cpu_list =3D NULL;
> >      GSList *list =3D get_sorted_cpu_model_list();
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index 01723bdfec..2a2d62e5bb 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -34,6 +34,7 @@
> >  #include "hw/ppc/ppc.h"
> >  #include "mmu-book3s-v3.h"
> >  #include "sysemu/qtest.h"
> > +#include "qmp-commands.h"
> >
> >  //#define PPC_DUMP_CPU
> >  //#define PPC_DEBUG_SPR
> > @@ -10391,7 +10392,7 @@ static void ppc_cpu_defs_entry(gpointer data,
> gpointer user_data)
> >      *first =3D entry;
> >  }
> >
> > -CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
> > +CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> >  {
> >      CpuDefinitionInfoList *cpu_list =3D NULL;
> >      GSList *list;
> > diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> > index 863dce064f..8021dda341 100644
> > --- a/target/s390x/cpu_models.c
> > +++ b/target/s390x/cpu_models.c
> > @@ -387,7 +387,7 @@ static void create_cpu_model_list(ObjectClass
> *klass, void *opaque)
> >      *cpu_list =3D entry;
> >  }
> >
> > -CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
> > +CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> >  {
> >      struct CpuDefinitionInfoListData list_data =3D {
> >          .list =3D NULL,
> > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> > index dcfe6f49f9..71af433f6b 100644
> > --- a/stubs/Makefile.objs
> > +++ b/stubs/Makefile.objs
> > @@ -1,4 +1,3 @@
> > -stub-obj-y +=3D arch-query-cpu-def.o
> >  stub-obj-y +=3D bdrv-next-monitor-owned.o
> >  stub-obj-y +=3D blk-commit-all.o
> >  stub-obj-y +=3D blockdev-close-all-bdrv-states.o
>
> --
Marc-Andr=C3=A9 Lureau
