Received: from eggs.gnu.org ([2001:4830:134:3::10]:46180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gFfAS-0004v6-T8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 08:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gFfAO-0001sh-FG
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 08:55:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gFfAM-0001qf-IS
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 08:55:11 -0400
Date: Thu, 25 Oct 2018 13:55:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181025125501.GA5912@work-vm>
References: <20181022110854.10284-1-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com

* Fei Li (fli@suse.com) wrote:
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

That sounds like the main thread is blocked for some reason? But I don't
normally use the window setup;  if you try with -nographic and can see
the HMP (or a QMP) monitor, can you see if the monitor still responds?
If it doesn't then try and get a backtrace.

The monitor really shouldn't block, so it would be interesting to see.

Dave

> The source host keeps running as expected, but I guess the hang
> phenonmenon in the dest is not right.
> Would someone kindly give some suggestions on this? Thanks a lot.
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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
