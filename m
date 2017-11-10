Received: from eggs.gnu.org ([2001:4830:134:3::10]:47346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eDD1H-00065B-FJ
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eDD1D-0001nc-Co
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 12:23:07 -0500
Date: Fri, 10 Nov 2017 17:22:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171110172253.GH30685@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171103144113.7188-1-berrange@redhat.com>
	<9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b0c5170-c97a-51d5-b1e4-003f1628d7be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix image corruption after
 committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Fri, Nov 10, 2017 at 10:34:59AM -0600, Eric Blake wrote:
> On 11/03/2017 09:41 AM, Daniel P. Berrange wrote:
> > After committing the qcow2 image contents into the base image, qemu-img
> > will call bdrv_make_empty to drop the payload in the layered image.
> > 
> > When this is done for qcow2 images, it blows away the LUKS encryption
> > header, making the resulting image unusable. There are two codepaths
> > for emptying a qcow2 image, and the second (slower) codepaths leaves
> > the LUKS header intact, so force use of that codepath.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> > 
> > NB, ideally we would fix the faster codepath in make_completely_empty, but
> > having looked at the code, I've really no idea how to even start on fixing that
> > to not kill the LUKS header clusters.
> 
> Hmm - I wonder if persistent bitmaps are also corrupted in the fast path.

I also wonder if there's anything better we can do to make us safer by
default, so we default to the slow & safe path, unless we can provide
we *only* have the subset of features that are safe for the fast path ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
