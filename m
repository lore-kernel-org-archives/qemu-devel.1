Received: from eggs.gnu.org ([2001:4830:134:3::10]:35177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdLve-00038H-V9
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdLva-0006dL-A1
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:41:39 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:52496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fdLvZ-0006d5-SW
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:41:34 -0400
Received: by mail-it0-x241.google.com with SMTP id p4-v6so4449866itf.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 13:41:33 -0700 (PDT)
References: <20180711164025.10924-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b21b8663-a756-4daa-8966-1c2c20d90ab6@linaro.org>
Date: Wed, 11 Jul 2018 15:41:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180711164025.10924-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix mmap_find_vma_reserved()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 07/11/2018 09:40 AM, Laurent Vivier wrote:
> The value given by mmap_find_vma_reserved() is used with mmap(),
> so it is needed to be aligned with the host page size.
> 
> Since commit 18e80c55bb, reserved_va is only aligned to TARGET_PAGE_SIZE,
> and it works well if this size is greater or equal to the host page size.
> 
> But ppc64 hosts have 64kB page size and when we start a 4kiB page size
> guest (like i386), it fails when it tries to mmap the stack:
> 
>     mmap stack: Invalid argument
> 
> Fixes: 18e80c55bb (linux-user: Tidy and enforce reserved_va initialization)
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v2:
>       fix typo s/has/as/
> 
>  linux-user/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 52b5a618fe..15299e9dd7 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -689,6 +689,11 @@ int main(int argc, char **argv, char **envp)
>      target_environ = envlist_to_environ(envlist, NULL);
>      envlist_free(envlist);
>  
> +    /* reserved_va must be aligned with the host page size
> +     * as it is used with mmap()
> +     */
> +    reserved_va &= qemu_host_page_mask;
> +

So... this silently overrides the command-line argument.  The current code is
only a problem because we assign the default to a global variable, which must
be a compile-time constant.

I wonder if it's worth add an error message in handle_arg_reserved_va, and
moving the default initialization logic from the global variable to here, as

    if (HOST_LONG_BITS == 64 &&
        TARGET_VIRT_ADDR_SPACE_BITS <= 32 &&
        reserved_va == 0) {
        reserved_va = MAX_RESERVED_VA & qemu_host_page_mask;
    }

merging your comment with the moved comment from the global variable init.


r~
