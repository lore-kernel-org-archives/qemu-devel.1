Received: from eggs.gnu.org ([2001:4830:134:3::10]:45728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT6g9-0004I0-9H
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT6g5-0004Al-7O
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:23:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fT6g4-00049d-WE
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:23:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F9844005F8A
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 14:23:12 +0000 (UTC)
Date: Wed, 13 Jun 2018 15:23:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180613142309.GX19901@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1528372809-175770-1-git-send-email-imammedo@redhat.com>
	<20180608132105.GA24764@localhost.localdomain>
	<20180611151625.4b2420b8@redhat.com>
	<20180611190607.GU7451@localhost.localdomain>
	<20180611232924.6e04b6f8@igors-macbook-pro.local>
	<20180611223633.GG7451@localhost.localdomain>
	<5cef972d-250b-5464-7482-90fa24d36c80@redhat.com>
	<20180612144205.2169e7a2@redhat.com>
	<20180612125033.GF24690@redhat.com>
	<20180613141730.GR7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613141730.GR7451@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH v6 2/2] vl: fix use of
 --daemonize with --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, ldoktor@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com

On Wed, Jun 13, 2018 at 11:17:30AM -0300, Eduardo Habkost wrote:
> On Tue, Jun 12, 2018 at 01:50:33PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Tue, Jun 12, 2018 at 02:42:05PM +0200, Igor Mammedov wrote:
> > > We can keep daemonizing flow in QEMU as it's now.
> > > But Eduardo's idea about libvirt created socked + letting QEMU conn=
ect to it
> > > has a merit. It should fix current deadlock issue with as monitor
> > > won't be depending on lead exit event.
> >=20
> > NB, libvirt only ever uses --daemonize when probing capabilities, nev=
er
> > when launching QEMU for a real VM. In the latter case, we now use FD
> > passing, so libvirt opens the UNIX domain socket listener, and passes
> > this into QEMU. So libvirt knows it can connect to the listener
> > immediately and will only ever get a failure if QEMU has exited.
>=20
> So, what I'm really missing here is: do we have a good reason to
> support --daemonize + --preconfig today?

On the libvirt zero, I don't see a compelling need for it.

> The options I see are:
>=20
> 1) complete daemonization before preconfig main loop
> ----------------------------------------------------
>=20
> By "complete daemonization" I mean doing chdir("/"),
> stderr/stdout cleanup, chroot, and UID magic before calling
> exit(0) on the main QEMU process.
>=20
> Pros:
> * More intuitive
>=20
> Cons:
> * Can break existing initialization code that don't expect
>   this to happen.
>   (can this be fixed?)
> * Can break any preconfig-time QMP commands that rely on opening
>   files
>   (is it a real problem?)

NB Use of -chroot is separate from -daemonize, so it is not
an issue with -preconfig + -daemonize alone.

There's soo many caveats around -chroot, I struggle to
care about adding another caveats.

> * Any initialization error conditions that currently rely on
>   error_report()+exit() will be very inconvenient to handle
>   properly
>   (this can be fixed eventually, but it's not trivial)


> 3) daemonize only after leaving preconfig state
> -----------------------------------------------
>=20
> AFAICS, this is the current behavior.
>=20
> Pros:
> * Less likely to break init code
> * Keeps existing code as is
>=20
> Cons:
> * Less intuitive
> * -daemonize becomes useless as synchronization point for monitor
>   availability

Yeah that honestly kills the key benefit of having -daemonize
imho.

> * Would this be useful for anybody, at all?
> * We won't be able to change this behavior later
>=20
>=20

> I believe the only reasonable options are (1) and (4).

Agreed.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
