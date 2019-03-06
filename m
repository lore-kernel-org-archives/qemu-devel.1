Received: from eggs.gnu.org ([209.51.188.92]:54274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1VvZ-0001WJ-Ue
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1VvZ-0008Qc-76
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:45:41 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:60135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1VvY-0008Pm-Tw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:45:41 -0500
References: <20190305151500.25038-1-marcandre.lureau@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0f00c642-39a0-7c88-f359-a9d4dc0b3ae0@vivier.eu>
Date: Wed, 6 Mar 2019 13:45:20 +0100
MIME-Version: 1.0
In-Reply-To: <20190305151500.25038-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix "may be used
 uninitialized" warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, alex.bennee@linaro.org

On 05/03/2019 16:15, Marc-André Lureau wrote:
> Fixes:
> 
> /home/elmarco/src/qemu/linux-user/syscall.c: In function ‘do_ioctl_rt’:
> /home/elmarco/src/qemu/linux-user/syscall.c:4773:9: error: ‘host_rt_dev_ptr’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      if (*host_rt_dev_ptr != 0) {
>          ^~~~~~~~~~~~~~~~
> /home/elmarco/src/qemu/linux-user/syscall.c:4774:9: error: ‘target_rt_dev_ptr’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>          unlock_user((void *)*host_rt_dev_ptr,
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                      *target_rt_dev_ptr, 0);
>                      ~~~~~~~~~~~~~~~~~~~~~~
> 
> Based on previous discussion from patch "linux-users/syscall: make
> do_ioctl_rt safer" by Alex Bennée.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  linux-user/syscall.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5bbb72f3d5..a15340b302 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4723,8 +4723,8 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>      const int *dst_offsets, *src_offsets;
>      int target_size;
>      void *argptr;
> -    abi_ulong *target_rt_dev_ptr;
> -    unsigned long *host_rt_dev_ptr;
> +    abi_ulong *target_rt_dev_ptr = NULL;
> +    unsigned long *host_rt_dev_ptr = NULL;
>      abi_long ret;
>      int i;
>  
> @@ -4770,6 +4770,9 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>      unlock_user(argptr, arg, 0);
>  
>      ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
> +
> +    assert(host_rt_dev_ptr != NULL);
> +    assert(target_rt_dev_ptr != NULL);
>      if (*host_rt_dev_ptr != 0) {
>          unlock_user((void *)*host_rt_dev_ptr,
>                      *target_rt_dev_ptr, 0);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
