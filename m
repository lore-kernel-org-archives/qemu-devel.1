Received: from eggs.gnu.org ([2001:4830:134:3::10]:52580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUy2q-0001Xw-Lf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUy2m-0006GQ-Ol
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:29:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUy2m-0006Fz-IQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:29:48 -0400
Date: Tue, 11 Jul 2017 17:29:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170711162943.GF2223@work-vm>
References: <20170709175422.30185-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170709175422.30185-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] slirp: fork_exec(): Don't close() a
 negative number in fork_exec()
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
> In a fork_exec() error path we try to closesocket(s) when s might
> be a negative number because the thing that failed was the
> qemu_socket() call. Add a guard so we don't do this.
> 
> (Spotted by Coverity: CID 1005727 issue 1 of 2.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Issue 2 of 2 in CID 1005727 is trickier -- we need to move as
> much as possible of the client-end connect/accept out of the
> child process and into the parent as possible. I'm not sure
> if it's safe to do it all in the parent without deadlocking...

or just bail earlier?   The bit that worries me there
is the dup2(s, [012]); which is called unchecked, if that fails
then your telnetd or whatever probably ends up connected to whatever
your 0..2 were originally.

>  slirp/misc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/slirp/misc.c b/slirp/misc.c
> index 88e9d94197..260187b6b6 100644
> --- a/slirp/misc.c
> +++ b/slirp/misc.c
> @@ -112,7 +112,9 @@ fork_exec(struct socket *so, const char *ex, int do_pty)
>  		    bind(s, (struct sockaddr *)&addr, addrlen) < 0 ||
>  		    listen(s, 1) < 0) {
>  			error_report("Error: inet socket: %s", strerror(errno));
> -			closesocket(s);
> +			if (s >= 0) {
> +			    closesocket(s);
> +			}


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(I'm not convinced this would ever do anything bad, at least on a *nix
system, the -ve value is always going to be an invalid fd so the close
will just fail).

Dave

>  			return 0;
>  		}
> -- 
> 2.11.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
