Received: from eggs.gnu.org ([2001:4830:134:3::10]:43622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dV0Az-0000uE-J9
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dV0Av-0005ZS-M7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:46:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dV0Av-0005YY-DW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:46:21 -0400
Date: Tue, 11 Jul 2017 19:46:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170711184615.GH2223@work-vm>
References: <1496679576-14336-1-git-send-email-peter.maydell@linaro.org>
	<1496679576-14336-3-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496679576-14336-3-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Handle error returns from
 sosendoob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> sosendoob() can return a failure code, but all its callers ignore it.
> This is OK in sbappend(), as the comment there states -- we will try
> again later in sowrite(). Add a (void) cast to tell Coverity so.
> In sowrite() we do need to check the return value -- we should handle
> a write failure in sosendoob() the same way we handle a write failure
> for the normal data.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I think this is OK, I do have one worry, which is perhaps there
were errors previously that would just loose OOB but get silently
ignored that perhaps we survived OK.
There's a comment there about seeing EAGAIN or EINTR in the normal
data path and not erroring;   hopefully we don't in the OOB case?

However, it generally seems to be sane, so:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  slirp/sbuf.c   |  2 +-
>  slirp/socket.c | 22 ++++++++++++++++------
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/slirp/sbuf.c b/slirp/sbuf.c
> index 10119d3..912f235 100644
> --- a/slirp/sbuf.c
> +++ b/slirp/sbuf.c
> @@ -91,7 +91,7 @@ sbappend(struct socket *so, struct mbuf *m)
>  	if (so->so_urgc) {
>  		sbappendsb(&so->so_rcv, m);
>  		m_free(m);
> -		sosendoob(so);
> +		(void)sosendoob(so);
>  		return;
>  	}
>  
> diff --git a/slirp/socket.c b/slirp/socket.c
> index a17caa9..84cf13a 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -404,7 +404,14 @@ sowrite(struct socket *so)
>  	DEBUG_ARG("so = %p", so);
>  
>  	if (so->so_urgc) {
> -		sosendoob(so);
> +		if (sosendoob(so) < so->so_urgc) {
> +			/* Treat a short write as a fatal error too,
> +			 * rather than continuing on and sending the urgent
> +			 * data as if it were non-urgent and leaving the
> +			 * so_urgc count wrong.
> +			 */
> +			goto err_disconnected;
> +		}
>  		if (sb->sb_cc == 0)
>  			return 0;
>  	}
> @@ -448,11 +455,7 @@ sowrite(struct socket *so)
>  		return 0;
>  
>  	if (nn <= 0) {
> -		DEBUG_MISC((dfd, " --- sowrite disconnected, so->so_state = %x, errno = %d\n",
> -			so->so_state, errno));
> -		sofcantsendmore(so);
> -		tcp_sockclosed(sototcpcb(so));
> -		return -1;
> +		goto err_disconnected;
>  	}
>  
>  #ifndef HAVE_READV
> @@ -479,6 +482,13 @@ sowrite(struct socket *so)
>  		sofcantsendmore(so);
>  
>  	return nn;
> +
> +err_disconnected:
> +	DEBUG_MISC((dfd, " --- sowrite disconnected, so->so_state = %x, errno = %d\n",
> +		    so->so_state, errno));
> +	sofcantsendmore(so);
> +	tcp_sockclosed(sototcpcb(so));
> +	return -1;
>  }
>  
>  /*
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
