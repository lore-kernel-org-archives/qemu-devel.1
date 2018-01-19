Received: from eggs.gnu.org ([2001:4830:134:3::10]:45081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecZbn-0004t5-5Y
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecZbj-0006Em-5e
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:33:39 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:52290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ecZbi-0006ED-Qw
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:33:35 -0500
References: <1513345976-22958-1-git-send-email-peter.maydell@linaro.org>
	<1513345976-22958-3-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <721eacb9-f011-4b97-08c6-70004ea41bdd@vivier.eu>
Date: Fri, 19 Jan 2018 17:33:23 +0100
MIME-Version: 1.0
In-Reply-To: <1513345976-22958-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: Don't use
 CMSG_ALIGN(sizeof struct cmsghdr)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Bruno Haible <bruno@clisp.org>, patches@linaro.org

Le 15/12/2017 à 14:52, Peter Maydell a écrit :
> The Linux struct cmsghdr is already guaranteed to be sufficiently
> aligned that CMSG_ALIGN(sizeof struct cmsghdr) is always equal
> to sizeof struct cmsghdr. Stop doing the unnecessary alignment
> arithmetic for host and target cmsghdr.
> 
> This follows kernel commit 1ff8cebf49ed9e9ca2 and brings our
> TARGET_CMSG_* macros back into line with the kernel ones,
> as well as making them easier to understand.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall_defs.h | 6 +++---
>  linux-user/syscall.c      | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index bec3680..a35c52a 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -303,9 +303,9 @@ struct target_cmsghdr {
>                                 __target_cmsg_nxthdr(mhdr, cmsg, cmsg_start)
>  #define TARGET_CMSG_ALIGN(len) (((len) + sizeof (abi_long) - 1) \
>                                 & (size_t) ~(sizeof (abi_long) - 1))
> -#define TARGET_CMSG_SPACE(len) (TARGET_CMSG_ALIGN (len) \
> -                               + TARGET_CMSG_ALIGN (sizeof (struct target_cmsghdr)))
> -#define TARGET_CMSG_LEN(len)   (TARGET_CMSG_ALIGN (sizeof (struct target_cmsghdr)) + (len))
> +#define TARGET_CMSG_SPACE(len) (sizeof(struct target_cmsghdr) + \
> +                                TARGET_CMSG_ALIGN(len))
> +#define TARGET_CMSG_LEN(len) (sizeof(struct target_cmsghdr) + (len))
>  
>  static __inline__ struct target_cmsghdr *
>  __target_cmsg_nxthdr(struct target_msghdr *__mhdr,
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index a1b9772..39553c8 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1692,7 +1692,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
>          void *target_data = TARGET_CMSG_DATA(target_cmsg);
>  
>          int len = tswapal(target_cmsg->cmsg_len)
> -                  - TARGET_CMSG_ALIGN(sizeof (struct target_cmsghdr));
> +            - sizeof(struct target_cmsghdr);
>  
>          space += CMSG_SPACE(len);
>          if (space > msgh->msg_controllen) {
> @@ -1773,7 +1773,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>          void *data = CMSG_DATA(cmsg);
>          void *target_data = TARGET_CMSG_DATA(target_cmsg);
>  
> -        int len = cmsg->cmsg_len - CMSG_ALIGN(sizeof (struct cmsghdr));
> +        int len = cmsg->cmsg_len - sizeof(struct cmsghdr);
>          int tgt_len, tgt_space;
>  
>          /* We never copy a half-header but may copy half-data;
> 

Applied to my linux-user branch.

Thanks,
Laurent
