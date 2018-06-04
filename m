Received: from eggs.gnu.org ([2001:4830:134:3::10]:37162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPrCn-0006Wv-OZ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPrCi-0002It-33
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:15:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPrCh-0002HK-LX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:15:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C5E5F013A
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 15:15:27 +0000 (UTC)
Date: Mon, 4 Jun 2018 16:15:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180604151523.GK19749@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-3-berrange@redhat.com>
	<fecc57bf-78a3-065c-729d-a465c974b2c5@redhat.com>
	<20180604170111.33480718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604170111.33480718@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vl: fix use of --daemonize with
 --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Jun 04, 2018 at 05:01:11PM +0200, Igor Mammedov wrote:
> On Mon, 4 Jun 2018 16:21:48 +0200
> Michal Privoznik <mprivozn@redhat.com> wrote:
>=20
> > On 06/04/2018 02:03 PM, Daniel P. Berrang=C3=A9 wrote:
> > > When using --daemonize, the initial lead process will fork a child =
and
> > > then wait to be notified that setup is complete via a pipe, before =
it
> > > exits.  When using --preconfig there is an extra call to main_loop(=
)
> > > before the notification is done from os_setup_post(). Thus the pare=
nt
> > > process won't exit until the mgmt application connects to the monit=
or
> > > and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt applicati=
on
> > > won't connect to the monitor until daemonizing has completed though=
.
> > >=20
> > > This is a chicken and egg problem, leading to deadlock at startup.
> not calling 1st main_loop(), solves the issue if no --preconfig
> is specified like Michal has suggested. So moving os_setup_post()
> earlier isn't the only option.
>=20
> With Michal's patch it should work fine with old libvirt versions,
> however it would mean more changes to libvirt when adding
> --preconfig option handling as it would need to connect to qmp
> socket earlier if the option is used.

This patch doesn't cause problems with old libvirt either - the opposite
in fact, it fixes the problems that broke with old libvirt.

>=20
> > > The only viable way to fix this is to call os_setup_post() before
> > > the early main_loop() call when in RUN_STATE_PRECONFIG. This has th=
e
> > > downside that any errors from this point onwards won't be handled
> > > well by the mgmt application, because it will think QEMU has starte=
d
> > > successfully, so not be expecting an abrupt exit. The only way to
> > > deal with that is to move as much user input validation as possible
> > > to before the main_loop() call. This is left as an exercise for
> > > future interested developers.
> Moving post board input validation might be problematic as
> it might require existing board to create a device so it could verify
> user provided parameters.
>=20
> Does mgmt application starts QEMU with log file where QEMU would
> write errors if any after os_setup_post() and would mgmt app look
> into it/report from it to user if QEMU disappears?

Sure any app can redirect stdout/err to a file if it wishes.

--daemonize was actually also a synchronization point - once the parent
returns, the mgmt app knows it can successfully connect to the QEMU
monitor as the listener socket is guaranteed to be created by then.
So moving the os_setup_post earlier as I did still gives that sync
point, which is good. It just means when the mgmt app has to be aware
that more errors might appear on stderr in the window until it exits
preconfig phase.

Ideally there would be a way to feed them back via the monitor, but
that's non-trivial, so doubt it'll happen any time in the forseeable
future.

> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > ---
> > >  vl.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-) =20
> >=20
> > Yup, this fixes the problem I've raised in my patch. Thanks!
> I'd prefer your patch, as it doesn't break error handling,

Michal's patch didn't actually fix the real problem. It simply avoided
triggering the bug when --preconfig was not present - QEMU still hangs
with --preconfig --daemonize are used together.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
