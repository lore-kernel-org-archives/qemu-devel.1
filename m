Received: from eggs.gnu.org ([2001:4830:134:3::10]:40643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gBgJk-0000lU-Cr
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 09:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gBgJg-0002kV-U4
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 09:20:24 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gBgJg-0002iG-6B
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 09:20:20 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20181010223656.31632-1-f4bug@amsat.org>
	<20181010223656.31632-2-f4bug@amsat.org>
Message-ID: <7922a298-276e-c1bf-a651-b61cb64c4f44@vivier.eu>
Date: Sun, 14 Oct 2018 15:19:31 +0200
MIME-Version: 1.0
In-Reply-To: <20181010223656.31632-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 01/10] linux-user/syscall: Verify
 recvfrom(addr) is user-writable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

On 11/10/2018 00:36, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ae3c0dfef7..ea503381aa 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2968,6 +2968,11 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
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

This one breaks the test recvfrom01 from the LTP testsuite
ltp-full-20180515 archive.

recvfrom01    3  TFAIL  :  recvfrom01.c:170: invalid socket buffer ;
returned -1 (expected 0), errno 14 (expected 88)

The testcase is with an invalid socket number (-1) and an invalid
addrlen pointer.

Thanks,
Laurent
