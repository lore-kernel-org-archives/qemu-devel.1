Received: from eggs.gnu.org ([2001:4830:134:3::10]:56974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Ynk-0007dX-2Y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 04:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2Ynf-0000yM-GS
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 04:25:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2Ynf-0000y0-7D
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 04:25:03 -0400
Date: Thu, 12 Oct 2017 09:24:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171012082456.GB16125@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
	<20171011154951.GA6163@redhat.com>
	<CAFEAcA8OZALycKmsrC=MrftfF0YytXzRxGrzbetmSvddfTVf1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8OZALycKmsrC=MrftfF0YytXzRxGrzbetmSvddfTVf1g@mail.gmail.com>
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

On Wed, Oct 11, 2017 at 05:45:04PM +0100, Peter Maydell wrote:
> On 11 October 2017 at 16:49, Daniel P. Berrange <berrange@redhat.com> wrote:
> > On Wed, Oct 11, 2017 at 03:37:08PM +0100, Peter Maydell wrote:
> >> Build failures:
> >>
> >> NetBSD:
> >>   CC      ui/input-keymap.o
> >> /root/qemu/ui/input-keymap.c:8:44: fatal error:
> >> ui/input-keymap-linux-to-qcode.c: No such file or directory
> >>  #include "ui/input-keymap-linux-to-qcode.c"
> >>                                             ^
> >>
> >> FreeBSD:
> >>
> >>
> >>   CC      ui/input-keymap.o
> >> /root/qemu/ui/input-keymap.c:8:10: fatal error:
> >> 'ui/input-keymap-linux-to-qcode.c' file not found
> >> #include "ui/input-keymap-linux-to-qcode.c"
> >>          ^
> >
> > So something is still racing in these two.
> >
> > I don't suppose you have the full log - interested if it
> > ever run the "GIT     ui/keycodemapdb dtc" rule and/or
> > re-ran configure earlier, or if this is literally all it
> > did ?
> 
> For NetBSD we have:
> From git://git.linaro.org/people/pmaydell/qemu-arm
>    bac9608320..54070377a3  staging    -> pmaydell/staging
> gmake: Entering directory '/root/qemu/build/all'
> sh: ./scripts/git-submodule.sh: not found
> gmake: Leaving directory '/root/qemu/build/all'
> gmake: Entering directory '/root/qemu/build/all'
> config-host.mak is out-of-date, running configure
> Install prefix    /usr/local
> BIOS directory    /usr/local/share/qemu
> firmware path     /usr/local/share/qemu-firmware
> binary directory  /usr/local/bin
> library directory /usr/local/lib
> module directory  /usr/local/lib/qemu
> libexec directory /usr/local/libexec
> include directory /usr/local/include
> config directory  /usr/local/etc
> local state directory   /usr/local/var
> Manual directory  /usr/local/share/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /root/qemu
> GIT submodules    ui/keycodemapdb dtc
> C compiler        cc
> Host C compiler   cc
> C++ compiler      c++
> [...]
> jemalloc support  no
> avx2 optimization yes
> replication support yes
> VxHS block device no
> gmake: Leaving directory '/root/qemu/build/all'
> gmake: Entering directory '/root/qemu/build/all'
>   GEN     ui/input-keymap-linux-to-qcode.c
> gmake: Leaving directory '/root/qemu/build/all'
> gmake: Entering directory '/root/qemu/build/all'
> [...]
> gmake: Leaving directory '/root/qemu/build/all'
> gmake: Entering directory '/root/qemu/build/all'
>   CC      ui/input-keymap.o
> /root/qemu/ui/input-keymap.c:8:44: fatal error:
> ui/input-keymap-linux-to-qcode.c: No such file or directory
> 
> 
> I didn't notice the 'git-submodule.sh not found' issue before:
> looks like that's the same /bin/bash problem as OpenBSD,
> maybe, plus something not noticing the failure?

Yeah looks the same. I'll investigate the error status checking
I'll assume FreeBSD also hit the bash problem.


> 
> >> AArch32 Linux:
> >>
> >> make: Entering directory '/home/peter.maydell/qemu/build/all-a32'
> >> config-host.mak is out-of-date, running configure
> >> Install prefix    /usr/local
> >> BIOS directory    /usr/local/share/qemu
> >> [...]
> >> VxHS block device no
> >>   GEN     config-host.h
> >>   GEN     module_block.h
> >>   GEN     ui/input-keymap-linux-to-qcode.c
> >>   GEN     ui/input-keymap-qcode-to-qnum.c
> >>   GEN     ui/input-keymap-qnum-to-qcode.c
> >>   GIT     ui/keycodemapdb dtc
> >>   GEN     trace/generated-tcg-tracers.h
> >>   GEN     trace/generated-helpers-wrappers.h
> >>   GEN     trace/generated-helpers.h
> >>   GEN     trace/generated-helpers.c
> >> Makefile:30: recipe for target 'git-submodule-update' failed
> >
> > Damn, we should not throw away stderr in scripts/git-submodule.sh,
> > as its hides whatever error occurred for you here.
> 
> I edited out the stdout/stderr throwaway on the git submodule command:
> 
> $ ./scripts/git-submodule.sh update ui/keycodemapdb dtc
> Cloning into 'ui/keycodemapdb'...
> fatal: unable to access
> 'https://gitlab.com/keycodemap/keycodemapdb.git/': Problem with the
> SSL CA cert (path? access rights?)
> fatal: clone of 'https://gitlab.com/keycodemap/keycodemapdb.git' into
> submodule path 'ui/keycodemapdb' failed

I'm not sure what I can do about this one - if GIT can't checkout
a normal git repo, this looks like a OS distro / setup bug on the
build host. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
