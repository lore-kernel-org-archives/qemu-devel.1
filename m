Received: from eggs.gnu.org ([2001:4830:134:3::10]:57845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8zV-00083I-Ow
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8zR-0005wg-OE
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:07:41 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:46629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8zR-0005wB-JR
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:07:37 -0500
Received: by mail-qk0-x241.google.com with SMTP id l12so2373505qke.13
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:07:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-8-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <caaceadf-57b6-febf-8338-6dfb998bdb80@amsat.org>
Date: Thu, 4 Jan 2018 14:07:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180104160523.22995-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/18] build-sys: add some sanitizers
 when --enable-debug if possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com

On 01/04/2018 01:05 PM, Marc-André Lureau wrote:
> Enable ASAN/UBSan by default if the compiler supports it.
> 
> Typical slowdown introduced by AddressSanitizer is 2x.
> UBSan shouldn't have much impact on runtime cost.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

docker-debian-amd64 with QEMU_CONFIGURE_OPTS=--enable-debug:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  configure | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/configure b/configure
> index 3953859314..de1477c93a 100755
> --- a/configure
> +++ b/configure
> @@ -5161,6 +5161,13 @@ if test "$gcov" = "yes" ; then
>  elif test "$fortify_source" = "yes" ; then
>    CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
>  elif test "$debug" = "yes"; then
> +  write_c_skeleton;
> +  if compile_prog "-fsanitize=address" ""; then
> +      CFLAGS="-fsanitize=address $CFLAGS"
> +  fi
> +  if compile_prog "-fsanitize=undefined" ""; then
> +      CFLAGS="-fsanitize=undefined $CFLAGS"
> +  fi
>    if compile_prog "-Og" ""; then
>        CFLAGS="-Og $CFLAGS"
>    elif compile_prog "-O1" ""; then
> 
