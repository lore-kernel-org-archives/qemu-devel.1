Received: from eggs.gnu.org ([2001:4830:134:3::10]:39787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDPmn-0003kH-D6
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDPmm-0003sk-Hi
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:28:45 -0400
Date: Wed, 24 May 2017 14:28:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524062833.GO12279@lemon.lan>
References: <20170519023233.24461-1-eblake@redhat.com>
	<20170519023233.24461-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170519023233.24461-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] qemu-io: Don't die on second open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, jsnow@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Thu, 05/18 21:32, Eric Blake wrote:
> Failure to open a file in qemu-io should normally return 1 on
> failure to end the command loop, on the presumption that when
> batching commands all on the command line, failure to open means
> nothing further can be attempted. But when executing qemu-io
> interactively, there is a special case: if open is executed a
> second time, we print a hint that the user should try the
> interactive 'close' first.  But the hint is useless if we don't
> actually LET them try 'close'.
> 
> This has been awkward since at least as far back as commit
> 43642b3, in 2011 (probably earlier, but git blame has a harder
> time going past the file renames at that point).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-io.c b/qemu-io.c
> index 34fa8a1..0c82dac 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -63,7 +63,7 @@ static int openfile(char *name, int flags, bool writethrough, bool force_share,
>      if (qemuio_blk) {
>          error_report("file open already, try 'help close'");
>          QDECREF(opts);
> -        return 1;
> +        return 0;
>      }
> 
>      if (force_share) {
> -- 
> 2.9.4
> 
> 

Hmm, failure is failure, why is "return 0" better than "return 1"?

If the control flow in the caller has a problem, fix it there? Specifically, I
don't think failed interactive open need to exit program, at all.

Fam
