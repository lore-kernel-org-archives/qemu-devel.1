Received: from eggs.gnu.org ([2001:4830:134:3::10]:48676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBhQO-0005y7-4r
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBhQK-0006k4-5r
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dBhQJ-0006hi-SI
	for qemu-devel@nongnu.org; Fri, 19 May 2017 08:54:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C195180478
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 12:54:26 +0000 (UTC)
Date: Fri, 19 May 2017 13:54:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170519125421.GN2081@work-vm>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-2-git-send-email-peterx@redhat.com>
	<20170519082538.GD4912@redhat.com>
	<20170519083010.GE4912@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170519083010.GE4912@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Daniel P. Berrange (berrange@redhat.com) wrote:
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
> > 
> > If QEMU hangs when the other end doesn't send data back, that actually seems
> > like a potentially serious bug in migration code. Even if using the normal
> > 'tcp' migration protocol, if the target QEMU server hangs and fails to
> > send data to QEMU on the return path, the source QEMU must never hang.
> 
> BTW, if you want to simplify the code in this area at all, then arguably
> we should get rid of the "get_return_path" helper method entirely. We're
> not actually opening any new connections - we're just creating a second
> QEMUFile that uses the same underlying QIOChannel object. All we would
> need is for the QEMUFile to have a separate 'buf' field management in
> QEMUFile for the read & write directions.  Then all the code would be
> able to just use the single QEMUFile for read & write getting rid of this
> concept of "opening a return path" which doens't actually do anything at
> the underlying data transport level.

No, I'd rather keep the get_return_path;  we should keep each direction
separate.

Dave

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
