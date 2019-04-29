Received: from eggs.gnu.org ([209.51.188.92]:39760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL6x4-0003hL-D0
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL6wy-0004UP-Tj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:08:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL6ww-0004Ov-Is
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:08:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id k16so16276434wrn.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:08:04 -0700 (PDT)
References: <20190429134757.13570-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c20eda65-a2db-97bf-3439-73f7e6c0f400@redhat.com>
Date: Mon, 29 Apr 2019 16:08:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190429134757.13570-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl: fix -sandbox parsing crash when
 seccomp support is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: otubo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, david@gibson.dropbear.id.au

On 4/29/19 3:47 PM, Marc-André Lureau wrote:
> $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> Segmentation fault
> 
> Commit 5780760f5e ("seccomp: check TSYNC host capability") wrapped one
> use of the sandbox option group to produce a sensible error, it didn't
> do the same for another call to qemu_opts_parse_noisily():
> 
> (gdb) bt
>     at util/qemu-option.c:829
>  #0  0x00000000105b36d8 in opts_parse (list=0x0, params=0x3ffffffffab5 "off", permit_abbrev=true, defaults=false, errp=0x3ffffffff080)
>      at util/qemu-option.c:829
>  #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=<optimized out>, params=<optimized out>, permit_abbrev=<optimized out>) at util/qemu-option.c:890
>  #2  0x0000000010024964 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:3589
> 
> Fixes: 5780760f5ea6163939a5dabe7427318b4f07d1a2
> Cc: david@gibson.dropbear.id.au
> Cc: otubo@redhat.com
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 4019a4387d..5fc4994d3c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3866,17 +3866,19 @@ int main(int argc, char **argv, char **envp)
>                  qtest_log = optarg;
>                  break;
>              case QEMU_OPTION_sandbox:
> -#ifdef CONFIG_SECCOMP
> -                opts = qemu_opts_parse_noisily(qemu_find_opts("sandbox"),
> -                                               optarg, true);
> +                olist = qemu_find_opts("sandbox");
> +                if (!olist) {
> +#ifndef CONFIG_SECCOMP
> +                    error_report("-sandbox support is not enabled "
> +                                 "in this QEMU binary");
> +#endif
> +                    exit(1);
> +                }
> +
> +                opts = qemu_opts_parse_noisily(olist, optarg, true);
>                  if (!opts) {
>                      exit(1);
>                  }
> -#else
> -                error_report("-sandbox support is not enabled "
> -                             "in this QEMU binary");
> -                exit(1);
> -#endif
>                  break;
>              case QEMU_OPTION_add_fd:
>  #ifndef _WIN32
> 
