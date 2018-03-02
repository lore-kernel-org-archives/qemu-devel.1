Received: from eggs.gnu.org ([2001:4830:134:3::10]:41823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ere2F-0004iU-Ex
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ere2B-0002ED-Gb
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:19:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ere2B-0002E9-C6
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:19:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06B8180AD238
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 06:19:01 +0000 (UTC)
Date: Fri, 2 Mar 2018 14:18:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302061847.GF27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-12-peterx@redhat.com>
	<20180301155001.GR14643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301155001.GR14643@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/15] qio: non-default context for TLS
 handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 03:50:01PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 01, 2018 at 04:44:34PM +0800, Peter Xu wrote:
> > qio_channel_tls_handshake_full() is introduced to allow the TLS to be
> > run on a non-default context.  Still, no functional change.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/io/channel-tls.h | 17 ++++++++++++++++
> >  io/channel-tls.c         | 51 +++++++++++++++++++++++++++++++++++---=
----------
> >  2 files changed, 54 insertions(+), 14 deletions(-)
> >=20
>=20
> >  static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
> > -                                           QIOTask *task)
> > +                                           QIOTask *task,
> > +                                           GMainContext *context)
> >  {
> >      Error *err =3D NULL;
> >      QCryptoTLSSessionHandshakeStatus status;
> > @@ -171,6 +177,11 @@ static void qio_channel_tls_handshake_task(QIOCh=
annelTLS *ioc,
> >          qio_task_complete(task);
> >      } else {
> >          GIOCondition condition;
> > +        QIOChannelTLSData *data =3D g_new0(typeof(*data), 1);
> > +
> > +        data->task =3D task;
> > +        data->context =3D context;
>=20
> The 'context' reference is only valid for as long as the caller
> exists. So you need to acquire a reference on 'context' here....
>=20
>=20
> > @@ -191,20 +203,23 @@ static gboolean qio_channel_tls_handshake_io(QI=
OChannel *ioc,
> >                                               GIOCondition condition,
> >                                               gpointer user_data)
> >  {
> > -    QIOTask *task =3D user_data;
> > +    QIOChannelTLSData *data =3D user_data;
> > +    QIOTask *task =3D data->task;
> > +    GMainContext *context =3D data->context;
> >      QIOChannelTLS *tioc =3D QIO_CHANNEL_TLS(
> >          qio_task_get_source(task));
> > =20
> > -    qio_channel_tls_handshake_task(
> > -       tioc, task);
>=20
> > +    g_free(data);
> > +    qio_channel_tls_handshake_task(tioc, task, context);
>=20
> And release the reference on context here.

Yeah, fixed both.  Thanks,

--=20
Peter Xu
