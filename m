Received: from eggs.gnu.org ([2001:4830:134:3::10]:53978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVJUy-00019u-Us
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVJUv-00071F-0d
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:28:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVJUu-00070k-Ry
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:28:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CDEA401B3A0
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 16:28:48 +0000 (UTC)
Date: Tue, 19 Jun 2018 17:28:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180619162844.GG26829@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180619151719.17002-1-berrange@redhat.com>
	<20180619154504.GI2368@work-vm> <20180619155859.GE26829@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180619155859.GE26829@redhat.com>
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

On Tue, Jun 19, 2018 at 04:58:59PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jun 19, 2018 at 04:45:05PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > The way we determine if we can start the incoming migration was
> > > changed to use migration_has_all_channels() in:
> > >=20
> > >   commit 428d89084c709e568f9cd301c2f6416a54c53d6d
> > >   Author: Juan Quintela <quintela@redhat.com>
> > >   Date:   Mon Jul 24 13:06:25 2017 +0200
> > >=20
> > >     migration: Create migration_has_all_channels
> > >=20
> > > This method in turn calls multifd_recv_all_channels_created()
> > > which is hardcoded to always return 'true' when multifd is
> > > not in use.
> > >=20
> > > This means that if channel initialization fails with normal
> > > migration, it'll never notice and attempt to start the
> > > incoming migration regardless.
> >=20
> > I'm not sure if that was actually the cause, because older versions
> > had no check at all in socket_accept_incoming_migration.
>=20
> Hmm, actually your write - it was a complicated series of refactorings
> for multifd, and I think I mis-identified. I'll do a proper bisect so
> we can have an accurate record.

Ok, this commit above introduces the latent bug, and then it is
activated by

  commit 36c2f8be2c4eb0003ac77a14910842b7ddd7337e
  Author: Juan Quintela <quintela@redhat.com>
  Date:   Wed Mar 7 08:40:52 2018 +0100

    migration: Delay start of migration main routines
   =20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
