Received: from eggs.gnu.org ([2001:4830:134:3::10]:35003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e52Uw-0008GC-6V
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e52Us-0002RD-03
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:31:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e52Ur-0002Qo-PF
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 00:31:53 -0400
Date: Thu, 19 Oct 2017 12:31:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171019043145.GA7850@pxdev.xzpeter.org>
References: <20171018174013.22709-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171018174013.22709-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] migration: pause-before-switchover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

On Wed, Oct 18, 2017 at 06:40:06PM +0100, Dr. David Alan Gilbert (git) wrote:

[...]

> The precopy flow is:
> active->pre-switchover->device->completed
> 
> The postcopy flow is:
> active->pre-switchover->postcopy-active->completed

The naming is still slightly confusing to me:

(1) we have a capability called "pause-before-switchover", so it feels
    like there is something called "switchover" and if we enable this
    we'll pause before that point;

(2) we have a new status "pre-switchover", it feels like that's the
    point before we are in "switchover" state;

(3) we don't really have a "switchover" state, but instead it's called
    "device" which is exactly the "switchover" action.

Considering (1) and (2), I would prefer "device" state to be just
"switchover"...

Further, not sure we can unify the state transition as well (say, we
add this switchover state even without cap "pause-before-switchover"
set, although it does not make much sense itself). Then, we can also
unify the precopy/postcopy state machine into one:

active->
  [pre-switchover->]      (optional, decided by "pause-before-switchover")
    switchover->
      [postcopy-active->] (optional, decided by "postcopy-arm")
        completed

(Sorry I am discussing the naming again instead of reviewing real
 stuff!)

-- 
Peter Xu
