Received: from eggs.gnu.org ([2001:4830:134:3::10]:59832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDUl1-0007GG-Tt
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fDUky-0005N0-4F
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:51:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fDUkx-0005Mb-Sp
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:51:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91F94C9351
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 12:51:39 +0000 (UTC)
Date: Tue, 1 May 2018 13:51:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180501125129.GA32129@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180430185943.35714-1-dgilbert@redhat.com>
	<20180501100035.GJ5708@redhat.com>
	<20180501101127.GK5708@redhat.com> <20180501105725.GC3105@work-vm>
	<20180501112118.GO5708@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180501112118.GO5708@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Migration+TLS: Fix crash due to double
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

On Tue, May 01, 2018 at 12:21:18PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, May 01, 2018 at 11:57:25AM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > On Tue, May 01, 2018 at 11:00:35AM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > > On Mon, Apr 30, 2018 at 07:59:43PM +0100, Dr. David Alan Gilbert =
(git) wrote:
> > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > >=20
> > > > > During a TLS connect we see:
> > > > >   migration_channel_connect calls
> > > > >   migration_tls_channel_connect
> > > > >   (calls after TLS setup)
> > > > >   migration_channel_connect
> > > > >=20
> > > > > My previous error handling fix made migration_channel_connect
> > > > > call migrate_fd_connect in all cases; unfortunately the above
> > > > > means it gets called twice and crashes doing double cleanup.
> > > > >=20
> > > > > Fixes: 688a3dcba98
> > > >=20
> > > > This fixes the crash, but we're still seeing error messages dupli=
cated
> > > >=20
> > > > (qemu) migrate_set_parameter tls-creds tls0
> > > > (qemu) migrate tcp:localhost:9000
> > > > qemu-system-x86_64: Certificate does not match the hostname local=
host
> > > > qemu-system-x86_64: Certificate does not match the hostname local=
host
> > > >=20
> > > > git bisect points to 688a3dcba98 as the cause of these double
> > > > errors still.
> >=20
> > Can you give me the full sequence to trigger that; I did try yesterda=
y
> > and have failed to get that error out of the TLS code.
>=20
> Essentially I follow this:
>=20
>   https://qemu.weilnetz.de/doc/qemu-doc.html#network_005ftls
>=20
> when generating the server-cert.pem file I use this input template:
>=20
> $ cat server.info
> organization =3D My Org
> cn =3D 127.0.0.1
> # Commented out to force failure with 'localhost' name
> #dns_name =3D "localhost"
> dns_name =3D "localhost.localdomain"
> ip_address =3D 127.0.0.1
> ip_address =3D ::1
> tls_www_server
> encryption_key
> signing_key
>=20
> $ certtool --generate-certificate \
>    --load-ca-certificate ca-cert.pem \
>    --load-ca-privkey ca-key.pem \
>    --load-privkey server-key.pem \
>    --template server.info \
>    --outfile server-cert.pem
>=20
> On the server (mig target) side I run:
>=20
> $ ./x86_64-softmmu/qemu-system-x86_64 \
>     -object tls-creds-x509,id=3Dtls0,endpoint=3Dserver,dir=3D/home/berr=
ange/security/qemutls,verify-peer=3Dno \
>     -incoming defer -monitor stdio -display none
> QEMU 2.11.50 monitor - type 'help' for more information
> (qemu) migrate_set_parameter tls-creds tls0
> (qemu) migrate_incoming tcp:localhost:9000
>=20
> Notice I've set  verify-peer=3Dno on the server, since I've not bothere=
d to
> issue any client-cert.pem on my dev setup here.
>=20
> On the client (mig source) side I run:
>=20
> $  ./x86_64-softmmu/qemu-system-x86_64 \
>     -object tls-creds-x509,id=3Dtls0,endpoint=3Dclient,dir=3D/home/berr=
ange/security/qemutls\
>     -monitor stdio  -display none=20
> QEMU 2.11.50 monitor - type 'help' for more information
> (qemu) migrate_set_parameter tls-creds tls0
> (qemu) migrate tcp:localhost:9000
> qemu-system-x86_64: Certificate does not match the hostname localhost
> qemu-system-x86_64: Certificate does not match the hostname localhost
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blo=
cks: off compress: off events: off postcopy-ram: off x-colo: off release-=
ram: off block: off return-path: off pause-before-switchover: off x-multi=
fd: off=20
> Migration status: failed (Certificate does not match the hostname local=
host)
> total time: 0 milliseconds
>=20
>=20
> Notice that when generating the server certificate I did *not* include
> "localhost" as a DNS name, nor in the Common Name.
>=20
> So when I connect with a URI of "tcp:localhost:9000" we correctly see
> that the "localhost" name doesn't match any DNS name or common name
> in the server cert.
>=20
> If I instead set the tls-hostname parameter it will succeed:
>=20
> (qemu) migrate_set_parameter tls-hostname 127.0.0.1
> (qemu) migrate_set_parameter tls-creds tls0
> (qemu) migrate tcp:localhost:9000
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blo=
cks: off compress: off events: off postcopy-ram: off x-colo: off release-=
ram: off block: off return-path: off pause-before-switchover: off x-multi=
fd: off=20
> Migration status: completed
> total time: 131 milliseconds
> downtime: 5 milliseconds
> setup: 1 milliseconds
> transferred ram: 1369 kbytes
> throughput: 105.76 mbps
> remaining ram: 0 kbytes
> total ram: 148296 kbytes
> duplicate: 36817 pages
> skipped: 0 pages
> normal: 261 pages
> normal bytes: 1044 kbytes
> dirty sync count: 2
> page size: 4 kbytes
>=20
>=20
> Or likewise if I used "tcp:127.0.0.1:9000"  it would succeed too,
> because "127.0.0.1" is listed as a IP address in the server cert.
>=20
> >
> > > The second stack trace is the error reporting context that I added =
originally
> > > in
> > >=20
> > >   commit d59ce6f34434bf47a9b26138c908650bf9a24be1
> > >   Author: Daniel P. Berrange <berrange@redhat.com>
> > >   Date:   Wed Apr 27 11:05:00 2016 +0100
> > >=20
> > >     migration: add reporting of errors for outgoing migration
> > >=20
> > >=20
> > > So the first stack trace is the new duplicate.
> > >
> > > Which error reporting context is "better" though, I don't know ?
> >=20
> >=20
> > OK, I see why I didn't see this - I almost always use migrate -d  and
> > that timer only happens without the -d.
>=20
> Oh, yes, I forget to mention I left migration in the foreground. If you
> background it, then my original patch would only show the error message
> when you did "info migrate"
>=20
> > > My patch was based on the view that, although alot of code uses err=
or_report,
> > > long term all migration would eventually need to be able to filter =
an
> > > 'Error *errp' back up the stack, so that we can pass it back to QMP=
 / HMP via
> > > 'info migrate' / query-migrate. So I decided to leave the error_rep=
ort_err
> > > call to the hmp.c code, as long term that's the only place that wou=
ld need
> > > to print to the console.
> >=20
> > I wanted it to land in the /var/log/libvirt/qemu/whatever so we could
> > see what happened.
>=20
> In general QMP commands are expected to send errors back to the QMP cli=
ent,
> not write them to stderr. Of course we have substantial legacy code so =
some
> commands do end up only using error_report, but the general expectation=
 with
> QMP is that we'd eliminate error_report in codepaths triggered from mon=
itor
> commands. The only reason we print to stderr with QMP is that it would =
be
> impossible to diagnose failures for code that is not converted to "Erro=
r *"
> yet. Places where we have converted to "Error *" don't need to use stde=
rr.

On looking further, it seems to me that the real problem was this change:=
L

  commit 87db1a7d89677e3dbc8b3763e417b9376009bdbb
  Author: Juan Quintela <quintela@redhat.com>
  Date:   Tue Sep 5 12:50:22 2017 +0200

    migration: Improve migration thread error handling
   =20
    We now report errors also when we finish migration, not only on info
    migrate.  We plan to use this error from several places, and we want
    the first error to happen to win, so we add an mutex to order it.
   =20
    Signed-off-by: Juan Quintela <quintela@redhat.com>
    Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


Which added an "error_report_err" call in migrate_fd_cleanup()
method which prints the s->error object. This is not needed for
QMP since we feed it back via query-migrate, and also not needed
for HMP since we can report it via info migrate, or directly via
the status callback if migration is in the foreground.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
