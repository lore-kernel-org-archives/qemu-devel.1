Received: from eggs.gnu.org ([2001:4830:134:3::10]:33496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etaqA-0007dz-SS
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etaq7-00030W-Dt
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:18:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41896 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etaq7-00030P-7W
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:18:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21CC3406E8B9
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 15:18:43 +0000 (UTC)
Date: Wed, 7 Mar 2018 15:18:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307151836.GK20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, lersek@redhat.com, kraxel@redhat.com

On Wed, Mar 07, 2018 at 03:49:51PM +0100, Kashyap Chamarthy wrote:
> Problem background
> ------------------
>=20
> The various OVMF binary file names and paths are slightly different[+]
> for each Linux distribution.  And each high-level management tool
> (libguestfs, oVirt, `virt-manager` and OpenStack Nova) is inventing its
> own approach to detect and configure the said OVMF files.  This email
> thread is about arriving at some common understanding to make this a bi=
t
> more "unified" by addressing these needs in QEMU and libvirt.

Let me expand on the problem & desired solution from libvirt's POV

Currently, if you are happy with the default firmware for a particular
machine type, life is easy. QEMU knows the right path to use automaticall=
y.

This was fine until people started wanting to use UEFI firemware with
x86_64 Q35 and/or aarch64  virt machine types, because Q35 defaults to
SeaBIOS and aarch64 defaults to no firmware.

So mgmt applications wanting to use UEFI have to provide a full path to
the firmware to libvirt.

>From a libvirt POV, we want to make it possible to just ask for a
firmware type eg for x86_64 we want to allow apps to just do either

  <os firmware=3D"bios"/>

or

  <os firmware=3D"efi"/>

and then have libvirt automatically provide the best firmware image
path to QEMU. We'll still allow apps to provide an explicit path
themselves if they really want to, because if nothing else that's
useful for people who need to test out ad-hoc firmware builds.

IOW, in general if you (sysadmin/mgmt app) want to enable EFI for a
guest, you should never need to care about firmware paths. This will
give libvirt QEMU driver parity with what's possible for vmware
guests in this area.

With this in mind, when we talk about providing metadata files for
firmware below, we should bear in mind that we likely want this
metadata to be general purpose, not something specific to OVMF.
IOW all existing QEMU firmware images, for all architetures should
be covered & whatever custom firmware users might have.

> Suggested approach
> ------------------
>=20
> Based on an upstream discussion on 'virt-tools'[1] mailing list and som=
e
> Bugzillas, Gerd Hoffmann, Laszlo Ersek and Dan Berrang=C3=A9 had a sugg=
estion
> to define a firmware metadata format and file (example in [1]):
>=20
>   - For each firmware file we need a metadata file in a well defined
>     location, e.g. /usr/share/qemu/bios/ that lists stuff like:
>=20
>       - Path to the firmware binary
>       - Path to the pre-built OVMF 'vars' file (if any)

Not neccessarily just OVMF - anything that uses the same pflash
config mechanism.

>       - Support architectures - associated QEMU feature flags (Secure
>         Boot)

We need to have ability to list machine types too, since historically
there have been cases where we screwed up and needed to provide differnt
builds of the same firmware to different machine types.

>       - If the binary provides / requires SMM (System Management Mode)

I think we just need a well defined list of properties / features
here as it might need to track morethan just SMM.

>      Essentially, QEMU would define[*] the file format, and provide
>      metadata files from any ROMs it ships directly.  If Linux
>      distributions / vendors ship extra ROMs like OVMF, etc then they
>      should provide suitable metadata files.

We need to define what order the metadata files are processed in,
so that if there are multuple firemware images that satisfy a given
guest config, we have a predictable / determinstic choice. This could
be as simple as recommending each filename start with a 2 digit number.

eg

     50-ovmf.json

That lets end user drop in a 20-ovmf.json if they want to provide a
different ovmf by default.

>   - Libvirt can read these metadata files and then pick the correct
>     firmware binary based on the settings for the guest.

IOW, we'll look at various things like firmware=3Defi|bios, and whether
secure boot is requested for the guest. I don't think we actually
have an explicit attribute for requesting secureboot=3Don|off, so we'd
probably want to add one. THis is then used to pick the default
firmware.

As a specific non-goal:

If multiple metadata files are all satisfactory for a given guest
config, libvirt is just going to pick the first acceptable match.
If users/apps want to have finer grained control, they can still
pass an explicit path themselves as done today to override the
default choice. =20

>   - Management tools can then wire up the libvirt-based OVMF SB (Secure
>     Boot) configuration.

NB, mgmt tools should never need to read the metadata files - they'll
just request libvirt to use firmware=3Defi|bios, etc

> [*] Open question: Who, between QEMU and libvirt, should define the sai=
d
> firmware metadata format and file?

IMHO QEMU should be defining the format, because the file will contain
info about certain QEMU features associated with the firmware (eg smm).
Also there are potentially other non-libvirt mgmt apps that spawn QEMU
which would like this info (eg libguestfs), so having libvirt define the
format is inappropriate.

I'd suggest we just need something in docs/specs/firmware-metadata.rst
for QEMU source tree.

Potentially QEMU could even use the metadata files itself for finding
the default firmeware images, instead of compiling this info into its
binaries. I wouldn't suggest we need todo that right away, but bear it
in mind as a potential use case.

>=20
>=20
> References
> ----------=20
>=20
> [1] A past proposal from Gerd to create a sort of a "firmware registry"
>=20
>     https://www.redhat.com/archives/virt-tools-list/2014-September/msg0=
0145.html
>=20
> [2] A libvirt upstream RFE bug requesting to simplify handling UEFI
>     https://bugzilla.redhat.com/show_bug.cgi?id=3D1295146 -- RFE: provi=
de
>     a bios=3Duefi XML convenience option
>=20
> [3] DanPB wrote a PoC in libvirt:
>     https://www.redhat.com/archives/libvir-list/2016-October/msg00045.h=
tml
>     -- [libvirt] [PATCH 0/3] Make UEFI firmware config simpler
>=20
>     But later came to the conclusion that it is flawed, and said we go
>     the route of "Suggested approach" mentioned earlier).
>=20
>=20
> [*] OVMF package path names for different distributions
> -------------------------------------------------------
>=20
>   - Debian (https://packages.debian.org/stretch/all/ovmf/filelist)
>      - /usr/share/OVMF/OVMF_CODE.fd
>      - /usr/share/OVMF/OVMF_VARS.fd
>=20
>   - OpenSUSE (package: "qemu-ovmf-x86_64" -- and it has *35*
>     files in that package):
>      - /usr/share/qemu/ovmf-x86_64-opensuse-code.bin
>      - /usr/share/qemu/ovmf-x86_64-opensuse-vars.bin [...]
>=20
>      Their RPM spec file gives some hints (where all the files with
>      'ms' means signed with MS keys; the files with 'opensuse-4096'
>      means signed with OpenSUSE 4096 bit CA keys -- I think that's one
>      of the points of Secure Boot, to let people have control over
>      system keys):
>      https://build.opensuse.org/package/view_file/openSUSE:Factory/ovmf=
/ovmf.spec?expand=3D1
>=20
>   - Fedora 27 (package: "edk2-ovmf", x86_64):
>      - /usr/share/edk2/ovmf/OVMF_CODE.fd
>      - /usr/share/edk2/ovmf/OVMF_CODE.secboot.fd
>      - /usr/share/edk2/ovmf/OVMF_VARS.fd
>=20
>   - RHEL-7.4 (package: "OVMF", x86_64):
>      - /usr/share/OVMF/OVMF_CODE.secboot.fd
>      - /usr/share/OVMF/OVMF_VARS.fd
>=20
>   - Gerd's firmware repo from Git:
>      - /usr/share/edk2.git/ovmf-x64/OVMF_VARS-need-smm.fd
>      - /usr/share/edk2.git/ovmf-x64/OVMF_CODE-pure-efi.fd
>=20
> --
> /kashyap

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
