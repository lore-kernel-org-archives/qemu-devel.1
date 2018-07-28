Received: from eggs.gnu.org ([2001:4830:134:3::10]:54735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fjGd5-0002h3-OE
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 00:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fjGd4-0007ap-EW
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 00:14:55 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fjGd4-0007Ze-6C
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 00:14:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so12561616oih.11
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 21:14:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
References: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
From: Michael Clark <mjc@sifive.com>
Date: Sat, 28 Jul 2018 16:14:52 +1200
Message-ID: <CAHNT7NuXwFfP3y78bmt7SWyMyLnOt1PzZmG_052RBWia0aqwXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] configure: Add RISC-V host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On Sat, Jul 28, 2018 at 11:49 AM, Alistair Francis <alistair.francis@wdc.com
> wrote:

> Allow QEMU to be built to run on a RISC-V host.
>
> QEMU does not yet have a RISC-V TCG or user mode target port, but
> running other architectures on RISC-V using TCI does work.
>

There is this RISC-V TCG backend here:

https://github.com/riscv/riscv-qemu/tree/wip-riscv-tcg-backend

I realized I had not sent an update to the list. There is a working TCG
backend for RISC-V:

- I've so far tested it with user-mode translation only.
- It does not support large guests e.g. 64-bit hosts on riscv32.
- The softmmu implementation is there but needs testing.
- Some things are missing, e.g. memory fences. big-endian support

You might find some other relevant changes in the configure hunks in the
patch. IIRC there were a few changes to configure, one of them was to get
the riscv disassembler working.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
> --
> 2.17.1
>
>
