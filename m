Received: from eggs.gnu.org ([2001:4830:134:3::10]:45854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkWwp-0005W0-LM
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkWwo-0007Kt-S1
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:47:59 -0400
Date: Wed, 23 Aug 2017 22:47:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170823144746.GA1866@lemon>
References: <20170823134242.12080-1-famz@redhat.com>
	<20170823134242.12080-3-famz@redhat.com>
	<dcc61514-4535-43bf-2b67-16051ef2b9c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcc61514-4535-43bf-2b67-16051ef2b9c6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/4] block-backend: Allow more
 "can inactivate" cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Wed, 08/23 09:36, Eric Blake wrote:
> On 08/23/2017 08:42 AM, Fam Zheng wrote:
> > These two conditions corresponds to mirror job's source and target,
> 
> s/corresponds to/correspond to a/
> 
> [can touch up on pull request]
> 
> > which need to be allowed as they are part of the non-shared storage
> > migration workflow: failing to inactivate either will result in a
> > failure during migration completion.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/block-backend.c          | 21 ++++++++++++++++-----
> >  include/sysemu/block-backend.h |  1 +
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> > 
> >  
> > -    return false;
> > +    /* Inactivating means no more write to the image can be done, even if it's
> 
> s/write/writes/
> 
> > +     * guest invisible change. For block job BBs that satisfy this, we can just
> 
> reads awkwardly. Maybe 'even if it's changes invisible to the guest'?
> But I can leave your wording if I don't get confirmation.

Not sure I understand the grammar of "it's changes" but yours must be better.
Feel free to update it. Thanks,

Fam

> 
> > +     * allow it.  This is the case for mirror job source, which is required by
> > +     * libvirt non-shared block migration. */
> > +    if (!(blk->perm & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED))) {
> > +        return true;
> > +    }
> > +
> > +    return blk->force_allow_inactivate;
> >  }
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
