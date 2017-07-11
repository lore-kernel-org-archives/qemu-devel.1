Received: from eggs.gnu.org ([2001:4830:134:3::10]:57982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUzXC-00066G-IN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUzX9-0000Bw-D6
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUzX9-0000Bd-3X
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:05:15 -0400
Date: Tue, 11 Jul 2017 19:05:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170711180509.GG2223@work-vm>
References: <1496679576-14336-1-git-send-email-peter.maydell@linaro.org>
	<1496679576-14336-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496679576-14336-2-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] slirp: Handle error returns from
 slirp_send() in sosendoob()
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
> The code in sosendoob() assumes that slirp_send() always
> succeeds, but it might return an OS error code (for instance
> if the other end has disconnected). Catch these and return
> the caller either -1 on error or the number of urgent bytes
> actually written. (None of the callers check this return
> value currently, though.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

That looks OK to me; the changes don't change the datastructure
usage at all - it's just the updated or so_urgc if it worked.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  slirp/socket.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/slirp/socket.c b/slirp/socket.c
> index 3b49a69..a17caa9 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -345,33 +345,40 @@ sosendoob(struct socket *so)
>  	if (sb->sb_rptr < sb->sb_wptr) {
>  		/* We can send it directly */
>  		n = slirp_send(so, sb->sb_rptr, so->so_urgc, (MSG_OOB)); /* |MSG_DONTWAIT)); */
> -		so->so_urgc -= n;
> -
> -		DEBUG_MISC((dfd, " --- sent %d bytes urgent data, %d urgent bytes left\n", n, so->so_urgc));
>  	} else {
>  		/*
>  		 * Since there's no sendv or sendtov like writev,
>  		 * we must copy all data to a linear buffer then
>  		 * send it all
>  		 */
> +		uint32_t urgc = so->so_urgc;
>  		len = (sb->sb_data + sb->sb_datalen) - sb->sb_rptr;
> -		if (len > so->so_urgc) len = so->so_urgc;
> +		if (len > urgc) {
> +			len = urgc;
> +		}
>  		memcpy(buff, sb->sb_rptr, len);
> -		so->so_urgc -= len;
> -		if (so->so_urgc) {
> +		urgc -= len;
> +		if (urgc) {
>  			n = sb->sb_wptr - sb->sb_data;
> -			if (n > so->so_urgc) n = so->so_urgc;
> +			if (n > urgc) {
> +				n = urgc;
> +			}
>  			memcpy((buff + len), sb->sb_data, n);
> -			so->so_urgc -= n;
>  			len += n;
>  		}
>  		n = slirp_send(so, buff, len, (MSG_OOB)); /* |MSG_DONTWAIT)); */
> +	}
> +
>  #ifdef DEBUG
> -		if (n != len)
> -		   DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
> +	if (n != len) {
> +		DEBUG_ERROR((dfd, "Didn't send all data urgently XXXXX\n"));
> +	}
>  #endif
> -		DEBUG_MISC((dfd, " ---2 sent %d bytes urgent data, %d urgent bytes left\n", n, so->so_urgc));
> +	if (n < 0) {
> +		return n;
>  	}
> +	so->so_urgc -= n;
> +	DEBUG_MISC((dfd, " ---2 sent %d bytes urgent data, %d urgent bytes left\n", n, so->so_urgc));
>  
>  	sb->sb_cc -= n;
>  	sb->sb_rptr += n;
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
