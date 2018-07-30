Received: from eggs.gnu.org ([2001:4830:134:3::10]:59157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fkCmi-00016X-EW
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fkCme-0007dw-Fs
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:20:44 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:39849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fkCme-0007dl-9c
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:20:40 -0400
Received: by mail-vk0-x244.google.com with SMTP id e139-v6so6199834vkf.6
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:20:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9d7f6a73-a00f-ebc1-efb3-18367e3c0f32@amsat.org>
Date: Mon, 30 Jul 2018 15:20:34 -0300
MIME-Version: 1.0
In-Reply-To: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] configure: Add RISC-V host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>, mjc@sifive.com, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com

On 07/27/2018 08:49 PM, Alistair Francis wrote:
> Allow QEMU to be built to run on a RISC-V host.
> 
> QEMU does not yet have a RISC-V TCG or user mode target port, but
> running other architectures on RISC-V using TCI does work.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  configure | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 2a7796ea80..c3ff3ae146 100755
> --- a/configure
> +++ b/configure
> @@ -606,6 +606,16 @@ EOF
>    compile_object
>  }
>  
> +check_define_value() {
> +cat > $TMPC <<EOF
> +#if (($1) != ($2))
> +#error $1 != ($2)
> +#endif
> +int main(void) { return 0; }
> +EOF
> +  compile_object
> +}
> +
>  check_include() {
>  cat > $TMPC <<EOF
>  #include <$1>
> @@ -704,6 +714,12 @@ elif check_define __arm__ ; then
>    cpu="arm"
>  elif check_define __aarch64__ ; then
>    cpu="aarch64"
> +elif check_define __riscv ; then
> +  if check_define_value __riscv_xlen 64 ; then
> +    cpu="riscv64"
> +  else
> +    cpu="riscv32"
> +  fi
>  else
>    cpu=$(uname -m)
>  fi
> @@ -712,7 +728,7 @@ ARCH=
>  # Normalise host CPU name and set ARCH.
>  # Note that this case should only have supported host CPUs, not guests.
>  case "$cpu" in
> -  ppc|ppc64|s390|s390x|sparc64|x32)
> +  ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
>      cpu="$cpu"
>      supported_cpu="yes"
>      eval "cross_cc_${cpu}=\$host_cc"
> 

Before this patch:

$ ./configure

ERROR: Unsupported CPU = riscv64, try --enable-tcg-interpreter

$ ./configure --enable-tcg-interpreter
Unsupported CPU = riscv64, will use TCG with TCI (experimental)

[...]

WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!

CPU host architecture riscv64 support is not currently maintained.
The QEMU project intends to remove support for this host CPU in
a future release if nobody volunteers to maintain it and to
provide a build host for our continuous integration setup.
configure has succeeded and you can continue to build, but
if you care about QEMU on this platform you should contact
us upstream at qemu-devel@nongnu.org.

It is unlikely the RISC-V port goes away in the next future releases :)

With this patch we can now build/use QEMU tools such qemu-img qemu-io
qemu-nbd ivshmem-client ivshmem-server scsi/qemu-pr-helper
qemu-bridge-helper qemu-keymap fsdev/virtfs-proxy-helper qemu-ga
vhost-user-scsi vhost-user-blk.

This is still not enough for system/user emulation, but this is
certainly an improvement, a starting point for the built system tests
(we have other crippled targets such TriCore).

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
