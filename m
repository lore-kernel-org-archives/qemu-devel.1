Received: from eggs.gnu.org ([2001:4830:134:3::10]:54566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gY7nz-0001Xt-4H
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 06:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gY7nu-0006IX-Na
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 06:08:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gY7nq-0006BD-A5
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 06:08:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so7727955wrt.13
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 03:08:12 -0800 (PST)
References: <20181215012625.73315-1-liq3ea@163.com>
	<20181215012625.73315-3-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec20980f-ab76-ceac-4ebe-79716dce336b@redhat.com>
Date: Sat, 15 Dec 2018 12:08:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181215012625.73315-3-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] vhost-user: add fds inf
 'vhost_set_vring_file' in qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, thuth@redhat.com, lvivier@redhat.com, mst@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org

On 15/12/18 02:26, Li Qiang wrote:
> Currently, the vhost-user-test assumes the eventfd is available.
> However it's not true because the accel is qtest. So the
> 'vhost_set_vring_file' will not add fds to the msg and the server
> side of vhost-user-test will be broken. This patch avoid this.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/virtio/vhost-user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index e09bed0e4a..3b666f093c 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -23,6 +23,7 @@
>  #include "migration/migration.h"
>  #include "migration/postcopy-ram.h"
>  #include "trace.h"
> +#include "sysemu/qtest.h"
>  
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
> @@ -742,7 +743,7 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
>          .hdr.size = sizeof(msg.payload.u64),
>      };
>  
> -    if (ioeventfd_enabled() && file->fd > 0) {

The bug is in ioeventfd_enabled.  It should be !kvm_enabled() ||
kvm_eventfds_enabled().

Paolo

> +    if ((qtest_enabled() || ioeventfd_enabled()) && file->fd > 0) {
>          fds[fd_num++] = file->fd;
>      } else {
>          msg.payload.u64 |= VHOST_USER_VRING_NOFD_MASK;
> 
