Received: from eggs.gnu.org ([2001:4830:134:3::10]:44947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffJ7A-0007R5-60
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffJ76-0002uo-TD
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:05:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ffJ76-0002uI-Hv
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 02:05:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD8ED401EF05
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 06:05:31 +0000 (UTC)
Date: Tue, 17 Jul 2018 14:05:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180717060527.GE20520@xz-mi>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-6-marcandre.lureau@redhat.com>
	<87va9eh15z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87va9eh15z.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/12] monitor: no need to save need_resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Tue, Jul 17, 2018 at 07:38:32AM +0200, Markus Armbruster wrote:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > There is no need for per-command need_resume granularity, it should
> > resume after running an non-oob command on oob-disabled monitor.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  monitor.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 462cf96f7b..ec40a80d81 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -257,12 +257,6 @@ struct QMPRequest {
> >       */
> >      QObject *req;
> >      Error *err;
> > -    /*
> > -     * Whether we need to resume the monitor afterward.  This flag i=
s
> > -     * used to emulate the old QMP server behavior that the current
> > -     * command must be completed before execution of the next one.
> > -     */
> > -    bool need_resume;
>=20
> Note for later: this comment goes away without a replacement.
>=20
> >  };
> >  typedef struct QMPRequest QMPRequest;
> > =20
> > @@ -4079,11 +4073,13 @@ static void monitor_qmp_bh_dispatcher(void *d=
ata)
> >  {
> >      QMPRequest *req_obj =3D monitor_qmp_requests_pop_any();
> >      QDict *rsp;
> > +    bool need_resume;
> > =20
> >      if (!req_obj) {
> >          return;
> >      }
> > =20
> > +    need_resume =3D !qmp_oob_enabled(req_obj->mon);

[1]

> >      if (req_obj->req) {
> >          trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->i=
d) ?: "");
> >          monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id=
);
> > @@ -4094,7 +4090,7 @@ static void monitor_qmp_bh_dispatcher(void *dat=
a)
> >          qobject_unref(rsp);
> >      }
> > =20
> > -    if (req_obj->need_resume) {
> > +    if (need_resume) {
> >          /* Pairs with the monitor_suspend() in handle_qmp_command() =
*/
>=20
> Why not
>=20
>        if (!qmp_oob_enabled(req_obj->mon)) {
>=20
> and drop the variable?  Perhaps you keep the variable to have its name
> provide a hint on why we resume.  But even with that hint and the "pair=
s
> with" comment, it's still less than clear.  What about...

IMO it's because the value of qmp_oob_enabled(req_obj->mon) might
change along the way, and we need to cache the old result to decide
whether we'll need to resume the monitor.  The trick is that when we
send the first "qmp_capabilities" command to enable out-of-band, then
when at [1] we will get a FALSE (since out-of-band is off by default)
while when reach here we'll get a TRUE instead (after we handled the
"qmp_capabilities" command, out-of-band is enabled).

So if we really want to remove the req_obj->need_resume variable or
anything similar, IMHO we'd better add some comment at [1] mentioning
about this trick.

Thanks,

>=20
> >          monitor_resume(req_obj->mon);
> >      }
> > @@ -4146,7 +4142,6 @@ static void handle_qmp_command(JSONMessageParse=
r *parser, GQueue *tokens)
> >      req_obj->id =3D id;
> >      req_obj->req =3D req;
> >      req_obj->err =3D err;
> > -    req_obj->need_resume =3D false;
> > =20
> >      /* Protect qmp_requests and fetching its length. */
> >      qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> > @@ -4159,7 +4154,6 @@ static void handle_qmp_command(JSONMessageParse=
r *parser, GQueue *tokens)
> >       */
> >      if (!qmp_oob_enabled(mon)) {
>=20
> ... adding a replacement for the deleted comment here, say
>=20
>            /*
>            * Emulate traditional QMP server behavior: read next command
>            * only after current command completed.  Pairs with
>            * monitor_resume() in monitor_qmp_bh_dispatcher().
>            */
>=20
> Would you then be okay with cutting out the variable?
>=20
> >          monitor_suspend(mon);
> > -        req_obj->need_resume =3D true;
> >      } else {
> >          /* Drop the request if queue is full. */
> >          if (mon->qmp.qmp_requests->length >=3D QMP_REQ_QUEUE_LEN_MAX=
) {
>=20
> Your patch works fine as far as I can tell, so
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

--=20
Peter Xu
