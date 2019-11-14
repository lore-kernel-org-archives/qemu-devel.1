Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B249C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 12:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CB0206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 12:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHXMlslU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CB0206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVDto-0004VJ-FX
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 07:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iVDsq-0003gW-V0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iVDso-0006RB-IZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:05:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iVDso-0006Ox-4s
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573733153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTum6zVf+69iriC2PGlHB2azntPShiyeCSjnZ77HP/g=;
 b=UHXMlslUJ9j4LHsOfJHA9DrcvEyQhG15zHyKwElBYJzKhoRgpgtAOjFZwya1JW3Dik9HCt
 qxQagEwtEsjoz5MA5nY0L9pvhNjkDXKQzzPHJBhEDkvte6o8KfrUBNWPV/3kQFsO3MQH1k
 WQDl3RRyqB3w1HcaOjQvb36T/pt5GiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-RHFNjEnrMYmkIai-AJ6UhQ-1; Thu, 14 Nov 2019 07:05:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56EE980451E;
 Thu, 14 Nov 2019 12:05:50 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-103.ams2.redhat.com [10.36.117.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE0BA106F95C;
 Thu, 14 Nov 2019 12:05:48 +0000 (UTC)
Date: Thu, 14 Nov 2019 13:05:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 02/18] qemu-storage-daemon: Add --object option
Message-ID: <20191114120547.GB5735@linux.fritz.box>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-3-kwolf@redhat.com>
 <87o8xns9t9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87o8xns9t9.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: RHFNjEnrMYmkIai-AJ6UhQ-1
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

Am 07.11.2019 um 21:36 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Add a command line option to create user-creatable QOM objects.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qemu-storage-daemon.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
> > index a251dc255c..48d6af43a6 100644
> > --- a/qemu-storage-daemon.c
> > +++ b/qemu-storage-daemon.c
> > @@ -35,6 +35,8 @@
> >  #include "qemu/log.h"
> >  #include "qemu/main-loop.h"
> >  #include "qemu/module.h"
> > +#include "qemu/option.h"
> > +#include "qom/object_interfaces.h"
> > =20
> >  #include "trace/control.h"
> > =20
> > @@ -51,10 +53,26 @@ static void help(void)
> >  "                         specify tracing options\n"
> >  "  -V, --version          output version information and exit\n"
> >  "\n"
> > +"  --object <properties>  define a QOM object such as 'secret' for\n"
> > +"                         passwords and/or encryption keys\n"
>=20
> This is less helpful than qemu-system-FOO's help:
>=20
> -object TYPENAME[,PROP1=3DVALUE1,...]
>                 create a new object of type TYPENAME setting properties
>                 in the order they are specified.  Note that the 'id'
>                 property must be set.  These objects are placed in the
>                 '/objects' path.

Hm, yes. I took the description from the tools. I can switch to the vl.c
one (should the tools, too?).

But honestly, neither of the two is enough to tell anyone how to
actually use this... Considering how many different objects there are,
maybe the best we can do is referring to the man page for details.

> > +"\n"
> >  QEMU_HELP_BOTTOM "\n",
> >      error_get_progname());
> >  }
> > =20
> > +enum {
> > +    OPTION_OBJECT =3D 256,
> > +};
> > +
> > +static QemuOptsList qemu_object_opts =3D {
> > +    .name =3D "object",
> > +    .implied_opt_name =3D "qom-type",
> > +    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
> > +    .desc =3D {
> > +        { }
> > +    },
> > +};
> > +
>=20
> Note for later: copied from vl.c.
>=20
> >  static int process_options(int argc, char *argv[], Error **errp)
> >  {
> >      int c;
> > @@ -63,6 +81,7 @@ static int process_options(int argc, char *argv[], Er=
ror **errp)
> > =20
> >      static const struct option long_options[] =3D {
> >          {"help", no_argument, 0, 'h'},
> > +        {"object", required_argument, 0, OPTION_OBJECT},
> >          {"version", no_argument, 0, 'V'},
> >          {"trace", required_argument, NULL, 'T'},
> >          {0, 0, 0, 0}
> > @@ -88,6 +107,22 @@ static int process_options(int argc, char *argv[], =
Error **errp)
> >              g_free(trace_file);
> >              trace_file =3D trace_opt_parse(optarg);
> >              break;
> > +        case OPTION_OBJECT:
> > +            {
> > +                QemuOpts *opts;
> > +                const char *type;
> > +
> > +                opts =3D qemu_opts_parse(&qemu_object_opts,
> > +                                       optarg, true, &error_fatal);
> > +                type =3D qemu_opt_get(opts, "qom-type");
> > +
> > +                if (user_creatable_print_help(type, opts)) {
> > +                    exit(EXIT_SUCCESS);
> > +                }
> > +                user_creatable_add_opts(opts, &error_fatal);
> > +                qemu_opts_del(opts);
> > +                break;
> > +            }
> >          }
> >      }
> >      if (optind !=3D argc) {
>=20
> PATCH 01 duplicates case QEMU_OPTION_trace pretty much verbatim.  Makes
> sense, as qemu-storage-daemon is basically qemu-system-FOO with "FOO"
> and most "system" cut away.
>=20
> This patch adds vl.c's case QEMU_OPTION_object in a much simpler form.
> This is one of my least favourite options, and I'll tell you why below.
> Let's compare the two versions.
>=20
> vl.c:
>=20
>             case QEMU_OPTION_object:
>                 opts =3D qemu_opts_parse_noisily(qemu_find_opts("object")=
,
>                                                optarg, true);
>                 if (!opts) {
>                     exit(1);
>                 }
>                 break;
>=20
> Further down:
>=20
>     qemu_opts_foreach(qemu_find_opts("object"),
>                       user_creatable_add_opts_foreach,
>                       object_create_initial, &error_fatal);
>=20
> Still further down:
>=20
>     qemu_opts_foreach(qemu_find_opts("object"),
>                       user_creatable_add_opts_foreach,
>                       object_create_delayed, &error_fatal);
>=20
> These are basically
>=20
>     for opts in qemu_object_opts {
>         type =3D qemu_opt_get(opts, "qom-type");
>         if (type) {
>             if (user_creatable_print_help(type, opts)) {
>                 exit(0);
>             }
>             if (!predicate(type)) {
>                 continue;
>             }
>         }
>         obj =3D user_creatable_add_opts(opts, &error_fatal);
>         object_unref(obj);
>     }
>=20
> where predicate(type) is true in exactly one of the two places for each
> QOM type.
>=20
> The reason for these gymnastics is to create objects at the right time
> during startup, except there is no right time, but two.
>=20
> Differences:
>=20
> * Options are processed left to right without gymnastics.  Getting their
>   order right is the user's problem.  I consider this an improvement.
>=20
> * You use &qemu_object_opts instead of qemu_find_opts("object").  Also
>   an improvement.
>=20
> * You use qemu_opts_parse() instead of qemu_opts_parse_noisily().
>   The latter can print help.  I failed to find a case where we lose help
>   compared to qemu-system-FOO.  I didn't try very hard.

I tried to reuse that code from qemu_opts_parse_noisily(), until I
realised that it wasn't even used for -object.

I don't remember the details why qemu_opts_print_help() wasn't even
called, but it's obvious that we can't lose anything from it:
qemu_object_opts has an empty list of properties, it accepts anything.
QemuOpts can't print any useful help when this is all the information it
has.

> * You neglect to guard user_creatable_print_help():
>=20
>     $ qemu-storage-daemon --object wrong=3D1,help
>     Segmentation fault (core dumped)

Thanks for catching this. (You don't even need the ",help" part, just
--object wrong=3D1 is enough.)

> * You neglect to object_unref().  I just double-checked the final
>   reference count: it's 2.

Hm, yes. Weird interface, no caller actually needs this reference.

> These bugs shouldn't be hard to fix.
>=20
>=20
> At this point you might wonder why I dislike this option so much.
> vl.c's gymnastics are ugly, but not unusually ugly, and they're gone
> here.  To explain my distaste, I have to go back a little bit.
>=20
> Like quite a few options, --object is paired with QMP command, namely
> object-add.  Both have the same parameters: QOM type, object ID, and
> additional type-specific object properties.  There's a difference,
> though: object-add wraps the latter in a 'props' object, while --object
> does not.
>=20
> QAPI schema:
>=20
>     { 'command': 'object-add',
>       'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
>=20
> QAPIfying this part of the CLI isn't easy.
>=20
> The obvious QAPIfied CLI buddy of object-add is incompatible to current
> --object.  That's not a concern for the storage daemon.  But it's also
> ugly, because object-add's nesting of the type-specific properties
> within @props is.  In QMP, it's merely yet another pair of curlies.  In
> the CLI, we get to prefix props. to each type-specific property.
>=20
> If we want to give the storage daemon a QAPIfied command line from the
> start (and I think we do), we'll have to decide how to address this
> issue, and possibly more (I'm only at PATCH 02/18).
>=20
> We have a long history of rather careless interface design, and now some
> of these chickens come home to roost.

On IRC, we discussed last week that we could turn object-add into a
'gen': false command and accept things both as options in props and as
flat options on the top level.

However, looking at this again, I'm afraid we forgot the context while
discussing specifics: How would this be used in a command line parser?

We don't start with a QDict here, but with a string. Getting a QDict
that could serve as an input to a modified qmp_object_add() would still
involve going through QemuOpts for parsing the option string, and then
converting it to a QDict. Using a visitor isn't possible with '*props':
'any' and even less so with 'gen': false.

So would this really improve things? Or do we have to wait until we have
an actual schema for object-add before calling qmp_object_add() actually
makes sense?

Kevin


