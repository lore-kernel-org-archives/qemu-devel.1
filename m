Received: from eggs.gnu.org ([2001:4830:134:3::10]:44469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBAtE-0006K9-Ig
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBAtB-0008VG-DH
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:14:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBAtB-0008Uy-74
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:14:37 -0400
Date: Wed, 25 Apr 2018 11:14:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180425031423.GH9036@xz-mi>
References: <1524295325-18136-1-git-send-email-wangxinxin.wang@huawei.com>
	<20180424171631.GF2521@work-vm> <20180424182405.GM20310@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180424182405.GM20310@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration/fd: abort migration if receive
 POLLHUP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Wang Xin <wangxinxin.wang@huawei.com>, qemu-devel@nongnu.org, quintela@redhat.com, arei.gonglei@huawei.com

On Tue, Apr 24, 2018 at 07:24:05PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 24, 2018 at 06:16:31PM +0100, Dr. David Alan Gilbert wrote:
> > * Wang Xin (wangxinxin.wang@huawei.com) wrote:
> > > If the fd socket peer closed shortly, ppoll may receive a POLLHUP
> > > event before the expected POLLIN event, and qemu will do nothing
> > > but goes into an infinite loop of the POLLHUP event.
> > >=20
> > > So, abort the migration if we receive a POLLHUP event.
> >=20
> > Hi Wang Xin,
> >   Can you explain how you manage to trigger this case; I've not hit i=
t.
> >=20
> > > Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>
> > >=20
> > > diff --git a/migration/fd.c b/migration/fd.c
> > > index cd06182..5932c87 100644
> > > --- a/migration/fd.c
> > > +++ b/migration/fd.c
> > > @@ -15,6 +15,7 @@
> > >   */
> > > =20
> > >  #include "qemu/osdep.h"
> > > +#include "qemu/error-report.h"
> > >  #include "channel.h"
> > >  #include "fd.h"
> > >  #include "monitor/monitor.h"
> > > @@ -46,6 +47,11 @@ static gboolean fd_accept_incoming_migration(QIO=
Channel *ioc,
> > >                                               GIOCondition conditio=
n,
> > >                                               gpointer opaque)
> > >  {
> > > +    if (condition & G_IO_HUP) {
> > > +        error_report("The migration peer closed, job abort");
> > > +        exit(EXIT_FAILURE);
> > > +    }
> > > +
> >=20
> > OK,  I wish we had a nicer way for failing;  especially for the
> > multifd/postcopy recovery worlds where one failed connection might no=
t
> > be fatal; but I don't see how to do that here.
>=20
> This doesn't feel right to me.
>=20
> We have passed in a pre-opened FD to QEMU, and we registered a watch
> on it to detect when there is data from the src QEMU that is available
> to read.  Normally the src will have sent something so we'll get G_IO_I=
N,
> but you're suggesting the client has quit immediately, so we're getting
> G_IO_HUP due to end of file.
>=20
> The migration_channel_process_incoming() method that we pass the ioc
> object to will be calling qio_channel_read(ioc) somewhere to try to
> read that data.
>=20
> For QEMU to spin in infinite loop there must be code in the
> migration_channel_process_incoming() that is ignoring the return
> value of qio_channel_read() in some manner causing it to retry
> the read again & again I presume.
>=20
> Putting this check for G_IO_HUP fixes your immediate problem scenario,
> but whatever code was spinning in infinite loop is still broken and
> I'd guess it was possible to still trigger the loop. eg by writing
> 1 single byte and then closing the socket.
>=20
> So, IMHO this fix is wrong - we need to find the root cause and fix
> that, not try to avoid calling the buggy code.

I agree. AFAIU the first read should be in qemu_loadvm_state():

    v =3D qemu_get_be32(f);
    if (v !=3D QEMU_VM_FILE_MAGIC) {
        error_report("Not a migration stream");
        return -EINVAL;
    }

So I would be curious more about how that infinite loop happened.

--=20
Peter Xu
