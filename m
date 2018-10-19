Received: from eggs.gnu.org ([2001:4830:134:3::10]:41422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDXqB-0002P1-QU
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDXq6-0001oD-9Z
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:41:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gDXq4-0001QF-01
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:41:28 -0400
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
	<1539926412-21831-8-git-send-email-liq3ea@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <95818941-44e4-c9fa-6d54-57c909732432@redhat.com>
Date: Fri, 19 Oct 2018 18:41:05 +0200
MIME-Version: 1.0
In-Reply-To: <1539926412-21831-8-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] vfio: platform: destory mutex in error
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, alex.williamson@redhat.com
Cc: philmd@redhat.com, qemu-devel@nongnu.org

Hi Li,

On 10/19/18 7:20 AM, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  hw/vfio/platform.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index ba19143..e9d9e80 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -668,7 +668,7 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
>              error_setg(errp, "%s", gerr->message);
>              g_error_free(gerr);
>              g_free(path);
> -            return;
> +            goto out;
You must set ret to != 0 otherwise the qemu_mutex_destroy will not be
reached I think. Also this will fix the fact we are not prepending the
vfio error prefix in that case, as we should.

Besides I am unsure about the cleanup strategy in case or error in
vfio_platform_realize(). The qemu process should always exit in case of
failure in vfio_platform_realize(). Platform devices can only be
cold-plugged through the qemu CLI. Cleaning all the allocated resources
may add a substantial amount of code. For instance resources allocated
in vfio_base_device_init() are not freed either. Comprehensive free in
realize() functions may only be needed in case of hotplug I think.

Thanks

Eric
>          }
>          g_free(path);
>          vdev->compat = contents;
> @@ -691,6 +691,8 @@ out:
>          return;
>      }
>  
> +    qemu_mutex_destroy(&vdev->intp_mutex);
> +
>      if (vdev->vbasedev.name) {
>          error_prepend(errp, ERR_PREFIX, vdev->vbasedev.name);
>      } else {
> 
