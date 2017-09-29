Received: from eggs.gnu.org ([2001:4830:134:3::10]:55115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxrLo-0003E6-21
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxrLk-0001l3-2O
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dxrLj-0001jk-Q0
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:12:48 -0400
References: <20170928205211.15641-1-gedwards@ddn.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e1d2e56-7969-cb58-b462-dc140c3ff91c@redhat.com>
Date: Fri, 29 Sep 2017 11:12:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170928205211.15641-1-gedwards@ddn.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] char: report errors from qio_channel_{read,
 write}v_full
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Greg Edwards <gedwards@ddn.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On 28/09/2017 22:52, Greg Edwards wrote:
> Two callers of qio_channel_{read,write}v_full were not passing in an
> Error pointer, missing any error messages from the channel class
> io_{read,write}v methods.
> 
> Signed-off-by: Greg Edwards <gedwards@ddn.com>

This is on purpose in order to avoid "spamming" the logs.  In
particular, for sockets it can be a normal thing for the other side to
disconnect.

Paolo

> ---
>  chardev/char-io.c     | 7 ++++++-
>  chardev/char-socket.c | 8 ++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index f81052481a55..7d8287cbfe31 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "chardev/char-io.h"
>  
>  typedef struct IOWatchPoll {
> @@ -152,6 +153,7 @@ int io_channel_send_full(QIOChannel *ioc,
>                           int *fds, size_t nfds)
>  {
>      size_t offset = 0;
> +    Error *local_err = NULL;
>  
>      while (offset < len) {
>          ssize_t ret = 0;
> @@ -160,7 +162,10 @@ int io_channel_send_full(QIOChannel *ioc,
>  
>          ret = qio_channel_writev_full(
>              ioc, &iov, 1,
> -            fds, nfds, NULL);
> +            fds, nfds, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
>          if (ret == QIO_CHANNEL_ERR_BLOCK) {
>              if (offset) {
>                  return offset;
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index e65148fe973c..4e27370440ff 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -272,15 +272,19 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
>      size_t i;
>      int *msgfds = NULL;
>      size_t msgfds_num = 0;
> +    Error *local_err = NULL;
>  
>      if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
>          ret = qio_channel_readv_full(s->ioc, &iov, 1,
>                                       &msgfds, &msgfds_num,
> -                                     NULL);
> +                                     &local_err);
>      } else {
>          ret = qio_channel_readv_full(s->ioc, &iov, 1,
>                                       NULL, NULL,
> -                                     NULL);
> +                                     &local_err);
> +    }
> +    if (local_err) {
> +        error_report_err(local_err);
>      }
>  
>      if (ret == QIO_CHANNEL_ERR_BLOCK) {
> 
