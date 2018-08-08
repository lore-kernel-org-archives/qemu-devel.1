Received: from eggs.gnu.org ([2001:4830:134:3::10]:40833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnRLV-0002FQ-Vs
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 12:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnRLV-0003DZ-8G
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 12:30:02 -0400
Date: Wed, 8 Aug 2018 18:29:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180808162948.GF15410@localhost.localdomain>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-5-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807043349.27196-5-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/21] block/commit: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

Am 07.08.2018 um 06:33 hat John Snow geschrieben:
> Change the manual deferment to commit_complete into the implicit
> callback to job_exit.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

There is one tricky thing in this patch that the commit message could be
a bit more explicit about, which is moving job_completed() to a later
point.

This is the code that happens between the old call of job_completed()
and the new one:

    /* If bdrv_drop_intermediate() didn't already do that, remove the commit
     * filter driver from the backing chain. Do this as the final step so that
     * the 'consistent read' permission can be granted.  */
    if (remove_commit_top_bs) {
        bdrv_child_try_set_perm(commit_top_bs->backing, 0, BLK_PERM_ALL,
                                &error_abort);
        bdrv_replace_node(commit_top_bs, backing_bs(commit_top_bs),
                          &error_abort);
    }

    bdrv_unref(commit_top_bs);
    bdrv_unref(top);

As the comment states, bdrv_replace_node() requires that the permission
restrictions that the commit job made are already lifted. The most
important part is done by the explicit block_job_remove_all_bdrv() call
right before this hunk. It still leaves bjob->blk around, which could
have implications, but luckily we didn't take any permissions for that
one:

    s = block_job_create(job_id, &commit_job_driver, NULL, bs, 0, BLK_PERM_ALL,
                         speed, JOB_DEFAULT, NULL, NULL, errp);

So I think we got everything out of the way and bdrv_replace_node() can
do what it wants to do.

Kevin
