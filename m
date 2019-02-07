Received: from eggs.gnu.org ([209.51.188.92]:49332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grhfC-00045T-Ag
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grhfA-0004k9-T0
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:16:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grhfA-0004jy-Nu
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:16:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id m17so6196865qki.5
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 03:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-6-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-6-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Feb 2019 12:16:00 +0100
Message-ID: <CAMxuvayyrBh=XCifqnKPBdcLEm_Y9MYqs=ixM8f0dxWsTKzt4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/17] qapi: Generate QAPIEvent stuff
 into separate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Feb 6, 2019 at 7:17 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Having to include qapi-events.h just for QAPIEvent is suboptimal, but
> quite tolerable now.  It'll become problematic when we have events
> conditional on the target, because then qapi-events.h won't be usable
> from target-independent code anymore.  Avoid that by generating it
> into separate files.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  .gitignore                   |  1 +
>  Makefile                     |  1 +
>  Makefile.objs                |  1 +
>  docs/devel/qapi-code-gen.txt | 48 ++++++++++++++++++++++++------------
>  monitor.c                    |  2 +-
>  scripts/qapi/events.py       | 32 +++++++++++++++---------
>  stubs/monitor.c              |  2 +-
>  tests/test-qmp-event.c       |  1 +
>  ui/vnc.c                     |  3 ++-
>  9 files changed, 61 insertions(+), 30 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 0430257313..6d66daf713 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -32,6 +32,7 @@
>  /qapi/qapi-builtin-visit.[ch]
>  /qapi/qapi-commands-*.[ch]
>  /qapi/qapi-commands.[ch]
> +/qapi/qapi-emit-events.[ch]
>  /qapi/qapi-events-*.[ch]
>  /qapi/qapi-events.[ch]
>  /qapi/qapi-introspect.[ch]
> diff --git a/Makefile b/Makefile
> index 1278a3eb52..cd13e26c88 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -101,6 +101,7 @@ GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qap=
i-visit-%.c)
>  GENERATED_QAPI_FILES +=3D qapi/qapi-commands.h qapi/qapi-commands.c
>  GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.h)
>  GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-commands-%.c)
> +GENERATED_QAPI_FILES +=3D qapi/qapi-emit-events.h qapi/qapi-emit-events.=
c
>  GENERATED_QAPI_FILES +=3D qapi/qapi-events.h qapi/qapi-events.c
>  GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.h)
>  GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.c)
> diff --git a/Makefile.objs b/Makefile.objs
> index 67a054b08a..c463899df3 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -12,6 +12,7 @@ util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-types-%.o)
>  util-obj-y +=3D qapi/qapi-builtin-visit.o
>  util-obj-y +=3D qapi/qapi-visit.o
>  util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-visit-%.o)
> +util-obj-y +=3D qapi/qapi-emit-events.o
>  util-obj-y +=3D qapi/qapi-events.o
>  util-obj-y +=3D $(QAPI_MODULES:%=3Dqapi/qapi-events-%.o)
>  util-obj-y +=3D qapi/qapi-introspect.o
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index c9ba8ddb2e..b517b0cfbf 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1381,11 +1381,15 @@ qapi_event_send_EVENT().
>
>  The following files are created:
>
> -$(prefix)qapi-events.h - Function prototypes for each event type, plus a=
n
> -                        enumeration of all event names
> +$(prefix)qapi-events.h - Function prototypes for each event type
>
>  $(prefix)qapi-events.c - Implementation of functions to send an event
>
> +$(prefix)qapi-emit-events.h - Enumeration of all event names, and
> +                              common event code declarations
> +
> +$(prefix)qapi-emit-events.c - Common event code definitions
> +
>  Example:
>
>      $ cat qapi-generated/example-qapi-events.h
> @@ -1397,9 +1401,32 @@ Example:
>      #include "qapi/util.h"
>      #include "example-qapi-types.h"
>
> -
>      void qapi_event_send_my_event(void);
>
> +    #endif /* EXAMPLE_QAPI_EVENTS_H */
> +    $ cat qapi-generated/example-qapi-events.c
> +[Uninteresting stuff omitted...]
> +
> +    void qapi_event_send_my_event(void)
> +    {
> +        QDict *qmp;
> +
> +        qmp =3D qmp_event_build_dict("MY_EVENT");
> +
> +        example_qapi_event_emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
> +
> +        qobject_unref(qmp);
> +    }
> +
> +[Uninteresting stuff omitted...]
> +    $ cat qapi-generated/example-qapi-emit-events.h
> +[Uninteresting stuff omitted...]
> +
> +    #ifndef EXAMPLE_QAPI_EMIT_EVENTS_H
> +    #define EXAMPLE_QAPI_EMIT_EVENTS_H
> +
> +    #include "qapi/util.h"
> +
>      typedef enum example_QAPIEvent {
>          EXAMPLE_QAPI_EVENT_MY_EVENT,
>          EXAMPLE_QAPI_EVENT__MAX,
> @@ -1412,21 +1439,10 @@ Example:
>
>      void example_qapi_event_emit(example_QAPIEvent event, QDict *qdict);
>
> -    #endif /* EXAMPLE_QAPI_EVENTS_H */
> -    $ cat qapi-generated/example-qapi-events.c
> +    #endif /* EXAMPLE_QAPI_EMIT_EVENTS_H */
> +    $ cat qapi-generated/example-qapi-emit-events.c
>  [Uninteresting stuff omitted...]
>
> -    void qapi_event_send_my_event(void)
> -    {
> -        QDict *qmp;
> -
> -        qmp =3D qmp_event_build_dict("MY_EVENT");
> -
> -        example_qapi_event_emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
> -
> -        qobject_unref(qmp);
> -    }
> -
>      const QEnumLookup example_QAPIEvent_lookup =3D {
>          .array =3D (const char *const[]) {
>              [EXAMPLE_QAPI_EVENT_MY_EVENT] =3D "MY_EVENT",
> diff --git a/monitor.c b/monitor.c
> index c09fa63940..20d8e2e2aa 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -75,7 +75,7 @@
>  #include "qemu/thread.h"
>  #include "block/qapi.h"
>  #include "qapi/qapi-commands.h"
> -#include "qapi/qapi-events.h"
> +#include "qapi/qapi-emit-events.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp-event.h"
>  #include "qapi/qapi-introspect.h"
> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index 6f39cf8196..28bbc3745d 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -143,12 +143,14 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
>          self._event_emit_name =3D c_name(prefix + 'qapi_event_emit')
>
>      def _begin_user_module(self, name):
> +        events =3D self._module_basename('qapi-events', name)
>          types =3D self._module_basename('qapi-types', name)
>          visit =3D self._module_basename('qapi-visit', name)
>          self._genc.add(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> -#include "%(prefix)sqapi-events.h"
> +#include "%(prefix)sqapi-emit-events.h"
> +#include "%(events)s.h"
>  #include "%(visit)s.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
> @@ -156,26 +158,34 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCV=
isitor):
>  #include "qapi/qmp-event.h"
>
>  ''',
> -                             visit=3Dvisit, prefix=3Dself._prefix))
> +                             events=3Devents, visit=3Dvisit,
> +                             prefix=3Dself._prefix))
>          self._genh.add(mcgen('''
>  #include "qapi/util.h"
>  #include "%(types)s.h"
> -
>  ''',
>                               types=3Dtypes))
>
>      def visit_end(self):
> -        (genc, genh) =3D self._module[self._main_module]
> -        genh.add(gen_enum(self._event_enum_name,
> -                          self._event_enum_members))
> -        genc.add(gen_enum_lookup(self._event_enum_name,
> -                                 self._event_enum_members))
> -        genh.add(mcgen('''
> +        self._add_system_module('emit', ' * QAPI Events emission')
> +        self._genc.preamble_add(mcgen('''
> +#include "qemu/osdep.h"
> +#include "%(prefix)sqapi-emit-events.h"
> +''',
> +                                      prefix=3Dself._prefix))
> +        self._genh.preamble_add(mcgen('''
> +#include "qapi/util.h"
> +'''))
> +        self._genh.add(gen_enum(self._event_enum_name,
> +                                self._event_enum_members))
> +        self._genc.add(gen_enum_lookup(self._event_enum_name,
> +                                       self._event_enum_members))
> +        self._genh.add(mcgen('''
>
>  void %(event_emit)s(%(event_enum)s event, QDict *qdict);
>  ''',
> -                       event_emit=3Dself._event_emit_name,
> -                       event_enum=3Dself._event_enum_name))
> +                             event_emit=3Dself._event_emit_name,
> +                             event_enum=3Dself._event_enum_name))
>
>      def visit_event(self, name, info, ifcond, arg_type, boxed):
>          with ifcontext(ifcond, self._genh, self._genc):
> diff --git a/stubs/monitor.c b/stubs/monitor.c
> index 32bd7012c3..b57fe6c32f 100644
> --- a/stubs/monitor.c
> +++ b/stubs/monitor.c
> @@ -1,6 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-events.h"
> +#include "qapi/qapi-emit-events.h"
>  #include "qemu-common.h"
>  #include "monitor/monitor.h"
>
> diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
> index bf900f14f4..eee7e08ab6 100644
> --- a/tests/test-qmp-event.c
> +++ b/tests/test-qmp-event.c
> @@ -21,6 +21,7 @@
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/qmp-event.h"
>  #include "test-qapi-events.h"
> +#include "test-qapi-emit-events.h"
>
>  typedef struct TestEventData {
>      QDict *expect;
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 6002d09407..284ea824d0 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -35,7 +35,8 @@
>  #include "qemu/timer.h"
>  #include "qemu/acl.h"
>  #include "qemu/config-file.h"
> -#include "qapi/qapi-events.h"
> +#include "qapi/qapi-emit-events.h"
> +#include "qapi/qapi-events-ui.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-ui.h"
>  #include "ui/input.h"
> --
> 2.17.2
>
