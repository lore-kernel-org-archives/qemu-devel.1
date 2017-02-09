Received: from eggs.gnu.org ([2001:4830:134:3::10]:49137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbpAb-00006X-AI
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbpAa-0003Y0-BS
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:53:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbpAa-0003Xu-2N
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:53:56 -0500
Message-ID: <1486648432.3641.43.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 09 Feb 2017 14:53:52 +0100
In-Reply-To: <CAFEAcA_txm4n6U1k3ZsTqb=91j5bm9H1i4FtzR92ybnFy-WJ_Q@mail.gmail.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<CAFEAcA8+wfPQXXhoYZDv8LAOS6=4_P9kyaHONuMQcb7VmkVyxw@mail.gmail.com>
	<1486582091.3641.32.camel@redhat.com>
	<CAFEAcA_txm4n6U1k3ZsTqb=91j5bm9H1i4FtzR92ybnFy-WJ_Q@mail.gmail.com>
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

On Wed, 2017-02-08 at 19:36 +0000, Peter Maydell wrote:
> > When -nodefaults is missing, a default virtio-net-pci
> > plugged into 00:01.0 is automatically added.
>=C2=A0
> Ah, right, default -net commands. Is that it?

I believe so, but double checking is never the wrong thing
to do ;)

> > On the other hand, I just realized that I can add
> >=C2=A0
> >=C2=A0=C2=A0=C2=A0[machine]
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0graphics =3D "off"
> >=C2=A0
> > to get rid of -nographic on the command line! \o/

... and after writing this, I actually tested it and
realized that it doesn't quite do what I want it to :(

> -nographic is kind of odd if you're taking the
> "use -nodefaults and specify everything manually"
> because it wraps up a whole pile of default config
> in one oddball legacy config switch. I would have
> expected -display none and whatever other options
> you wanted.

-nographic is just what libvirt uses: if there's a better
way to achieve the same result then I'm all for it!

Seems like '-display none' behaves the same as -nographic,
at least for my purposes. Unfortunately I still can't have
it inside the configuration file, it has to be on the
command line :(

[...]
> > Moreover, something that I haven't been able to do on
> > mach-virt (even though I could on q35, but again, I want the
> > files to be as close as possible) is to configure the serial
> > console from the configuration file.
>=C2=A0
> If there's stuff we can fix in the virt board to make
> this work the way it does on the PC model I'm happy
> to make fixes to help.

Well, with a q35 guest I can just add

=C2=A0 [chardev "hostconsole"]
=C2=A0=C2=A0=C2=A0=C2=A0backend =3D "stdio"

=C2=A0 [device "console"]
=C2=A0=C2=A0=C2=A0=C2=A0driver =3D "isa-serial"
=C2=A0=C2=A0=C2=A0=C2=A0chardev =3D "hostconsole"

to the configuration file and get the same behavior I would
get by adding '-serial stdio' to the command line, but I
haven't been able to find any device that I can use the same
way as isa-serial on mach-virt. Maybe I just missed it?

[...]
> The trouble with using virtconsole is that you have to
> get quite a long way forward (probing and setting up
> PCI, etc) before you can get any kind of console output.
> "System doesn't boot and doesn't produce any output"
> is a common and really annoying failure mode in the
> ARM world, and I think that using virtconsole is
> asking for that kind of thing to happen more rather
> than less often. (Plus having two different serial
> ports in the guest means that now the user has to
> configure where both of them are supposed to output.)

You don't get one unless you use '-serial stdio' or
something like that in my experience, so if you use the
sample configuration file as I posted it you will only
get one serial console, the VirtIO-based one.

I agree though that the lack of boot output and especially
GRUB menu access in virtconsole is less then ideal, because
even though the users will eventually get a login prompt,
the first few seconds without any output at all might lead
them to believe the guest is not working properly.

I just wish there were a way to add the default serial
console straight from the configuration file...

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
