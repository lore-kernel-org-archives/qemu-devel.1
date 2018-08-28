Received: from eggs.gnu.org ([2001:4830:134:3::10]:55688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fuoPI-0006Zn-LA
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 20:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fuoOy-0007Iz-Kq
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 20:32:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fuoOy-0007Fb-7l
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 20:32:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7T0T9LA001893
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 20:32:02 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m5bp2jy4h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 20:32:02 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 28 Aug 2018 18:32:00 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAJ+F1CL+w0f8Esow9RS3XEo0bYmg28uqPhQyvi+7fJEARACkTA@mail.gmail.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-9-marcandre.lureau@redhat.com>
	<153541472616.13636.8864065629716803544@sif>
	<CAJ+F1CL+w0f8Esow9RS3XEo0bYmg28uqPhQyvi+7fJEARACkTA@mail.gmail.com>
Date: Tue, 28 Aug 2018 18:52:48 -0500
Message-Id: <153550036836.13636.2315178729210330934@sif>
Subject: Re: [Qemu-devel] [PATCH v3 8/9] qga: process_event() simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Quoting Marc-Andr=C3=A9 Lureau (2018-08-28 06:56:51)
> Hi
> On Tue, Aug 28, 2018 at 2:05 AM Michael Roth <mdroth@linux.vnet.ibm.com> =
wrote:
> >
> > Quoting Marc-Andr=C3=A9 Lureau (2018-08-25 08:57:23)
> > > Simplify the code around qmp_dispatch():
> > > - rely on qmp_dispatch/check_obj() for message checking
> > > - have a single send_response() point
> > > - constify send_response() argument
> > >
> > > It changes a couple of error messages:
> > >
> > > * When @req isn't a dictionary, from
> > >     Invalid JSON syntax
> > >   to
> > >     QMP input must be a JSON object
> > >
> > > * When @req lacks member "execute", from
> > >     this feature or command is not currently supported
> > >   to
> > >     QMP input lacks member 'execute'
> > >
> > > CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  qga/main.c | 47 +++++++++--------------------------------------
> > >  1 file changed, 9 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/qga/main.c b/qga/main.c
> > > index 6d70242d05..f0ec035996 100644
> > > --- a/qga/main.c
> > > +++ b/qga/main.c
> > > @@ -544,15 +544,15 @@ fail:
> > >  #endif
> > >  }
> > >
> > > -static int send_response(GAState *s, QDict *payload)
> > > +static int send_response(GAState *s, const QDict *rsp)
> > >  {
> > >      const char *buf;
> > >      QString *payload_qstr, *response_qstr;
> > >      GIOStatus status;
> > >
> > > -    g_assert(payload && s->channel);
> > > +    g_assert(rsp && s->channel);
> > >
> > > -    payload_qstr =3D qobject_to_json(QOBJECT(payload));
> > > +    payload_qstr =3D qobject_to_json(QOBJECT(rsp));
> > >      if (!payload_qstr) {
> > >          return -EINVAL;
> > >      }
> > > @@ -578,53 +578,24 @@ static int send_response(GAState *s, QDict *pay=
load)
> > >      return 0;
> > >  }
> > >
> > > -static void process_command(GAState *s, QDict *req)
> > > -{
> > > -    QDict *rsp;
> > > -    int ret;
> > > -
> > > -    g_assert(req);
> > > -    g_debug("processing command");
> > > -    rsp =3D qmp_dispatch(&ga_commands, QOBJECT(req), false);
> > > -    if (rsp) {
> > > -        ret =3D send_response(s, rsp);
> > > -        if (ret < 0) {
> > > -            g_warning("error sending response: %s", strerror(-ret));
> > > -        }
> > > -        qobject_unref(rsp);
> > > -    }
> >
> > We used to check here for the success-response=3Dfalse scenario (e.g.
> > guest-shutdown qga command). Now we pass the result of qmp_dispatch()
> > directly to send_response(), which looks like that might cause an
> > assertion now. Do we need to add handling for this?
> =

> Good catch! fixing it:
> =

> end:
>     if (rsp) {
>         ret =3D send_response(s, rsp);
>         if (ret < 0) {
>             g_warning("error sending error response: %s", strerror(-ret));
>         }
>         qobject_unref(rsp);
>     }
> =

> ack, with that?

Looks good! With that:

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> =

> > > -}
> > > -
> > >  /* handle requests/control events coming in over the channel */
> > >  static void process_event(void *opaque, QObject *obj, Error *err)
> > >  {
> > >      GAState *s =3D opaque;
> > > -    QDict *req, *rsp;
> > > +    QDict *rsp;
> > >      int ret;
> > >
> > >      g_debug("process_event: called");
> > >      assert(!obj !=3D !err);
> > >      if (err) {
> > > -        goto err;
> > > -    }
> > > -    req =3D qobject_to(QDict, obj);
> > > -    if (!req) {
> > > -        error_setg(&err, "Input must be a JSON object");
> > > -        goto err;
> > > -    }
> > > -    if (!qdict_haskey(req, "execute")) {
> > > -        g_warning("unrecognized payload format");
> > > -        error_setg(&err, QERR_UNSUPPORTED);
> > > -        goto err;
> > > +        rsp =3D qmp_error_response(err);
> > > +        goto end;
> > >      }
> > >
> > > -    process_command(s, req);
> > > -    qobject_unref(obj);
> > > -    return;
> > > +    g_debug("processing command");
> > > +    rsp =3D qmp_dispatch(&ga_commands, obj, false);
> > >
> > > -err:
> > > -    g_warning("failed to parse event: %s", error_get_pretty(err));
> > > -    rsp =3D qmp_error_response(err);
> > > +end:
> > >      ret =3D send_response(s, rsp);
> > >      if (ret < 0) {
> > >          g_warning("error sending error response: %s", strerror(-ret)=
);
> > > --
> > > 2.18.0.547.g1d89318c48
> > >
> >
> =

> =

> -- =

> Marc-Andr=C3=A9 Lureau
>=20
