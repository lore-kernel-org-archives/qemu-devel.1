Received: from eggs.gnu.org ([2001:4830:134:3::10]:54144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBecq-00035c-3q
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBecn-0004jW-1D
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:55:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBecm-0004iD-RN
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:55:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B80EA624B3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 09:55:07 +0000 (UTC)
Date: Fri, 19 May 2017 17:55:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170519095500.GD14679@pxdev.xzpeter.org>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-2-git-send-email-peterx@redhat.com>
	<20170519082538.GD4912@redhat.com>
	<20170519083010.GE4912@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, May 19, 2017 at 09:30:10AM +0100, Daniel P. Berrange wrote:
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

Makes sense. Noted. Thanks,

-- 
Peter Xu
