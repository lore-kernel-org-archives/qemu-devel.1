Received: from eggs.gnu.org ([209.51.188.92]:45922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghIPo-0007MQ-Db
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghIJK-0004QE-Sk
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:10:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghIJK-0004Ok-L2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:10:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so9295450wmc.1
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 10:10:35 -0800 (PST)
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-3-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f1d83216-d9a8-605b-d87b-be6b96f42557@redhat.com>
Date: Wed, 9 Jan 2019 19:10:32 +0100
MIME-Version: 1.0
In-Reply-To: <1547051976-13982-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] configure: Force the C standard to
 gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 1/9/19 5:39 PM, Thomas Huth wrote:
> Different versions of GCC and Clang use different versions of the C standard.
> This repeatedly caused problems already, e.g. with duplicated typedefs:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
> 
> or with for-loop variable initializers:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
> 
> To avoid these problems, we should enforce the C language version to the
> same level for all compilers. Since our minimum compiler versions is
> GCC v4.8, our best option is "gnu99" for C code right now ("gnu17" is not
> available there yet, and "gnu11" is marked as "experimental"), and "gnu++98"
> for the few C++ code that we have in the repository.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Raising from a 30 years old stantard to a 20 years old one is a great
improvement (I used to be a defender of the C89, but I evolved and now
admit C99 has helpful features).

Using '-std=gnu++98' for g++ v4.8 looks like a good compromise to the
issues Daniel mentioned (still 'experimental').

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  v3: Compile C++ code with -std=gnu++98
> 
>  configure | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index b9f34af..448dbc8 100755
> --- a/configure
> +++ b/configure
> @@ -107,6 +107,9 @@ update_cxxflags() {
>              -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
>              -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls)
>                  ;;
> +            -std=gnu99)
> +                QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }"-std=gnu++98"
> +                ;;
>              *)
>                  QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
>                  ;;
> @@ -585,7 +588,7 @@ ARFLAGS="${ARFLAGS-rv}"
>  # left shift of signed integers is well defined and has the expected
>  # 2s-complement style results. (Both clang and gcc agree that it
>  # provides these semantics.)
> -QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
> +QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv -std=gnu99 $QEMU_CFLAGS"
>  QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
>  QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
>  QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
> 
