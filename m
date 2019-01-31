Received: from eggs.gnu.org ([209.51.188.92]:48134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gp9uL-0007VN-QR
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gp9uJ-0003J0-Rl
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:49:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gp9uJ-0003IB-I7
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 05:49:19 -0500
Date: Thu, 31 Jan 2019 10:49:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190131104911.GF19982@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAChFQ9RNaHyROB47QeLwc6cLCCnFx4SmXKV7rbs1MYjk7S0sbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAChFQ9RNaHyROB47QeLwc6cLCCnFx4SmXKV7rbs1MYjk7S0sbw@mail.gmail.com>
Subject: Re: [Qemu-devel] NSIS - including DLL dependencies for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adam Baxter <voltagex@voltagex.org>
Cc: qemu-devel@nongnu.org

On Thu, Jan 31, 2019 at 02:45:13PM +1100, Adam Baxter wrote:
> Hi,
> How do I gather and include the required DLLs (SDL, zlib etc) in the NSIS
> installer? (and also in a standalone build to be zipped up, but that's less
> important)
> 
> I noticed the wiki doesn't really mention bundling dependencies anywhere.
> 
> The official unofficial windows builds are documented at
> https://qemu.weilnetz.de/FAQ but this doesn't cover building the actual
> installer.

Yeah, this is a pretty major ommision in QEMU's build rules for the NSIS
installer making it pretty much useless as is. We really need to expand
it so that it can resolve the dlls that qemu .exe's need, locate them
on the host and bundle them into the installer automatically.

It seems we can get a list of deps for an .exe using 

$ winedump  -j import /path/to/binary.exe  | grep offset | grep dll | awk '{print $3}'

We would need to run that for each .exe we're bundling. I think we might
need to also then run that recursively for each .dll to get the transitive
set of required dlls.

Even this is not entirely satisfactory though, as it is blindly assuming
that the only thing we need in the QEMU installer is the dlls themselves.
GTK at least has other resources used at runtime besides the dll that
should be bundled.

This kind of problem is why the GNOME project created the msitools project
for creating .msi installers, to relpace nsis. With msitools there is a
metadata file for each package listing all the files that need it needs
to have bundled into an installer:

  https://gitlab.gnome.org/GNOME/msitools/tree/master/data/wixl

This is not without its own downsides though. It bundles all the .wxi
files itself, with their content based on current mingw packages present
in the most recent Fedora release. This means it won't work on any other
distro :-(

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
