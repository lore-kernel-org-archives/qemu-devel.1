Received: from eggs.gnu.org ([2001:4830:134:3::10]:40350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZjO8-0003rv-Fw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZjO7-0002za-PT
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 15:51:32 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-31-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <82a0e0b4-392a-020f-eb98-9bc1039f66c4@vivier.eu>
Date: Mon, 24 Jul 2017 21:51:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-31-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 30/35] syscall: fix use of
 uninitialized values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 24/07/2017 à 20:27, Philippe Mathieu-Daudé a écrit :
> linux-user/syscall.c:1627:35: warning: 1st function call argument is an uninitialized value
>         target_saddr->sa_family = tswap16(addr->sa_family);
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~
> linux-user/syscall.c:1629:25: warning: The left operand of '==' is a garbage value
>     if (addr->sa_family == AF_NETLINK && len >= sizeof(struct sockaddr_nl)) {
>         ~~~~~~~~~~~~~~~ ^
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 26450d235f..963b9c8f4b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1618,6 +1618,7 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
>      if (len == 0) {
>          return 0;
>      }
> +    assert(addr);
>  
>      target_saddr = lock_user(VERIFY_WRITE, target_addr, len, 0);
>      if (!target_saddr)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
