Received: from eggs.gnu.org ([2001:4830:134:3::10]:40504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1duLfH-0007kk-44
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1duLfG-0004Ok-4u
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:27 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:35007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1duLfF-0004OO-W4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:46:26 -0400
Received: by mail-io0-x243.google.com with SMTP id d16so217484ioj.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:46:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170808203900.7661-4-jfreimann@redhat.com>
References: <20170808203900.7661-1-jfreimann@redhat.com>
	<20170808203900.7661-4-jfreimann@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Sep 2017 18:46:24 +0200
Message-ID: <CAJ+F1C+1WzPe4Z6DDZyn308VV+D7AjVob2VseWK+0FFpiY2NsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] libvhost-user: quit when no more
 data received
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, QEMU <qemu-devel@nongnu.org>
Cc: Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

On Tue, Aug 8, 2017 at 10:52 PM Jens Freimann <jfreimann@redhat.com> wrote:
>
> From: Jens Freimann <jfreiman@redhat.com>
>
> End processing of messages when VHOST_USER_NONE
> is received.
>
> Without this we run into a vubr_panic() call and get
> "PANIC: Unhandled request: 0"
>
> Signed-off-by: Jens Freimann <jfreiman@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 9efb9dac0e..35fa0c5e56 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -161,7 +161,7 @@ vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
>          rc = recvmsg(conn_fd, &msg, 0);
>      } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>
> -    if (rc <= 0) {
> +    if (rc < 0) {
>          vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
>          return false;
>      }
> @@ -806,6 +806,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>          return vu_get_queue_num_exec(dev, vmsg);
>      case VHOST_USER_SET_VRING_ENABLE:
>          return vu_set_vring_enable_exec(dev, vmsg);
> +    case VHOST_USER_NONE:
> +        break;


I am afraid this isn't working. vu_message_read() returns
true/success, vu_process_message() returns false/no-reply, so
vu_dispatch() will return success, and the caller has no clear way to
know that the socket got disconnected. For me the vu_panic() was quite
more appropriate here.

What problem did this patch exactly solve?

>
>      default:
>          vmsg_close_fds(vmsg);
>          vu_panic(dev, "Unhandled request: %d", vmsg->request);
> --
> 2.13.3
>
>
