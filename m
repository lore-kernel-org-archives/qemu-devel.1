Received: from eggs.gnu.org ([2001:4830:134:3::10]:54299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSwo1-0006SR-92
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSwny-0007yU-51
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:46:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dSwnx-0007y8-Tf
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:46:10 -0400
References: <cover.1499276048.git.alistair.francis@xilinx.com>
	<4c63c416af7bffe388d399132a006355366a3cfb.1499276048.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1d8284d3-0694-a207-8fe7-f58c0e223988@redhat.com>
Date: Thu, 6 Jul 2017 04:46:03 +0200
MIME-Version: 1.0
In-Reply-To: <4c63c416af7bffe388d399132a006355366a3cfb.1499276048.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 3/3] char-socket: Report TCP socket
 waiting as information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, armbru@redhat.com

On 05.07.2017 19:36, Alistair Francis wrote:
> When QEMU is waiting for a TCP socket connection it reports that message as
> an error. This isn't an error it is just information so let's change the
> report to use info_report() instead.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  chardev/char-socket.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ccc499cfa1..a050a686ea 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -765,8 +765,8 @@ static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
>       * in TLS and telnet cases, only wait for an accepted socket */
>      while (!s->ioc) {
>          if (s->is_listen) {
> -            error_report("QEMU waiting for connection on: %s",
> -                         chr->filename);
> +            info_report("QEMU waiting for connection on: %s",
> +                        chr->filename);
>              qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), true, NULL);
>              tcp_chr_accept(QIO_CHANNEL(s->listen_ioc), G_IO_IN, chr);
>              qio_channel_set_blocking(QIO_CHANNEL(s->listen_ioc), false, NULL);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

And in case you also want to add some warn_reports, I suggest to do a

grep -r "error_report.*[Ww]arning:" *

in the sources - there seem to be quite a lot of error_reports that are
rather a warning instead.

 Thomas
