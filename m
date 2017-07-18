Received: from eggs.gnu.org ([2001:4830:134:3::10]:46360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXMrT-00005D-Vq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXMrP-0008M7-VU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXMrP-0008Le-P0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:23:59 -0400
Date: Tue, 18 Jul 2017 08:23:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718072351.GB11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
	<a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Mon, Jul 17, 2017 at 12:29:08PM -0500, Eric Blake wrote:
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

Mingw isn't using a fork of GCC anymore, its all mainline. Thus Fedora's
mingw gcc packages track native gcc packages. IOW i686-w64-mingw32-gcc
is already on version 7.1.0 in Fedora

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
