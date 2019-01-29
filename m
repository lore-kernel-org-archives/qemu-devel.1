Received: from eggs.gnu.org ([209.51.188.92]:36678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXiN-0007vq-67
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXiA-0003bp-OD
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:02:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goXiA-0003bS-BY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:02:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so23059590wrt.13
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 10:02:14 -0800 (PST)
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-3-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a91a9a56-9abd-cb00-ab1d-6799518f05fa@redhat.com>
Date: Tue, 29 Jan 2019 19:02:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/18] configure: Disable W^X on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On 1/29/19 6:53 PM, Philippe Mathieu-Daudé wrote:
> Since OpenBSD 6.0 [1], W^X is enforced by default [2].
> TCG requires WX access. Disable W^X if it is available.
> This fixes:
> 
>   # lm32-softmmu/qemu-system-lm32
>   Could not allocate dynamic translator buffer
> 
>   # sysctl kern.wxabort=1
>   kern.wxabort: 0 -> 1
>   # lm32-softmmu/qemu-system-lm32
>   mmap: Not supported
>   Abort trap (core dumped)
>   # gdb -q lm32-softmmu/qemu-system-lm32 qemu-system-lm32.core
>   (gdb) bt
>   #0  0x000017e3c156c50a in _thread_sys___syscall () at {standard input}:5
>   #1  0x000017e3c15e5d7a in *_libc_mmap (addr=Variable "addr" is not available.) at /usr/src/lib/libc/sys/mmap.c:47
>   #2  0x000017e17d9abc8b in alloc_code_gen_buffer () at /usr/src/qemu/accel/tcg/translate-all.c:1064
>   #3  0x000017e17d9abd04 in code_gen_alloc (tb_size=0) at /usr/src/qemu/accel/tcg/translate-all.c:1112
>   #4  0x000017e17d9abe81 in tcg_exec_init (tb_size=0) at /usr/src/qemu/accel/tcg/translate-all.c:1149
>   #5  0x000017e17d9897e9 in tcg_init (ms=0x17e45e456800) at /usr/src/qemu/accel/tcg/tcg-all.c:66
>   #6  0x000017e17d9891b8 in accel_init_machine (acc=0x17e3c3f50800, ms=0x17e45e456800) at /usr/src/qemu/accel/accel.c:63
>   #7  0x000017e17d989312 in configure_accelerator (ms=0x17e45e456800, progname=0x7f7fffff07b0 "lm32-softmmu/qemu-system-lm32") at /usr/src/qemu/accel/accel.c:111
>   #8  0x000017e17d9d8616 in main (argc=1, argv=0x7f7fffff06b8, envp=0x7f7fffff06c8) at vl.c:4325
> 
> [1] https://www.openbsd.org/faq/upgrade60.html
> [2] https://undeadly.org/cgi?action=article&sid=20160527203200
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  configure | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/configure b/configure
> index b18281c61f..799ec2013b 100755
> --- a/configure
> +++ b/configure
> @@ -5795,6 +5795,17 @@ if test "$mingw32" = "yes" ; then
>      done
>  fi
>  
> +# Disable OpenBSD W^X if available
> +if test "$tcg" = "yes" -a "$targetos" = "OpenBSD"; then
> +    cat > $TMPC <<EOF
> +    int main(void) { return 0; }
> +EOF
> +    wx_ldflags="-Wl,-z,wxneeded"

I told Thomas I'd remove the wx_ldflags but forgot.
Anyway this doesn't change the patch correctness.

> +    if compile_prog "" "$wx_ldflags"; then
> +        QEMU_LDFLAGS="$QEMU_LDFLAGS $wx_ldflags"
> +    fi
> +fi
> +
>  qemu_confdir=$sysconfdir$confsuffix
>  qemu_moddir=$libdir$confsuffix
>  qemu_datadir=$datadir$confsuffix
> 
