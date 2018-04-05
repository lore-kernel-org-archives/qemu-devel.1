Received: from eggs.gnu.org ([2001:4830:134:3::10]:54302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f44Eo-0001l7-HU
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f44En-0000dk-Nf
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:43:34 -0400
Date: Thu, 5 Apr 2018 14:43:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180405124317.GC4077@localhost.localdomain>
References: <5ac0b76e-213a-60c3-c010-87512d3a564a@redhat.com>
	<20180212135206.GG5103@localhost.localdomain>
	<81af35f9-4934-0c21-e3b1-b27c2fa7fdd9@redhat.com>
	<20180212143040.GH5103@localhost.localdomain>
	<3d6031b0-7d75-c3ab-e466-ce3d87d630df@redhat.com>
	<20180212144824.GI5103@localhost.localdomain>
	<31e295bd-3012-c34c-a96d-54122557b20c@redhat.com>
	<2d47ca9e-6f68-ab4e-0ec0-9f932128a93f@redhat.com>
	<20180312115846.GC31537@localhost.localdomain>
	<9aed83cb-e718-3d47-87e1-f66a1c5c7c1a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aed83cb-e718-3d47-87e1-f66a1c5c7c1a@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] scsi: add block job
 opblockers for scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 05.04.2018 um 13:59 hat Paolo Bonzini geschrieben:
> On 12/03/2018 12:58, Kevin Wolf wrote:
> >> - users of dirty bitmaps would call use perm/shared_perm as in your
> >> message above
> >>
> >> - dirty bitmaps creation calls bdrv_get_cumulative_perm (which should
> >> now become public) and checks that it doesn't have BLK_PERM_BYPASS in
> >> shared_perm
> > 
> > My proposal was really that users of dirty bitmaps don't change
> > anything, but we do everything in the dirty bitmap implementation. Dirty
> > bitmap creation would add a BdrvChild with the above permissions.
> > Deleting a dirty bitmap would remove the BdrvChild again.
> 
> This is also better because it works if somebody requests
> BLK_PERM_BYPASS after dirty bitmap creation.
> 
> However, is there any better way than also creating a dummy BlockDriver
> and BlockDriverState?  I first thought of a root role similar to
> BlockBackend's, but BdrvChildRole doesn't have a way to inject its own
> permissions.  I then tried moving bdrv_child_perm to BdrvChildRole, and
> that almost works except that child_backing has special requirements
> (mostly due to commit_top and mirror_top's special block drivers).

Have a look at block_job_add_bdrv(), which does the same thing to
restrict permissions while a block job is working on the subchain.

Essentially, yes, you'll probably have a new BdrvChildRole (I suppose
with .stay_at_node = true and .get_parent_desc only), but the place
where you specify the permissions is the bdrv_root_attach_child() call.
When you're done, you call bdrv_root_unref_child().

Kevin

> Perhaps child_perm should be in BdrvChildRole and BlockDriverState
> should only have a bdrv_get_backing_perm (called by
> child_backing.child_perm).  This makes sense to me since those
> permissions are specific to the driver, e.g. whether it has metadata at
> all.  But this becomes 2.13 material.
> 
> Do you still object to the two opblocker patches?
> 
> Paolo
