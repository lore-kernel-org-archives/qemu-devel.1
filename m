Received: from eggs.gnu.org ([2001:4830:134:3::10]:44469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtbq-00020p-P9
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtbm-0003Ji-Qs
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:57:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewtbm-0003J4-LQ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 594D1EB6F6
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:57:27 +0000 (UTC)
Date: Fri, 16 Mar 2018 17:57:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316175719.GF3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
	<20180316115403.4148-2-quintela@redhat.com>
	<20180316174907.GZ3066@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316174907.GZ3066@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 01/15] migration: Set error state in
 case of error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On Fri, Mar 16, 2018 at 05:49:07PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 16, 2018 at 12:53:49PM +0100, Juan Quintela wrote:
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/ram.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 7266351fd0..1b8095a358 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -414,6 +414,16 @@ static void terminate_multifd_send_threads(Error=
 *errp)
> >  {
> >      int i;
> > =20
> > +    if (errp) {
> > +        MigrationState *s =3D migrate_get_current();
> > +        migrate_set_error(s, errp);
>=20
> This doesn't look quiet right. You're checking if 'errp' is a non-NULL,
> which just tells you if the caller wants to collect the error, not
> whether an error has happened. For the latter you need
>=20
>   if (errp && *errp)
>=20
> seems a little strange though for the caller to pass an error into this
> method for reporting.

Oh wait, I'm being mislead by the unusual parameter name.

An "errp" name should only ever be used for a "Error **", but we
only have an "Error *" here.

So just fix the parameter name to be "err" instead of "errp".


> > +        if (s->state =3D=3D MIGRATION_STATUS_SETUP ||
> > +            s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
> > +            migrate_set_state(&s->state, s->state,
> > +                              MIGRATION_STATUS_FAILED);
> > +        }
> > +    }
> > +
> >      for (i =3D 0; i < multifd_send_state->count; i++) {
> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> > =20
> > @@ -514,6 +524,16 @@ static void terminate_multifd_recv_threads(Error=
 *errp)

This parameter name needs fixing too.

These are actually a pre-existing problem in current GIT, so worth fixing
in a separate patch.

> >  {
> >      int i;
> > =20
> > +    if (errp) {
> > +        MigrationState *s =3D migrate_get_current();
> > +        migrate_set_error(s, errp);
> > +        if (s->state =3D=3D MIGRATION_STATUS_SETUP ||
> > +            s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
> > +            migrate_set_state(&s->state, s->state,
> > +                              MIGRATION_STATUS_FAILED);
> > +        }
> > +    }
> > +
> >      for (i =3D 0; i < multifd_recv_state->count; i++) {
> >          MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
> > =20
> > --=20
> > 2.14.3
> >=20
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
