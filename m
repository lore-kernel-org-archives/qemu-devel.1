Received: from eggs.gnu.org ([2001:4830:134:3::10]:46439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbXuc-0001nh-8M
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbXuY-0006cG-97
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:28:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbXuY-0006cA-0f
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:28:14 -0500
Message-ID: <1486582091.3641.32.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 08 Feb 2017 20:28:11 +0100
In-Reply-To: <CAFEAcA8+wfPQXXhoYZDv8LAOS6=4_P9kyaHONuMQcb7VmkVyxw@mail.gmail.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<CAFEAcA8+wfPQXXhoYZDv8LAOS6=4_P9kyaHONuMQcb7VmkVyxw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Andrew Jones <drjones@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, 2017-02-08 at 18:32 +0000, Peter Maydell wrote:
> What does nodefaults disable on the virt board?
> (I've never looked into exactly what nodefaults does...)

When -nodefaults is missing, a default virtio-net-pci
plugged into 00:01.0 is automatically added.

> There doesn't seem to be any specification of the GIC
> version (unless I missed it in the config file); you
> probably want -machine gic-version=3Dhost if you're using
> -cpu host.

Very good point! I've added it.

I would really, really like to be able to specify the
CPU model in the configuration file as well, but I haven't
found a way to do so :(

On the other hand, I just realized that I can add

=C2=A0 [machine]
=C2=A0=C2=A0=C2=A0=C2=A0graphics =3D "off"

to get rid of -nographic on the command line! \o/

> > +# Using -nodefaults is required to have full control over
> > +# the virtual hardware: when it's specified, QEMU will
> > +# create a bare machine with just the very essential
> > +# chipset devices being present:
>=C2=A0
> The theory of 'virt' is it only has the essential
> devices anyway.

See above ;)

The use of -nodefaults is there mostly to guarantee that we
always start from a clean slate, like for example add the
Ethernet adapter ourselves (giving us a chance to comment
on its usage) instead of using the default one.

Another goal is to be consistent with the q35 sample
configuration files: ideally comparing mach-virt-serial.cfg
and q35-virtio-serial.cfg, for example, should yield a
very minimal diff.

> > +#=C2=A0=C2=A0=C2=A000:00.0 Host bridge
>=C2=A0
> I'm pretty sure -nodefaults isn't going to disable
> the GIC, the UART, the flash devices, etc etc that
> the virt board has. Not everything in the world is
> a PCI device :-)

Right. So far I've basically stuck with PCI devices: even
the device listing, as you can see, is modeled after the
output of lspci.

That said, I'm not against documenting more devices.

[...]
> It's a shame that we've ended up with different
> firmware names (even between RHEL and Fedora, without
> getting to Debian or SUSE).

Yeah, it's pretty unfortunate :(

> Would making UEFI a
> more "official" rom image in pc-bios/ help to
> harmonise things, or just introduce yet another
> possibility to the mix?

Sorry, no idea. I'll let someone else comment on this one.

[...]
> > +[device "console"]
> > +=C2=A0=C2=A0driver =3D "virtconsole"
> > +=C2=A0=C2=A0chardev =3D "hostconsole"
>=C2=A0
> Won't most guests expect serial to be the default
> PL011 UART ?

Possibly. I'm using virtconsole here (and in q35*serial.cfg)
mostly to have as much VirtIO as possible, but I also
document the fact that you might want or need to use the
native serial console instead.

Moreover, something that I haven't been able to do on
mach-virt (even though I could on q35, but again, I want the
files to be as close as possible) is to configure the serial
console from the configuration file.

Seeing as we have an alternative, I'd rather keep it this
way and minimize the number of command line arguments the
user needs to specify.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
