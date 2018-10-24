Received: from eggs.gnu.org ([2001:4830:134:3::10]:40934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gFQgx-0001nt-SV
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gFQgu-0006QO-OG
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gFQgu-0006PO-HY
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:27:48 -0400
Date: Wed, 24 Oct 2018 22:27:42 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181024212742.GB30830@xz-x1.hotspot.internet-for-guests.com>
References: <20181022110854.10284-1-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181022110854.10284-1-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] Fix migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com

On Mon, Oct 22, 2018 at 07:08:52PM +0800, Fei Li wrote:
> Hi,
> these two patches are to fix live migration issues. The first is
> about multifd, and the second is to fix some error handling.
> 
> But I have a question about using multifd migration.
> In our current code, when multifd is used during migration, if there
> is an error before the destination receives all new channels (I mean
> multifd_recv_new_channel(ioc)), the destination does not exit but
> keeps waiting (Hang in recvmsg() in qio_channel_socket_readv) until
> the source exits.
> 
> My question is about the state of the destination host if fails during
> this period. I did a test, after applying [1/2] patch, if
> multifd_new_send_channel_async() fails, the destination host hangs for
> a while then later pops up a window saying
>     "'QEMU (...) [stopped]' is not responding.
>     You may choose to wait a short while for it to continue or force
>     the application to quit entirely."
> But after closing the window by clicking, the qemu on the dest still
> hangs there until I exclusively kill the qemu on the source.
> 
> The source host keeps running as expected, but I guess the hang
> phenonmenon in the dest is not right.
> Would someone kindly give some suggestions on this? Thanks a lot.

Note that it's during KVM forum so the response from anyone might be
slow (it ends this week).

I think the thing you described seems normal since we can't guarantee
the network is always stable, normally I'll expect that the migration
will fail but it won't matter much since after all it's a precopy so
we lose nothing.  So I'm curious about when the error you mentioned
happens (e.g., total channel number is N, you only got M channels
connected, with M < N) could you just simply kill the destination?
Then AFAIU the source can just continue to run, right?

> 
> 
> Fei Li (2):
>   migration: fix the multifd code
>   migration: fix some error handling
> 
>  migration/migration.c    |  5 +----
>  migration/postcopy-ram.c |  3 +++
>  migration/ram.c          | 33 +++++++++++++++++++++++----------
>  migration/ram.h          |  2 +-
>  4 files changed, 28 insertions(+), 15 deletions(-)
> 
> -- 
> 2.13.7
> 

Regards,

-- 
Peter Xu
