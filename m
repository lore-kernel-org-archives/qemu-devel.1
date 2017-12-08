Received: from eggs.gnu.org ([2001:4830:134:3::10]:40344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNHZ0-0002wS-AI
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eNHYz-0006kJ-BY
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:15:34 -0500
Date: Fri, 8 Dec 2017 12:15:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171208121521.GA2458@work-vm>
References: <20171206115726.5237-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171206115726.5237-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

* Daniel P. Berrange (berrange@redhat.com) wrote:
> qemu-io puts the TTY into non-canonical mode, which means no EOF processing is
> done and thus getchar() will never return the EOF constant. Instead we have to
> check for an explicit Ctrl-D, aka  0x4, to detect EOF and exit the qemu-io
> shell. This fixes the regression that prevented Ctrl-D from triggering an exit
> of qemu-io that has existed since readline was first added in
> 
>   commit 0cf17e181798063c3824c8200ba46f25f54faa1a
>   Author: Stefan Hajnoczi <stefanha@redhat.com>
>   Date:   Thu Nov 14 11:54:17 2013 +0100
> 
>     qemu-io: use readline.c
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-io.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-io.c b/qemu-io.c
> index c70bde3eb1..2ea0bfbaf8 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -322,7 +322,9 @@ static char *fetchline_readline(void)
>      readline_start(readline_state, get_prompt(), 0, readline_func, &line);
>      while (!line) {
>          int ch = getchar();
> -        if (ch == EOF) {
> +        /* In non-canon tty mode we get 0x4 (Ctrl-D), not the stdio "EOF"
> +         * constant */
> +        if (ch == 0x4) {

Personally I'd have made that EOF or 0x4  - but that's fine

(I don't see the point of reading the ioctl to figure out which EOF
char we're using; it seems to turn a trivial check into something much
more complex)

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>              break;
>          }
>          readline_handle_byte(readline_state, ch);
> -- 
> 2.14.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
