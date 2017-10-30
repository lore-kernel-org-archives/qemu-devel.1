Received: from eggs.gnu.org ([2001:4830:134:3::10]:38555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e94sU-0004hO-4t
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e94sO-0006kk-2o
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:52:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e94sN-0006i1-PM
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 03:52:51 -0400
Date: Mon, 30 Oct 2017 08:52:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171030075244.GB31767@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171027131412.18830-1-berrange@redhat.com>
	<20171027131412.18830-2-berrange@redhat.com>
	<f1716a0f-6c6d-7704-e628-3c4cfc1a6bf2@ozlabs.ru>
	<20171028204505.GA21304@redhat.com>
	<8f0324f3-a0c8-a4b0-357b-8b8ff7e75d08@ozlabs.ru>
	<20171029075727.GA21571@redhat.com>
	<a34b48cd-c112-7812-4e8a-2ba2db1a18e2@ozlabs.ru>
	<20171029162902.GA14433@redhat.com>
	<a3f3604c-4a6d-f99b-0542-f8a4d02a3c7f@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3f3604c-4a6d-f99b-0542-f8a4d02a3c7f@ozlabs.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] build: allow setting a custom GIT
 binary for transparent proxying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Oct 30, 2017 at 10:49:01AM +1100, Alexey Kardashevskiy wrote:
> On 30/10/17 03:29, Daniel P. Berrange wrote:
> > On Mon, Oct 30, 2017 at 01:08:56AM +1100, Alexey Kardashevskiy wrote:
> >>
> >> I run ./scripts/git-submodule.sh on a server (where source directory=
 is
> >> writeable), them "rm .git-submodule-status", then run "Makefile" on =
a build
> >> machine (which has the source directory mounted as read-only). I bas=
ically
> >> recreate the situation where I was when I just discovered this brand=
 new
> >> ./scripts/git-submodule.sh.
> >=20
> > Don't rm the .git-submodule-status. That means 'make' thinks the modu=
les
> > are out of date.
> >=20
> > Just run 'scripts/git-submodules.sh ...mods..' on the writable source
> > dir, and then run 'make' on the build machine.
> >=20
> >> I know that now, all I am asking is an error message to print exact =
command
> >> to run...
> >=20
> > If you hadn't deleted the .git-submodule-status, it would have worked=
 fine.
>=20
> No.
>=20
> I do this on a server:
>=20
> [vpl1 qemu]$ git co v2.10.0
> At this point no .git-submodule-status is expected/required/exist.
>=20
> [vpl1 qemu]$ ssh aikhostos2 make -C /home/aik/pbuild/qemu-aikhostos2-pp=
c64/
> -j24
>=20
> Configure succeeds, compiles just fine, it has been working like this f=
or
> years.
>=20
>=20
> Now:
>=20
> [vpl1 qemu]$ git co git-submodule  (this is your stuff)
> [vpl1 qemu]$ ssh aikhostos2 make -C /home/aik/pbuild/qemu-aikhostos2-pp=
c64/
> -j24
> touch: cannot touch =E2=80=98.git-submodule-status=E2=80=99: Read-only =
file system
> make: Entering directory `/home/aik/pbuild/qemu-aikhostos2-ppc64'
>   GEN     ppc64-softmmu/config-devices.mak.tmp
> [...]
>=20
> ./scripts/git-submodule.sh: line 74: .git-submodule-status: Read-only f=
ile
> system
> ./scripts/git-submodule.sh: failed to save git submodule status
> make: *** [git-submodule-update] Error 1

Oh I see, the git submodules list is empty because you have a previous
built source tree, so its shortcircuiting the extra check I added. Tihs
is easy enough to address


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
