Received: from eggs.gnu.org ([209.51.188.92]:46241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1yfz-0003PC-JS
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:27:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1yfy-0007qh-MP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:27:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1h1yfy-0007pu-BY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:27:30 -0500
Date: Thu, 7 Mar 2019 19:27:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190307192727.GG2915@stefanha-x1.localdomain>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ulDeV4rPMk/y39in"
Content-Disposition: inline
In-Reply-To: <20190307145120.GF32268@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com


--ulDeV4rPMk/y39in
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 02:51:20PM +0000, Daniel P. Berrang=E9 wrote:
> On Thu, Mar 07, 2019 at 02:26:09PM +0000, Stefan Hajnoczi wrote:
> > On Wed, Mar 06, 2019 at 11:22:53PM -0800, elena.ufimtseva@oracle.com wr=
ote:
> > > diff --git a/docs/devel/qemu-multiprocess.txt b/docs/devel/qemu-multi=
process.txt
> > > new file mode 100644
> > > index 0000000..e29c6c8
> > > --- /dev/null
> > > +++ b/docs/devel/qemu-multiprocess.txt
> >=20
> > Thanks for this document and the interesting work that you are doing.
> > I'd like to discuss the security advantages gained by disaggregating
> > QEMU in more detail.
> >=20
> > The security model for VMs managed by libvirt (most production x86, ppc,
> > s390 guests) is that the QEMU process is untrusted and only has access
> > to resources belonging to the guest.  SELinux is used to restrict the
> > process from accessing other files, processes, etc on the host.
>=20
> NB it doesn't have to be SELinux. Libvirt also supports AppArmor and
> can even do isolation with traditional DAC by putting each QEMU under
> a distinct UID/GID and having libvirtd set ownership on resources each
> VM is permitted to use.
>=20
> > QEMU does not hold privileged resources that must be kept away from the
> > guest.  An escaped guest can access its image file, tap file descriptor,
> > etc but they are the same resources it could already access via device
> > emulation.
> >=20
> > Can you give specific examples of how disaggregation improves security?

Elena & collaborators: Dan has posted some ideas but please share yours
so the security benefits of this patch series can be better understood.

> I guess one obvious answer is that the existing security mechanisms like
> SELinux/ApArmor/DAC can be made to work in a more fine grained manner if
> there are distinct processes. This would allow for a more useful seccomp
> filter to better protect against secondary kernel exploits should QEMU
> itself be exploited, if we can protect individual components.

Fine-grained sandboxing is possible in theory but tedious in practice.
=46rom what I can tell this patch series doesn't implement any sandboxing
for child processes.

There must be a convenient way to get fine-grained sandboxing for
disaggregated devices.  In other words, it shouldn't be left as an
exercise to device process authors.

How to do this in practice must be clear from the beginning if
fine-grained sandboxing is the main selling point.

Some details to start the discussion:

 * How will fine-grained SELinux/AppArmor/DAC policies be configured for
   each process?  I guess this requires root, so does libvirt need to
   know about each process?

 * We need to make sure that processes cannot send signals to each
   other, ptrace, interfere in /proc/$PID, etc.  How will this be done?

 * Were you planning to use any other sandboxing mechanisms
   (namespaces?)?  How will they be set up if the device processed is
   forked/executed by an unprivileged QEMU?

> Not everything is protected by MAC/DAC. For example network based disks
> typically have a username + password for accessing the remote storage
> server. Best practice would be a distinct username for every QEMU process
> such that each can only access its own storage, but I don't know of any
> app which does that. So ability to split off backends into separate
> processes could limit exposure of information that is not otherwise
> protected by current protection models.

If the disaggregated disk process with a global username + password is
compromised then all your disk images are compromised.  So you still
need to follow the best practice of per-VM credentials even with
disaggregation, and if you do then disaggregation doesn't add anything!

Stefan

--ulDeV4rPMk/y39in
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgXCfAAoJEJykq7OBq3PIr5UH/0haZv53ViDBxTVF9XneXKY5
BLEkp8KXcb2IxD4TNaRpy99kb6KQAS9LGV89Zj8NKuk50BYzhpsCml3WCdgEKJDu
YdSP369nYvAySQpGZaRCoG0AkFBBHpY0M4eYWt2K0mDDT9SRo/L83OmiojhAtNmX
ms2HLPa5H/O5ctOUbswerVjTE8EdtqHtzpspxWAo7hpaLSztX4ytx+E2I+pPk3JV
r0aRpXHGt8w8fdUJQkuHWwTXzMdZpET3fk9vldazrOeDYDxT6NbLgWT64n6Mc6r4
Al/ch/PZ8vdPiDPV+bykA0s80Se2UjN46ApGxRZHgc2Lct6uwSRANUhOxgfSqAs=
=n7eP
-----END PGP SIGNATURE-----

--ulDeV4rPMk/y39in--
