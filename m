Received: from eggs.gnu.org ([2001:4830:134:3::10]:39895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2aKQ-0000tD-FW
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e2aKK-0007SS-Id
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:02:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e2aKK-0007Rq-Dp
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:02:52 -0400
Date: Thu, 12 Oct 2017 11:02:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171012100244.GG16125@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171011191317.24157-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171011191317.24157-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] migration: pause-before-device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

On Wed, Oct 11, 2017 at 08:13:10PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This set attempts to make a race condition between migration and
> drive-mirror (and other block users) soluble by allowing the migration
> to be paused after the source qemu releases the block devices but
> before the serialisation of the device state.
> 
> The symptom of this failure, as reported by Wangjie, is a:
>    _co_do_pwritev: Assertion `!(bs->open_flags & 0x0800)' failed
> 
> and the source qemu dieing; so the problem is pretty nasty.
> This has only been seen on 2.9 onwards, but the theory is that
> prior to 2.9 it might have been happening anyway and we were
> perhaps getting unreported corruptions (lost writes); so this
> really needs fixing.
> 
> This flow came from discussions between Kevin and me, and we can't
> see a way of fixing it without exposing a new state to the management
> layer.
> 
> The flow is now:
> 
> (qemu) migrate_set_capability pause-before-device on

How about 'switchover-cleanup'


> (qemu) migrate -d ...
> (qemu) info migrate
> ...
> Migration status: pause-before-device

and 'switchover'

> ...
> << issue commands to clean up any block jobs>>
> 
> (qemu) migrate_continue pause-before-device
> (qemu) info migrate
> ...
> Migration status: completed
> 
> This set has been _very_ lightly tested just at the normal migration
> code, without the addition of the drive mirror; so this is a first
> cut.  I'd appreciate some feedback from libvirt whether the inteface
> is OK and ideally a hack to test it in a full libvirt setup to see
> if we hit any other issues.
> 
> The precopy flow is:
> active->pause-before-device->completed
> 
> The postcopy flow is:
> active->pause-before-device->postcopy-active->completed
> 
> Although the behaviour with postcopy only gets interesting when
> we add something like Max's active-sync.
> 
> Please argue about the command and state naming.

Argued above :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
