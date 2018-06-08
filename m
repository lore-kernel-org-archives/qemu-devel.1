Received: from eggs.gnu.org ([2001:4830:134:3::10]:43624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRCeT-0006i7-Vw
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRCeS-0007Uq-QV
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:21:41 -0400
Date: Fri, 8 Jun 2018 09:21:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180608082129.GC2671@work-vm>
References: <20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
	<f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
	<20180607103218.GC1455@redhat.com>
	<20180607103620.GJ28827@redhat.com>
	<dd014be5c818e71d4f833e150fbae11e490e2325.camel@redhat.com>
	<7410e002-ba2f-2dd2-b24f-c9841f456ac9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7410e002-ba2f-2dd2-b24f-c9841f456ac9@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

* Laszlo Ersek (lersek@redhat.com) wrote:
> On 06/07/18 12:54, Andrea Bolognani wrote:
> > On Thu, 2018-06-07 at 11:36 +0100, Daniel P. Berrang=E9 wrote:
> >> On Thu, Jun 07, 2018 at 11:32:18AM +0100, Richard W.M. Jones wrote:
> >>> Another problem which Laszlo mentioned is the varstore isn't portab=
le
> >>> between UEFI implementations, or if the UEFI is compiled with
> >>> different options.  You can even imagine shipping multiple
> >>> varstores(!) which argues for a tar-like format.
> >>
> >> Could we perhaps imagine shipping the actual UEFI bios, rather
> >> than only the varstore.  The bios blob runs in guest context,
> >> so there shouldn't be able security concerns from hosting
> >> vendors with running user provided bios. Mostly its a matter
> >> of confidence that the interface between bios & qemu is stable
> >> which feels easier than assuming varstore vs different bios is
> >> portable.
> >=20
> > That sounds sensible, and further reinforces the idea that we
> > need way more than a single string baked into the qcow2 file.
> >=20
>=20
> Sorry for arriving late (thanks Rich for the Fwd).
>=20
> The contents of the non-volatile UEFI variables should be considered
> part of (permanent) guest state, such as disk contents. Therefore I'd
> argue for bundling the varstore file with the disk image(s).
>=20
> In turn, the best way to ensure comaptibility between varstore and
> firmware binary is to just bundle the firmware binary as well. It's
> generally not large (x86) or if it is, it compresses extremely well
> (aarch64). For extra politeness, image providers can bundle a text file
> with their firmware build options (like a kernel config), possibly even
> a JSON document conforming to the new firmware schema (qemu commit
> 3a0adfc9bfcf), but that's not a hard requirement I guess.
>=20
> If such a VM is to be migrated between hosts, I'd expect the host admin
> to take care of installing the fw binary on all eligible hosts.

There's no way they can do that if they're just importing VMs from
templates that include the image; who is going to keep track of which
BIOSs are needed where?

Dave

> Regarding compat between QEMU and firmware binary, I see three cases:
>=20
> (1) Static requirements presented by the firmware for the QEMU
> configuration. (Such as -D SMM_REQUIRE.) With the domain configuration
> captured one way or another alongside the disk image anyway, this shoul=
d
> not be a problem.
>=20
> (2) New firmware launched on old QEMU. The firmware generally detects o=
r
> negotiates features with QEMU, so this should be safe.
>=20
> (Discounting firmware regressions, of course -- for example, search
> <https://www.mail-archive.com/qemu-devel@nongnu.org/msg471901.html> for
> the string "I messed up".)
>=20
> (3) Old firmware launched on new QEMU. This scenario has given us a lot
> more grief than (2), but I think for the appliance distribution use
> case, it can be folded into case (1) above -- specify the machine type
> too in the domain config, and that should be compatible with the old
> firmware.
>=20
> (The handling of (3) is not uniform between upstream QEMU and various
> downstreams. For example, consider
> <https://bugs.launchpad.net/qemu/+bug/1715700>. This was a latent bug i=
n
> OVMF that got exposed by a new QEMU (due to a valid QEMU change), even
> when using old machine types. The upstream solution was to fix edk2 and
> stick with QEMU as-was (although the agreement around that hadn't been
> universal). Conversely, one downstream solution was to restrict the
> otherwise valid QEMU change to new machine types
> <https://bugzilla.redhat.com/show_bug.cgi?id=3D1489800#c5>.)
>=20
>=20
> All in all I agree with Daniel's proposal; it seems to be the most
> robust one.
>=20
> And, I too recall that, under AMD SEV, users will be supposed to, or
> allowed to, provide their own firmware binaries.
>=20
> Thanks!
> Laszlo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
