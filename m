Received: from eggs.gnu.org ([2001:4830:134:3::10]:56280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyzAM-0000RJ-Kb
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 07:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyzAJ-0000sD-El
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 07:13:26 -0400
Received: from mail-he1eur01on0099.outbound.protection.outlook.com
	([104.47.0.99]:55726
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1cyzAI-0000pz-Th
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 07:13:23 -0400
Date: Fri, 14 Apr 2017 10:40:41 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170414074040.GA30735@rkaganb.sw.ru>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
	<d77e0178-8898-3583-ca2c-adf43bf9e0f4@redhat.com>
	<e00ab029-cf9f-5aca-9786-581915dd5189@openvz.org>
	<20170413094454.GB5095@noname.redhat.com>
	<1cc754f6-6718-edbc-96ef-ab0e0e10fd56@openvz.org>
	<d34a20e9-8cb7-3b83-e96f-4631f91045cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d34a20e9-8cb7-3b83-e96f-4631f91045cd@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Stefan
	Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, Apr 13, 2017 at 09:06:19PM -0400, John Snow wrote:
> So if we have a 1MB cluster with 64k subclusters as a hypothetical, if
> we write just the first subcluster, we'll have a map like:
> 
> X---------------
> 
> Whatever actually happens to exist in this space, whether it be a hole
> we punched via fallocate or literal zeroes, this space is known to the
> filesystem to be contiguous.
> 
> If we write to the last subcluster, we'll get:
> 
> X--------------X
> 
> And again, maybe the dashes are a fallocate hole, maybe they're zeroes.
> but the last subcluster is located virtually exactly 15 subclusters
> behind the first, they're not physically contiguous. We've saved the
> space between them. Future out-of-order writes won't contribute to any
> fragmentation, at least at this level.

Yeah I think this is where the confusion lies.  You apparently assume
that the filesystem is smart enough to compensate for the subclusters
being sparse within a cluster, and will make them eventually contiguous
on the *media* once they are all written.  Denis is claiming the
opposite.  I posted a simple experiment with a 64kB sparse file written
out of order which ended up being 16 disparate blocks on the platters
(ext4; with xfs this may be different), and this is obviously
detrimental for performance with rotating disks.

Note also that if the filesystem actually is smart to maintain the
subclusters contiguos even if written out of order, apparently by not
allowing blocks from other files to take the yet unused space between
sparse subclusters, the disk space saving becomes not so obvious.

> You might be able to reduce COW from 5 IOPs to 3 IOPs, but if we tune
> the subclusters right, we'll have *zero*, won't we?

Right, this is an attractive advantage.  Need to test if the later
access to such interleaved clusters is not degraded, though.

Roman.
