Received: from eggs.gnu.org ([2001:4830:134:3::10]:60993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWeMc-0003nP-BH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWeMY-0000yy-9g
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:30:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gWeMY-0000yK-2w
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:29:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B180307C94A
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 09:29:57 +0000 (UTC)
Date: Tue, 11 Dec 2018 09:29:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181211092944.GA921@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
	<20181126124250.29985-2-marcandre.lureau@redhat.com>
	<20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
	<CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
	<20181210183313-mutt-send-email-mst@kernel.org>
	<20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hoffmann, Gerd" <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Dec 11, 2018 at 08:42:41AM +0100, Hoffmann, Gerd wrote:
>   Hi,
> 
> > Right. The main issue is that we need to make sure only
> > in-tree devices are supported.
> 
> Well, that is under debate right now, see:
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04912.html

I've previously been against the idea of external plugins for QEMU,
however, that was when the plugin was something that would be dlopen'd
by QEMU. That would cause our internal ABI to be exposed to 3rd parties
which is highly undesirable, even if they were open source to comply
with the license needs.

When the plugin is a completely isolated process communicating with a
well defined protocol, it is not placing a significant burden on the
QEMU developers' ongoing maintainence, nor has problems with license
compliance. The main problem would come from debugging the combined
system as the external process is essentially a black box from QEMU's
POV. Downstream OS vendors are free to place restrictions on which
backend processes they'd be willing to support with QEMU, and upstream
is under no obligation to debug stuff beyond the QEMU boundary.

We have already accepted that tradeoff with networking by supporting
vhost-user and have externals impls like DPDK, so I don't see a
compelling reason to try to restrict it for other vhost-user backends.

> > vhost-user by design
> > is for out of tree users. It needn't be hard,
> > maybe it's enough to just make qemu launch these processes
> > as opposed to connecting to them on command line.
> 
> Not sure this is a good idea, with security being one of the motivating
> factors to move device emulation to other processes.  When libvirt
> launches the processes it can place them in separate sandboxes ...

Yep, libvirt already turns on seccomp policies which forbid QEMU from
forking/execing anything, and we have no desire to go backwards here.
Any external processes have to be launched by libvirt ahead of time.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
