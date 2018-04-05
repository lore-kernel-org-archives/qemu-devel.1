Received: from eggs.gnu.org ([2001:4830:134:3::10]:60465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f46mk-0005gC-Ov
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f46mh-0000t9-L2
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:26:46 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f46mh-0000rX-BF
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:26:43 -0400
Received: by mail-wr0-x242.google.com with SMTP id 80so29121866wrb.2
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 08:26:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180328121804.16203-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c0f2f9a-b03e-e792-a20a-ce3b45380037@redhat.com>
Date: Thu, 5 Apr 2018 17:26:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180328121804.16203-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] memfd: fix vhost-user-test on
 non-memfd capable host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 28/03/2018 14:18, Marc-André Lureau wrote:
> On RHEL7, memfd is not supported, and vhost-user-test fails:
> TEST: tests/vhost-user-test... (pid=10248)
>   /x86_64/vhost-user/migrate:
>   qemu-system-x86_64: -object memory-backend-memfd,id=mem,size=2M,: failed to create memfd
> FAIL
> 
> There is a qemu_memfd_check() to prevent running memfd path, but it
> also checks for fallback implementation. Let's specialize
> qemu_memfd_check() to check memfd only, while qemu_memfd_alloc_check()
> checks for the qemu_memfd_alloc() API.
> 
> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
> Tested-by: Miroslav Rezanina <mrezanin@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/memfd.h |  1 +
>  hw/virtio/vhost.c    |  2 +-
>  util/memfd.c         | 30 +++++++++++++++++++++++++++++-
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
> index de10198ed6..49e79634da 100644
> --- a/include/qemu/memfd.h
> +++ b/include/qemu/memfd.h
> @@ -18,6 +18,7 @@
>  
>  int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>                        uint64_t hugetlbsize, unsigned int seals, Error **errp);
> +bool qemu_memfd_alloc_check(void);
>  void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
>                         int *fd, Error **errp);
>  void qemu_memfd_free(void *ptr, size_t size, int fd);
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 250f886acb..27c1ec5fe8 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1223,7 +1223,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>          if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
>              error_setg(&hdev->migration_blocker,
>                         "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
> -        } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_check()) {
> +        } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_check()) {
>              error_setg(&hdev->migration_blocker,
>                         "Migration disabled: failed to allocate shared memory");
>          }
> diff --git a/util/memfd.c b/util/memfd.c
> index 07d579ea7d..277f7211af 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -173,7 +173,13 @@ enum {
>      MEMFD_TODO
>  };
>  
> -bool qemu_memfd_check(void)
> +/**
> + * qemu_memfd_alloc_check():
> + *
> + * Check if qemu_memfd_alloc() can allocate, including using a
> + * fallback implementation when host doesn't support memfd.
> + */
> +bool qemu_memfd_alloc_check(void)
>  {
>      static int memfd_check = MEMFD_TODO;
>  
> @@ -188,3 +194,25 @@ bool qemu_memfd_check(void)
>  
>      return memfd_check == MEMFD_OK;
>  }
> +
> +/**
> + * qemu_memfd_check():
> + *
> + * Check if host supports memfd.
> + */
> +bool qemu_memfd_check(void)
> +{
> +    static int memfd_check = MEMFD_TODO;
> +
> +    if (memfd_check == MEMFD_TODO) {
> +        int mfd = memfd_create("test", 0);
> +        if (mfd >= 0) {
> +            memfd_check = MEMFD_OK;
> +            close(mfd);
> +        } else {
> +            memfd_check = MEMFD_KO;
> +        }
> +    }
> +
> +    return memfd_check == MEMFD_OK;
> +}
> 

Queued, thanks.

Paolo
