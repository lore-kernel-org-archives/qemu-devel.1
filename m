Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC628C17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC11222CE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBY6nPzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC11222CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUX8G-0005Or-NV
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iUX6y-0004iU-1t
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iUX6u-0005Qb-Rz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:25:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iUX6u-0005QG-OK
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573568736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ASHRBNxECsLe69ZT9NZxuNZrC8PQlxuUTfYmgWgMY3s=;
 b=RBY6nPzdZLB7Px/rS10Z99xQGeicxGjy4p7xWXj6ofr03mTuwLgR13Jtjnjlm7PQYZA+aw
 0TxVjeqeYY8IBBqXWBDamwj8YnoLKsx/U60l7B8MkLCgc31CGFxEih2jvOwNm9mH998Cgd
 yR0x4SG9dXwsuWMPeHYz8xSl2A8qEMQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-fWtB_gZLO8-o6SSlbDhgmw-1; Tue, 12 Nov 2019 09:25:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13D70107ACC6;
 Tue, 12 Nov 2019 14:25:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F80060C4E;
 Tue, 12 Nov 2019 14:25:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D8B081138648; Tue, 12 Nov 2019 15:25:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 18/18] qemu-storage-daemon: Add --monitor option
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-19-kwolf@redhat.com>
Date: Tue, 12 Nov 2019 15:25:29 +0100
In-Reply-To: <20191017130204.16131-19-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:02:04 +0200")
Message-ID: <87imnpgoiu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: fWtB_gZLO8-o6SSlbDhgmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> This adds and parses the --monitor option, so that a QMP monitor can be
> used in the storage daemon. The monitor offers commands defined in the
> QAPI schema at storage-daemon/qapi/qapi-schema.json.

I feel we should explain the module sharing between the two QAPI
schemata here.  It's not exactly trivial, as we'll see below.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  storage-daemon/qapi/qapi-schema.json | 15 ++++++++++++
>  qemu-storage-daemon.c                | 34 ++++++++++++++++++++++++++++
>  Makefile                             | 30 ++++++++++++++++++++++++
>  Makefile.objs                        |  4 ++--
>  monitor/Makefile.objs                |  2 ++
>  qapi/Makefile.objs                   |  5 ++++
>  qom/Makefile.objs                    |  1 +
>  scripts/qapi/gen.py                  |  5 ++++
>  storage-daemon/Makefile.objs         |  1 +
>  storage-daemon/qapi/Makefile.objs    |  1 +
>  10 files changed, 96 insertions(+), 2 deletions(-)
>  create mode 100644 storage-daemon/qapi/qapi-schema.json
>  create mode 100644 storage-daemon/Makefile.objs
>  create mode 100644 storage-daemon/qapi/Makefile.objs
>
> diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/q=
api-schema.json
> new file mode 100644
> index 0000000000..58c561ebea
> --- /dev/null
> +++ b/storage-daemon/qapi/qapi-schema.json
> @@ -0,0 +1,15 @@
> +# -*- Mode: Python -*-
> +
> +{ 'include': '../../qapi/pragma.json' }
> +
> +{ 'include': '../../qapi/block.json' }
> +{ 'include': '../../qapi/block-core.json' }
> +{ 'include': '../../qapi/char.json' }
> +{ 'include': '../../qapi/common.json' }
> +{ 'include': '../../qapi/crypto.json' }
> +{ 'include': '../../qapi/introspect.json' }
> +{ 'include': '../../qapi/job.json' }
> +{ 'include': '../../qapi/monitor.json' }
> +{ 'include': '../../qapi/qom.json' }
> +{ 'include': '../../qapi/sockets.json' }
> +{ 'include': '../../qapi/transaction.json' }
> diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
> index 46e0a6ea56..4939e6b41f 100644
> --- a/qemu-storage-daemon.c
> +++ b/qemu-storage-daemon.c
> @@ -28,12 +28,16 @@
>  #include "block/nbd.h"
>  #include "chardev/char.h"
>  #include "crypto/init.h"
> +#include "monitor/monitor.h"
> +#include "monitor/monitor-internal.h"
> =20
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-block.h"
>  #include "qapi/qapi-commands-block-core.h"
> +#include "qapi/qapi-commands-monitor.h"

Aren't these three redundant with ...

>  #include "qapi/qapi-visit-block.h"
>  #include "qapi/qapi-visit-block-core.h"
> +#include "qapi/qmp/qstring.h"
>  #include "qapi/qobject-input-visitor.h"
> =20
>  #include "qemu-common.h"
> @@ -46,6 +50,8 @@
>  #include "qemu/option.h"
>  #include "qom/object_interfaces.h"
> =20
> +#include "storage-daemon/qapi/qapi-commands.h"
> +

... this one now?

>  #include "sysemu/runstate.h"
>  #include "trace/control.h"
> =20
> @@ -58,6 +64,11 @@ void qemu_system_killed(int signal, pid_t pid)
>      exit_requested =3D true;
>  }
> =20
> +void qmp_quit(Error **errp)
> +{
> +    exit_requested =3D true;
> +}
> +
>  static void help(void)
>  {
>      printf(
> @@ -101,6 +112,7 @@ enum {
>      OPTION_OBJECT =3D 256,
>      OPTION_BLOCKDEV,
>      OPTION_CHARDEV,
> +    OPTION_MONITOR,
>      OPTION_NBD_SERVER,
>      OPTION_EXPORT,
>  };

Recommend to keep these sorted alphabetically.

> @@ -116,6 +128,17 @@ static QemuOptsList qemu_object_opts =3D {
>      },
>  };
> =20
> +static void init_qmp_commands(void)
> +{
> +    qmp_init_marshal(&qmp_commands);
> +    qmp_register_command(&qmp_commands, "query-qmp-schema",
> +                         qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
> +
> +    QTAILQ_INIT(&qmp_cap_negotiation_commands);
> +    qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilitie=
s",
> +                         qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONF=
IG);
> +}

Duplicates monitor_init_qmp_commands() less two 'gen': false commands
that don't exist in the storage daemon.

Hmm, could we let commands.py generate command registration even for
'gen': false commands?

> +
>  static void init_export(BlockExport *export, Error **errp)
>  {
>      switch (export->type) {
> @@ -138,6 +161,7 @@ static int process_options(int argc, char *argv[], Er=
ror **errp)
>          {"object", required_argument, 0, OPTION_OBJECT},
>          {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
>          {"chardev", required_argument, 0, OPTION_CHARDEV},
> +        {"monitor", required_argument, 0, OPTION_MONITOR},
>          {"nbd-server", required_argument, 0, OPTION_NBD_SERVER},
>          {"export", required_argument, 0, OPTION_EXPORT},
>          {"version", no_argument, 0, 'V'},
> @@ -208,6 +232,14 @@ static int process_options(int argc, char *argv[], E=
rror **errp)
>                  qemu_opts_del(opts);
>                  break;
>              }
> +        case OPTION_MONITOR:
> +            {
> +                QemuOpts *opts =3D qemu_opts_parse(&qemu_mon_opts,
> +                                                 optarg, true, &error_fa=
tal);
> +                monitor_init_opts(opts, false, &error_fatal);
> +                qemu_opts_del(opts);
> +                break;
> +            }
>          case OPTION_NBD_SERVER:
>              {
>                  Visitor *v;

Recommend to keep the switch cases sorted.  Perhaps put help first.
Order the short options string and the long_options[] array to match.

> @@ -272,6 +304,8 @@ int main(int argc, char *argv[])
>      qemu_add_opts(&qemu_trace_opts);
>      qcrypto_init(&error_fatal);
>      bdrv_init();
> +    monitor_init_globals_core();
> +    init_qmp_commands();
> =20
>      if (qemu_init_main_loop(&local_err)) {
>          error_report_err(local_err);
> diff --git a/Makefile b/Makefile
> index 0e3e98582d..e367d2b28a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -121,7 +121,26 @@ GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/qa=
pi-events-%.c)
>  GENERATED_QAPI_FILES +=3D qapi/qapi-introspect.c qapi/qapi-introspect.h
>  GENERATED_QAPI_FILES +=3D qapi/qapi-doc.texi
> =20
> +GENERATED_STORAGE_DAEMON_QAPI_FILES =3D storage-daemon/qapi/qapi-builtin=
-types.h
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-builti=
n-types.c
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-builti=
n-visit.h
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-builti=
n-visit.c

Any particular reason for not reusing qapi/qapi-builtin-*?  See also the
recipe for storage-daemon/qapi/qapi-gen-timestamp below.

> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-comman=
ds.h
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-comman=
ds.c
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-emit-e=
vents.h
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-emit-e=
vents.c
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-events=
.h
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-events=
.c
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-intros=
pect.h
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-intros=
pect.c
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-types.=
h
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-types.=
c
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-visit.=
h
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-visit.=
c
> +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-doc.te=
xi

These are the files generated for the storage daemon's main module.  The
files generated for its sub-modules (all shared right now) are absent.
I think this could use a comment.

See also scripts/qapi/gen.py below.

> +
>  generated-files-y +=3D $(GENERATED_QAPI_FILES)
> +generated-files-y +=3D $(GENERATED_STORAGE_DAEMON_QAPI_FILES)
> =20
>  generated-files-y +=3D trace/generated-tcg-tracers.h
> =20
> @@ -616,6 +635,17 @@ qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
>  =09=09"GEN","$(@:%-timestamp=3D%)")
>  =09@>$@
> =20
> +qapi-modules-storage-daemon =3D \
> +=09$(SRC_PATH)/storage-daemon/qapi/qapi-schema.json \
> +    $(QAPI_MODULES_STORAGE_DAEMON:%=3D$(SRC_PATH)/qapi/%.json)
> +
> +$(GENERATED_STORAGE_DAEMON_QAPI_FILES): storage-daemon/qapi/qapi-gen-tim=
estamp ;
> +storage-daemon/qapi/qapi-gen-timestamp: $(qapi-modules-storage-daemon) $=
(qapi-py)
> +=09$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
> +=09=09-o "storage-daemon/qapi" -b $<, \

If we can reuse qapi/qapi-builtin-*, then omit -b to suppress generating
redundant copies.

> +=09=09"GEN","$(@:%-timestamp=3D%)")
> +=09@>$@
> +
>  QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-=
visit.h qga-qapi-commands.h)
>  $(qga-obj-y): $(QGALIB_GEN)
> =20
> diff --git a/Makefile.objs b/Makefile.objs
> index b667d3f07b..d4e0daddee 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -41,8 +41,8 @@ io-obj-y =3D io/
>  # storage-daemon-obj-y is code used by qemu-storage-daemon (these object=
s are
>  # used for system emulation, too, but specified separately there)
> =20
> -storage-daemon-obj-y =3D block/
> -storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
> +storage-daemon-obj-y =3D block/ monitor/ qapi/ qom/ storage-daemon/
> +storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o job-qmp.o
>  storage-daemon-obj-$(CONFIG_WIN32) +=3D os-win32.o
>  storage-daemon-obj-$(CONFIG_POSIX) +=3D os-posix.o
> =20
> diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
> index 15eb6380c5..6e4ef60601 100644
> --- a/monitor/Makefile.objs
> +++ b/monitor/Makefile.objs
> @@ -2,3 +2,5 @@ obj-y +=3D misc.o
>  common-obj-y +=3D monitor.o qmp.o hmp.o
>  common-obj-y +=3D qmp-cmds.o qmp-cmds-monitor.o
>  common-obj-y +=3D hmp-cmds.o
> +
> +storage-daemon-obj-y +=3D monitor.o qmp.o qmp-cmds-monitor.o
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index 3e04e299ed..03d256f0a4 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -30,3 +30,8 @@ obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
>  obj-y +=3D qapi-events.o
>  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
>  obj-y +=3D qapi-commands.o
> +
> +QAPI_MODULES_STORAGE_DAEMON =3D block block-core char common crypto intr=
ospect
> +QAPI_MODULES_STORAGE_DAEMON +=3D job monitor qom sockets pragma transact=
ion
> +
> +storage-daemon-obj-y +=3D $(QAPI_MODULES_STORAGE_DAEMON:%=3Dqapi-command=
s-%.o)
> diff --git a/qom/Makefile.objs b/qom/Makefile.objs
> index f9d77350ac..1b45d104ba 100644
> --- a/qom/Makefile.objs
> +++ b/qom/Makefile.objs
> @@ -2,3 +2,4 @@ qom-obj-y =3D object.o container.o qom-qobject.o
>  qom-obj-y +=3D object_interfaces.o
> =20
>  common-obj-$(CONFIG_SOFTMMU) +=3D qom-hmp-cmds.o qom-qmp-cmds.o
> +storage-daemon-obj-y +=3D qom-qmp-cmds.o
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 796c17c38a..c25634f673 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -44,6 +44,11 @@ class QAPIGen(object):
>          return ''
> =20
>      def write(self, output_dir):
> +        # Include paths starting with ../ are used to reuse modules of t=
he main
> +        # schema in specialised schemas. Don't overwrite the files that =
are
> +        # already generated for the main schema.
> +        if self.fname.startswith('../'):
> +            return
>          pathname =3D os.path.join(output_dir, self.fname)
>          dir =3D os.path.dirname(pathname)
>          if dir:

Ugh.

tests/qapi-schema/include/sub-module.json violates the stated assumption
"Include paths starting with ../ are used to reuse modules of the main
schema":

    { 'include': '../sub-sub-module.json' }

Works anyway because it's only used via

    { 'include': 'include/sub-module.json' }

where the ../ is folded with the include/ and vanishes.  self.fname is
relative to the main schema's directory.

Still, baking the assumption into gen.py makes it a part of the QAPI
schema language.  It needs to be documented as such.

Complication: because we generate array types and supporting code code
only when they're actually used, the code generated for a shared module
can depend on how it is used outside the shared module.

Right now, storage-daemon/qapi/qapi-schema.json contains nothing but
modules shared with qapi/qapi-schema.json.  Works.

If storage-daemon/qapi/qapi-schema.json ever acquires an array reference
that is not also in qapi/qapi-schema.json, the generated C won't
compile.

This also needs to be documented because it's anything but obvious.

Instead of suppressing code generated for reused modules outright, we
could somehow avoid clobbering the main schema's output.  I guess we
can't use -p for that, because it makes interferes with reusing the
hand-written QMP code.  Can we make do with -o?

By doing that, we sidestep making ../ special in the QAPI schema
language.  We then have two options for the storage daemon.

One, use the code generated for the storage daemon schema.  Simple,
robust, but we compile more.

Two, we use the code generated for the main schema (same as now).  We
compile less, but expose ourselves to the array problem described
above.

> diff --git a/storage-daemon/Makefile.objs b/storage-daemon/Makefile.objs
> new file mode 100644
> index 0000000000..cfe6beee52
> --- /dev/null
> +++ b/storage-daemon/Makefile.objs
> @@ -0,0 +1 @@
> +storage-daemon-obj-y +=3D qapi/
> diff --git a/storage-daemon/qapi/Makefile.objs b/storage-daemon/qapi/Make=
file.objs
> new file mode 100644
> index 0000000000..df8946bdae
> --- /dev/null
> +++ b/storage-daemon/qapi/Makefile.objs
> @@ -0,0 +1 @@
> +storage-daemon-obj-y +=3D qapi-commands.o qapi-introspect.o

Now let's take a step back and examine the problem this patch solves.

The storage daemon needs a control interface.  Instead of inventing a
new one, we want to reuse QMP, both the protocol and the actual
commands, as far as they make sense in the storage daemon.  Makes sense.

To get the QMP protocol, the storage daemon needs a QAPI schema.

To reuse existing QMP commands, the storage daemon's QAPI schema needs
to include the parts of the existing QAPI schema that define them.

The stupidest possible way to do that is copying.  Unworkable; too much
code, too hard to keep it in sync.

Instead, this patch reuses schema modules.  Summary of issues so far:

* The include directive lets us avoid duplicating schema code, but to
  avoid duplicating the generated code, we resort to a gross hack.

  The hack needs a certain amount of rather awkward documentation (still
  to be written).

  Putting non-shared bits into the storage daemon's schema risks array
  trouble.

  Accepting duplicated generated code might be the lesser evil.

* The discussion of how this module reuse thing works, assumptions,
  shortcomings need to go on the permanent record, be it code comments,
  something in docs/, or at least commit messages.

  Commit messages of PATCH 13 and 16 need to hint at where we're going
  to make sense.  I figure that's easier to do once we got this patch
  into shape.

* We get a bunch of commands that make no sense in the storage daemon,
  see my review of PATCH 04 for examples.

  To avoid that, we need to split modules.  May well be a good idea
  anyway; qapi/block-core.json is by far the fattest module: 850
  non-blank, non-comment lines, 4.5 times fatter than the runner-up
  ui.json.

  Keeping unwanted commands out of the storage daemon will be an ongoing
  process: we need to keep unwanted commands from creeping into modules
  shared with the storage daemon.  Hopefully, properly focused modules
  can make such creep unlikely.

A less hacky solution is to extend the QAPI schema language from one set
of QMP commands and events to many.  Hard to justify when we have just
two sets.

I'm afraid my review isn't a straight "do A, B and C to get my
blessings".  I hope it's useful anyway.


