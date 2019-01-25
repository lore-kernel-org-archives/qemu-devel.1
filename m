Received: from eggs.gnu.org ([209.51.188.92]:60445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn6bz-0007e4-QP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn6by-0004XF-UR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:53:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn6by-0004Wg-OR
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 13:53:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id p7so11450334wru.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 10:53:54 -0800 (PST)
References: <20190115200252.25911-1-mst@redhat.com>
	<20190115200252.25911-8-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <690e996c-2ece-5b4b-956b-e5a50f22f975@redhat.com>
Date: Fri, 25 Jan 2019 19:53:51 +0100
MIME-Version: 1.0
In-Reply-To: <20190115200252.25911-8-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 07/49] util: check the return value of
 fcntl in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Brad Smith <brad@comstyle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <n54@gmx.com>

Hi,

On 1/15/19 9:04 PM, Michael S. Tsirkin wrote:
> From: Li Qiang <liq3ea@163.com>
> 
> Assert that the return value is not an error. This is like commit
> 7e6478e7d4f for qemu_set_cloexec.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  util/oslib-posix.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index c1bee2a581..4ce1ba9ca4 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -233,14 +233,18 @@ void qemu_set_block(int fd)
>  {
>      int f;
>      f = fcntl(fd, F_GETFL);
> -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> +    assert(f != -1);
> +    f = fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> +    assert(f != -1);
>  }
>  
>  void qemu_set_nonblock(int fd)
>  {
>      int f;
>      f = fcntl(fd, F_GETFL);
> -    fcntl(fd, F_SETFL, f | O_NONBLOCK);
> +    assert(f != -1);
> +    f = fcntl(fd, F_SETFL, f | O_NONBLOCK);
> +    assert(f != -1);

This commit breaks OpenBSD, when trying to start QEMU I get:
assertion "f != -1" failed: file "util/oslib-posix.c", line 247,
function "qemu_set_nonblock"

Having a quick look at gdb, the last device opened is /dev/null, and
when fcntl() fails we have errno = ENODEV.

    19 ENODEV Operation not supported by device.
    An attempt was made to apply an inappropriate function to a device,
    for example, trying to read a write-only device such as a printer.

Digging further I found a recent commit which could fix this problem:
https://github.com/openbsd/src/commit/c2a35b387f9d3c
"fcntl(F_SETFL) invokes the FIONBIO and FIOASYNC ioctls internally, so
the memory devices (/dev/null, /dev/zero, etc) need to permit them."

Brad: Do you think this might be the fix? If so, any idea what is the
first release to contain this fix? I don't know OpenBSD and can't figure
this out... Also, what would be the cleaner QEMU fix?

Thanks,

Phil.

>  }
>  
>  int socket_set_fast_reuse(int fd)
> 
