Received: from eggs.gnu.org ([2001:4830:134:3::10]:54529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gVm5J-0005WK-Et
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 18:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gVm5F-0000wH-MV
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 18:32:33 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gVm5F-0000g6-5i
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 18:32:29 -0500
Date: Sat, 8 Dec 2018 18:32:00 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181208233200.GA31917@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-49-cota@braap.org>
	<20181129204518.f7bttrlm5mesftv6@MacBook-Pro-Roman.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129204518.f7bttrlm5mesftv6@MacBook-Pro-Roman.local>
Subject: Re: [Qemu-devel] [RFC 48/48] plugin: add a couple of very simple
 examples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Stefan Hajnoczi <stefanha@gmail.com>

On Thu, Nov 29, 2018 at 23:45:18 +0300, Roman Bolshakov wrote:
> On Thu, Oct 25, 2018 at 01:20:57PM -0400, Emilio G. Cota wrote:
> > +
> > +lib%.so: %.o
> > +	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
> 
> The rule should be a bit different for macOS:
> %.bundle: %.o
>        $(CC) -bundle -Wl,-bundle_loader,PATH_TO_QEMU_EXE -o $@ $^ $(LDLIBS)
> 
> "-bundle" flag is needed because macOS has two kinds of Mach-O
> dynamically loaded executables:
>  - dylib (MH_DYLIB) - it's like an ELF shared object used for dynamic
>    linking. Can be loaded, preloaded for sake of function interposing
>    but cannot be explicitly unloaded.
>  - bundle (MH_BUNDLE) - similar to an ELF shared object used in plugin
>    dlopen/dlclose scenario.
> 
> We can pick any (enabled in configure) qemu-system executable as
> bundle_loader. We specify it to check if all symbols in a bundle,
> including the ones coming from the executable are defined. FWIW, here's
> the reference for bundle_loader flag:
>   -bundle_loader executable
>       This specifies the executable that will be loading the bundle
>       output file being linked. Undefined symbols from the bundle are
>       checked against the specified executable like it was one of the
>       dynamic libraries the bundle was linked with
> 
> 
> The ".bundle" extension is not required but IMO it feels more native to
> the system than ".so".

The goal of the examples is to be target-independent, so I'm not
convinced that we want to bury $PATH_TO_QEMU_EXE in the build recipe
(or get configure involved in this).

Since you say the "bundle" business isn't a requirement, I'll leave just
the .so rule in v2.

Thanks,

		Emilio
