Received: from eggs.gnu.org ([209.51.188.92]:56387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grR3R-0001nD-Om
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grR3Q-0006mx-GT
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:32:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grR3O-0006m8-HS
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:32:06 -0500
Date: Wed, 6 Feb 2019 17:31:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190206173157.GB12331@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <alpine.BSF.2.21.9999.1902061736310.58711@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1902061736310.58711@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] 07333e1ca (kbd-state: use state tracker for sdl2)
 breaks keyboard input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Feb 06, 2019 at 05:41:22PM +0100, BALATON Zoltan wrote:
> Hello,
> 
> The commit 07333e1ca breaks keyboard input in bios console with SDL2 UI. To
> reproduce: start qemu-system-i386 without any options, press Ctrl-B when
> prompted to get an IPXE command line and type. Key presses are doubled.

This isn't related to the IPXE BIOS - it is broken in general in fact.

Enabling tracing shows that all the input events are doubled up
all the time, before we even get into IPXE BIOS

$ ./x86_64-softmmu/qemu-system-x86_64  -display sdl -d trace:input*
17197@1549474207.037592:input_event_key_qcode con 0, key qcode f, down 1
17197@1549474207.037662:input_event_sync 
17197@1549474207.037680:input_event_key_qcode con 0, key qcode f, down 1
17197@1549474207.037706:input_event_sync 
17197@1549474207.145514:input_event_key_qcode con 0, key qcode f, down 0
17197@1549474207.145542:input_event_sync 
17197@1549474207.145548:input_event_key_qcode con 0, key qcode f, down 0
17197@1549474207.145552:input_event_sync 
17197@1549474208.477246:input_event_key_qcode con 0, key qcode f, down 1
17197@1549474208.477294:input_event_sync 
17197@1549474208.477299:input_event_key_qcode con 0, key qcode f, down 1
17197@1549474208.477301:input_event_sync 
17197@1549474208.547471:input_event_key_qcode con 0, key qcode f, down 0
17197@1549474208.547503:input_event_sync 
17197@1549474208.547509:input_event_key_qcode con 0, key qcode f, down 0


> (Besides this the output window mixup when something is output to serial
> window I've reported earlier is still present. I'd appreciate if these could
> be fixed now that the working SDL1 alternative was completely removed.)

AFAIR, we determined there was something related to the nvidia binary
only drivers that was breaking this and needed to know if using nouveau
drivers would fix it.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
