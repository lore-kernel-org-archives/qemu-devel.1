Received: from eggs.gnu.org ([2001:4830:134:3::10]:55996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBelJ-0005g7-3g
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dBelF-0007XC-4F
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dBelE-0007Wm-Rn
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:03:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9DEAC04BD2D
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:03:51 +0000 (UTC)
Date: Fri, 19 May 2017 11:03:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170519100344.GG4912@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-2-git-send-email-peterx@redhat.com>
	<20170519082538.GD4912@redhat.com>
	<20170519095143.GC14679@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519095143.GC14679@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH RFC 1/6] io: only allow return path for
 socket typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, May 19, 2017 at 05:51:43PM +0800, Peter Xu wrote:
> On Fri, May 19, 2017 at 09:25:38AM +0100, Daniel P. Berrange wrote:
> > On Fri, May 19, 2017 at 02:43:27PM +0800, Peter Xu wrote:
> > > We don't really have a return path for the other types yet. Let's check
> > > this when .get_return_path() is called.
> > > 
> > > For this, we introduce a new feature bit, and set it up only for socket
> > > typed IO channels.
> > > 
> > > This will help detect earlier failure for postcopy, e.g., logically
> > > speaking postcopy cannot work with "exec:". Before this patch, when we
> > > try to migrate with "migrate -d exec:cat>out", we'll hang the system.
> > > With this patch, we'll get:
> > > 
> > > (qemu) migrate -d exec:cat>out
> > > Unable to open return-path for postcopy
> > 
> > This is wrong - post-copy migration *can* work with exec: - it just entirely
> > depends on what command you are running. Your example ran a command which is
> > unidirectional, but if you ran 'exec:socat ...' you would have a fully
> > bidirectional channel. Actually the channel is always bi-directional, but
> > 'cat' simply won't ever send data back to QEMU.
> 
> Indeed. I should not block postcopy if the user used a TCP tunnel
> between the source and destination in some way, using this exec: way.
> Thanks for pointing that out.
> 
> However I still think the idea is needed here. Say, we'd better know
> whether the transport would be able to respond (though current
> approach of "assuming sockets are the only ones that can reply" is not
> a good solution...). Please see below.
> 
> > 
> > If QEMU hangs when the other end doesn't send data back, that actually seems
> > like a potentially serious bug in migration code. Even if using the normal
> > 'tcp' migration protocol, if the target QEMU server hangs and fails to
> > send data to QEMU on the return path, the source QEMU must never hang.
> 
> Firstly I should not say it's a hang - it's actually by-design here
> imho - migration thread is in the last phase now, waiting for a SHUT
> message from destination (which I think is wise). But from the
> behavior, indeed src VM is not usable during the time, just like what
> happened for most postcopy cases on the source side. So, we can see
> that postcopy "assumes" that destination side can reply now.
> 
> Meanwhile, I see it reasonable for postcopy to have such an
> assumption. After all, postcopy means "start VM on destination before
> pages are moved over completely", then there must be someone to reply
> to source, no matter whether it'll be via some kind of io channel.
> 
> That's why I think we still need the general idea here, that we need
> to know whether destination end is able to reply.
> 
> But, I still have no good idea (after knowing this patch won't work)
> on how we can do this... Any further suggestions would be greatly
> welcomed.

IMHO this is nothing more than a documentation issue for the 'exec'
protocol. ie, document that you should provide a bi-directional
transport for live migration.

A uni-directional transport is arguably only valid if you're using
migrate to save/restore the VM state to a file.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
