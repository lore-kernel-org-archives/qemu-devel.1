Received: from eggs.gnu.org ([2001:4830:134:3::10]:53200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cbpOP-0007X8-JR
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cbpOK-0007w7-ID
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:08:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cbpOK-0007vU-AU
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:08:08 -0500
Date: Thu, 9 Feb 2017 15:08:04 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170209140804.onpj3pniqim3qxr4@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
	<CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
	<1486637473.3641.36.camel@redhat.com>
	<20170209122819.ajgatpsnxj7cdjq2@kamzik.brq.redhat.com>
	<1486646865.3641.41.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1486646865.3641.41.camel@redhat.com>
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
To: Andrea Bolognani <abologna@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Feb 09, 2017 at 02:27:45PM +0100, Andrea Bolognani wrote:
> On Thu, 2017-02-09 at 10:42 +0100, Andrew Jones wrote:
> > > +[machine]
> > > +=A0=A0type =3D "virt"
> > > +=A0=A0accel =3D "kvm"
> > > +
> > > +[memory]
> > > +=A0=A0size =3D "1024"
> >=A0
> > So I'm not sure about providing this, at least not in this
> > config file. I think we should expect the user to provide ram
> > size explicitly, as this depends on what they want to do with
> > the guest. Even accel is debatable, as many users may want to
> > use tcg from their x86 machines.
> >=A0
> > How about focusing this config on the PCIe topology and default
> > devices? Additional config defaults like accel and ram could
> > be added to an additional config, if we want.
>=20
> Well, this is a sample configuration, not a one-size-fits-all
> solution. It's okay for it to be opinionated.
>=20
> The way I expect this file to be consumed is that people will
> copy it over[1] to some location, tweak it to their liking by
> adding and removing devices and altering settings such as
> memory size, then use it to start a specific guest from that
> moment on. When they need another guest, they can make another
> copy of the sample and start over.
>=20
> So the least parameters the user will have to specify outside
> of the configuration file, the better. We actually moved *away*
> from the idea of including multiple configuration files (one
> for the "common" parts such as PCIe controllers, one for other
> devices such as the video card as opposed to the serial
> console) because it's much easier to have everything in one
> place, for usability and for documentation purposes.
>=20
> It's not a framework, just a decent starting point.

OK, if that's the consensus on how they should be used, then
that's fine by me. I've actually never used files like these,
but I was imagining they'd be great to use like this

 qemu -nodefaults -readconfig configfile -more -params \
      -that -may -override -stuff -in -the -configfile

Actually, I don't think anything is stopping me from using this
file that way. I'll have to try the file name override that I
suggested below, but

 qemu -nodefaults -readconfig configfile -m $MEM -machine accel=3Dtcg

should certainly override correctly.

>=20
> [...]
> > > +[drive "aavmf-code"]
> > > +=A0=A0file =3D "/usr/share/edk2/aarch64/QEMU_EFI.fd"=A0=A0# CHANGE=
 ME
> > > +=A0=A0format =3D "raw"
> > > +=A0=A0if =3D "pflash"
> > > +=A0=A0unit =3D "0"
> > > +=A0=A0readonly =3D "on"
> > > +
> > > +[drive "aavmf-vars"]
> > > +=A0=A0file =3D "guest_VARS.fd"=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0# CHANGE ME
> > > +=A0=A0format =3D "raw"
> > > +=A0=A0if =3D "pflash"
> > > +=A0=A0unit =3D "1"
> >=A0
> > The fact these entries need 'CHANGE ME' comments make me think they
> > should also be removed from this config and required explicitly,
> > or provided by other configs. Perhaps we can create a config for
> > each firmware path we know of? Or, is there any way for a user
> > to override the file path from the command line? Does
> >=A0
> >=A0=A0-readconfig config -drive id=3Daavmf-vars,file=3Dnew-path
> >=A0
> > work? If so, then we can document how CHANGEME's can be easily
> > changed without touching the file.
>=20
> See above.
>=20
> [...]
> > > +# Display controller
> > > +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +#
> > > +# We use virtio-gpu because the legacy VGA framebuffer is
> > > +# very troublesome on aarch64, and virtio-gpu is the only
> >=A0
> > We use virtio-gpu because emulating a legacy VGA framebuffer
> > is not possible on AArch64 KVM guests due to unavoidable
> > stage1 / stage2 page table cache mode mismatches.
> >=A0
> > Or just leave the troublesome comment...
>=20
> I guess that depends a lot on how low-level we want them
> be... Overall, I kept them fairly high-level, not least
> because that's pretty much as far my knowledge goes.
>=20
> In other words, your take on the description is certainly
> 100% accurate but also 100% flying way over my head ;)
>=20
> [...]
> > I agree with the comments of others that we should be using
> > the PL011 instead. We should also set it up such that the
> > monitor is multiplexed, so ^C won't terminate the guest and
> > ^A will allow us to go to the monitor.
>=20
> That sounds awesome, how do I actually make it work from
> the configuration file though?

Sorry, dunno :-)

>=20
>=20
> [1] Looks like these files are not being installed on the
> =A0=A0=A0=A0system by 'make install'. I'd argue having them in
> =A0=A0=A0=A0/usr/share/doc/qemu/examples would be nice for users.

I agree.

Thanks,
drew
