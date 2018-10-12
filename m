Received: from eggs.gnu.org ([2001:4830:134:3::10]:35235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2i6-0001yg-K4
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2i3-0002KC-EG
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:02:54 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gB2i3-0002JY-38
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:02:51 -0400
References: <20181009074559.1041-1-likan_999.student@sina.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a433b99c-c4f5-2aa9-dbbf-c823ff752b7a@vivier.eu>
Date: Fri, 12 Oct 2018 21:02:44 +0200
MIME-Version: 1.0
In-Reply-To: <20181009074559.1041-1-likan_999.student@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix crashes in
 ioctl(SIOCGIFCONF) when ifc_buf is NULL.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kan Li <likan_999.student@sina.com>, qemu-devel@nongnu.org

On 09/10/2018 09:45, Kan Li wrote:
> Summary:
> This is to fix bug https://bugs.launchpad.net/qemu/+bug/1796754.
> It is valid for ifc_buf to be NULL according to
> http://man7.org/linux/man-pages/man7/netdevice.7.html.
> 
> Signed-off-by: Kan Li <likan_999.student@sina.com>
> ---
>  linux-user/syscall.c | 56 ++++++++++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 25 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ae3c0dfef7..fbab98d4f7 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4134,28 +4134,33 @@ static abi_long do_ioctl_ifconf(const IOCTLEntry *ie, uint8_t *buf_temp,
>      unlock_user(argptr, arg, 0);
>  
>      host_ifconf = (struct ifconf *)(unsigned long)buf_temp;
> -    target_ifc_len = host_ifconf->ifc_len;
>      target_ifc_buf = (abi_long)(unsigned long)host_ifconf->ifc_buf;
>  
> -    target_ifreq_size = thunk_type_size(ifreq_arg_type, 0);
> -    nb_ifreq = target_ifc_len / target_ifreq_size;
> -    host_ifc_len = nb_ifreq * sizeof(struct ifreq);
> +    if (target_ifc_buf != 0) {
> +        target_ifc_len = host_ifconf->ifc_len;
>  
> -    outbufsz = sizeof(*host_ifconf) + host_ifc_len;
> -    if (outbufsz > MAX_STRUCT_SIZE) {
> -        /* We can't fit all the extents into the fixed size buffer.
> -         * Allocate one that is large enough and use it instead.
> -         */
> -        host_ifconf = malloc(outbufsz);
> -        if (!host_ifconf) {
> -            return -TARGET_ENOMEM;
> +        target_ifreq_size = thunk_type_size(ifreq_arg_type, 0);
> +        nb_ifreq = target_ifc_len / target_ifreq_size;
> +        host_ifc_len = nb_ifreq * sizeof(struct ifreq);
> +
> +        outbufsz = sizeof(*host_ifconf) + host_ifc_len;
> +        if (outbufsz > MAX_STRUCT_SIZE) {
> +            /* We can't fit all the extents into the fixed size buffer.
> +             * Allocate one that is large enough and use it instead.
> +             */
> +            host_ifconf = malloc(outbufsz);
> +            if (!host_ifconf) {
> +                return -TARGET_ENOMEM;
> +            }
> +            memcpy(host_ifconf, buf_temp, sizeof(*host_ifconf));
> +            free_buf = 1;
>          }
> -        memcpy(host_ifconf, buf_temp, sizeof(*host_ifconf));
> -        free_buf = 1;
> -    }
> -    host_ifc_buf = (char*)host_ifconf + sizeof(*host_ifconf);
> +        host_ifc_buf = (char*)host_ifconf + sizeof(*host_ifconf);
>  
> -    host_ifconf->ifc_len = host_ifc_len;
> +        host_ifconf->ifc_len = host_ifc_len;
> +    } else {
> +      host_ifc_buf = NULL;
> +    }
>      host_ifconf->ifc_buf = host_ifc_buf;
>  
>      ret = get_errno(safe_ioctl(fd, ie->host_cmd, host_ifconf));
> @@ -4178,15 +4183,16 @@ static abi_long do_ioctl_ifconf(const IOCTLEntry *ie, uint8_t *buf_temp,
>          thunk_convert(argptr, host_ifconf, arg_type, THUNK_TARGET);
>          unlock_user(argptr, arg, target_size);
>  
> -	/* copy ifreq[] to target user */
> -
> -        argptr = lock_user(VERIFY_WRITE, target_ifc_buf, target_ifc_len, 0);
> -        for (i = 0; i < nb_ifreq ; i++) {
> -            thunk_convert(argptr + i * target_ifreq_size,
> -                          host_ifc_buf + i * sizeof(struct ifreq),
> -                          ifreq_arg_type, THUNK_TARGET);
> +        if (target_ifc_buf != 0) {
> +            /* copy ifreq[] to target user */
> +            argptr = lock_user(VERIFY_WRITE, target_ifc_buf, target_ifc_len, 0);
> +            for (i = 0; i < nb_ifreq ; i++) {
> +                thunk_convert(argptr + i * target_ifreq_size,
> +                              host_ifc_buf + i * sizeof(struct ifreq),
> +                              ifreq_arg_type, THUNK_TARGET);
> +            }
> +            unlock_user(argptr, target_ifc_buf, target_ifc_len);
>          }
> -        unlock_user(argptr, target_ifc_buf, target_ifc_len);
>      }
>  
>      if (free_buf) {
> 

Applied to my branch linux-user-for-3.1

Thanks,
Laurent
