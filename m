Received: from eggs.gnu.org ([2001:4830:134:3::10]:46925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emNDT-0005pE-OM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emNDP-0008M9-JI
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:21:03 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60425)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emNDP-0008LF-7s
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:20:59 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-12-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <55383805-d7b5-bf46-1bf3-f61a90055387@vivier.eu>
Date: Thu, 15 Feb 2018 18:20:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180124130126.20871-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/11] linux-user/syscall: simplify
 recvfrom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Le 24/01/2018 à 14:01, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b6b9beca5b..e082af2911 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4023,8 +4023,8 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
>                              abi_ulong target_addr,
>                              abi_ulong target_addrlen)
>  {
> -    socklen_t addrlen;
> -    void *addr;
> +    socklen_t addrlen = 0;
> +    void *addr = NULL;
>      void *host_msg;
>      abi_long ret;
>  
> @@ -4046,12 +4046,9 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
>          }
>  
>          addr = alloca(addrlen);
> -        ret = get_errno(safe_recvfrom(fd, host_msg, len, flags,
> -                                      addr, &addrlen));
> -    } else {
> -        addr = NULL; /* To keep compiler quiet.  */
> -        ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, NULL, 0));
>      }
> +    ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, addr, &addrlen));
> +
>      if (!is_error(ret)) {
>          if (fd_trans_host_to_target_data(fd)) {
>              ret = fd_trans_host_to_target_data(fd)(host_msg, ret);
> 

I think it would be better to pass a NULL pointer to the function for
addrlen if addr is NULL.

In man page we have:

    If the caller is not interested in the source address, src_addr and
    addrlen should be specified as NULL.

Something like:

...
-    socklen_t addrlen;
-    void *addr;
+    socklen_t *addrlen = NULL;
+    void *addr = NULL;
+    socklen_t target_len;
...
-        addr = alloca(addrlen);
-        ret = get_errno(safe_recvfrom(fd, host_msg, len, flags,
-                                      addr, &addrlen));
-    } else {
-        addr = NULL; /* To keep compiler quiet.  */
-        ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, NULL, 0));
+        addr = alloca(target_len);
+        addrlen = &target_len
     }
+    ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, addr,
addrlen));
...


Thanks,
Laurent
