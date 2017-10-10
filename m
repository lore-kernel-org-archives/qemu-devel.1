Received: from eggs.gnu.org ([2001:4830:134:3::10]:35940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1qcd-0005pb-7L
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1qcX-0005rF-JC
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:14:43 -0400
Date: Tue, 10 Oct 2017 11:14:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010091420.GD4177@dhcp-200-186.str.redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-6-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-6-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/18] block/mirror: Convert to coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Am 13.09.2017 um 20:18 hat Max Reitz geschrieben:
> In order to talk to the source BDS (and maybe in the future to the
> target BDS as well) directly, we need to convert our existing AIO
> requests into coroutine I/O requests.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Please follow through with it and add a few patches that turn it into
natural coroutine code rather than just any coroutine code. I know I did
the same kind of half-assed conversion in qed, but mirror is code that
is actually used and that people look at for more than just a bad
example.

You'll probably notice more things when you do this, but the obvious
things would be changing mirror_co_read() into a mirror_co_copy() with
the former callbacks inlined; keeping op on the stack instead of
mallocing it in mirror_perform() and free it deep inside the nested
functions that used to be callbacks; and probably also cleaning up the
random calls to aio_context_acquire/release() that will now appear in
the middle of the function.

Anyway, that's for follow-up patches (though ideally in the same
series), so for this one you can have:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
