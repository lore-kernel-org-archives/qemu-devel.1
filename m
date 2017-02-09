Received: from eggs.gnu.org ([2001:4830:134:3::10]:40586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbolM-0005Sn-Bx
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbolI-0002rR-D4
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:27:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbolI-0002rD-5A
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:27:48 -0500
Message-ID: <1486646865.3641.41.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 09 Feb 2017 14:27:45 +0100
In-Reply-To: <20170209122819.ajgatpsnxj7cdjq2@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
	<CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
	<1486637473.3641.36.camel@redhat.com>
	<20170209122819.ajgatpsnxj7cdjq2@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, 2017-02-09 at 10:42 +0100, Andrew Jones wrote:
> > +[machine]
> > +=C2=A0=C2=A0type =3D "virt"
> > +=C2=A0=C2=A0accel =3D "kvm"
> > +
> > +[memory]
> > +=C2=A0=C2=A0size =3D "1024"
>=C2=A0
> So I'm not sure about providing this, at least not in this
> config file. I think we should expect the user to provide ram
> size explicitly, as this depends on what they want to do with
> the guest. Even accel is debatable, as many users may want to
> use tcg from their x86 machines.
>=C2=A0
> How about focusing this config on the PCIe topology and default
> devices? Additional config defaults like accel and ram could
> be added to an additional config, if we want.

Well, this is a sample configuration, not a one-size-fits-all
solution. It's okay for it to be opinionated.

The way I expect this file to be consumed is that people will
copy it over[1] to some location, tweak it to their liking by
adding and removing devices and altering settings such as
memory size, then use it to start a specific guest from that
moment on. When they need another guest, they can make another
copy of the sample and start over.

So the least parameters the user will have to specify outside
of the configuration file, the better. We actually moved *away*
from the idea of including multiple configuration files (one
for the "common" parts such as PCIe controllers, one for other
devices such as the video card as opposed to the serial
console) because it's much easier to have everything in one
place, for usability and for documentation purposes.

It's not a framework, just a decent starting point.

[...]
> > +[drive "aavmf-code"]
> > +=C2=A0=C2=A0file =3D "/usr/share/edk2/aarch64/QEMU_EFI.fd"=C2=A0=C2=A0=
# CHANGE ME
> > +=C2=A0=C2=A0format =3D "raw"
> > +=C2=A0=C2=A0if =3D "pflash"
> > +=C2=A0=C2=A0unit =3D "0"
> > +=C2=A0=C2=A0readonly =3D "on"
> > +
> > +[drive "aavmf-vars"]
> > +=C2=A0=C2=A0file =3D "guest_VARS.fd"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# CHANGE ME
> > +=C2=A0=C2=A0format =3D "raw"
> > +=C2=A0=C2=A0if =3D "pflash"
> > +=C2=A0=C2=A0unit =3D "1"
>=C2=A0
> The fact these entries need 'CHANGE ME' comments make me think they
> should also be removed from this config and required explicitly,
> or provided by other configs. Perhaps we can create a config for
> each firmware path we know of? Or, is there any way for a user
> to override the file path from the command line? Does
>=C2=A0
>=C2=A0=C2=A0-readconfig config -drive id=3Daavmf-vars,file=3Dnew-path
>=C2=A0
> work? If so, then we can document how CHANGEME's can be easily
> changed without touching the file.

See above.

[...]
> > +# Display controller
> > +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +#
> > +# We use virtio-gpu because the legacy VGA framebuffer is
> > +# very troublesome on aarch64, and virtio-gpu is the only
>=C2=A0
> We use virtio-gpu because emulating a legacy VGA framebuffer
> is not possible on AArch64 KVM guests due to unavoidable
> stage1 / stage2 page table cache mode mismatches.
>=C2=A0
> Or just leave the troublesome comment...

I guess that depends a lot on how low-level we want them
be... Overall, I kept them fairly high-level, not least
because that's pretty much as far my knowledge goes.

In other words, your take on the description is certainly
100% accurate but also 100% flying way over my head ;)

[...]
> I agree with the comments of others that we should be using
> the PL011 instead. We should also set it up such that the
> monitor is multiplexed, so ^C won't terminate the guest and
> ^A will allow us to go to the monitor.

That sounds awesome, how do I actually make it work from
the configuration file though?


[1] Looks like these files are not being installed on the
=C2=A0=C2=A0=C2=A0=C2=A0system by 'make install'. I'd argue having them i=
n
=C2=A0=C2=A0=C2=A0=C2=A0/usr/share/doc/qemu/examples would be nice for us=
ers.
--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
