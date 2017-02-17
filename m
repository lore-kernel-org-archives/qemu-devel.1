Received: from eggs.gnu.org ([2001:4830:134:3::10]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cei9r-00005Z-HH
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cei9q-0006mM-Ow
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:01:07 -0500
Date: Fri, 17 Feb 2017 14:00:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170217130058.GF5338@noname.redhat.com>
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-14-git-send-email-vsementsov@virtuozzo.com>
	<20170216140834.GF4869@noname.redhat.com>
	<0faf5e21-6a29-c691-0ae9-99706c344e63@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0faf5e21-6a29-c691-0ae9-99706c344e63@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v15 13/25] qcow2: add
 .bdrv_store_persistent_dirty_bitmaps()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

Am 17.02.2017 um 13:24 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 16.02.2017 17:08, Kevin Wolf wrote:
> >Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>Realize block bitmap storing interface, to allow qcow2 images store
> >>persistent bitmaps.
> >>
> >>Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>Reviewed-by: John Snow <jsnow@redhat.com>
> >Similary to autoload, I think this must be called as part of
> >qcow2_inactivate() rather than just in bdrv_close().
> >
> >Kevin
> 
> I prefer to store bitmaps once, on the final close of bds, and
> remove corresponding BdrvDirtyBitmap in the same point. bdrv_close
> is simpler point, I don't want to think about loading/saving bitmap
> on each invalidate/inactivate. I don't want to make dependencies
> between qcow2 bitmap loading/storing and migration, etc.
> 
> So, my approach was just load bitmap on bdrv_open and store on
> bdrv_close, and between these two calls BdrvDirtyBitmap lives its
> normal life. For me it looks simpler. I'm not sure about what new
> corner cases will come if we change this.

You make this sounds like invalidate/inactivate was a very frequent
operation. It's not. Essentially it is what you probably consider
open/close to be.

The semantics is basically that after inactivate (or more precisely, as
long as BDRV_O_INACTIVE is set), another process can access and
potentially modify the image file. At invalidate, qemu takes ownership
again and reloads everything from the image file.

Kevin
