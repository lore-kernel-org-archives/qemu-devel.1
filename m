Received: from eggs.gnu.org ([2001:4830:134:3::10]:41958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKLoN-0004rD-8B
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dKLoJ-0005R6-90
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:39:03 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dKLoJ-0005Qv-1H
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:38:59 -0400
Received: by mail-wr0-x243.google.com with SMTP id u101so20661115wrc.1
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 02:38:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170611123714.31292-1-mreitz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cbd02834-2619-a643-5999-50726f2b6f14@redhat.com>
Date: Mon, 12 Jun 2017 11:38:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170611123714.31292-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Ignore SIGPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org



On 11/06/2017 14:37, Max Reitz wrote:
> qemu proper has done so for 13 years
> (8a7ddc38a60648257dc0645ab4a05b33d6040063), qemu-img and qemu-io have
> done so for four years (526eda14a68d5b3596be715505289b541288ef2a).
> Ignoring this signal is especially important in qemu-nbd because
> otherwise a client can easily take down the qemu-nbd server by dropping
> the connection when the server wants to send something, for example:
> 
> $ qemu-nbd -x foo -f raw -t null-co:// &
> [1] 12726
> $ qemu-io -c quit nbd://localhost/bar
> can't open device nbd://localhost/bar: No export with name 'bar' available
> [1]  + 12726 broken pipe  qemu-nbd -x foo -f raw -t null-co://
> 
> In this case, the client sends an NBD_OPT_ABORT and closes the
> connection (because it is not required to wait for a reply), but the
> server replies with an NBD_REP_ACK (because it is required to reply).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> I tried to find some other reproducer instead of using a qemu client
> (e.g. nping -c 1 --tcp-connect localhost -p 10809, which gives the same
> pattern of <FIN-ACK, >PSH-ACK, <RST as qemu-io) but to no avail. This
> only results in the write being successful and the next read failing;
> interestingly, sendmsg()'s man page states that EPIPE is only returned
> when the local end is closed. However, I have not found the NBD server
> to close that local end anywhere.
> 
> In any case, ignoring SIGPIPE is the right thing to do. We get an EPIPE
> anyway, and this is fully sufficient to let us know that the connection
> is dead.
> ---
>  qemu-nbd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index b7ab86b..b2eeedb 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -580,6 +580,10 @@ int main(int argc, char **argv)
>      sa_sigterm.sa_handler = termsig_handler;
>      sigaction(SIGTERM, &sa_sigterm, NULL);
>  
> +#ifdef CONFIG_POSIX
> +    signal(SIGPIPE, SIG_IGN);
> +#endif
> +
>      module_call_init(MODULE_INIT_TRACE);
>      qcrypto_init(&error_fatal);
>  
> 

Queued, thanks.
