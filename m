Received: from eggs.gnu.org ([2001:4830:134:3::10]:45244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXA67-0007OR-FU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXA64-0006mn-NX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:46:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXA64-0006mT-E6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:46:16 -0400
Date: Mon, 17 Jul 2017 18:46:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170717174609.GB31820@work-vm>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
	<a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

* Eric Blake (eblake@redhat.com) wrote:
> On 07/17/2017 11:46 AM, Dr. David Alan Gilbert wrote:
> 
> >> +++ w/hw/usb/bus.c
> >> @@ -407,8 +407,9 @@ void usb_register_companion(const char *masterbus,
> >> USBPort *ports[],
> >>  void usb_port_location(USBPort *downstream, USBPort *upstream, int portnr)
> >>  {
> >>      if (upstream) {
> >> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
> >> -                 upstream->path, portnr);
> >> +        int l = snprintf(downstream->path, sizeof(downstream->path),
> >> "%s.%d",
> >> +                         upstream->path, portnr);
> >> +        assert(l < sizeof(downstream->path));
> > 
> > You may find this doesn't help in some windows builds;  the assert
> > functions aren't always marked as noreturn (because they pop up a dialog
> > that asks you whether you want to run into a debugger etc).
> 
> How would it not help?  Are we using gcc 7 on windows builds?  Adding
> the assert is enough to shut up new gcc; old gcc was already silent; and
> if mingw is still on old gcc, it doesn't matter whether assert() is
> marked noreturn for what this patch is doing.

[dgilbert@dgilbert-t530 ~]$ x86_64-w64-mingw32-gcc -v
Using built-in specs.
COLLECT_GCC=/usr/bin/x86_64-w64-mingw32-gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-w64-mingw32/7.1.0/lto-wrapper
Target: x86_64-w64-mingw32
Configured with: ../configure --prefix=/usr --bindir=/usr/bin --includedir=/usr/include --mandir=/usr/share/man --infodir=/usr/share/info --datadir=/usr/share --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --with-gnu-as --with-gnu-ld --verbose --without-newlib --disable-multilib --disable-plugin --with-system-zlib --disable-nls --without-included-gettext --disable-win32-registry --enable-languages=c,c++,objc,obj-c++,fortran --with-bugurl=http://bugzilla.redhat.com/bugzilla --with-cloog --enable-threads=posix --enable-libgomp --target=x86_64-w64-mingw32 --with-sysroot=/usr/x86_64-w64-mingw32/sys-root --with-gxx-include-dir=/usr/x86_64-w64-mingw32/sys-root/mingw/include/c++
Thread model: posix
gcc version 7.1.0 20170502 (Fedora MinGW 7.1.0-1.fc26) (GCC)

Dave
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
