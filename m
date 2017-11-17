Received: from eggs.gnu.org ([2001:4830:134:3::10]:50856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFhlh-0006Xo-0S
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFhlb-0007Fb-Dd
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:37:21 -0500
Date: Fri, 17 Nov 2017 14:37:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171117143705.GW25830@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171117112913.21875-1-berrange@redhat.com>
	<9f180831-1ecd-7326-7659-19f79170439e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f180831-1ecd-7326-7659-19f79170439e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 (for-2.11)] qcow2: fix image corruption
 after committing qcow2 image into base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Fri, Nov 17, 2017 at 08:32:32AM -0600, Eric Blake wrote:
> On 11/17/2017 05:29 AM, Daniel P. Berrange wrote:
> > After committing the qcow2 image contents into the base image, qemu-img
> > will call bdrv_make_empty to drop the payload in the layered image.
> > 
> > When this is done for qcow2 images, it blows away the LUKS encryption
> > header, making the resulting image unusable. There are two codepaths
> > for emptying a qcow2 image, and the second (slower) codepath leaves
> > the LUKS header intact, so force use of that codepath.
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> 
> >  
> >      if (s->qcow_version >= 3 && !s->snapshots &&
> > -        3 + l1_clusters <= s->refcount_block_size) {
> > +        3 + l1_clusters <= s->refcount_block_size &&
> > +        s->crypt_method_header != QCOW_CRYPT_LUKS) {
> 
> Missing the check for s->nb_bitmaps == 0 that Vladimir mentioned on v1.
> Either we can add that in this patch, or I can post the obvious followup
> that also needs queuing.

That's unrelated to LUKS though, so best as a separate patch, which adds
a I/O test case that validates that feature.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
