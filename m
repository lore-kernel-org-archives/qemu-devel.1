Received: from eggs.gnu.org ([2001:4830:134:3::10]:54866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f480K-0005F1-FP
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alarson@ddci.com>) id 1f480H-0005vV-C0
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:44:52 -0400
Received: from phx2.ddci.com ([184.183.10.180]:61664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alarson@ddci.com>) id 1f480H-0005su-4l
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 12:44:49 -0400
In-Reply-To: <CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
MIME-Version: 1.0
From: alarson@ddci.com
Message-ID: <OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
Date: Thu, 5 Apr 2018 11:44:40 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Qemu-devel] -icount changes physical address assignments in
 QEMU 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

"Peter Maydell" <peter.maydell@linaro.org> wrote on 04/05/2018 09:05:53 
AM:

> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: alarson@ddci.com
> Cc: "QEMU Developers" <qemu-devel@nongnu.org>
> Date: 04/05/2018 09:06 AM
> Subject: Re: [Qemu-devel] -icount changes physical address assignments 
in QEMU 2.10/2.11
> 
> On 22 March 2018 at 05:31,  <alarson@ddci.com> wrote:
> > Your patch (applied to 2.11 source release) changed the behavior
> > somewhat, but did not fix the problem.  Attached is a binary that when
> > run should show a CGA fontset and color bars.
> >
> > This command should "work":
> >
> > qemu-system-aarch64 -M virt,virtualization=on -cpu cortex-a53 -vga std
> > -device secondary-vga -device virtio-net,netdev=vlan0,addr=2 -kernel
> > icount-bug.bin -netdev user,id=vlan0
> >
> > If you add "-icount 2" the display will appear, but be mangled.
> >
> > I didn't spend too much time trimming the source code, so if you need
> > to step by step debug walking through the guest code, I'll have to
> > prune it down some more.
> >
> > For the record, the QEMU source I have is modified slightly to add ARM 
WFE
> > support, something I will submit once this is all straightened out,
> > but this bug appeared before I made that patch.
> 
> Hi; sorry for the delay in testing this. I've just tried your
> attached test image with current head of git QEMU (commit
> 0e87fdc966d05f4e5ad86, which is the 2.12.0-rc2 release candidate),
> and it gives me a correct display both with and without -icount 2.
> So I think we've fixed this bug, probably with the combination
> of commits 0790f86861079b19 and 87f963be66a3245, or possibly
> a75a52d62418da.
> 
> thanks
> -- PMM

Thank you for your help.

> I've just tried your attached test image ...

Curious.  I just downloaded qemu-2.12.0-rc2.tar.xz and built it using
Cygwin (a version from about a month ago) using mingw compilers
(mingw64-i686-gcc-g++ 6.4.0), and I still see the issue when the
resulting QEMU binary is run using -icount 2 against my test binary,
but not when run without -icount.  Here are the commands used:

../qemu-2.12.0-rc2/configure --python=/usr/bin/python \
   '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
   --prefix=/usr/local/qemu \
   --enable-sdl --with-sdlabi=2.0 \
   '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu' \
   --cross-prefix=i686-w64-mingw32-
/usr/bin/make -Otarget -j 8

Any suggestions of things to try?

If you think this is a build environment issue, I can try MSYS and
report my results.
