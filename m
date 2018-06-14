Received: from eggs.gnu.org ([2001:4830:134:3::10]:58405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTRQq-0006dT-BY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTRQl-0008JV-CC
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:32:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fTRQl-0008JA-6O
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:32:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91BAF859A8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:32:46 +0000 (UTC)
Date: Thu, 14 Jun 2018 14:32:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180614143241.354dd8df@redhat.com>
In-Reply-To: <20180613170932.GA7451@localhost.localdomain>
References: <20180608132105.GA24764@localhost.localdomain>
	<20180611151625.4b2420b8@redhat.com>
	<20180611190607.GU7451@localhost.localdomain>
	<20180611232924.6e04b6f8@igors-macbook-pro.local>
	<20180611223633.GG7451@localhost.localdomain>
	<5cef972d-250b-5464-7482-90fa24d36c80@redhat.com>
	<20180612144205.2169e7a2@redhat.com>
	<20180612125033.GF24690@redhat.com>
	<20180613141730.GR7451@localhost.localdomain>
	<20180613142309.GX19901@redhat.com>
	<20180613170932.GA7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, ldoktor@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, pkrempa@redhat.com

On Wed, 13 Jun 2018 14:09:32 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Jun 13, 2018 at 03:23:09PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jun 13, 2018 at 11:17:30AM -0300, Eduardo Habkost wrote: =20
> > > On Tue, Jun 12, 2018 at 01:50:33PM +0100, Daniel P. Berrang=C3=A9 wro=
te: =20
> > > > On Tue, Jun 12, 2018 at 02:42:05PM +0200, Igor Mammedov wrote: =20
> > > > > We can keep daemonizing flow in QEMU as it's now.
> > > > > But Eduardo's idea about libvirt created socked + letting QEMU co=
nnect to it
> > > > > has a merit. It should fix current deadlock issue with as monitor
> > > > > won't be depending on lead exit event. =20
> > > >=20
> > > > NB, libvirt only ever uses --daemonize when probing capabilities, n=
ever
> > > > when launching QEMU for a real VM. In the latter case, we now use FD
> > > > passing, so libvirt opens the UNIX domain socket listener, and pass=
es
> > > > this into QEMU. So libvirt knows it can connect to the listener
> > > > immediately and will only ever get a failure if QEMU has exited. =20
> > >=20
> > > So, what I'm really missing here is: do we have a good reason to
> > > support --daemonize + --preconfig today? =20
> >=20
> > On the libvirt zero, I don't see a compelling need for it. =20
>=20
> Good. :)
>=20
> > > The options I see are:
> > > 1) complete daemonization before preconfig main loop =20
> [...]
> > > 4) Not supporting -preconfig + -daemonize =20
> [...]
> > > I believe the only reasonable options are (1) and (4). =20
> >=20
> > Agreed. =20
>=20
> If it was up to me, I would just go with (4) because it's
> simpler.
Let's just disable it for now. it will be easier to allow it
than take it back later.

>=20
> But if somebody wants to implement (1), the caveats should be
> clearly documented.  I would prefer to simply document
> "--daemonize --preconfig" as experimental, with something like:
>=20
>   "Note: usage of --daemonize with the --preconfig option is
>   experimental, because it can prevent QEMU from reporting
>   machine initialization errors and prevent some features from
>   working after QEMU is daemonized."
