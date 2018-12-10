Received: from eggs.gnu.org ([2001:4830:134:3::10]:38988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWOyv-00071p-9F
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWOyo-0003kT-Kr
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:04:33 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWOyn-0003jy-Pi
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:04:26 -0500
Received: by mail-oi1-x244.google.com with SMTP id x23so9561812oix.3
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 09:04:25 -0800 (PST)
References: <cover.1544229872.git.alistair.francis@wdc.com>
	<d6c491ecb5c0224c113ddfb2c06552ec89b68227.1544229872.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4a5e3e9-5e62-c0a3-67e3-891725db89d5@linaro.org>
Date: Mon, 10 Dec 2018 11:04:21 -0600
MIME-Version: 1.0
In-Reply-To: <d6c491ecb5c0224c113ddfb2c06552ec89b68227.1544229872.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 04/24] linux-user: riscv: Fix compile
 failure on riscv32 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 12/7/18 6:46 PM, Alistair Francis wrote:
> When cross compilling for riscv32 hosts using GCC 8.2 this error is seen:
>     error: '__NR__llseek' undeclared (first use in this function); did you mean '_llseek'?
> 
> To avoid the error let's ensure that __NR__llseek is defined.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/riscv/target_syscall.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
> index ee81d8bc88..af73f71839 100644
> --- a/linux-user/riscv/target_syscall.h
> +++ b/linux-user/riscv/target_syscall.h
> @@ -47,6 +47,11 @@ struct target_pt_regs {
>  #endif
>  #define UNAME_MINIMUM_RELEASE "4.15.0"
>  
> +/* This is sometimes needed to compile riscv32 Linux user mode */
> +#if !defined(__NR__llseek) && !defined(__NR_lseek)
> +#define __NR__llseek __NR3264_lseek
> +#endif

I'm not quite sure how this could be.  Upstream I see

#if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
...
#define __NR_lseek __NR3264_lseek
...
#else
...
#define __NR_llseek __NR3264_lseek

so this define should already exist.

Do you have the wrong headers installed for the cross-build?


r~
