Received: from eggs.gnu.org ([2001:4830:134:3::10]:50892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cahuu-0007xz-KS
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cahur-0004UE-JW
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:57:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cahur-0004Tw-BB
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:57:05 -0500
Date: Mon, 6 Feb 2017 11:57:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170206115659.GC2524@work-vm>
References: <20170202150530.1025-1-pbonzini@redhat.com>
	<20170203150050.GF642@stefanha-x1.localdomain>
	<55b46fa3-c861-9ba4-da65-25bc392d8900@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55b46fa3-c861-9ba4-da65-25bc392d8900@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] configure: remove
 --enable-replication/--disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> 
> 
> On 03/02/2017 07:00, Stefan Hajnoczi wrote:
> > On Thu, Feb 02, 2017 at 07:05:30AM -0800, Paolo Bonzini wrote:
> >> The replication feature is a small amount of code, does not
> >> require any external library and unless used does not add
> >> anything to the guest's attack surface.  Since any extra
> >> configure option affects maintainability on the other hand
> >> and is subject to bit rot, I think there is no need to
> >> make it configurable.
> > 
> > I think the current state is good: replication is enabled by default but
> > can be compiled out if desired.
> > 
> > Downstreams may not be comfortable supporting this feature yet since
> > it's incomplete.  It's fair to offer an option to disable it, otherwise
> > downstreams will have to patch this themselves.
> 
> I understand---I just am not sure where to draw the line because there's
> plenty of other incomplete features, hence the RFC.  For example,
> record/replay cannot be enabled or disabled on the configure command
> line.  That was the case even in the beginning, where it didn't support
> either block or character device replay.

The line is certainly fuzzy, but I think it's worth making the following
type of things configurable:
   Features that have a large chunk of code
     - dont lets try and configure tiny things on and off
   That can be trivially configured
     - lets not put big chunks of code around making them configurable
and   that are incomplete
   or are unused by large chunks of the users

Dave

> --enable-coroutine-pool is a relic of when Windows builds needed it, but
> all other --enable-* options require an external library or at least a
> specific operating system.  See for example this patch:
> 
>     commit 52b53c04faab9f7a9879c8dc014930649a3e698d
>     Author: Fam Zheng <famz@redhat.com>
>     Date:   Wed Sep 10 14:17:51 2014 +0800
> 
>     block: Always compile virtio-blk dataplane
> 
>     Dataplane doesn't depend on linux-aio any more, so we don't need the
>     compiling condition now.
> 
>     Configure options are kept but just print a message.
> 
>     Signed-off-by: Fam Zheng <famz@redhat.com>
>     Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>     Message-id: 1410329871-28885-4-git-send-email-famz@redhat.com
>     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> 
> I would actually prefer to remove many of the latter
> (--enable-vhost-net, --enable-vhost-scsi, --enable-vhost-socket) and
> just use default-configs.  We are already doing it for ivshmem for example:
> 
>     CONFIG_IVSHMEM=$(CONFIG_EVENTFD)
> 
> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
