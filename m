Received: from eggs.gnu.org ([2001:4830:134:3::10]:54408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gKiCj-0008UO-Iw
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gKiCe-0004xG-DL
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:10:29 -0500
References: <20181108105904.27980-1-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0c6c5e77-92b7-e64e-c666-6f5c3bc10ca8@vivier.eu>
Date: Thu, 8 Nov 2018 12:09:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181108105904.27980-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-users/syscall: make do_ioctl_rt safer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

On 08/11/2018 11:59, Alex Bennée wrote:
> host_rt_dev_ptr is set while looping through a control structure. The
> compiler can not know that all structures passed to do_ioctl_rt will
> trigger the if clause so rightly complains with an --enable-sanitizers
> build. To keep the compiler happy we default the host_rt_dev_ptr and
> check it has been set before attempting to follow it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> CC: qemu-trivial@nongnu.org
> ---
>  linux-user/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 810a58b704..3a942f1f4a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4669,7 +4669,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>      int target_size;
>      void *argptr;
>      abi_ulong *target_rt_dev_ptr;
> -    unsigned long *host_rt_dev_ptr;
> +    unsigned long *host_rt_dev_ptr = NULL;
>      abi_long ret;
>      int i;
>  
> @@ -4715,7 +4715,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
>      unlock_user(argptr, arg, 0);
>  
>      ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
> -    if (*host_rt_dev_ptr != 0) {
> +    if (host_rt_dev_ptr && *host_rt_dev_ptr != 0) {

As host_rt_dev_ptr should be set in every case, I think an
"assert(host_rt_dev_ptr != NULL)" would be more meaningful.

Thanks,
Laurent
