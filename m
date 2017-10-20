Received: from eggs.gnu.org ([2001:4830:134:3::10]:49177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Wc4-0003bJ-UU
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Wc1-0004y2-3t
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:41:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5Wc0-0004xh-TY
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:41:17 -0400
Date: Fri, 20 Oct 2017 13:41:11 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171020124111.GK21172@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1B925CC0CD9F3341B32D442251E7E1DC391048B2@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1B925CC0CD9F3341B32D442251E7E1DC391048B2@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] qemu compile error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Chen, Farrah" <farrah.chen@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hu, Robert" <robert.hu@intel.com>

On Fri, Oct 20, 2017 at 12:13:05PM +0000, Chen, Farrah wrote:
> Hi,
> 
> When I build qemu with commit from aef45d51d1204f3335fb99de6658e0c5612c2b67 to the latest one, the following error occurred:
> 
> tsocks git clone git://git.qemu.org/qemu.git

The use of 'tsocks' is probably the problem you have

> cd qemu
> 
> ./configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --disable-gtk --enable-libusb --enable-numa --disable-sdl
> make
>   GEN     config-host.h
>   GIT     dtc

When we checkout the submodule we just call "git" and expect it to
work - we've no knowledge of tsocks.

>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     module_block.h
>   GEN     trace/generated-helpers.c
> make: *** [git-submodule-update] Error 1
> 
> 
> Would you mind telling me how to avoid this error?

You need to make sure the 'git' command in the $PATH can checkout from
qemu.org directly. Since you seem to require tsocks, then the way to
achieve this is to create a wrapper script and make sure it appears
first in $PATH.

eg something like

   $ cat > $HOME/.local/bin/git <<EOF
   #!/bin/sh

   exec tsocks /usr/bin/git "$@"
   EOF
   chmod +x $HOME/.local/bin/git
   export PATH=$HOME/.local/bin:$PATH

so now just typing 'git' transparently runs tsocks.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
