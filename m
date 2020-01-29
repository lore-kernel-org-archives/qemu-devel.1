Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30935C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF30620708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpF52mRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF30620708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjNc-00039z-5o
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwjMN-0002By-FM
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwjMM-0000cd-1c
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:10:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53465
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwjML-0000ZU-Tz
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580289004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Daza2dmHFFVOmSy/Q0vuHvQ6xOpfm6LJkoD7pXLCPxg=;
 b=TpF52mRnBLjvO8ZzVUgydr/OG19spOWf7wkQfncrV5Xevjv8tHX0NSimKPgqIPDe8tsQ8O
 wt3/5Jtk1EvYpmJwyEr9enmBa9tbvWt9n/LzbOH7N6acF4zmGXBLtttPJs85JsU5LvB/+I
 ByKu0HmEKVDfkpnP0mK8kVYbPvEOqBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-bfIxYeOHMwSwhSjLnBdgaw-1; Wed, 29 Jan 2020 04:09:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57701107ACC5;
 Wed, 29 Jan 2020 09:09:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-205.ams2.redhat.com [10.36.116.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 684BD1000322;
 Wed, 29 Jan 2020 09:09:55 +0000 (UTC)
Date: Wed, 29 Jan 2020 10:09:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/4] qapi: Create module 'control'
Message-ID: <20200129090953.GA5690@linux.fritz.box>
References: <20200128175211.30007-1-kwolf@redhat.com>
 <20200128175211.30007-3-kwolf@redhat.com>
 <8736by4q3m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <8736by4q3m.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: bfIxYeOHMwSwhSjLnBdgaw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.01.2020 um 09:35 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > misc.json contains definitions that are related to the system emulator,
> > so it can't be used for other tools like the storage daemon. This patch
> > moves basic functionality that is shared between all tools (and mostly
> > related to the monitor itself) into a new control.json, which could be
> > used in tools as well.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/control.json          | 218 +++++++++++++++++++++++++++++++++++++
> >  qapi/misc.json             | 212 ------------------------------------
> >  qapi/qapi-schema.json      |   1 +
> >  monitor/monitor-internal.h |   1 +
> >  monitor/hmp-cmds.c         |   1 +
> >  monitor/misc.c             |   1 +
> >  monitor/qmp-cmds.c         |   1 +
> >  monitor/qmp.c              |   2 +-
> >  tests/qtest/qmp-test.c     |   2 +-
> >  ui/gtk.c                   |   1 +
> >  qapi/Makefile.objs         |   6 +-
> >  11 files changed, 229 insertions(+), 217 deletions(-)
> >  create mode 100644 qapi/control.json
> >
> > diff --git a/qapi/control.json b/qapi/control.json
> > new file mode 100644
> > index 0000000000..a82a18da1a
> > --- /dev/null
> > +++ b/qapi/control.json
> > @@ -0,0 +1,218 @@
> > +# -*- Mode: Python -*-
> > +#
> > +
>=20
> Let's add a copyright notice:
>=20
>    # Copyright (C) 2011-2020 Red Hat, Inc.
>    #
>    # This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>    # See the COPYING file in the top-level directory.

I'm not adding anything new, but just moving code from a file that
doesn't have a copyright notice. In fact, almost none of the schema
files have a copyright notice. I'm not comfortable adding legal
assertions without verifying that they are correct, and certainly not as
a side-effect of a code movement patch. This would be an unrelated
change.

I suggest that we leave this patch as is, and if you think copyright
notices should be added, the correct information can be tracked down
and added consistently for all schema files in a separate series.

> > +##
> > +# =3D Monitor definitions (shared between system emulator and tools)
> > +##
>=20
> This comment does double-duty: it's for readers of this source file, and
> for readers of generated docs/interop/qemu-qmp-ref.*.  It's okay for
> the former, but not the latter, as the resulting table of contents
> shows:
> [...]

> Proposed header:
>=20
>     # =3D QMP monitor control

Works for me.

> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index 9751b11f8f..61fd91ede7 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -103,6 +103,7 @@
> >  { 'include': 'qdev.json' }
> >  { 'include': 'machine.json' }
> >  { 'include': 'machine-target.json' }
> > +{ 'include': 'control.json' }
> >  { 'include': 'misc.json' }
> >  { 'include': 'misc-target.json' }
> >  { 'include': 'audio.json' }
>=20
> This determines position within docs/interop/qemu-qmp-ref.*.  Next to
> misc.json is the least change.  Perhaps putting it next to
> introspect.json would be better.
>=20
> If we split @quit off control.json, then we could include the .json
> providing @quit next to @stop & friends.  Again, I'm not demanding such
> a split.

I'll put it before introspect.json for now.

I don't think the whole order is overly meaningful and it could use some
rearrangement in general. Again, unrelated to this series.

> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index d78f5ca190..4d402ded85 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -27,6 +27,7 @@
> > =20
> >  #include "chardev/char-fe.h"
> >  #include "monitor/monitor.h"
> > +#include "qapi/qapi-types-control.h"
> >  #include "qapi/qmp/dispatch.h"
> >  #include "qapi/qmp/json-parser.h"
> >  #include "qemu/readline.h"
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index d0e0af893a..abb052836b 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -33,6 +33,7 @@
> >  #include "qapi/qapi-commands-char.h"
> >  #include "qapi/qapi-commands-migration.h"
> >  #include "qapi/qapi-commands-misc.h"
> > +#include "qapi/qapi-commands-control.h"
> >  #include "qapi/qapi-commands-net.h"
> >  #include "qapi/qapi-commands-rocker.h"
> >  #include "qapi/qapi-commands-run-state.h"
>=20
> Please keep the qapi/qapi-commands-* sorted, like you do ...

It is sorted! It's exactly where you would expect "-monitor"... *sigh*

/me goes back to finding each #include and moving it.
/me hates renaming header files.

> > diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> > index a8f1f4c35e..20fcc37c2c 100644
> > --- a/qapi/Makefile.objs
> > +++ b/qapi/Makefile.objs
> > @@ -5,9 +5,9 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
> >  util-obj-y +=3D qmp-event.o
> >  util-obj-y +=3D qapi-util.o
> > =20
> > -QAPI_COMMON_MODULES =3D audio authz block-core block char common crypt=
o
> > -QAPI_COMMON_MODULES +=3D dump error introspect job machine migration m=
isc net
> > -QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
> > +QAPI_COMMON_MODULES =3D audio authz block-core block char common contr=
ol crypto
> > +QAPI_COMMON_MODULES +=3D dump error introspect job machine migration m=
isc
> > +QAPI_COMMON_MODULES +=3D net qdev qom rdma rocker run-state sockets tp=
m
> >  QAPI_COMMON_MODULES +=3D trace transaction ui
> >  QAPI_TARGET_MODULES =3D machine-target misc-target
> >  QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
>=20
> With the comments and the include directives tidied up:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks. (I assume this means even without the copyright header.)

Kevin


