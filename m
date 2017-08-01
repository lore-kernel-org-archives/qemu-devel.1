Received: from eggs.gnu.org ([2001:4830:134:3::10]:36664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcUy4-0002vu-Mx
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcUy1-0003g4-II
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:04:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dcUy1-0003em-Bq
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:04:01 -0400
Date: Tue, 1 Aug 2017 12:03:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170801110348.GH12670@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-17-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501229198-30588-17-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 16/29] qmp: hmp: add migrate "resume" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jul 28, 2017 at 04:06:25PM +0800, Peter Xu wrote:
> It will be used when we want to resume one paused migration.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hmp-commands.hx       | 7 ++++---
>  hmp.c                 | 4 +++-
>  migration/migration.c | 2 +-
>  qapi-schema.json      | 5 ++++-
>  4 files changed, 12 insertions(+), 6 deletions(-)

I'm not seeing explicit info about how we handle the original failure
and how it relates to this resume command, but this feels like a
potentially racy approach to me.

If we have a network problem between source & target, we could see
two results. Either the TCP stream will simply hang (it'll still
appear open to QEMU but no traffic will be flowing), or the connection
may actually break such that we get EOF and end up closing the file
descriptor.

In the latter case, we're ok because the original channel is now
gone and we can safely establish the new one by issuing the new
'migrate --resume URI' command.

In the former case, however, there is the possibility that the
hang may come back to life at some point, concurrently with us
trying to do 'migrate --resume URI' and I'm unclear on the
semantics if that happens.

Should the original connection carry on, and thus cause the
'migrate --resume' command to fail, or will we forcably terminate
the original connection no matter what and use the new "resumed"
connection.

There's also synchronization with the target host - at the time we
want to recover, we need to be able to tell the target to accept
new incoming clients again, but we don't want to do that if the
original connection comes back to life.

It feels to me that if the mgmt app or admin believes the migration
is in a stuck state, we should be able to explicitly terminate the
existing connection via a monitor command. Then setup the target
host to accept new client, and then issue this migrate resume on
the source.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
