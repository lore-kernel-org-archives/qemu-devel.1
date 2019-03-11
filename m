Received: from eggs.gnu.org ([209.51.188.92]:35525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3IA4-0005rG-KN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3I2c-0004Wb-VX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:20:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h3I2c-0004W4-LJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:20:18 -0400
Date: Mon, 11 Mar 2019 10:20:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190311102006.GK12393@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John G Johnson <john.g.johnson@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, sstabellini@kernel.org, Jag Raman <jag.raman@oracle.com>, konrad.wilk@oracle.com, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com

On Thu, Mar 07, 2019 at 03:29:41PM -0800, John G Johnson wrote:
>=20
>=20
> > On Mar 7, 2019, at 11:27 AM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >=20
> > On Thu, Mar 07, 2019 at 02:51:20PM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> >> I guess one obvious answer is that the existing security mechanisms =
like
> >> SELinux/ApArmor/DAC can be made to work in a more fine grained manne=
r if
> >> there are distinct processes. This would allow for a more useful sec=
comp
> >> filter to better protect against secondary kernel exploits should QE=
MU
> >> itself be exploited, if we can protect individual components.
> >=20
> > Fine-grained sandboxing is possible in theory but tedious in practice=
.
> > From what I can tell this patch series doesn't implement any sandboxi=
ng
> > for child processes.
> >=20
>=20
> 	The policies aren=E2=80=99t in QEMU, but in the selinux config files.
> They would say, for example, that when the QEMU process exec()s the
> disk emulation process, the process security context type transitions
> to a new type.  This type would have permission to access the VM image
> objects, whereas the QEMU process type (and any other device emulation
> process types) cannot access them.

Note that currently all QEMU instances run by libvirt have seccomp
policy applied that explicitly forbids any use of fork+exec as a way
to reduce avenues of attack for an exploited QEMU.

Even in a modularized QEMU I'd be loathe to allow QEMU to have the
fork+exec privileged, unless "QEMU" in this case was just a stub
process that does nothing more than fork+exec the other binaries,
while having zero attack exposed to the untrusted guest OS.

> 	If you wanted to use DAC, you could do the something similar by
> making the disk emulation executable setuid to a UID than can access
> VM image files.
>=20
> 	In either case, the policies and permissions are set up before
> libvirt even runs, so it doesn=E2=80=99t need to be aware of them.

That's not the case bearing in mind the above point about fork+exec
being forbidden. It would likely require libvirt to be in charge of
spawning the various helper binaries from a trusted context.


> > How to do this in practice must be clear from the beginning if
> > fine-grained sandboxing is the main selling point.
> >=20
> > Some details to start the discussion:
> >=20
> > * How will fine-grained SELinux/AppArmor/DAC policies be configured f=
or
> >   each process?  I guess this requires root, so does libvirt need to
> >   know about each process?
> >=20
>=20
> 	The polices would apply to process security context types (or
> UIDs in a DAC regime), so I would not expect libvirt to be aware of the=
m.

I'm pretty skeptical that such a large modularization of QEMU can be
done without libvirt being aware of it & needing some kind of changes
applied.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
