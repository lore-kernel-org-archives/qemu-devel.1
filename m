Received: from eggs.gnu.org ([2001:4830:134:3::10]:40121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dxVbc-0002Nw-2L
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dxVbY-0005Ag-Td
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dxVbY-00059P-Nv
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:59:40 -0400
Date: Thu, 28 Sep 2017 10:59:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170928095935.GB12157@stefanha-x1.localdomain>
References: <20170928025958.1420-1-peterx@redhat.com>
	<20170928025958.1420-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928025958.1420-6-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/5] aio: fix assert when remove poll
 during destroy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Manos Pitsidianakis <el13635@mail.ntua.gr>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Sep 28, 2017 at 10:59:58AM +0800, Peter Xu wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> After iothread is enabled internally inside QEMU with GMainContext, we
> may encounter this warning when destroying the iothread:
> 
> (qemu-system-x86_64:19925): GLib-CRITICAL **: g_source_remove_poll:
>  assertion '!SOURCE_DESTROYED (source)' failed
> 
> The problem is that g_source_remove_poll() does not allow to remove one
> source from array if the source is detached from its owner
> context. (peterx: which IMHO does not make much sense)
> 
> Fix it on QEMU side by avoid calling g_source_remove_poll() if we know
> the object is during destruction, and we won't leak anything after all
> since the array will be gone soon cleanly even with that fd.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> [peterx: write the commit message]
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  util/aio-posix.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
