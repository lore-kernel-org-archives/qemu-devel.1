Received: from eggs.gnu.org ([2001:4830:134:3::10]:50721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cE9iz-0005vS-Na
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 01:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cE9iw-0005S3-NM
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 01:59:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cE9iw-0005Rq-HQ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 01:59:34 -0500
Message-ID: <1481007570.20373.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 06 Dec 2016 07:59:30 +0100
In-Reply-To: <62f28da2-a81b-e0f8-32b7-6e75f197750b@redhat.com>
References: <20161202174015.GE15373@work-vm>
	<1480926783.28320.9.camel@redhat.com> <20161205094646.GA2508@work-vm>
	<62f28da2-a81b-e0f8-32b7-6e75f197750b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [Spice-devel] Postcopy+spice crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: uril@redhat.com
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, spice-devel <spice-devel@freedesktop.org>

  Hi,

> >> On a quick glance I'd blame the guest for sending corrupted commands.
> >> Strange though that it happens on migration only, so there could be
> >> a host issue too.  Or a timing issue triggered by migration.
> >>
> >> Which migration phase?
> >
> > This is the point at which it switches over in postcopy.
>=20
> It looks like it's the vmstate (post) load phase of the qxl device on
> destination host.

Dave, can you try "thread apply all bt" so we see the other threads too?
That should show whenever it happens in post_load

> Maybe if you trace qxl device save/load related functions
> on both src and dst hosts you'll see a difference.

qxl keeps references to certain commands (create surface for example) in
qxl device memory, so it can replay them in post_load.  That possibly
doesn't work correctly with postcopy.

cheers,
  Gerd
