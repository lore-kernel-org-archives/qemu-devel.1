Received: from eggs.gnu.org ([209.51.188.92]:38843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJgXz-0008WF-8q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJgXx-00035I-GX
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:44:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJgXx-000346-80
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:44:25 -0400
Date: Thu, 25 Apr 2019 16:44:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190425154421.GG17806@stefanha-x1.localdomain>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
	<20190308095036.GC12318@stefanha-x1.localdomain>
	<20190326080822.GC21018@stefanha-x1.localdomain>
	<e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
	<CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
	<c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline
In-Reply-To: <c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
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
To: Jag Raman <jag.raman@oracle.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@gmail.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, John G Johnson <john.g.johnson@oracle.com>, sstabellini@kernel.org, konrad.wilk@oracle.com, qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 05:26:33PM -0400, Jag Raman wrote:
> On 3/26/2019 6:20 PM, Philippe Mathieu-Daud=E9 wrote:
>=20
> > > > > Please share the SELinux policy files, containerization scripts, =
etc.
> > > > > There is probably a home for them in qemu.git, libvirt.git, or el=
sewhere
> > > > > upstream.
> > > > >=20
> > > > > We need to find a way to make the sandboxing improvements availab=
le to
> > > > > users besides yourself and easily reusable for developers who wis=
h to
> > > > > convert additional device models.
> > >=20
> >=20
> > Also for testing this series.
>=20
> Hi,
>=20
> We are wondering how to deliver the example SELinux policies. I have
> posted on Fedora's SELinux mailing list to get info. on how to upstream
> SElinux policy.
>=20
> We are developing SELinux Type Enforcements and MCS labels to sandbox
> the emulation process. Details regarding example Type Enforcement is
> available below.
>=20
> We are also working on changes to libvirt, to launch the remote process
> and apply MCS labels. Libvirt changes will be posted separately in the
> future.
>=20
> The Type Enforcements for SElinux is available in the pastebin location
> below (also copied at the end of this email):
> https://pastebin.com/t1bpS6MY

Can multiple LSI SCSI controllers be launched such that each process
only has access to a subset of disk images?  Or is the disk image label
per-VM so that there is no isolation between LSI SCSI controller
processes for that VM?

My concern with this overall approach is the practicality vs its
benefits.  Regarding practicality, each emulated device needs to be
proxied separately.  The QEMU subsystem used by the device also needs to
be proxied.  Global state, monitor commands, and live migration all
require code changes to support proxied operation.  This is very
invasive.

Then each emulated device needs an SELinux policy to achieve the
benefits of confinement.  I have no idea how to correctly write a policy
like this and it's likely that developers who contribute a single new
device will not be proficient in it either.  Writing these policies is a
rare thing and few people will be good at this.  It also makes me worry
about how we test and review them.

Despite the efforts required in making this work, all processes still
effectively have full access to the guest since they can access guest
RAM.  What I mean is that the device is actually not confined to its
host process (e.g. LSI SCSI controller process) because it can write
code to executable guest RAM pages.  The guest will then execute that
code and therefore all guest I/O (networking, disk, etc) is still
available indirectly to the "confined" processes.  They are not really
sandboxed from the outside world, regardless of how strict the SELinux
policy is :(.

There are performance issues due to proxying as well, but let's ignore
them for now and focus on security.

How do the benefits compare against today's monolithic approach?  If the
guest exploits monolithic QEMU it has full access to all host files and
APIs available to QEMU.  However, these are largely just the resources
that belong to the guest anyway - not resources we are trying to keep
away from the guest.  With multi-process QEMU each process still has
access to all guest interfaces via the code injection I mentioned above,
but the SELinux policy could restrict access to some resources.  But
this benefit is really small in my opinion, given that the resources
belong to the guest anyway and the guest can already access them.

I think you can implement this for a handful of devices as a one-time
thing, but the invasiveness and the impracticality of getting wide cover
of QEMU make this approach questionable.

Am I mistaken about the invasiveness or impracticality?

Am I misunderstanding the security benefits compared to what already
exists today?

A more practical approach is to strip down QEMU (compiling out unused
devices and features) and to run virtio devices in vhost-user processes
(e.g. virtio-input, virtio-gpu, virtio-fs).  This achieves similar goals
without proxy objects or invasive changes to QEMU since the vhost-user
devices use a different codebase and aren't accessible via the QEMU
monitor.  The limitation is that existing QEMU code and non-virtio
devices aren't available in this model.

Stefan

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwdXVAAoJEJykq7OBq3PIh6kIAKVBEG/qr1RJmNnqjwxiIuMW
g0e3uf9nzgBv3dt7ZZWepKTPYAxT3Wu0ZivtTK9dTvTKJa5T6HLgfXId19iNIyvc
43MHUuMqmK1MSE/5dZEVt1j4pWQikMdWF8PsH9351jFjHYqlwBVPmUj4bBjlvnAF
DIuazUV0e7XSX5SN9pqT8jPuGfJhrV9HQcDogy9jVuwt0RQg5sExZ4OwRP2gHMvM
uI5OC/eS+zrLFRWiU6hzEyz3VqV5ffEkmg5qKvFKxHbtNTnArpprcOj4XRbJlW8t
4Wsg2WaLbDCV5uGWIZKqlcnIoignmS6IrVWPOlNyLx+i3j2d+fIqKNg023R6ccs=
=6Q+9
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
