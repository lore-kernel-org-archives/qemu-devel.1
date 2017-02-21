Received: from eggs.gnu.org ([2001:4830:134:3::10]:39558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg7JW-0007qX-Qf
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg7JR-0007Ta-Sk
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:04:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg7JR-0007T6-MJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:04:49 -0500
Message-ID: <1487671486.2694.65.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 11:04:46 +0100
In-Reply-To: <CAJ+F1C+0jQ=e3dC--qWGDzhjAHtxDeYd_FRo3QGfWKO-thQ3yA@mail.gmail.com>
References: <1487663858-11731-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CLK3aPi+aDgHGUjCCF2Xbi1V=g5UjM_BAko_PSfau33KA@mail.gmail.com>
	<1487668309.2694.37.camel@redhat.com>
	<CAJ+F1C+0jQ=e3dC--qWGDzhjAHtxDeYd_FRo3QGfWKO-thQ3yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] spice: add display & head options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

  Hi,

> It's always 0, except with virtio.=20
>=20
> But I think virtio linux driver multi-monitor code would work with a
> single qemu head (like qxl, fwiw last time I checked, multi-monitor
> virtio+spice worked, with 3d too).

> It seems to me the qemu "head" is quite different (lower-level) from
> spice "head".

Well.  spice/qxl supports two different ways to do multihead ...

The first way is one display channel per head.  Which maps nicely to
qemu heads.  With qxl you'll use one qxl-vga device for the primary
display and one (or more) qxl devices for the secondary displays.  I
think multihead with windows guests still works that way, but xorg
support for that (xinerama mode) is pretty bad.  IIRC it needs manual
configuration, could also be recent xorg versions don't support it any
more.  Dunno where we stand with wayland.

The second way is a single display channel with a single, big surface
for all heads.  Then -- with spice-agent help -- guest and client
negotiate which region of the big display gets scanned out to which
head.

Multihead spice with virtio-gpu fundamentally works like the first way,
except that we have a single device with multiple heads (and display
channels) instead of multiple devices which have a single head each.

The use case I see for this is not so much multihead configuration.
With multiple display devices in your system, for example one intel-vgpu
and one emulated display device one could export only one of the two via
spice.

cheers,
  Gerd
