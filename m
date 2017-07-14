Received: from eggs.gnu.org ([2001:4830:134:3::10]:50891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dW1W5-0003wM-B1
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dW1W4-0006QZ-Bb
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:24:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dW1W4-0006QN-21
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 10:24:24 -0400
Date: Fri, 14 Jul 2017 15:24:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170714142418.GA2415@work-vm>
References: <1500030745-10619-1-git-send-email-peter.maydell@linaro.org>
	<1500030745-10619-3-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500030745-10619-3-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] slirp: Handle error returns from
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
> ---
>  slirp/sbuf.c   |  2 +-
>  slirp/socket.c | 23 +++++++++++++++++------
>  2 files changed, 18 insertions(+), 7 deletions(-)
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
> index a17caa9..ecec029 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -404,7 +404,15 @@ sowrite(struct socket *so)
>  	DEBUG_ARG("so = %p", so);
>  
>  	if (so->so_urgc) {
> -		sosendoob(so);
> +		uint32_t expected = so->so_urgc;
> +		if (sosendoob(so) < expected) {

Oops, yes that is better.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
> @@ -448,11 +456,7 @@ sowrite(struct socket *so)
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
> @@ -479,6 +483,13 @@ sowrite(struct socket *so)
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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
