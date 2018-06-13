Received: from eggs.gnu.org ([2001:4830:134:3::10]:43814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT6ar-0008RB-HO
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fT6ao-0007R8-Ps
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:17:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fT6ao-0007OQ-H5
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:17:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A37B73086247
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 14:17:39 +0000 (UTC)
Date: Wed, 13 Jun 2018 11:17:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613141730.GR7451@localhost.localdomain>
References: <20180606135051.GR7451@localhost.localdomain>
	<1528372809-175770-1-git-send-email-imammedo@redhat.com>
	<20180608132105.GA24764@localhost.localdomain>
	<20180611151625.4b2420b8@redhat.com>
	<20180611190607.GU7451@localhost.localdomain>
	<20180611232924.6e04b6f8@igors-macbook-pro.local>
	<20180611223633.GG7451@localhost.localdomain>
	<5cef972d-250b-5464-7482-90fa24d36c80@redhat.com>
	<20180612144205.2169e7a2@redhat.com>
	<20180612125033.GF24690@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180612125033.GF24690@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, ldoktor@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com

On Tue, Jun 12, 2018 at 01:50:33PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jun 12, 2018 at 02:42:05PM +0200, Igor Mammedov wrote:
> > We can keep daemonizing flow in QEMU as it's now.
> > But Eduardo's idea about libvirt created socked + letting QEMU connec=
t to it
> > has a merit. It should fix current deadlock issue with as monitor
> > won't be depending on lead exit event.
>=20
> NB, libvirt only ever uses --daemonize when probing capabilities, never
> when launching QEMU for a real VM. In the latter case, we now use FD
> passing, so libvirt opens the UNIX domain socket listener, and passes
> this into QEMU. So libvirt knows it can connect to the listener
> immediately and will only ever get a failure if QEMU has exited.

So, what I'm really missing here is: do we have a good reason to
support --daemonize + --preconfig today?

The options I see are:

1) complete daemonization before preconfig main loop
----------------------------------------------------

By "complete daemonization" I mean doing chdir("/"),
stderr/stdout cleanup, chroot, and UID magic before calling
exit(0) on the main QEMU process.

Pros:
* More intuitive

Cons:
* Can break existing initialization code that don't expect
  this to happen.
  (can this be fixed?)
* Can break any preconfig-time QMP commands that rely on opening
  files
  (is it a real problem?)
* Any initialization error conditions that currently rely on
  error_report()+exit() will be very inconvenient to handle
  properly
  (this can be fixed eventually, but it's not trivial)


2) incomplete daemonization before preconfig main loop
------------------------------------------------------

This means calling exit(0) on the main process before doing the
chdir/stderr/etc magic.

Pros:
* Less likely to break initialization code and other QMP commands

Cons:
* Not what's expected from a well-behaved daemon.
  (If we're not daemonizing properly, what's the point of using
  -daemonize at all?)
* More difficult to change behavior later.


3) daemonize only after leaving preconfig state
-----------------------------------------------

AFAICS, this is the current behavior.

Pros:
* Less likely to break init code
* Keeps existing code as is

Cons:
* Less intuitive
* -daemonize becomes useless as synchronization point for monitor
  availability
* Would this be useful for anybody, at all?
* We won't be able to change this behavior later


4) Not supporting -preconfig + -daemonize
-----------------------------------------

Pros:
* Simple to implement.
* Avoids unexpected bugs.
* Saves our time.
* We can change this behavior later.

Cons:
* People might want us to support it eventually.



I believe the only reasonable options are (1) and (4).

--=20
Eduardo
