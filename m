Received: from eggs.gnu.org ([2001:4830:134:3::10]:42245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2JGj-0006dx-9p
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2JGf-0002KH-De
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:50:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2JGf-0002Ip-3t
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 11:49:57 -0400
Date: Wed, 11 Oct 2017 16:49:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171011154951.GA6163@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Oct 11, 2017 at 03:37:08PM +0100, Peter Maydell wrote:
> On 11 October 2017 at 09:35, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > The following changes since commit 567d0a19c7998fa366598b83d5a6e5f0759d3ea9:
> >
> >   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-10-10 13:25:46 +0100)
> >
> > are available in the git repository at:
> >
> >   git://git.kraxel.org/qemu tags/ui-20171011-pull-request
> >
> > for you to fetch changes up to 92328b7104ffc825f10c33f3fd1866e940a523f7:
> >
> >   ui/gtk: Fix deprecation of vte_terminal_copy_clipboard (2017-10-11 10:03:31 +0200)
> >
> > ----------------------------------------------------------------
> > ui: use keycodemapdb for key code mappings, part one (v2)
> > ui: add qemu-keymap, update reverse keymaps (for qemu -k $map)
> > ui: fix for vte 0.50
> >
> > ----------------------------------------------------------------
> 
> Build failures:
> 
> NetBSD:
>   CC      ui/input-keymap.o
> /root/qemu/ui/input-keymap.c:8:44: fatal error:
> ui/input-keymap-linux-to-qcode.c: No such file or directory
>  #include "ui/input-keymap-linux-to-qcode.c"
>                                             ^
> 
> FreeBSD:
> 
> 
>   CC      ui/input-keymap.o
> /root/qemu/ui/input-keymap.c:8:10: fatal error:
> 'ui/input-keymap-linux-to-qcode.c' file not found
> #include "ui/input-keymap-linux-to-qcode.c"
>          ^

So something is still racing in these two.

I don't suppose you have the full log - interested if it
ever run the "GIT     ui/keycodemapdb dtc" rule and/or
re-ran configure earlier, or if this is literally all it
did ?

> 
> OpenBSD:
> 
> gmake: Entering directory '/home/qemu/build/all'
> /bin/sh: ./scripts/git-submodule.sh: No such file or directory
> gmake: Leaving directory '/home/qemu/build/all'
> gmake: Entering directory '/home/qemu/build/all'
>   GIT
> /bin/sh: ./scripts/git-submodule.sh: No such file or directory
> gmake: *** [Makefile:30: git-submodule-update] Error 1
> gmake: Leaving directory '/home/qemu/build/all'
> gmake: *** Waiting for unfinished jobs....
> gmake: Entering directory '/home/qemu/build/all'
> config-host.mak is out-of-date, running configure
> Install prefix    /usr/local
> [configure output snipped]
> gmake: Leaving directory '/home/qemu/build/all'
> 
> AArch32 Linux:
> 
> make: Entering directory '/home/peter.maydell/qemu/build/all-a32'
> config-host.mak is out-of-date, running configure
> Install prefix    /usr/local
> BIOS directory    /usr/local/share/qemu
> [...]
> VxHS block device no
>   GEN     config-host.h
>   GEN     module_block.h
>   GEN     ui/input-keymap-linux-to-qcode.c
>   GEN     ui/input-keymap-qcode-to-qnum.c
>   GEN     ui/input-keymap-qnum-to-qcode.c
>   GIT     ui/keycodemapdb dtc
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
> Makefile:30: recipe for target 'git-submodule-update' failed

Damn, we should not throw away stderr in scripts/git-submodule.sh,
as its hides whatever error occurred for you here.

> make: *** [git-submodule-update] Error 128
> make: *** Waiting for unfinished jobs....
> make: Leaving directory '/home/peter.maydell/qemu/build/all-a32'
> 
> 
> The OpenBSD failure is because make now tries to run a
> script that uses #!/bin/bash, and this machine doesn't
> have bash installed. Do we really need to add bash to
> our build-dependencies? The script doesn't seem like it's
> doing anything that critically requires bash...

Yeah, that's easily replacable with /bin/sh


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
