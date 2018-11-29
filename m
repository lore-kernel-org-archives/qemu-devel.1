Received: from eggs.gnu.org ([2001:4830:134:3::10]:46720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gSTBf-0002fM-Ef
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gSTBa-00034G-Et
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:45:27 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:35944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gSTBa-00033F-5s
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 15:45:22 -0500
Date: Thu, 29 Nov 2018 23:45:18 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20181129204518.f7bttrlm5mesftv6@MacBook-Pro-Roman.local>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-49-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181025172057.20414-49-cota@braap.org>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Stefan Hajnoczi <stefanha@gmail.com>

On Thu, Oct 25, 2018 at 01:20:57PM -0400, Emilio G. Cota wrote:
> +
> +lib%.so: %.o
> +	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)

The rule should be a bit different for macOS:
%.bundle: %.o
       $(CC) -bundle -Wl,-bundle_loader,PATH_TO_QEMU_EXE -o $@ $^ $(LDLIBS)

"-bundle" flag is needed because macOS has two kinds of Mach-O
dynamically loaded executables:
 - dylib (MH_DYLIB) - it's like an ELF shared object used for dynamic
   linking. Can be loaded, preloaded for sake of function interposing
   but cannot be explicitly unloaded.
 - bundle (MH_BUNDLE) - similar to an ELF shared object used in plugin
   dlopen/dlclose scenario.

We can pick any (enabled in configure) qemu-system executable as
bundle_loader. We specify it to check if all symbols in a bundle,
including the ones coming from the executable are defined. FWIW, here's
the reference for bundle_loader flag:
  -bundle_loader executable
      This specifies the executable that will be loading the bundle
      output file being linked. Undefined symbols from the bundle are
      checked against the specified executable like it was one of the
      dynamic libraries the bundle was linked with


The ".bundle" extension is not required but IMO it feels more native to
the system than ".so".

I've checked both plugins can be loaded and print a line when QEMU exits.

Best regards,
Roman
