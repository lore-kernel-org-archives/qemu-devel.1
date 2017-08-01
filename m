Received: from eggs.gnu.org ([2001:4830:134:3::10]:56007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcXPd-0002iz-Hu
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcXPc-0007C2-Ig
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:40:41 -0400
Date: Tue, 1 Aug 2017 15:40:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170801134026.GB4257@localhost.localdomain>
References: <20170711170821.24669-1-ppandit@redhat.com>
	<29e5dd08-80e7-ae0d-7179-73f5d34c3485@redhat.com>
	<20170721154712.GM18014@stefanha-x1.localdomain>
	<b3ba0182-8700-76fc-5d20-97c054137ef9@redhat.com>
	<e8a30256-9b83-1c58-d8e6-9ec5192604b6@redhat.com>
	<3a90fa30-00b3-b389-5b78-54b55046648c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a90fa30-00b3-b389-5b78-54b55046648c@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: check BlockDriverState
 object before dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Kieron Shorrock <kshorrock@paloaltonetworks.com>, Prasad J Pandit <pjp@fedoraproject.org>, Markus Armbruster <armbru@redhat.com>

Am 01.08.2017 um 10:35 hat Paolo Bonzini geschrieben:
> On 01/08/2017 02:14, John Snow wrote:
> > I may need some nudging towards understanding what the right solution
> > here is, though. Should the blk_aio_flush assume that there always is a
> > root BDS? should it not assume that?
> 
> I think blk_aio_flush is not special.  If there is no root BDS, either
> you return -ENOMEDIUM, or you crash.  But all functions should be doing
> the same.

The intended semantics is that they return -ENOMEDIUM (or fail at
least). This is how things have always worked, and that it crashes now
because of the bdrv_inc_in_flight() was not an intentional change, but
simply a bug in the patch.

> The former makes sense, but right now blk_prwv for one are crashing if
> there is no root BDS so the minimum patch would fix the caller rather
> than blk_aio_flush.

The synchronous versions don't crash, and bdrv_aio_prwv() would fix all
cases if bdrv_inc_in_flight() were moved inside the coroutine; probably
right before blk_aio_complete(). This would be more consistent with how
the synchronous versions work, too, increasing the in-flight count only
by 1 rather than 2 for an AIO request.

Kevin
