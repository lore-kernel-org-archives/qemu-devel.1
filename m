Received: from eggs.gnu.org ([2001:4830:134:3::10]:32893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWnCe-00087v-Sv
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gWnCa-0006yN-PE
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:56:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gWnCa-0006xa-G8
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:56:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46B7029A76
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 18:56:15 +0000 (UTC)
Date: Tue, 11 Dec 2018 13:56:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181211135230-mutt-send-email-mst@kernel.org>
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
	<20181126124250.29985-2-marcandre.lureau@redhat.com>
	<20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
	<CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
	<20181210183313-mutt-send-email-mst@kernel.org>
	<20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
	<20181211092944.GA921@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181211092944.GA921@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Hoffmann, Gerd" <kraxel@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Dec 11, 2018 at 09:29:44AM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Dec 11, 2018 at 08:42:41AM +0100, Hoffmann, Gerd wrote:
> >   Hi,
> >=20
> > > Right. The main issue is that we need to make sure only
> > > in-tree devices are supported.
> >=20
> > Well, that is under debate right now, see:
> > https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04912.html
>=20
> I've previously been against the idea of external plugins for QEMU,
> however, that was when the plugin was something that would be dlopen'd
> by QEMU. That would cause our internal ABI to be exposed to 3rd parties
> which is highly undesirable, even if they were open source to comply
> with the license needs.
>=20
> When the plugin is a completely isolated process communicating with a
> well defined protocol, it is not placing a significant burden on the
> QEMU developers' ongoing maintainence, nor has problems with license
> compliance. The main problem would come from debugging the combined
> system as the external process is essentially a black box from QEMU's
> POV. Downstream OS vendors are free to place restrictions on which
> backend processes they'd be willing to support with QEMU, and upstream
> is under no obligation to debug stuff beyond the QEMU boundary.
>=20
> We have already accepted that tradeoff with networking by supporting
> vhost-user and have externals impls like DPDK, so I don't see a
> compelling reason to try to restrict it for other vhost-user backends.

OK seems to be more or less a rough concensus then.

I wonder what's the approach wrt migration though.

Even the compatibility story about vhost-user isn't
great, I would like to see something solid before
we allow that.

Are we happy to just block live migration?
For sure that's already the case with VFIO.


> > > vhost-user by design
> > > is for out of tree users. It needn't be hard,
> > > maybe it's enough to just make qemu launch these processes
> > > as opposed to connecting to them on command line.
> >=20
> > Not sure this is a good idea, with security being one of the motivati=
ng
> > factors to move device emulation to other processes.  When libvirt
> > launches the processes it can place them in separate sandboxes ...
>=20
> Yep, libvirt already turns on seccomp policies which forbid QEMU from
> forking/execing anything, and we have no desire to go backwards here.
> Any external processes have to be launched by libvirt ahead of time.
>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
