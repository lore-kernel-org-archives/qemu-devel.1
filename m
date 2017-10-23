Received: from eggs.gnu.org ([2001:4830:134:3::10]:57849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6aUv-0000xc-EI
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6aUq-0005FS-Df
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:02:21 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6aUq-0005FJ-96
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:02:16 -0400
Received: by mail-qt0-x242.google.com with SMTP id p1so25557646qtg.2
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 04:02:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171023095910.23202-1-marcandre.lureau@redhat.com>
	<20171023095910.23202-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <30d6702f-4fd7-070f-a263-4003025f759c@amsat.org>
Date: Mon, 23 Oct 2017 08:02:12 -0300
MIME-Version: 1.0
In-Reply-To: <20171023095910.23202-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 1/6] memfd: split qemu_memfd_alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com

On 10/23/2017 06:59 AM, Marc-André Lureau wrote:
> Add a function to only create a memfd, without mmap. The function is
> used in the following memory backend.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qemu/memfd.h |  1 +
>  util/memfd.c         | 61 +++++++++++++++++++++++++++++++---------------------
>  2 files changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
> index 745a8c501e..41c24d807c 100644
> --- a/include/qemu/memfd.h
> +++ b/include/qemu/memfd.h
> @@ -16,6 +16,7 @@
>  #define F_SEAL_WRITE    0x0008  /* prevent writes */
>  #endif
>  
> +int qemu_memfd_create(const char *name, size_t size, unsigned int seals);
>  void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
>                         int *fd);
>  void qemu_memfd_free(void *ptr, size_t size, int fd);
> diff --git a/util/memfd.c b/util/memfd.c
> index 4571d1aba8..e9c1a0e700 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -55,6 +55,38 @@ static int memfd_create(const char *name, unsigned int flags)
>  #define MFD_ALLOW_SEALING 0x0002U
>  #endif
>  
> +int qemu_memfd_create(const char *name, size_t size, unsigned int seals)
> +{
> +    int mfd = -1;
> +
> +#ifdef CONFIG_LINUX
> +    unsigned int flags = MFD_CLOEXEC;
> +
> +    if (seals) {
> +        flags |= MFD_ALLOW_SEALING;

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    }
> +
> +    mfd = memfd_create(name, flags);
> +    if (mfd < 0) {
> +        return -1;
> +    }
> +
> +    if (ftruncate(mfd, size) == -1) {
> +        perror("ftruncate");
> +        close(mfd);
> +        return -1;
> +    }
> +
> +    if (seals && fcntl(mfd, F_ADD_SEALS, seals) == -1) {
> +        perror("fcntl");
> +        close(mfd);
> +        return -1;
> +    }
> +#endif
> +
> +    return mfd;
> +}
> +
>  /*
>   * This is a best-effort helper for shared memory allocation, with
>   * optional sealing. The helper will do his best to allocate using
> @@ -65,35 +97,14 @@ void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
>                         int *fd)
>  {
>      void *ptr;
> -    int mfd = -1;
> -
> -    *fd = -1;
> -
> -#ifdef CONFIG_LINUX
> -    if (seals) {
> -        mfd = memfd_create(name, MFD_ALLOW_SEALING | MFD_CLOEXEC);
> -    }
> +    int mfd = qemu_memfd_create(name, size, seals);
>  
> +    /* some systems have memfd without sealing */
>      if (mfd == -1) {
> -        /* some systems have memfd without sealing */
> -        mfd = memfd_create(name, MFD_CLOEXEC);
> -        seals = 0;
> +        mfd = qemu_memfd_create(name, size, 0);
>      }
> -#endif
> -
> -    if (mfd != -1) {
> -        if (ftruncate(mfd, size) == -1) {
> -            perror("ftruncate");
> -            close(mfd);
> -            return NULL;
> -        }
>  
> -        if (seals && fcntl(mfd, F_ADD_SEALS, seals) == -1) {
> -            perror("fcntl");
> -            close(mfd);
> -            return NULL;
> -        }
> -    } else {
> +    if (mfd == -1) {
>          const char *tmpdir = g_get_tmp_dir();
>          gchar *fname;
>  
> 
