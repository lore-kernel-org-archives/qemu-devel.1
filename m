Received: from eggs.gnu.org ([209.51.188.92]:47149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMQPC-0000fa-Dq
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMQPB-0003Ou-8f
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:06:42 -0400
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<20190503003618.10089-1-driver1998@foxmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aa0dce0b-1be0-7247-8f81-c4f265ba0009@redhat.com>
Date: Fri, 3 May 2019 07:06:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190503003618.10089-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/4] QEMU_PACKED: Remove gcc_struct
 attribute in Windows non x86 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 03/05/2019 02.36, Cao Jiaxi wrote:
> gcc_struct is for x86 only, and it generates an warning on ARM64 Clang/MinGW targets.
> 
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
> ---
>  contrib/libvhost-user/libvhost-user.h | 2 +-
>  include/qemu/compiler.h               | 2 +-
>  scripts/cocci-macro-file.h            | 7 ++++++-
>  slirp/src/util.h                      | 2 +-
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
> index 414ceb0a2f..78b33306e8 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -148,7 +148,7 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
>  
> -#if defined(_WIN32)
> +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>  # define VU_PACKED __attribute__((gcc_struct, packed))
>  #else
>  # define VU_PACKED __attribute__((packed))
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 296b2fd572..09fc44cca4 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -28,7 +28,7 @@
>  
>  #define QEMU_SENTINEL __attribute__((sentinel))
>  
> -#if defined(_WIN32)
> +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>  # define QEMU_PACKED __attribute__((gcc_struct, packed))
>  #else
>  # define QEMU_PACKED __attribute__((packed))
> diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
> index e485cdccae..c6bbc05ba3 100644
> --- a/scripts/cocci-macro-file.h
> +++ b/scripts/cocci-macro-file.h
> @@ -23,7 +23,12 @@
>  #define QEMU_NORETURN __attribute__ ((__noreturn__))
>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>  #define QEMU_SENTINEL __attribute__((sentinel))
> -#define QEMU_PACKED __attribute__((gcc_struct, packed))
> +
> +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> +# define QEMU_PACKED __attribute__((gcc_struct, packed))
> +#else
> +# define QEMU_PACKED __attribute__((packed))
> +#endif
>  
>  #define cat(x,y) x ## y
>  #define cat2(x,y) cat(x,y)
> diff --git a/slirp/src/util.h b/slirp/src/util.h
> index 01f1e0e068..278828fe3f 100644
> --- a/slirp/src/util.h
> +++ b/slirp/src/util.h
> @@ -43,7 +43,7 @@
>  #include <netinet/in.h>
>  #endif
>  
> -#if defined(_WIN32)
> +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>  # define SLIRP_PACKED __attribute__((gcc_struct, packed))
>  #else
>  # define SLIRP_PACKED __attribute__((packed))
> 

The slirp code is currently on its way into a separate module, so you
might need to provide that hunk to the libslirp folks again... I'm
putting the slirp maintainers on CC:, maybe they can pick it up from here.

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
