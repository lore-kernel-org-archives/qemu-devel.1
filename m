Received: from eggs.gnu.org ([2001:4830:134:3::10]:40150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1gMap3-0001pX-Gg
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1gMaoz-0001IA-0p
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:41:49 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:45822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1gMaot-00018W-Gw
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:41:41 -0500
Date: Tue, 13 Nov 2018 18:41:33 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
Message-ID: <20181113154133.GA9113@dimastep-nix>
References: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
	<1539919345-10703-25-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539919345-10703-25-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PULL V2 24/26] net: ignore packet size greater
 than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

Hi Jason,

I know that this patch has been already merged to stable, but i have a
question:

On Fri, Oct 19, 2018 at 11:22:23AM +0800, Jason Wang wrote:
> There should not be a reason for passing a packet size greater than
> INT_MAX. It's usually a hint of bug somewhere, so ignore packet size
> greater than INT_MAX in qemu_deliver_packet_iov()
> 
> CC: qemu-stable@nongnu.org
> Reported-by: Daniel Shapira <daniel@twistlock.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  net/net.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/net.c b/net/net.c
> index c66847e..07c194a 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -712,10 +712,15 @@ ssize_t qemu_deliver_packet_iov(NetClientState *sender,
>                                  void *opaque)
>  {
>      NetClientState *nc = opaque;
> +    size_t size = iov_size(iov, iovcnt);
>      int ret;
>  
> +    if (size > INT_MAX) {
> +        return size;
Is it okay that the function returns ssize_t (signed), but the type of the
size variable is size_t (unsigned)? For now the top level routine checks
the return value only for 0, but anyway we can return negative value
here instead of positive. What do you think?

Regards, Dima.

> +    }
> +
>      if (nc->link_down) {
> -        return iov_size(iov, iovcnt);
> +        return size;
>      }
>  
>      if (nc->receive_disabled) {
> -- 
> 2.5.0
> 
> 
