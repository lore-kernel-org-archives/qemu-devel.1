Received: from eggs.gnu.org ([2001:4830:134:3::10]:54730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsWHi-0004W2-Ls
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dsWHh-00010Z-Qz
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:42:34 -0400
Date: Thu, 14 Sep 2017 16:42:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170914154221.GD7370@stefanha-x1.localdomain>
References: <20170913181910.29688-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/18] block/mirror: Add active-sync
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, Sep 13, 2017 at 08:18:52PM +0200, Max Reitz wrote:
> There may be a couple of things to do on top of this series:
> - Allow switching between active and passive mode at runtime: This
>   should not be too difficult to implement, the main question is how to
>   expose it to the user.
>   (I seem to recall we wanted some form of block-job-set-option
>   command...?)
> 
> - Implement an asynchronous active mode: May be detrimental when it
>   comes to convergence, but it might be nice to have anyway.  May or may
>   not be complicated to implement.

Ideally the user doesn't have to know about async vs sync.  It's an
implementation detail.

Async makes sense during the bulk copy phase (e.g. sync=full) because
guest read/write latencies are mostly unaffected.  Once the entire
device has been copied there are probably still dirty blocks left
because the guest touched them while the mirror job was running.  At
that point it definitely makes sense to switch to synchronous mirroring
in order to converge.
