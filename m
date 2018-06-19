Received: from eggs.gnu.org ([2001:4830:134:3::10]:46355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVJ5t-0005Ls-Ow
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVJ5s-0007zm-Kf
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:02:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVJ5s-0007zP-E8
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:02:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAD95819BAA9
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 16:02:55 +0000 (UTC)
Date: Tue, 19 Jun 2018 17:02:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619160253.GF26829@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180619151719.17002-1-berrange@redhat.com>
	<20180619154504.GI2368@work-vm> <20180619155859.GE26829@redhat.com>
	<20180619160033.GJ2368@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180619160033.GJ2368@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix crash in when incoming
 client channel setup fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Tue, Jun 19, 2018 at 05:00:34PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Tue, Jun 19, 2018 at 04:45:05PM +0100, Dr. David Alan Gilbert wrot=
e:
> > > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > > The way we determine if we can start the incoming migration was
> > > > changed to use migration_has_all_channels() in:
> > > >=20
> > > >   commit 428d89084c709e568f9cd301c2f6416a54c53d6d
> > > >   Author: Juan Quintela <quintela@redhat.com>
> > > >   Date:   Mon Jul 24 13:06:25 2017 +0200
> > > >=20
> > > >     migration: Create migration_has_all_channels
> > > >=20
> > > > This method in turn calls multifd_recv_all_channels_created()
> > > > which is hardcoded to always return 'true' when multifd is
> > > > not in use.
> > > >=20
> > > > This means that if channel initialization fails with normal
> > > > migration, it'll never notice and attempt to start the
> > > > incoming migration regardless.
> > >=20
> > > I'm not sure if that was actually the cause, because older versions
> > > had no check at all in socket_accept_incoming_migration.
> >=20
> > Hmm, actually your write - it was a complicated series of refactoring=
s
> > for multifd, and I think I mis-identified. I'll do a proper bisect so
> > we can have an accurate record.
> >=20
> > >=20
> > > > This can be seen, for example, if a client connects to a server
> > > > requiring TLS, but has an invalid x509 certificate:
> > > >=20
> > > > qemu-system-x86_64: The certificate hasn't got a known issuer
> > > > qemu-system-x86_64: migration/migration.c:386: process_incoming_m=
igration_co: Assertion `mis->from_src_file' failed.
> > > >=20
> > > >  #0  0x00007fffebd24f2b in raise () at /lib64/libc.so.6
> > > >  #1  0x00007fffebd0f561 in abort () at /lib64/libc.so.6
> > > >  #2  0x00007fffebd0f431 in _nl_load_domain.cold.0 () at /lib64/li=
bc.so.6
> > > >  #3  0x00007fffebd1d692 in  () at /lib64/libc.so.6
> > > >  #4  0x0000555555ad027e in process_incoming_migration_co (opaque=3D=
<optimized out>) at migration/migration.c:386
> > > >  #5  0x0000555555c45e8b in coroutine_trampoline (i0=3D<optimized =
out>, i1=3D<optimized out>) at util/coroutine-ucontext.c:116
> > > >  #6  0x00007fffebd3a6a0 in __start_context () at /lib64/libc.so.6
> > > >  #7  0x0000000000000000 in  ()
> > > >=20
> > > > To handle the non-multifd case, we check whether mis->from_src_fi=
le
> > > > is non-NULL.
> > >=20
> > > So, what happens with this fix, does the destination exit cleanly, =
or
> > > stay to accept another connection or what?
> >=20
> > It stays around and can accept another connection, which is actually
> > quite desirable, as it limits impact of a malicious client from DOS'i=
ng
> > the genuine client by racing to connect first.
>=20
> OK, that's fine, although I suspect in most other cases QEMU exits on
> the destination with an error (e.g. if you aren't using TLS and just
> connect to the port and squirt garbage down it, I think it'll exit
> telling you that it's not a migration header).

That's ok as non-TLS has zero security anyway, so improving resilience
only really matters for TLS setups, prior to authorizing the client.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
