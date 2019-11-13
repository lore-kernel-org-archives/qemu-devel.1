Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5D0C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEBA222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTIWTeiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEBA222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUqNQ-0007MD-6h
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 05:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iUqMf-0006pc-2T
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iUqMc-0002uC-4s
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:59:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iUqMb-0002t8-Tq
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573642744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dgn2S4LbZyla69mhI+dwazUVMp/ykwm4v3fxxIvCNnU=;
 b=KTIWTeiVig14RGS1/IXVaczUSV7i273lBO5v5Sti6u38/HbI2XiwYLZNGPOtupP6JiHxC5
 1axbixR9DZVAkNfzX7N/r3jWLqBqNwwpWUphvhZXn1BWenMEjCutzhJA2wwFdzcmVaSOXc
 mvM5rFu6/bHhTybhAXtauLTXRqZ3BQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-MJCfb49VMNu7rflCu0RP_w-1; Wed, 13 Nov 2019 05:59:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 710AD8048E2;
 Wed, 13 Nov 2019 10:59:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3C0B60C85;
 Wed, 13 Nov 2019 10:58:59 +0000 (UTC)
Date: Wed, 13 Nov 2019 11:58:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 18/18] qemu-storage-daemon: Add --monitor option
Message-ID: <20191113105858.GC6471@linux.fritz.box>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-19-kwolf@redhat.com>
 <87imnpgoiu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87imnpgoiu.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: MJCfb49VMNu7rflCu0RP_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Am 12.11.2019 um 15:25 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > This adds and parses the --monitor option, so that a QMP monitor can be
> > used in the storage daemon. The monitor offers commands defined in the
> > QAPI schema at storage-daemon/qapi/qapi-schema.json.
>=20
> I feel we should explain the module sharing between the two QAPI
> schemata here.  It's not exactly trivial, as we'll see below.
>=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  storage-daemon/qapi/qapi-schema.json | 15 ++++++++++++
> >  qemu-storage-daemon.c                | 34 ++++++++++++++++++++++++++++
> >  Makefile                             | 30 ++++++++++++++++++++++++
> >  Makefile.objs                        |  4 ++--
> >  monitor/Makefile.objs                |  2 ++
> >  qapi/Makefile.objs                   |  5 ++++
> >  qom/Makefile.objs                    |  1 +
> >  scripts/qapi/gen.py                  |  5 ++++
> >  storage-daemon/Makefile.objs         |  1 +
> >  storage-daemon/qapi/Makefile.objs    |  1 +
> >  10 files changed, 96 insertions(+), 2 deletions(-)
> >  create mode 100644 storage-daemon/qapi/qapi-schema.json
> >  create mode 100644 storage-daemon/Makefile.objs
> >  create mode 100644 storage-daemon/qapi/Makefile.objs
> >
> > diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi=
/qapi-schema.json
> > new file mode 100644
> > index 0000000000..58c561ebea
> > --- /dev/null
> > +++ b/storage-daemon/qapi/qapi-schema.json
> > @@ -0,0 +1,15 @@
> > +# -*- Mode: Python -*-
> > +
> > +{ 'include': '../../qapi/pragma.json' }
> > +
> > +{ 'include': '../../qapi/block.json' }
> > +{ 'include': '../../qapi/block-core.json' }
> > +{ 'include': '../../qapi/char.json' }
> > +{ 'include': '../../qapi/common.json' }
> > +{ 'include': '../../qapi/crypto.json' }
> > +{ 'include': '../../qapi/introspect.json' }
> > +{ 'include': '../../qapi/job.json' }
> > +{ 'include': '../../qapi/monitor.json' }
> > +{ 'include': '../../qapi/qom.json' }
> > +{ 'include': '../../qapi/sockets.json' }
> > +{ 'include': '../../qapi/transaction.json' }
> > diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
> > index 46e0a6ea56..4939e6b41f 100644
> > --- a/qemu-storage-daemon.c
> > +++ b/qemu-storage-daemon.c
> > @@ -28,12 +28,16 @@
> >  #include "block/nbd.h"
> >  #include "chardev/char.h"
> >  #include "crypto/init.h"
> > +#include "monitor/monitor.h"
> > +#include "monitor/monitor-internal.h"
> > =20
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-commands-block.h"
> >  #include "qapi/qapi-commands-block-core.h"
> > +#include "qapi/qapi-commands-monitor.h"
>=20
> Aren't these three redundant with ...
>=20
> >  #include "qapi/qapi-visit-block.h"
> >  #include "qapi/qapi-visit-block-core.h"
> > +#include "qapi/qmp/qstring.h"
> >  #include "qapi/qobject-input-visitor.h"
> > =20
> >  #include "qemu-common.h"
> > @@ -46,6 +50,8 @@
> >  #include "qemu/option.h"
> >  #include "qom/object_interfaces.h"
> > =20
> > +#include "storage-daemon/qapi/qapi-commands.h"
> > +
>=20
> ... this one now?

Looks like it.

> >  #include "sysemu/runstate.h"
> >  #include "trace/control.h"
> > =20
> > @@ -58,6 +64,11 @@ void qemu_system_killed(int signal, pid_t pid)
> >      exit_requested =3D true;
> >  }
> > =20
> > +void qmp_quit(Error **errp)
> > +{
> > +    exit_requested =3D true;
> > +}
> > +
> >  static void help(void)
> >  {
> >      printf(
> > @@ -101,6 +112,7 @@ enum {
> >      OPTION_OBJECT =3D 256,
> >      OPTION_BLOCKDEV,
> >      OPTION_CHARDEV,
> > +    OPTION_MONITOR,
> >      OPTION_NBD_SERVER,
> >      OPTION_EXPORT,
> >  };
>=20
> Recommend to keep these sorted alphabetically.
>=20
> > @@ -116,6 +128,17 @@ static QemuOptsList qemu_object_opts =3D {
> >      },
> >  };
> > =20
> > +static void init_qmp_commands(void)
> > +{
> > +    qmp_init_marshal(&qmp_commands);
> > +    qmp_register_command(&qmp_commands, "query-qmp-schema",
> > +                         qmp_query_qmp_schema, QCO_ALLOW_PRECONFIG);
> > +
> > +    QTAILQ_INIT(&qmp_cap_negotiation_commands);
> > +    qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilit=
ies",
> > +                         qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECO=
NFIG);
> > +}
>=20
> Duplicates monitor_init_qmp_commands() less two 'gen': false commands
> that don't exist in the storage daemon.
>=20
> Hmm, could we let commands.py generate command registration even for
> 'gen': false commands?

Possibly. Are you telling me to do it or is it just an idea for a later
cleanup?

> > +
> >  static void init_export(BlockExport *export, Error **errp)
> >  {
> >      switch (export->type) {
> > @@ -138,6 +161,7 @@ static int process_options(int argc, char *argv[], =
Error **errp)
> >          {"object", required_argument, 0, OPTION_OBJECT},
> >          {"blockdev", required_argument, 0, OPTION_BLOCKDEV},
> >          {"chardev", required_argument, 0, OPTION_CHARDEV},
> > +        {"monitor", required_argument, 0, OPTION_MONITOR},
> >          {"nbd-server", required_argument, 0, OPTION_NBD_SERVER},
> >          {"export", required_argument, 0, OPTION_EXPORT},
> >          {"version", no_argument, 0, 'V'},
> > @@ -208,6 +232,14 @@ static int process_options(int argc, char *argv[],=
 Error **errp)
> >                  qemu_opts_del(opts);
> >                  break;
> >              }
> > +        case OPTION_MONITOR:
> > +            {
> > +                QemuOpts *opts =3D qemu_opts_parse(&qemu_mon_opts,
> > +                                                 optarg, true, &error_=
fatal);
> > +                monitor_init_opts(opts, false, &error_fatal);
> > +                qemu_opts_del(opts);
> > +                break;
> > +            }
> >          case OPTION_NBD_SERVER:
> >              {
> >                  Visitor *v;
>=20
> Recommend to keep the switch cases sorted.  Perhaps put help first.
> Order the short options string and the long_options[] array to match.
>=20
> > @@ -272,6 +304,8 @@ int main(int argc, char *argv[])
> >      qemu_add_opts(&qemu_trace_opts);
> >      qcrypto_init(&error_fatal);
> >      bdrv_init();
> > +    monitor_init_globals_core();
> > +    init_qmp_commands();
> > =20
> >      if (qemu_init_main_loop(&local_err)) {
> >          error_report_err(local_err);
> > diff --git a/Makefile b/Makefile
> > index 0e3e98582d..e367d2b28a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -121,7 +121,26 @@ GENERATED_QAPI_FILES +=3D $(QAPI_MODULES:%=3Dqapi/=
qapi-events-%.c)
> >  GENERATED_QAPI_FILES +=3D qapi/qapi-introspect.c qapi/qapi-introspect.=
h
> >  GENERATED_QAPI_FILES +=3D qapi/qapi-doc.texi
> > =20
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES =3D storage-daemon/qapi/qapi-built=
in-types.h
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-buil=
tin-types.c
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-buil=
tin-visit.h
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-buil=
tin-visit.c
>=20
> Any particular reason for not reusing qapi/qapi-builtin-*?  See also the
> recipe for storage-daemon/qapi/qapi-gen-timestamp below.

Hm, I guess not. I'm just tweaking stuff until it seems to work, and
this seemed to work, so...

But as far as I can see, the generated file are never actually used, so
I'll get rid of them.

> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-comm=
ands.h
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-comm=
ands.c
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-emit=
-events.h
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-emit=
-events.c
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-even=
ts.h
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-even=
ts.c
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-intr=
ospect.h
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-intr=
ospect.c
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-type=
s.h
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-type=
s.c
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-visi=
t.h
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-visi=
t.c
> > +GENERATED_STORAGE_DAEMON_QAPI_FILES +=3D storage-daemon/qapi/qapi-doc.=
texi
>=20
> These are the files generated for the storage daemon's main module.  The
> files generated for its sub-modules (all shared right now) are absent.
> I think this could use a comment.

Ok.

> See also scripts/qapi/gen.py below.
>=20
> > +
> >  generated-files-y +=3D $(GENERATED_QAPI_FILES)
> > +generated-files-y +=3D $(GENERATED_STORAGE_DAEMON_QAPI_FILES)
> > =20
> >  generated-files-y +=3D trace/generated-tcg-tracers.h
> > =20
> > @@ -616,6 +635,17 @@ qapi-gen-timestamp: $(qapi-modules) $(qapi-py)
> >  =09=09"GEN","$(@:%-timestamp=3D%)")
> >  =09@>$@
> > =20
> > +qapi-modules-storage-daemon =3D \
> > +=09$(SRC_PATH)/storage-daemon/qapi/qapi-schema.json \
> > +    $(QAPI_MODULES_STORAGE_DAEMON:%=3D$(SRC_PATH)/qapi/%.json)
> > +
> > +$(GENERATED_STORAGE_DAEMON_QAPI_FILES): storage-daemon/qapi/qapi-gen-t=
imestamp ;
> > +storage-daemon/qapi/qapi-gen-timestamp: $(qapi-modules-storage-daemon)=
 $(qapi-py)
> > +=09$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
> > +=09=09-o "storage-daemon/qapi" -b $<, \
>=20
> If we can reuse qapi/qapi-builtin-*, then omit -b to suppress generating
> redundant copies.
>=20
> > +=09=09"GEN","$(@:%-timestamp=3D%)")
> > +=09@>$@
> > +
> >  QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qap=
i-visit.h qga-qapi-commands.h)
> >  $(qga-obj-y): $(QGALIB_GEN)
> > =20
> > diff --git a/Makefile.objs b/Makefile.objs
> > index b667d3f07b..d4e0daddee 100644
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -41,8 +41,8 @@ io-obj-y =3D io/
> >  # storage-daemon-obj-y is code used by qemu-storage-daemon (these obje=
cts are
> >  # used for system emulation, too, but specified separately there)
> > =20
> > -storage-daemon-obj-y =3D block/
> > -storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o
> > +storage-daemon-obj-y =3D block/ monitor/ qapi/ qom/ storage-daemon/
> > +storage-daemon-obj-y +=3D blockdev.o blockdev-nbd.o iothread.o job-qmp=
.o
> >  storage-daemon-obj-$(CONFIG_WIN32) +=3D os-win32.o
> >  storage-daemon-obj-$(CONFIG_POSIX) +=3D os-posix.o
> > =20
> > diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
> > index 15eb6380c5..6e4ef60601 100644
> > --- a/monitor/Makefile.objs
> > +++ b/monitor/Makefile.objs
> > @@ -2,3 +2,5 @@ obj-y +=3D misc.o
> >  common-obj-y +=3D monitor.o qmp.o hmp.o
> >  common-obj-y +=3D qmp-cmds.o qmp-cmds-monitor.o
> >  common-obj-y +=3D hmp-cmds.o
> > +
> > +storage-daemon-obj-y +=3D monitor.o qmp.o qmp-cmds-monitor.o
> > diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> > index 3e04e299ed..03d256f0a4 100644
> > --- a/qapi/Makefile.objs
> > +++ b/qapi/Makefile.objs
> > @@ -30,3 +30,8 @@ obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
> >  obj-y +=3D qapi-events.o
> >  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
> >  obj-y +=3D qapi-commands.o
> > +
> > +QAPI_MODULES_STORAGE_DAEMON =3D block block-core char common crypto in=
trospect
> > +QAPI_MODULES_STORAGE_DAEMON +=3D job monitor qom sockets pragma transa=
ction
> > +
> > +storage-daemon-obj-y +=3D $(QAPI_MODULES_STORAGE_DAEMON:%=3Dqapi-comma=
nds-%.o)
> > diff --git a/qom/Makefile.objs b/qom/Makefile.objs
> > index f9d77350ac..1b45d104ba 100644
> > --- a/qom/Makefile.objs
> > +++ b/qom/Makefile.objs
> > @@ -2,3 +2,4 @@ qom-obj-y =3D object.o container.o qom-qobject.o
> >  qom-obj-y +=3D object_interfaces.o
> > =20
> >  common-obj-$(CONFIG_SOFTMMU) +=3D qom-hmp-cmds.o qom-qmp-cmds.o
> > +storage-daemon-obj-y +=3D qom-qmp-cmds.o
> > diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> > index 796c17c38a..c25634f673 100644
> > --- a/scripts/qapi/gen.py
> > +++ b/scripts/qapi/gen.py
> > @@ -44,6 +44,11 @@ class QAPIGen(object):
> >          return ''
> > =20
> >      def write(self, output_dir):
> > +        # Include paths starting with ../ are used to reuse modules of=
 the main
> > +        # schema in specialised schemas. Don't overwrite the files tha=
t are
> > +        # already generated for the main schema.
> > +        if self.fname.startswith('../'):
> > +            return
> >          pathname =3D os.path.join(output_dir, self.fname)
> >          dir =3D os.path.dirname(pathname)
> >          if dir:
>=20
> Ugh.

That's why I asked you before writing it like this. :-)

> tests/qapi-schema/include/sub-module.json violates the stated assumption
> "Include paths starting with ../ are used to reuse modules of the main
> schema":
>=20
>     { 'include': '../sub-sub-module.json' }
>=20
> Works anyway because it's only used via
>=20
>     { 'include': 'include/sub-module.json' }
>=20
> where the ../ is folded with the include/ and vanishes.  self.fname is
> relative to the main schema's directory.
>=20
> Still, baking the assumption into gen.py makes it a part of the QAPI
> schema language.  It needs to be documented as such.

Maybe you'd like it better if we made it explicit?

    { 'include': '../../qapi/block.json', 'gen': false }

But how do I actually get this information down to QAPIGen? This brings
us back to the problem that the QAPI generator doesn't really have a
notion of modules, but only entities have a module name and the first
entity to use a module name causes it to be generated. We don't have
access to the QAPISchemaInclude that created the module.

Even the QAPISchema._modules that I introduced only contains filenames.
Should it contain QAPISchemaInclude objects instead?

> Complication: because we generate array types and supporting code code
> only when they're actually used, the code generated for a shared module
> can depend on how it is used outside the shared module.
>=20
> Right now, storage-daemon/qapi/qapi-schema.json contains nothing but
> modules shared with qapi/qapi-schema.json.  Works.
>=20
> If storage-daemon/qapi/qapi-schema.json ever acquires an array reference
> that is not also in qapi/qapi-schema.json, the generated C won't
> compile.
>=20
> This also needs to be documented because it's anything but obvious.

A comment in the storage daemon main module?

> Instead of suppressing code generated for reused modules outright, we
> could somehow avoid clobbering the main schema's output.  I guess we
> can't use -p for that, because it makes interferes with reusing the
> hand-written QMP code.  Can we make do with -o?

I guess we could by artificially generating to a sub-sub-directory, so
that ../../ relative to the output directory specified with -o is still
a directory specific to the storage daemon. Not very nice, though.

It also results in (hopefully!) unused files with duplicate file names
that are supposed to be mostly the same, modulo bugs.

> By doing that, we sidestep making ../ special in the QAPI schema
> language.  We then have two options for the storage daemon.
>=20
> One, use the code generated for the storage daemon schema.  Simple,
> robust, but we compile more.

Not simple at all: What do you mean by "use"? For linking? For compiling
qemu-storage-daemon.c? For compiling blockdev.c?

The latter would mean that we compile everything that uses QAPI types
twice. Considering that we're trying to get rid of per-target
compilation as much as we can, it doesn't appear desirable to start
compiling shared files multiple times for the storage daemon. (I think
you only meant the generated files, not everything that uses QAPI types,
when you said "we compile more"?)

Only compiling a single file with the headers generated from the storage
daemon schema doesn't sound like a great idea either. The storage daemon
headers _should_ be a subset of the main schema ones, but if there is
ever a bug and data structures differ, I don't want to be the poor guy
to debug this. And anyway - you can compile against different versions
of the header, but you can link in only one version of the generated .c
files. I'm not sure what to call this, but "robust" is probably not in
the selection.

> Two, we use the code generated for the main schema (same as now).  We
> compile less, but expose ourselves to the array problem described
> above.

I think we can live with this restriction. If we ever need an array
type only in the storage daemon, we can still define the type that uses
it in the main schema, but leave it unused there.

> > diff --git a/storage-daemon/Makefile.objs b/storage-daemon/Makefile.obj=
s
> > new file mode 100644
> > index 0000000000..cfe6beee52
> > --- /dev/null
> > +++ b/storage-daemon/Makefile.objs
> > @@ -0,0 +1 @@
> > +storage-daemon-obj-y +=3D qapi/
> > diff --git a/storage-daemon/qapi/Makefile.objs b/storage-daemon/qapi/Ma=
kefile.objs
> > new file mode 100644
> > index 0000000000..df8946bdae
> > --- /dev/null
> > +++ b/storage-daemon/qapi/Makefile.objs
> > @@ -0,0 +1 @@
> > +storage-daemon-obj-y +=3D qapi-commands.o qapi-introspect.o
>=20
> Now let's take a step back and examine the problem this patch solves.
>=20
> The storage daemon needs a control interface.  Instead of inventing a
> new one, we want to reuse QMP, both the protocol and the actual
> commands, as far as they make sense in the storage daemon.  Makes sense.
>=20
> To get the QMP protocol, the storage daemon needs a QAPI schema.
>=20
> To reuse existing QMP commands, the storage daemon's QAPI schema needs
> to include the parts of the existing QAPI schema that define them.
>=20
> The stupidest possible way to do that is copying.  Unworkable; too much
> code, too hard to keep it in sync.
>=20
> Instead, this patch reuses schema modules.  Summary of issues so far:
>=20
> * The include directive lets us avoid duplicating schema code, but to
>   avoid duplicating the generated code, we resort to a gross hack.
>=20
>   The hack needs a certain amount of rather awkward documentation (still
>   to be written).

Can possibly be solved by making it explicit.

>   Putting non-shared bits into the storage daemon's schema risks array
>   trouble.
>=20
>   Accepting duplicated generated code might be the lesser evil.

I disagree on this one.

> * The discussion of how this module reuse thing works, assumptions,
>   shortcomings need to go on the permanent record, be it code comments,
>   something in docs/, or at least commit messages.
>=20
>   Commit messages of PATCH 13 and 16 need to hint at where we're going
>   to make sense.  I figure that's easier to do once we got this patch
>   into shape.
>=20
> * We get a bunch of commands that make no sense in the storage daemon,
>   see my review of PATCH 04 for examples.
>=20
>   To avoid that, we need to split modules.  May well be a good idea
>   anyway; qapi/block-core.json is by far the fattest module: 850
>   non-blank, non-comment lines, 4.5 times fatter than the runner-up
>   ui.json.
>=20
>   Keeping unwanted commands out of the storage daemon will be an ongoing
>   process: we need to keep unwanted commands from creeping into modules
>   shared with the storage daemon.  Hopefully, properly focused modules
>   can make such creep unlikely.

Maybe we can have a bit of a protection against this by moving
qmp_get_blk() and friends into a separate file that isn't linked in the
storage daemon and removing blk_by_qdev_id() from the stubs so that the
build fails rather than just getting an error message back from the
QMP command that makes no sense in the storage daemon.

> A less hacky solution is to extend the QAPI schema language from one set
> of QMP commands and events to many.  Hard to justify when we have just
> two sets.

Right, and when the only actual problem is a hypothetical corner case
that can be worked around relatively easily (array types).

Kevin


