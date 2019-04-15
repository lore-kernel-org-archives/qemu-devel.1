Received: from eggs.gnu.org ([209.51.188.92]:55351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG0Kl-0004fb-Vf
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG0Kj-0003in-Q5
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:03:35 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:57782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG0Kh-0003gs-SK
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:03:33 -0400
Date: Mon, 15 Apr 2019 14:03:28 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190415120328.bcuxvj6nrjh7b4ol@function>
References: <20190415120205.2221-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415120205.2221-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] slirp: Gcc 9 -O3 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, jan.kiszka@siemens.com

Dr. David Alan Gilbert (git), le lun. 15 avril 2019 13:02:05 +0100, a ecrit:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Gcc 9 needs some convincing that sopreprbuf really is going to fill
> in iov in the call from soreadbuf, even though the failure case
> shouldn't happen.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  slirp/src/socket.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/slirp/src/socket.c b/slirp/src/socket.c
> index 4a3c935e25..beb8517f1c 100644
> --- a/slirp/src/socket.c
> +++ b/slirp/src/socket.c
> @@ -181,7 +181,7 @@ soread(struct socket *so)
>  	 * No need to check if there's enough room to read.
>  	 * soread wouldn't have been called if there weren't
>  	 */
> -	sopreprbuf(so, iov, &n);
> +	assert(sopreprbuf(so, iov, &n) != 0);

Please make this through a variable, otherwise anybody building with
-DNDEBUG will get sopreprbuf not being called.

>  	nn = recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
>  	if (nn <= 0) {
> @@ -257,6 +257,7 @@ int soreadbuf(struct socket *so, const char *buf, int size)
>  	 * No need to check if there's enough room to read.
>  	 * soread wouldn't have been called if there weren't
>  	 */
> +	assert(size > 0);
>  	if (sopreprbuf(so, iov, &n) < size)
>          goto err;
>  
> -- 
> 2.21.0
> 
