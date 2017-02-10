Received: from eggs.gnu.org ([2001:4830:134:3::10]:55188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ccCsq-0004A8-II
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ccCsm-0004fp-Eo
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:13:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1ccCsm-0004fF-6W
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:13:08 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C35242BA2
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 15:13:08 +0000 (UTC)
Message-ID: <1486739585.4029.0.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 10 Feb 2017 16:13:05 +0100
In-Reply-To: <d039b4d9-4c9a-ed49-dd36-304b290a013b@redhat.com>
References: <1486722439-12033-1-git-send-email-abologna@redhat.com>
	<1486723086-12247-1-git-send-email-abologna@redhat.com>
	<1486723086-12247-2-git-send-email-abologna@redhat.com>
	<d039b4d9-4c9a-ed49-dd36-304b290a013b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, kraxel@redhat.com

On Fri, 2017-02-10 at 12:43 +0100, Laszlo Ersek wrote:
> So, what speaks against adding "-serial mon:stdio" here too? Even with =
a
> graphical guest, the monitor is useful. And, if you care about firmware
> logs (who doesn't? ;)), seeing serial output is good. (Same applies to
> the guest kernel -- sooner or later everyone enables serial output for
> grub2 and kernel, for reporting bugs.)
>=C2=A0
> Just my two cents, you're welcome to disagree.

The sample configurations are opinionated, that's why there
are both a graphical and a serial variant and not a single
configuration with everything but the kitchen sink. Users
are of course more than welcome to mix and match :)

> > +# We create eight PCI Express Root Ports, and we plug them
> > +# all into separate functions of the same slot. Some of
> > +# them will be used by devices, the rest will remain
> > +# available for hotplug.
> > +
> > +[device "pci.1"]
>=C2=A0
> I suggest to call these devices "pcie.x" (and update the references).

Makes sense. I followed libvirt's naming here, but there
is no reason not to highlight the fact that these
controllers are, indeed, PCI Express rather than legacy
PCI.

[...]
> A number of suggestions. If you think they are beyond the scope of thes=
e
> examples, or plain disagree, that's fine. :)
>=C2=A0
> * please add a CD-ROM too (scsi-cd), and point its drive to some
> installer ISO. (remember # CHANGE ME for the pathname)
>=C2=A0
> * please spell out the "bootindex" property for both the disk and the
> CD-ROM device. If you set booindex=3D1 for the disk and bootindex=3D2 f=
or
> the CD-ROM, then that configuration is permanently suitable for first
> installing the guest from the ISO, then booting it all subsequent times
> from the disk. ArmVirtQemu is king like that! ;)

So it does! And the same trick works for SeaBIOS as well,
I just tested with the q35 sample configurations :)

I'll include this.

> * I'm a *huge* fan of saving disk space on the host. So, thin
> provisioning FTW! Virtio-scsi is definitely a step in the right
> direction, but for the disk drive, please add these wo properties:
>=C2=A0
>=C2=A0=C2=A0=C2=A0discard =3D "unmap"
>=C2=A0=C2=A0=C2=A0werror =3D "enospc"
>=C2=A0
> The first property will release host filesystem blocks when the guest
> runs "fstrim". The second option lets you over-provision the host
> filesystem, and if a guest runs out of room mid-flight, it will be
> paused. You can free up more disk space and unpause the guest then.
>=C2=A0
> (There's also "detect-zeroes", but I've never tried that. I very vaguel=
y
> recall reading bad things about its CPU demand. I could be wrong, but I
> certainly don't feel comfortable enough to actively recommend it.)

I think such tweaks, while definitely useful, fall beyond
the scope of these sample configuration files.

[...]
> > +# If you're running the guest on a remote, potentially
> > +# headless host, you will probably want to append something
> > +# like
> > +#
> > +#=C2=A0=C2=A0=C2=A0-display vnc=3D127.0.0.1:0
> > +#
> > +# to the command line in order to prevent QEMU from trying
> > +# to display a GTK+ window on the host and enable remote
> > +# access instead.
>=C2=A0
> Haha, someone prefers GTK+ to SDL? :) Last time I checked the GTK+
> window, it was painful. (It was a very long time ago.)
>=C2=A0
> Maybe that's to blame on GTK+ *in RHEL-7* specifically, I'm uncertain.
> But, I digress; no need to do anything about this.

GTK+ just seems to be the default display mode, so no
preference of my own really - although I have no problem
admitting that I'm a massive GNOME fan ;)

Calling out GTK+ explicitly here does not serve any purpose,
though, so I'll change it to a more neutral wording.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
