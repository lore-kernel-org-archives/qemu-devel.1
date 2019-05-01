Received: from eggs.gnu.org ([209.51.188.92]:60324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr01-0000Q9-A6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLqzy-000616-9K
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:18:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLqzy-0005zz-3K
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:18:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so24909763wrs.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:18:16 -0700 (PDT)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b361f969-413b-baa1-4d98-474bf1d7aa57@redhat.com>
Date: Wed, 1 May 2019 17:18:13 +0200
MIME-Version: 1.0
In-Reply-To: <20190428155451.15653-4-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/8] tests/qemu-iotests/check: Pick a
 default machine if necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 4/28/19 5:54 PM, Thomas Huth wrote:
> qemu-system-arm, qemu-system-aarch64 and qemu-system-tricore do not have
> a default machine, so when running the qemu-iotests with such a binary,
> lots of tests are failing. Fix it by picking a default machine in the
> "check" script instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/qemu-iotests/check | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index f9c24b6753..922c5d1d3d 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -130,7 +130,6 @@ export CACHEMODE="writeback"
>  export QEMU_IO_OPTIONS=""
>  export QEMU_IO_OPTIONS_NO_FMT=""
>  export CACHEMODE_IS_DEFAULT=true
> -export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
>  export VALGRIND_QEMU=
>  export IMGKEYSECRET=
>  export IMGOPTSSYNTAX=false
> @@ -564,6 +563,18 @@ then
>  fi
>  export QEMU_PROG="$(type -p "$QEMU_PROG")"
>  
> +case "$QEMU_PROG" in
> +    *qemu-system-arm|*qemu-system-aarch64)
> +        export QEMU_OPTIONS="-nodefaults -machine virt,accel=qtest"
> +        ;;
> +    *qemu-system-tricore)
> +        export QEMU_OPTIONS="-nodefaults -machine tricore_testboard,accel=qtest"
> +        ;;
> +    *)
> +        export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
> +        ;;
> +esac
> +
>  if [ -z "$QEMU_IMG_PROG" ]; then
>      if [ -x "$build_iotests/qemu-img" ]; then
>          export QEMU_IMG_PROG="$build_iotests/qemu-img"
> 
