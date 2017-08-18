Received: from eggs.gnu.org ([2001:4830:134:3::10]:50380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diqCs-0002Qj-Qf
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diqCp-0000vV-MR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:57:34 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diqCp-0000vO-FJ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 18:57:31 -0400
Received: by mail-qt0-x243.google.com with SMTP id i19so10169950qte.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 15:57:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170818222313.13391-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a31ed9ca-120f-e5fd-b4c7-0c9d38da72e7@amsat.org>
Date: Fri, 18 Aug 2017 19:57:27 -0300
MIME-Version: 1.0
In-Reply-To: <20170818222313.13391-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] osdep.h: Prohibit disabling assert()
 in supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com

On 08/18/2017 07:23 PM, Eric Blake wrote:
> We already have several files that knowingly require assert()
> to work.  While we do NOT want to encourage the use of
> 'assert(side-effects)' (that is a bad practice that prevents
> copy-and-paste of code to other projects that CAN disable
> assertions; plus it costs unnecessary reviewer mental cycles
> to remember our project policy on crippling asserts), we DO
> want to send a message that anyone that disables assertions
> has to tweak code in order to compile, making it obvious that
> we are not going to support their efforts.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> First mentioned as an idea here:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg06084.html
> but I'm titling this RFC as I'm not 100% convinced we want to make
> it a project-wide, rather than a per-file decision.

I think project-wide is the correct way.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>   include/qemu/osdep.h | 12 ++++++++++++
>   hw/scsi/mptsas.c     |  4 ----
>   hw/virtio/virtio.c   |  4 ----
>   3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 6855b94bbf..9e745a8af9 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -107,6 +107,18 @@ extern int daemon(int, int);
>   #include "glib-compat.h"
>   #include "qemu/typedefs.h"
> 
> +/*
> + * We have a lot of unaudited code that will fail in strange ways if
> + * you disable assertions at compile-time.  You are on your own if
> + * you cripple these safety-checks.
> + */
> +#ifdef NDEBUG
> +#error building with NDEBUG is not supported
> +#endif
> +#ifdef G_DISABLE_ASSERT
> +#error building with G_DISABLE_ASSERT is not supported
> +#endif
> +
>   #ifndef O_LARGEFILE
>   #define O_LARGEFILE 0
>   #endif
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 765ab53c34..3b93f12cdb 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -1236,11 +1236,7 @@ static void *mptsas_load_request(QEMUFile *f, SCSIRequest *sreq)
>       n = qemu_get_be32(f);
>       /* TODO: add a way for SCSIBusInfo's load_request to fail,
>        * and fail migration instead of asserting here.
> -     * When we do, we might be able to re-enable NDEBUG below.
>        */
> -#ifdef NDEBUG
> -#error building with NDEBUG is not supported
> -#endif
>       assert(n >= 0);
> 
>       pci_dma_sglist_init(&req->qsg, pci, n);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 464947f76d..2778adabcc 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1025,11 +1025,7 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
> 
>       /* TODO: teach all callers that this can fail, and return failure instead
>        * of asserting here.
> -     * When we do, we might be able to re-enable NDEBUG below.
>        */
> -#ifdef NDEBUG
> -#error building with NDEBUG is not supported
> -#endif
>       assert(ARRAY_SIZE(data.in_addr) >= data.in_num);
>       assert(ARRAY_SIZE(data.out_addr) >= data.out_num);
> 
