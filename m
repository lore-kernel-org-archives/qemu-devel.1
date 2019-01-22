Received: from eggs.gnu.org ([209.51.188.92]:58778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1LA-0001nY-CC
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1L5-0005y9-A4
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:04:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gm1L3-0005wo-8d
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:03:59 -0500
Date: Tue, 22 Jan 2019 14:17:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122141729.GO13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-2-berrange@redhat.com>
	<20190121104545.GE30536@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121104545.GE30536@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] display: ensure qxl log_buf is a
 nul terminated string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Jan 21, 2019 at 10:45:45AM +0000, Stefan Hajnoczi wrote:
> On Fri, Jan 18, 2019 at 05:31:00PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> > index 8e9a65e75b..eefdf4baac 100644
> > --- a/hw/display/qxl.c
> > +++ b/hw/display/qxl.c
> > @@ -1763,7 +1763,8 @@ async_common:
> >          qxl_set_mode(d, val, 0);
> >          break;
> >      case QXL_IO_LOG:
> > -        trace_qxl_io_log(d->id, d->ram->log_buf);
> > +        d->ram->log_buf[sizeof(d->ram->log_buf) - 1] =3D '\0';
> > +        trace_qxl_io_log(d->id, (const char *)d->ram->log_buf);
>=20
> This is a PCI BAR shared with the guest?  Then NUL termination is
> subject to races with vcpu threads that modify log_buf[] while we acces=
s
> it.

Doh, yes, it is racy.

> The safe way to do this is to copy in log_buf[] and then NUL-terminate
> the local copy.

log_buf is 4k in size, which I don't really want to allocate on the
stack. Using malloc would impose a perf penalty on logging but not
sure if that's significant enough to worry about. Alternatively we
could just drop the tracepoint, given that you can already use the
'guestdebug' option to get these fprintf'd to stderr.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
