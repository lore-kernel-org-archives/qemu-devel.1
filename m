Received: from eggs.gnu.org ([209.51.188.92]:32781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkYAa-0004mU-NN
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkYAW-0005WA-PH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:43:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gkYAU-0005Ql-NZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:43:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD963C04C28D
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 17:42:56 +0000 (UTC)
Date: Fri, 18 Jan 2019 17:42:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190118174245.GR20660@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-2-berrange@redhat.com>
	<83c29d37-d37c-86ea-9133-8268df23c3ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83c29d37-d37c-86ea-9133-8268df23c3ad@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jan 18, 2019 at 11:40:29AM -0600, Eric Blake wrote:
> On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> > The QXL_IO_LOG command allows the guest to send log messages to the h=
ost
> > via a buffer in the QXLRam struct. QEMU prints these to the console i=
f
> > the qxl 'guestdebug' option is set to non-zero. It will also feed the=
m
> > to the trace subsystem if any backends are built-in.
> >=20
> > In both cases the log_buf data will get treated as being as a nul
> > terminated string, by the printf '%s' format specifier and / or other
> > code reading the buffer.
> >=20
> > QEMU does nothing to guarantee that the log_buf really is nul termina=
ted,
> > so there is potential for out of bounds array access.
> >=20
> > This would affect any QEMU which has the log, syslog or ftrace trace
> > backends built into QEMU. It can only be triggered if the 'qxl_io_log=
'
> > trace event is enabled, however, so they are not vulnerable without
> > specific administrative action to enable this.
> >=20
> > It would also affect QEMU if the 'guestdebug' parameter is set to a
> > non-zero value, which again is not the default and requires explicit
> > admin opt-in.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  hw/display/qxl.c        | 3 ++-
> >  hw/display/trace-events | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> > +++ b/hw/display/qxl.c
> > @@ -1763,7 +1763,8 @@ async_common:
> >          qxl_set_mode(d, val, 0);
> >          break;
> >      case QXL_IO_LOG:
> > -        trace_qxl_io_log(d->id, d->ram->log_buf);
> > +        d->ram->log_buf[sizeof(d->ram->log_buf) - 1] =3D '\0';
>=20
> May lose a character from the log, but the improved safety is worth it.

In practice it won't.  The Xorg QXL driver and Windows XDDM DOD driver
don't use this feature at all. The Windows QXL miniport driver uses snpri=
ntf
when populating the buffer so will already have truncated if it was going
to overflow.

>=20
> > +        trace_qxl_io_log(d->id, (const char *)d->ram->log_buf);
> >          if (d->guestdebug) {
> >              fprintf(stderr, "qxl/guest-%d: %" PRId64 ": %s", d->id,
> >                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), d->ram->l=
og_buf);
> > diff --git a/hw/display/trace-events b/hw/display/trace-events
> > index 5a48c6cb6a..387c6b8931 100644
> > --- a/hw/display/trace-events
> > +++ b/hw/display/trace-events
> > @@ -72,7 +72,7 @@ qxl_interface_update_area_complete_rest(int qid, ui=
nt32_t num_updated_rects) "%d
> >  qxl_interface_update_area_complete_overflow(int qid, int max) "%d ma=
x=3D%d"
> >  qxl_interface_update_area_complete_schedule_bh(int qid, uint32_t num=
_dirty) "%d #dirty=3D%d"
> >  qxl_io_destroy_primary_ignored(int qid, const char *mode) "%d %s"
> > -qxl_io_log(int qid, const uint8_t *log_buf) "%d %s"
> > +qxl_io_log(int qid, const char *log_buf) "%d %s"
> >  qxl_io_read_unexpected(int qid) "%d"
> >  qxl_io_unexpected_vga_mode(int qid, uint64_t addr, uint64_t val, con=
st char *desc) "%d 0x%"PRIx64"=3D%"PRIu64" (%s)"
> >  qxl_io_write(int qid, const char *mode, uint64_t addr, const char *a=
name, uint64_t val, unsigned size, int async) "%d %s addr=3D%"PRIu64 " (%=
s) val=3D%"PRIu64" size=3D%u async=3D%d"
> >=20
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
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
