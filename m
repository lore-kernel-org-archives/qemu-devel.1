Received: from eggs.gnu.org ([209.51.188.92]:60715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gj5CL-00022j-EQ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gj5CK-0001uH-8D
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:34:49 -0500
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:53491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gj5CJ-0001e7-WF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:34:48 -0500
Received: from player772.ha.ovh.net (unknown [10.109.143.24])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6A0E11108D6
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 17:34:22 +0100 (CET)
Date: Mon, 14 Jan 2019 17:34:03 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190114173403.4950bb51@bahia.lan>
In-Reply-To: <eef8c4ba-ae32-6518-e93f-1dda1e9d914d@kaod.org>
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
	<154724066386.525985.7102226604937744914.stgit@bahia.lan>
	<cdbc7f08-f0f7-725e-8511-6a303696c1ef@kaod.org>
	<20190114161020.297ac3b2@bahia.lan>
	<eef8c4ba-ae32-6518-e93f-1dda1e9d914d@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/13] spapr_irq: Allow synchronization
 of a single irq state to KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On Mon, 14 Jan 2019 17:29:48 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 1/14/19 4:10 PM, Greg Kurz wrote:
> > On Mon, 14 Jan 2019 09:19:50 +0100
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> >> On 1/11/19 10:04 PM, Greg Kurz wrote: =20
> >>> When using the in-kernel interrupt controller, the state of all irqs =
is
> >>> synchronized to KVM at machine reset time. In the case of PHB hotplug=
, we
> >>> will need to synchronize LSIs manually.   =20
> >>
> >> Yes. This is because the interrupt sources in the KVM XICS device have=
=20
> >> already been initialized as MSIs.=20
> >>
> >> Can not we reset the source when it is claimed ?=20
> >>
> >> An alternative solution would be to initialize the SPAPR_IRQ_PCI_LSI r=
ange=20
> >> as LSIs at a KVM level.
> >> =20
> >=20
> > I don't really want to add some dependency to sPAPR code in KVM XICS...=
 what
> > about claiming LSIs for all possible PHBs at machine init time ? =20
>=20
> you can not claim IRQ numbers twice. So if a new PHB is hot-plugged,=20
> it will fail the claim its LSIs.
>=20

The intent is to claim all these LSIs for the lifetime of the machine, inst=
ead
of having each PHB to claim its own ones during realize.

> C. =20
