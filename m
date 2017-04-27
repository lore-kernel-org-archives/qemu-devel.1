Received: from eggs.gnu.org ([2001:4830:134:3::10]:49790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d3kvl-0007hP-UE
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d3kvi-00057L-1u
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d3kvh-00056z-Ri
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:02:01 -0400
Message-ID: <1493305319.31995.63.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Apr 2017 17:01:59 +0200
In-Reply-To: <20170427140006.GE4805@noname.str.redhat.com>
References: <20170421091632.30900-1-kraxel@redhat.com>
	<20170421091632.30900-3-kraxel@redhat.com>
	<20170427140006.GE4805@noname.str.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/9] memory: add support getting and using
 a dirty bitmap copy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Do, 2017-04-27 at 16:00 +0200, Kevin Wolf wrote:
> Am 21.04.2017 um 11:16 hat Gerd Hoffmann geschrieben:
> > +bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
> > +                                            ram_addr_t start,
> > +                                            ram_addr_t length)
> > +{
> > +    unsigned long page, end;
> > +
> > +    assert(start >=3D snap->start);
> > +    assert(start + length <=3D snap->end);
>=20
> Not sure if this has been reported somewhere else, but I got an
> assertion failure here while booting a guest:
>=20
> $ ~/source/qemu/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -m 2G -driv=
e file=3DWindows-10-20170427.0-x86_64.qcow2,snapshot=3Don -usbdevice tablet=
 -vga qxl
> qemu-system-x86_64: /home/kwolf/source/qemu/exec.c:1125: cpu_physical_mem=
ory_snapshot_get_dirty: Zusicherung >>start + length <=3D snap->end<< nicht=
 erf?llt.
> Abgebrochen (Speicherabzug geschrieben)
>=20
> Unfortunately, I didn't have gdb attached or core dumps enabled, and it
> doesn't seem to reproduce easily, so I don't have anything that could
> help debugging it, but I thought I'd just let you know anyway.

Saw this a few times too, didn't have the time yet to dig deeper,
appears to happen due to a display update when the guest is half-way
through a mode switch and the vga registers are in inconsistent state.

Reproducer: boot fedora live iso, when isolinux switches back to text
mode it can trigger (one out of ten boots, loaded host seems to make it
more likely)

The easy way out is to just return false instead of asserting.

I want check how exactly this happens though, to make sure this isn't a
exploitable race (unlikely IMHO, but still worth checking ...).  Also
I'd prefer to fix vga and keep the assert()s, they are a good sanity
check.

cheers,
  Gerd
