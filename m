Received: from eggs.gnu.org ([209.51.188.92]:51412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go8XD-0008Io-Ks
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go8L8-00042O-KM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:56:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1go8L8-00042H-E0
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:56:46 -0500
Date: Mon, 28 Jan 2019 14:56:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190128145642.GA3437@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAChFQ9RDi+VK_EERZsPB6UK_DpL-LDs97A6VivYSbuk=0VKP7A@mail.gmail.com>
	<CAFEAcA9gvX_9HDadd1VaC214CLDg7w1dOdCaKXuG5PXxC+-quA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9gvX_9HDadd1VaC214CLDg7w1dOdCaKXuG5PXxC+-quA@mail.gmail.com>
Subject: Re: [Qemu-devel] Building nsis installer - cross compile for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Adam Baxter <voltagex@voltagex.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jan 28, 2019 at 01:46:57PM +0000, Peter Maydell wrote:
> On Mon, 28 Jan 2019 at 13:34, Adam Baxter <voltagex@voltagex.org> wrote:
> >
> > I'm getting stuck trying to build the NSIS installer for Windows
> >
> >
> > export CFLAGS="-Wno-stringop-truncation"
> > ./configure --python=$(command -v python3)
> > --cross-prefix=x86_64-w64-mingw32- --enable-docs
> > echo 3.99.99 > VERSION
> > make -j`nproc`
> > make -j`nproc` installer
> >
> > results in:
> 
> > File: "/tmp/qemu-nsis\*.bmp" -> no files found.
> > Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
> >    /oname=outfile one_file_only)
> > Error in script "/drone/src/qemu.nsi" on line 122 -- aborting creation process
> > make: *** [Makefile:915: qemu-setup-3.99.99.exe] Error 1
> 
> I suspect this is because we've recently removed the
> qemu-icon.bmp but didn't update the NSIS installer script,
> which is now looking for a wildcard that doesn't match anything
> (and isn't trying to install the new .png icon files).
> If you try this on a commit before a8260d3876389eb52 does it
> work?

Opps, I'll cook up a fix that.

> 
> qemu-icon.bmp seems also to still be listed in the LINKS
> in configure which defines what we symlink from the source
> tree to the build tree (and again, the png files are not).

Wierd, I don't understand why we need any of that LINKS stuff in
configure. Not having the png files listed doesn't cause any
obvious problem that I can see. For that matter nor does having
the (now deleted) qemu-icon.bmp seem to cause a failure, as we
silent ignore source tree files that don't exist.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
