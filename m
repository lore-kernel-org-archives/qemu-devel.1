Received: from eggs.gnu.org ([2001:4830:134:3::10]:55575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duDVA-0003zs-O7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duDV6-0001bS-T6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:03:28 -0400
Date: Tue, 19 Sep 2017 16:03:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170919080311.GC11534@lemon.lan>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-18-mreitz@redhat.com>
	<20170918064613.GG15551@lemon.lan>
	<87b2b2f4-ecc0-3436-a5af-6d2c9d858b8f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87b2b2f4-ecc0-3436-a5af-6d2c9d858b8f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/18] qemu-io: Add background write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On Mon, 09/18 19:53, Max Reitz wrote:
> On 2017-09-18 08:46, Fam Zheng wrote:
> > On Wed, 09/13 20:19, Max Reitz wrote:
> >> Add a new parameter -B to qemu-io's write command.  When used, qemu-io
> >> will not wait for the result of the operation and instead execute it in
> >> the background.
> > 
> > Cannot aio_write be used for this purpose?
> 
> Depends.  I have been trained to dislike *_aio_*, so that's probably the
> initial reason why I didn't use it.
> 
> Second, I'd have to fix aio_write before it can be used.  Currently,
> this aborts:
> 
> echo 'qemu-io drv0 "aio_write -P 0x11 0 64M"' \
>     | x86_64-softmmu/qemu-system-x86_64 -monitor stdio \
>           -blockdev node-name=drv0,driver=null-co
> 
> because aio_write_done thinks it's a good idea to use qemu-io's
> BlockBackend -- but when qemu-io is executed through the HMP, the
> BlockBackend is only created for the duration of the qemu-io command
> (unless there already is a BB).  So what I'd have to do is add a
> blk_ref()/blk_unref() there, but for some reason I really don't like that.

What is the reason? If it crashes it should be fixed anyway, I assume?

Fam
