Received: from eggs.gnu.org ([2001:4830:134:3::10]:48397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emNJz-0000Z1-Sc
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emNJw-0004D0-OJ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:27:47 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:49957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emNJw-0004Ci-Dt
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:27:44 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-11-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <de201d07-7c25-f6f8-c68a-ca8d0f1c2ad6@vivier.eu>
Date: Thu, 15 Feb 2018 18:27:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180124130126.20871-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/11] linux-user/syscall: verify
 recvfrom(addr) is user-writable
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
>  linux-user/syscall.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 11c9116c4a..b6b9beca5b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4040,6 +4040,11 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
>              ret = -TARGET_EINVAL;
>              goto fail;
>          }
> +        if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
> +            ret = -TARGET_EFAULT;
> +            goto fail;
> +        }
> +
>          addr = alloca(addrlen);
>          ret = get_errno(safe_recvfrom(fd, host_msg, len, flags,
>                                        addr, &addrlen));
> 

Even if host_to_target_sockaddr() will do the check before copying data
to the target, I think it is good to check this before reading the data, so:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent
