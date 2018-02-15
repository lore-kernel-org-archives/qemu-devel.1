Received: from eggs.gnu.org ([2001:4830:134:3::10]:50121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emGZi-00033I-Hi
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emGZe-0007aV-H1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:15:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emGZe-0007aB-BT
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:15:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F60E401DEBA
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:15:18 +0000 (UTC)
Date: Thu, 15 Feb 2018 10:15:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180215101512.GD3322@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <jpg4lmj2gb5.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jpg4lmj2gb5.fsf@linux.bootlegged.copy>
Subject: Re: [Qemu-devel] ERROR:qom/object.c:907:object_unref: assertion
 failed (obj->ref > 0): (0 > 0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Wed, Feb 14, 2018 at 08:27:10PM -0500, Bandan Das wrote:
> 
> I get the error mentioined in the subject line when using vncviewer with
> commit 13e1d0e71e78a925848258391a6e616b6b5ae219:
> 
> Author: Daniel P. Berrange <berrange@redhat.com>
> Date:   Thu Feb 1 16:45:14 2018 +0000
> 
>     ui: convert VNC server to QIONetListener
>     
>     The VNC server already has the ability to listen on multiple sockets.
>     Converting it to use the QIONetListener APIs though, will reduce the
>     amount of code in the VNC server and improve the clarity of what is
>     left.
>     
>     Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>     Message-id: 20180201164514.10330-1-berrange@redhat.com
>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> 
> It appears to be related to the unconditional unref in vnc_listen_io:
> static void vnc_listen_io(QIONetListener *listener,
>                           QIOChannelSocket *cioc,
>                           void *opaque)
> {
>     VncDisplay *vd = opaque;
>     bool isWebsock = listener == vd->wslistener;
> 
>     qio_channel_set_name(QIO_CHANNEL(cioc),
>                          isWebsock ? "vnc-ws-server" : "vnc-server");
>     qio_channel_set_delay(QIO_CHANNEL(cioc), false);
>     vnc_connect(vd, cioc, false, isWebsock);
>     object_unref(OBJECT(cioc));
> }

[snip]

> So, it looks like the unref is already being handled as part of the event
> handling stuff when the window is closed. Is this a known issue/Is the
> object_unref above required ?

Yeah, my bad. The vnc_listen_io fnuc does *not* own the reference it is
given in the cioc parameter, so should not be unref'ing it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
