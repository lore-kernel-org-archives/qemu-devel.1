Received: from eggs.gnu.org ([2001:4830:134:3::10]:36504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emKZI-0008Aw-Cc
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emKZF-0006GD-6d
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:31:24 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:39827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emKZE-0006Fj-Sp
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:31:21 -0500
References: <mvmmv0nk6g7.fsf@suse.de> <mvmvafah0jd.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <13e5772f-7b47-4a34-3316-a908dc7d4f85@vivier.eu>
Date: Thu, 15 Feb 2018 15:31:03 +0100
MIME-Version: 1.0
In-Reply-To: <mvmvafah0jd.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Implement copy_file_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 06/02/2018 à 11:31, Andreas Schwab a écrit :
> No attempt is made to emulate it on the host.

I don't understand what you mean here...

> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
> v2: fix spacing
> ---
>  linux-user/syscall.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index bed154139e..92b4f59c05 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
...
> +#if defined(TARGET_NR_copy_file_range) && defined(__NR_copy_file_range)
> +    case TARGET_NR_copy_file_range:
> +        {
> +            loff_t inoff, outoff;
> +            loff_t *pinoff = NULL, *poutoff = NULL;
> +
> +            if (arg2) {
> +                if (get_user_u64(inoff, arg2)) {
> +                    goto efault;
> +                }
> +                pinoff = &inoff;
> +            }
> +            if (arg4) {
> +                if (get_user_u64(outoff, arg4)) {
> +                    goto efault;
> +                }
> +                poutoff = &outoff;
> +            }
> +            ret = get_errno(safe_copy_file_range(arg1, pinoff, arg3, poutoff,
> +                                                 arg5, arg6));
> +            if (arg2) {
> +                if (put_user_u64(inoff, arg2)) {
> +                    goto efault;
> +                }
> +            }
> +            if (arg4) {
> +                if (put_user_u64(outoff, arg4)) {
> +                    goto efault;
> +                }
> +            }

According to the linux implementation, this should be something like:

if (ret > 0) {
    if (arg2) {
        if (put_user_u64(inoff, arg2)) {
            ret = -TARGET_EFAULT;
        }
    }
    if (arg4) {
        if (put_user_u64(outoff, arg4)) {
            ret = -TARGET_EFAULT;
        }
    }
}

[TARGET_NR_splice should do this the same way]

Thanks,
Laurent
