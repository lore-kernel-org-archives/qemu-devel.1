Received: from eggs.gnu.org ([209.51.188.92]:49322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voltagex@voltagex.org>) id 1gpA00-0000TH-Rp
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voltagex@voltagex.org>) id 1gp9zz-0005Gv-Nq
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:55:12 -0500
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:39222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <voltagex@voltagex.org>)
	id 1gp9zz-0005El-Cs
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:55:11 -0500
Received: by mail-ua1-x944.google.com with SMTP id c12so864429uas.6
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 02:55:11 -0800 (PST)
MIME-Version: 1.0
References: <CAChFQ9RNaHyROB47QeLwc6cLCCnFx4SmXKV7rbs1MYjk7S0sbw@mail.gmail.com>
	<20190131104911.GF19982@redhat.com>
In-Reply-To: <20190131104911.GF19982@redhat.com>
From: Adam Baxter <voltagex@voltagex.org>
Date: Thu, 31 Jan 2019 21:54:58 +1100
Message-ID: <CAChFQ9TJNqWHiGzjeAxYCJhj9RXxn0WAG3M1YhMguNcQpV7w7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] NSIS - including DLL dependencies for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

My extremely embarassing script for getting the DLLs is as follows,
but at least it avoids a WINE dependency:

STAGING=3D/tmp/myqemu/
make install prefix=3D$STAGING
#todo: probably better to walk these dependencies in a loop, and not
use grep (but seriously, where's the mingw dumpbin)
FIRST=3D$(strings $STAGING/*.exe | grep '\.dll' | sort -u | xargs -I{}
readlink -e /usr/x86_64-w64-mingw32/sys-root/mingw/bin/{})
SECOND=3D$(for d in $FIRST; do strings $d | grep '\.dll' | sort -u |
xargs -I{} readlink -e /usr/x86_64-w64-mingw32/sys-root/mingw/bin/{};
done)
THIRD=3D$(for d in $SECOND; do strings $d | grep '\.dll' | sort -u |
xargs -I{} readlink -e /usr/x86_64-w64-mingw32/sys-root/mingw/bin/{};
done)
echo $FIRST $SECOND $THIRD | sed 's/ /\n/g' | sort -u | xargs -I{} cp
-v {} $STAGING

--Adam

On Thu, 31 Jan 2019 at 21:49, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Jan 31, 2019 at 02:45:13PM +1100, Adam Baxter wrote:
> > Hi,
> > How do I gather and include the required DLLs (SDL, zlib etc) in the NS=
IS
> > installer? (and also in a standalone build to be zipped up, but that's =
less
> > important)
> >
> > I noticed the wiki doesn't really mention bundling dependencies anywher=
e.
> >
> > The official unofficial windows builds are documented at
> > https://qemu.weilnetz.de/FAQ but this doesn't cover building the actual
> > installer.
>
> Yeah, this is a pretty major ommision in QEMU's build rules for the NSIS
> installer making it pretty much useless as is. We really need to expand
> it so that it can resolve the dlls that qemu .exe's need, locate them
> on the host and bundle them into the installer automatically.
>
> It seems we can get a list of deps for an .exe using
>
> $ winedump  -j import /path/to/binary.exe  | grep offset | grep dll | awk=
 '{print $3}'
>
> We would need to run that for each .exe we're bundling. I think we might
> need to also then run that recursively for each .dll to get the transitiv=
e
> set of required dlls.
>
> Even this is not entirely satisfactory though, as it is blindly assuming
> that the only thing we need in the QEMU installer is the dlls themselves.
> GTK at least has other resources used at runtime besides the dll that
> should be bundled.
>
> This kind of problem is why the GNOME project created the msitools projec=
t
> for creating .msi installers, to relpace nsis. With msitools there is a
> metadata file for each package listing all the files that need it needs
> to have bundled into an installer:
>
>   https://gitlab.gnome.org/GNOME/msitools/tree/master/data/wixl
>
> This is not without its own downsides though. It bundles all the .wxi
> files itself, with their content based on current mingw packages present
> in the most recent Fedora release. This means it won't work on any other
> distro :-(
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
