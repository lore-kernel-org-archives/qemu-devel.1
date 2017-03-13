Received: from eggs.gnu.org ([2001:4830:134:3::10]:41403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnRjV-0002SH-ET
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnRjS-00048e-7b
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:18:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cnRjS-000486-0x
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:17:58 -0400
Message-ID: <1489418275.13264.39.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Mar 2017 16:17:55 +0100
In-Reply-To: <94414912-f18a-bb2b-4055-126261181e89@reactos.org>
References: <1489048710-22084-1-git-send-email-kraxel@redhat.com>
	<1489048710-22084-5-git-send-email-kraxel@redhat.com>
	<94414912-f18a-bb2b-4055-126261181e89@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/4] [RfC] stdvga: add xres and yres
 properties.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Do, 2017-03-09 at 22:03 +0100, Herv=C3=A9 Poussineau wrote:
> Le 09/03/2017 =C3=A0 09:38, Gerd Hoffmann a =C3=A9crit :
> > Add two new registers to the qemu extended register range, carrying the
> > suggested width and height of the display device.  In case the xres and
> > yres properties are set, fill these new registers accordingly.
> >
> > Additionally guest driver updates are needed to support the new
> > registers.  These changes will probably land in linux kernel 4.12.
>=20
> Is it possible to provide a mecanism to tell guest that the preferred
> default size changed?
> For example, the user can resize the VM window on host, and guest will
> auto-adapt to new size/resolution.
> It is already working like this on VirtualBox with VM Additions.

Well, sure, we can pimp the virtual hardware even more.  Adding such a
notification is pretty invasive though.  We'll have to add irq support
to stdvga, on both guest and host.

So the question is:  Is it worth the effort?  How far we want take it
and why?

For linux this would require a pretty recent guest kernel with the (to
be written) driver changes added.  If you have a recent guest kernel
anyway you can just switch to virtio-gpu where this works today (gtk ui,
or spice with guest agent active).  So I see little reason to put too
much effort into stdvga, for linux guests.

For non-linux guests (where no virtio-gpu driver is available) better
stdvga support might be more useful.  Do you have specific guests in
mind?  Looking at your email address I suspect that is the case ...

While being at it:  We might also consider adding hardware cursor
support.  Seems that is standard these days.  Wayland has no software
cursor support any more, therefore you have no mouse pointer when
running wayland on stdvga (again: on virtio-gpu it'll work just fine).

cheers,
  Gerd
